package com.bookflow.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.io.File;

@Configuration
public class AppConfig implements WebMvcConfigurer {

    @Value("${bookflow.upload.dir:uploads/covers/}")
    private String uploadDir;

    @Bean
    public RestTemplate restTemplate() {
        CloseableHttpClient httpClient = HttpClients.custom()
            .build();

        HttpComponentsClientHttpRequestFactory factory =
            new HttpComponentsClientHttpRequestFactory(httpClient);
        factory.setConnectTimeout(10_000);

        return new RestTemplate(factory);
    }

    @Bean
    public ObjectMapper objectMapper() {
        return new ObjectMapper();
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // uploadDir is "uploads/covers/" by default — strip the "covers/" leaf
        // so /uploads/** maps to the base "uploads/" filesystem folder,
        // matching how BookService stores coverPath as "uploads/covers/<file>".
        String baseUploadFolder = new File(uploadDir).getParentFile() != null
            ? new File(uploadDir).getParentFile().getPath()
            : "uploads";

        String absolutePath = new File(baseUploadFolder).getAbsolutePath();

        registry.addResourceHandler("/uploads/**")
            .addResourceLocations("file:" + absolutePath + File.separator);
    }

    public String getUploadDir() {
        return uploadDir;
    }
}
