package com.bookflow.repository;

import com.bookflow.model.Reservation;
import com.bookflow.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Long> {

    List<Reservation> findByMemberOrderByRequestDateDesc(User member);

    List<Reservation> findByBookIsbnAndStatusOrderByRequestDateAsc(
        String isbn, Reservation.ReservationStatus status
    );

    long countByBookIsbnAndStatus(String isbn, Reservation.ReservationStatus status);
    @Query("SELECT r FROM Reservation r JOIN FETCH r.book JOIN FETCH r.member WHERE r.status = 'PENDING' ORDER BY r.requestDate ASC")
    List<Reservation> findAllPending();

    boolean existsByMemberSystemIdAndBookIsbnAndStatus(
        String memberId, String isbn, Reservation.ReservationStatus status
    );
}
