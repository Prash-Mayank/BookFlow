package com.bookflow;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

/**
 * BookFlow — Online Library Management System
 * Project Lead: Mayank Prashar
 *
 * Extends SpringBootServletInitializer to allow WAR deployment
 * on external Apache Tomcat server.
 */
@SpringBootApplication
public class BookFlowApplication extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(BookFlowApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(BookFlowApplication.class, args);
    }
}