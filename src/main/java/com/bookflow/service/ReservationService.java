package com.bookflow.service;

import com.bookflow.exception.BookFlowException;
import com.bookflow.model.AuditLog;
import com.bookflow.model.Book;
import com.bookflow.model.Reservation;
import com.bookflow.model.User;
import com.bookflow.repository.ReservationRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ReservationService {

    private final ReservationRepository reservationRepository;
    private final BookService bookService;
    private final AuditLogService auditLogService;

    public ReservationService(ReservationRepository reservationRepository,
                              BookService bookService,
                              AuditLogService auditLogService) {
        this.reservationRepository = reservationRepository;
        this.bookService = bookService;
        this.auditLogService = auditLogService;
    }

    @Transactional
    public Reservation reserveBook(User member, String isbn) {
        Book book = bookService.getByIsbn(isbn);

        boolean alreadyReserved = reservationRepository.existsByMemberSystemIdAndBookIsbnAndStatus(
                member.getSystemId(), isbn, Reservation.ReservationStatus.PENDING
        );
        if (alreadyReserved) {
            throw new BookFlowException("You already have a pending reservation for this book");
        }

        Reservation reservation = Reservation.builder()
                .member(member)
                .book(book)
                .status(Reservation.ReservationStatus.PENDING)
                .build();

        reservationRepository.save(reservation);

        auditLogService.log(member.getSystemId(), AuditLog.AuditAction.RESERVATION_CREATED,
                "Reserved '" + book.getTitle() + "'");

        return reservation;
    }

    @Transactional
    public Reservation fulfillReservation(Long rsvId, String fulfilledByLibrarianId) {
        Reservation reservation = reservationRepository.findById(rsvId)
                .orElseThrow(() -> new BookFlowException("Reservation not found: " + rsvId));

        if (reservation.getStatus() != Reservation.ReservationStatus.PENDING) {
            throw new BookFlowException("Reservation is not pending");
        }

        reservation.setStatus(Reservation.ReservationStatus.FULFILLED);
        reservation.setFulfilledAt(java.time.LocalDateTime.now());
        reservationRepository.save(reservation);

        auditLogService.log(fulfilledByLibrarianId, AuditLog.AuditAction.RESERVATION_FULFILLED,
                "Fulfilled reservation #" + rsvId + " for " + reservation.getMember().getSystemId());

        return reservation;
    }

    @Transactional
    public void cancelReservation(Long rsvId, String cancelledByUserId) {
        Reservation reservation = reservationRepository.findById(rsvId)
                .orElseThrow(() -> new BookFlowException("Reservation not found: " + rsvId));
        reservation.setStatus(Reservation.ReservationStatus.CANCELLED);
        reservationRepository.save(reservation);
    }

    @Transactional(readOnly = true)
    public List<Reservation> getForMember(User member) {
        return reservationRepository.findByMemberOrderByRequestDateDesc(member);
    }

    @Transactional(readOnly = true)
    public List<Reservation> getAllPending() {
        return reservationRepository.findAllPending();
    }
}