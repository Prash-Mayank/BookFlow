package com.bookflow.service;

import com.bookflow.dto.BookRequest;
import com.bookflow.exception.BookFlowException;
import com.bookflow.model.AuditLog;
import com.bookflow.model.Book;
import com.bookflow.repository.BookRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;

@Service
public class BookService {

    @Value("${bookflow.upload.dir:uploads/covers/}")
    private String uploadDir;

    private final BookRepository bookRepository;
    private final AuditLogService auditLogService;

    public BookService(BookRepository bookRepository, AuditLogService auditLogService) {
        this.bookRepository = bookRepository;
        this.auditLogService = auditLogService;
    }

    // ---- CRUD ----

    @Transactional
    public Book addBook(BookRequest request, MultipartFile coverImage, String addedByUserId) {
        if (bookRepository.existsById(request.getIsbn())) {
            throw new BookFlowException("A book with ISBN " + request.getIsbn() + " already exists");
        }

        Book book = Book.builder()
                .isbn(request.getIsbn().trim())
                .title(request.getTitle().trim())
                .author(request.getAuthor().trim())
                .category(request.getCategory())
                .publisher(request.getPublisher())
                .year(request.getYear())
                .description(request.getDescription())
                .language(request.getLanguage() != null ? request.getLanguage() : "English")
                .pages(request.getPages())
                .totalCopies(request.getTotalCopies())
                .available(request.getTotalCopies())
                .build();

        if (coverImage != null && !coverImage.isEmpty()) {
            book.setCoverPath(storeCoverImage(coverImage));
        }

        bookRepository.save(book);

        auditLogService.log(addedByUserId, AuditLog.AuditAction.BOOK_ADDED,
                "Book added: " + book.getIsbn() + " — " + book.getTitle());

        return book;
    }

    @Transactional
    public Book updateBook(String isbn, BookRequest request, MultipartFile coverImage, String updatedByUserId) {
        Book book = getByIsbn(isbn);

        book.setTitle(request.getTitle().trim());
        book.setAuthor(request.getAuthor().trim());
        book.setCategory(request.getCategory());
        book.setPublisher(request.getPublisher());
        book.setYear(request.getYear());
        book.setDescription(request.getDescription());
        if (request.getLanguage() != null) book.setLanguage(request.getLanguage());
        book.setPages(request.getPages());

        // Adjust available count proportionally if total copies changed
        int delta = request.getTotalCopies() - book.getTotalCopies();
        book.setTotalCopies(request.getTotalCopies());
        book.setAvailable(Math.max(0, book.getAvailable() + delta));

        if (coverImage != null && !coverImage.isEmpty()) {
            book.setCoverPath(storeCoverImage(coverImage));
        }

        bookRepository.save(book);

        auditLogService.log(updatedByUserId, AuditLog.AuditAction.BOOK_UPDATED,
                "Book updated: " + book.getIsbn() + " — " + book.getTitle());

        return book;
    }

    @Transactional
    public void deleteBook(String isbn, String deletedByUserId) {
        Book book = getByIsbn(isbn);
        bookRepository.delete(book);

        auditLogService.log(deletedByUserId, AuditLog.AuditAction.BOOK_DELETED,
                "Book deleted: " + isbn + " — " + book.getTitle());
    }

    @Transactional(readOnly = true)
    public Book getByIsbn(String isbn) {
        return bookRepository.findById(isbn)
                .orElseThrow(() -> new BookFlowException("Book not found for ISBN: " + isbn));
    }

    @Transactional(readOnly = true)
    public List<Book> getAll() {
        return bookRepository.findAll();
    }

    // ---- Search (real-time AJAX) ----

    @Transactional(readOnly = true)
    public Page<Book> search(String query, Pageable pageable) {
        if (query == null || query.isBlank()) {
            return bookRepository.findAll(pageable);
        }
        return bookRepository.search(query.trim(), pageable);
    }

    @Transactional(readOnly = true)
    public List<Book> getByCategory(Book.BookCategory category) {
        return bookRepository.findByCategory(category);
    }

    @Transactional(readOnly = true)
    public List<Book> getAvailableBooks() {
        return bookRepository.findByAvailableGreaterThan(0);
    }

    @Transactional(readOnly = true)
    public List<Book> getMostBorrowed(int topN) {
        return bookRepository.findMostBorrowed(org.springframework.data.domain.PageRequest.of(0, topN));
    }

    // ---- Stock management (used by IssueReturnService) ----

    @Transactional
    public void decrementStock(String isbn) {
        Book book = getByIsbn(isbn);
        book.decrementAvailable();
        bookRepository.save(book);
    }

    @Transactional
    public void incrementStock(String isbn) {
        Book book = getByIsbn(isbn);
        book.incrementAvailable();
        bookRepository.save(book);
    }

    // ---- Cover image upload ----

    private String storeCoverImage(MultipartFile file) {
        try {
            Path uploadPath = Paths.get(uploadDir);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            String originalName = file.getOriginalFilename();
            String extension = (originalName != null && originalName.contains("."))
                    ? originalName.substring(originalName.lastIndexOf('.'))
                    : ".jpg";

            String fileName = UUID.randomUUID() + extension;
            Path destination = uploadPath.resolve(fileName);

            Files.copy(file.getInputStream(), destination, StandardCopyOption.REPLACE_EXISTING);

            return uploadDir + fileName;

        } catch (IOException e) {
            throw new BookFlowException("Failed to upload cover image: " + e.getMessage(), e);
        }
    }
    @Transactional(readOnly = true)
    public long getTotalBookCount() {
        return bookRepository.count();
    }

    @Transactional(readOnly = true)
    public long getAvailableBookCount() {
        return bookRepository.countByAvailableGreaterThan(0);
    }
}