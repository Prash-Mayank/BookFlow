package com.bookflow.service;

import com.bookflow.model.AuditLog;
import com.bookflow.repository.AuditLogRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AuditLogService {

    private final AuditLogRepository auditLogRepository;

    public AuditLogService(AuditLogRepository auditLogRepository) {
        this.auditLogRepository = auditLogRepository;
    }

    @Transactional
    public void log(String userId, AuditLog.AuditAction action, String description) {
        log(userId, action, description, null, null);
    }

    @Transactional
    public void log(String userId, AuditLog.AuditAction action, String description,
                    String ipAddress, String userAgent) {
        AuditLog entry = AuditLog.builder()
                .userId(userId)
                .action(action)
                .description(description)
                .ipAddress(ipAddress)
                .userAgent(userAgent)
                .build();
        auditLogRepository.save(entry);
    }
}