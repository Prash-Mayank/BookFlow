package com.bookflow.service;

import com.bookflow.model.AiCache;
import com.bookflow.model.Book;
import com.bookflow.model.Transaction;
import com.bookflow.model.User;
import com.bookflow.repository.AiCacheRepository;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class GeminiService {

    @Value("${bookflow.gemini.api-key:}")
    private String apiKey;

    @Value("${bookflow.gemini.api-url:https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent}")
    private String apiUrl;

    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;
    private final AiCacheRepository aiCacheRepository;
    private final IssueReturnService issueReturnService;
    private final BookService bookService;

    public GeminiService(RestTemplate restTemplate,
                         ObjectMapper objectMapper,
                         AiCacheRepository aiCacheRepository,
                         IssueReturnService issueReturnService,
                         BookService bookService) {
        this.restTemplate = restTemplate;
        this.objectMapper = objectMapper;
        this.aiCacheRepository = aiCacheRepository;
        this.issueReturnService = issueReturnService;
        this.bookService = bookService;
    }

    /**
     * Returns 5 personalised book recommendations for the student.
     * Uses cache if valid (within 24h); otherwise calls Gemini and re-caches.
     * Falls back to top-borrowed books if the API call fails.
     */
    @Transactional
    public JsonNode getRecommendations(User student) {

        var cached = aiCacheRepository.findById(student.getSystemId());
        if (cached.isPresent() && cached.get().isValid()) {
            try {
                return objectMapper.readTree(cached.get().getRecommendations());
            } catch (Exception ignored) {
                // fall through to regenerate
            }
        }

        try {
            JsonNode recommendations = callGeminiApi(student);
            cacheRecommendations(student.getSystemId(), recommendations);
            return recommendations;

        } catch (Exception e) {
            // Graceful fallback: top-borrowed books
            return buildFallbackRecommendations();
        }
    }

    private JsonNode callGeminiApi(User student) {
        List<Transaction> history = issueReturnService.getHistoryForMember(student.getSystemId());

        List<Transaction> last10 = history.stream().limit(10).collect(Collectors.toList());

        if (last10.isEmpty()) {
            throw new RestClientException("No borrow history — skip Gemini call, use fallback");
        }

        String prompt = buildPrompt(last10);

        ObjectNode requestBody = objectMapper.createObjectNode();
        ArrayNode contents = requestBody.putArray("contents");
        ObjectNode contentItem = contents.addObject();
        ArrayNode parts = contentItem.putArray("parts");
        parts.addObject().put("text", prompt);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<String> entity = new HttpEntity<>(requestBody.toString(), headers);

        String url = apiUrl + "?key=" + apiKey;

        ResponseEntity<String> response = restTemplate.postForEntity(url, entity, String.class);

        if (!response.getStatusCode().is2xxSuccessful() || response.getBody() == null) {
            throw new RestClientException("Gemini API returned non-success status");
        }

        return parseGeminiResponse(response.getBody());
    }

    private String buildPrompt(List<Transaction> history) {
        StringBuilder sb = new StringBuilder();
        sb.append("Based on this reader's borrow history, suggest exactly 5 books they would enjoy. ");
        sb.append("Respond ONLY with a JSON array of 5 objects, each with keys: title, author, genre, reason. ");
        sb.append("No markdown, no extra text.\n\nBorrow history:\n");

        for (Transaction t : history) {
            sb.append("- \"").append(t.getBook().getTitle()).append("\" by ")
                    .append(t.getBook().getAuthor()).append(" (")
                    .append(t.getBook().getCategory()).append(")\n");
        }
        return sb.toString();
    }

    private JsonNode parseGeminiResponse(String rawBody) {
        try {
            JsonNode root = objectMapper.readTree(rawBody);
            String text = root.path("candidates").path(0)
                    .path("content").path("parts").path(0)
                    .path("text").asText();

            // Strip potential markdown code fences
            String cleaned = text.replaceAll("```json", "").replaceAll("```", "").trim();
            return objectMapper.readTree(cleaned);

        } catch (Exception e) {
            throw new RestClientException("Failed to parse Gemini response", e);
        }
    }

    private void cacheRecommendations(String memberId, JsonNode recommendations) {
        try {
            AiCache cache = AiCache.builder()
                    .memberId(memberId)
                    .recommendations(objectMapper.writeValueAsString(recommendations))
                    .build();
            aiCacheRepository.save(cache);
        } catch (Exception ignored) {
            // Caching failure should not break the recommendation flow
        }
    }

    private JsonNode buildFallbackRecommendations() {
        List<Book> topBooks = bookService.getMostBorrowed(5);

        ArrayNode array = objectMapper.createArrayNode();
        for (Book b : topBooks) {
            ObjectNode node = array.addObject();
            node.put("title", b.getTitle());
            node.put("author", b.getAuthor());
            node.put("genre", b.getCategory().getDisplayName());
            node.put("reason", "Popular among other readers");
        }
        return array;
    }
}