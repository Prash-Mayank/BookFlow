package com.bookflow.repository;

import com.bookflow.model.Book;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface BookRepository extends JpaRepository<Book, String> {

    @Query("""
        SELECT b FROM Book b
        WHERE LOWER(b.title)    LIKE LOWER(CONCAT('%', :q, '%'))
           OR LOWER(b.author)   LIKE LOWER(CONCAT('%', :q, '%'))
           OR b.isbn             LIKE CONCAT('%', :q, '%')
           OR LOWER(b.category) LIKE LOWER(CONCAT('%', :q, '%'))
        """)
    Page<Book> search(@Param("q") String query, Pageable pageable);

    List<Book> findByCategory(Book.BookCategory category);

    List<Book> findByStatus(Book.BookStatus status);

    List<Book> findByAvailableGreaterThan(int available);

    long countByStatus(Book.BookStatus status);

    long countByAvailableGreaterThan(int available);

    @Query("""
        SELECT b FROM Book b
        JOIN Transaction t ON t.book = b
        GROUP BY b
        ORDER BY COUNT(t) DESC
        """)
    List<Book> findMostBorrowed(Pageable pageable);
}