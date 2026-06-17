=CREATE DATABASE IF NOT EXISTS bookflow_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE bookflow_db;
CREATE TABLE IF NOT EXISTS users (
    system_id           VARCHAR(25)     NOT NULL    COMMENT 'FIRSTNAME+6DIGITS+ROLECODE — login username',
    first_name          VARCHAR(50)     NOT NULL,
    last_name            VARCHAR(50)     NOT NULL,
    password_hash       VARCHAR(255)    NOT NULL    COMMENT 'BCrypt hash — never plain text',
    role                ENUM('ADM','LIB','STU') NOT NULL,
    email               VARCHAR(100)    NOT NULL,
    phone               VARCHAR(15),
    address             TEXT,
    status              ENUM('ACTIVE','LOCKED','INACTIVE') NOT NULL DEFAULT 'ACTIVE',
    failed_login_attempts INT           NOT NULL DEFAULT 0,
    profile_image_path  VARCHAR(255),
    created_at          DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (system_id),
    UNIQUE KEY uq_email (email),
    INDEX idx_role  (role),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- 2. books — Book master catalogue
-- ============================================================
CREATE TABLE IF NOT EXISTS books (
    isbn                VARCHAR(13)     NOT NULL,
    title               VARCHAR(200)    NOT NULL,
    author              VARCHAR(100)    NOT NULL,
    category            ENUM('NOVEL','TEXTBOOK','REFERENCE','MAGAZINE','BIOGRAPHY','SCIENCE','HISTORY','TECHNOLOGY','OTHER') NOT NULL,
    publisher           VARCHAR(150),
    year                SMALLINT,
    description         TEXT,
    language            VARCHAR(50)     DEFAULT 'English',
    pages               SMALLINT,
    total_copies        INT             NOT NULL DEFAULT 1,
    available           INT             NOT NULL DEFAULT 1,
    cover_path          VARCHAR(255),
    status              ENUM('AVAILABLE','ISSUED','RESERVED') NOT NULL DEFAULT 'AVAILABLE',
    added_at            DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (isbn),
    FULLTEXT INDEX ft_title_author (title, author),
    INDEX idx_category (category),
    INDEX idx_status   (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- 3. transactions — Book issue / return records
-- ============================================================
CREATE TABLE IF NOT EXISTS transactions (
    txn_id              BIGINT          NOT NULL AUTO_INCREMENT,
    member_id           VARCHAR(25)     NOT NULL,
    isbn                VARCHAR(13)     NOT NULL,
    issue_date          DATE            NOT NULL,
    due_date            DATE            NOT NULL,
    return_date         DATE,
    status              ENUM('ISSUED','RETURNED','LOST') NOT NULL DEFAULT 'ISSUED',
    issued_by           VARCHAR(25),
    returned_by         VARCHAR(25),
    notes               TEXT,
    created_at          DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (txn_id),
    FOREIGN KEY fk_txn_member (member_id)  REFERENCES users(system_id) ON DELETE RESTRICT,
    FOREIGN KEY fk_txn_isbn   (isbn)       REFERENCES books(isbn)       ON DELETE RESTRICT,
    INDEX idx_txn_member (member_id),
    INDEX idx_txn_isbn   (isbn),
    INDEX idx_txn_status (status),
    INDEX idx_due_date   (due_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- 4. fines — Fine records per transaction
-- ============================================================
CREATE TABLE IF NOT EXISTS fines (
    fine_id             BIGINT          NOT NULL AUTO_INCREMENT,
    txn_id              BIGINT          NOT NULL UNIQUE,
    member_id           VARCHAR(25)     NOT NULL,
    amount              DECIMAL(10,2)   NOT NULL,
    overdue_days        INT             NOT NULL DEFAULT 0,
    daily_rate          DECIMAL(6,2)    NOT NULL DEFAULT 5.00,
    processing_charge   DECIMAL(6,2)    NOT NULL DEFAULT 0.00,
    paid                BOOLEAN         NOT NULL DEFAULT FALSE,
    waived              BOOLEAN         NOT NULL DEFAULT FALSE,
    waiver_reason       TEXT,
    waived_by           VARCHAR(25),
    payment_date        DATE,
    payment_mode        VARCHAR(30),
    receipt_number      VARCHAR(50)     UNIQUE,
    created_at          DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (fine_id),
    FOREIGN KEY fk_fine_txn    (txn_id)    REFERENCES transactions(txn_id) ON DELETE RESTRICT,
    FOREIGN KEY fk_fine_member (member_id) REFERENCES users(system_id)     ON DELETE RESTRICT,
    INDEX idx_fine_member (member_id),
    INDEX idx_fine_paid   (paid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- 5. reservations — Book reservation queue
-- ============================================================
CREATE TABLE IF NOT EXISTS reservations (
    rsv_id              BIGINT          NOT NULL AUTO_INCREMENT,
    member_id           VARCHAR(25)     NOT NULL,
    isbn                VARCHAR(13)     NOT NULL,
    request_date        DATE            NOT NULL DEFAULT (CURDATE()),
    expiry_date         DATE,
    status              ENUM('PENDING','FULFILLED','CANCELLED','EXPIRED') NOT NULL DEFAULT 'PENDING',
    fulfilled_at        DATETIME,
    created_at          DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (rsv_id),
    FOREIGN KEY fk_rsv_member (member_id) REFERENCES users(system_id) ON DELETE CASCADE,
    FOREIGN KEY fk_rsv_isbn   (isbn)      REFERENCES books(isbn)      ON DELETE CASCADE,
    INDEX idx_rsv_member (member_id),
    INDEX idx_rsv_isbn   (isbn),
    INDEX idx_rsv_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- 6. config — System settings (fine rates, limits)
-- ============================================================
CREATE TABLE IF NOT EXISTS config (
    config_key          VARCHAR(50)     NOT NULL,
    config_value        VARCHAR(255)    NOT NULL,
    description         VARCHAR(255),
    updated_at          DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by          VARCHAR(25),

    PRIMARY KEY (config_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT IGNORE INTO config (config_key, config_value, description) VALUES
('fine.rate.novel',       '2.00',  'Daily fine rate (₹) for NOVEL category'),
('fine.rate.textbook',    '5.00',  'Daily fine rate (₹) for TEXTBOOK category'),
('fine.rate.reference',   '10.00', 'Daily fine rate (₹) for REFERENCE category'),
('fine.rate.magazine',    '1.00',  'Daily fine rate (₹) for MAGAZINE category'),
('fine.rate.default',     '5.00',  'Default daily fine rate (₹)'),
('fine.processing.charge','20.00', 'Processing charge added per fine receipt'),
('borrow.limit.student',  '3',     'Max books a student can borrow at once'),
('borrow.duration.days',  '14',    'Default borrow duration in days'),
('login.max.attempts',    '5',     'Max failed logins before account lock');

-- ============================================================
-- 7. audit_log — Security and action trail
-- ============================================================
CREATE TABLE IF NOT EXISTS audit_log (
    log_id              BIGINT          NOT NULL AUTO_INCREMENT,
    user_id             VARCHAR(25),
    action               VARCHAR(30)     NOT NULL,
    description         TEXT,
    ip_address          VARCHAR(45),
    user_agent          VARCHAR(255),
    created_at          DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (log_id),
    INDEX idx_audit_user   (user_id),
    INDEX idx_audit_action (action),
    INDEX idx_audit_time   (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- 8. announcements — Admin system-wide notices
-- ============================================================
CREATE TABLE IF NOT EXISTS announcements (
    ann_id              BIGINT          NOT NULL AUTO_INCREMENT,
    created_by          VARCHAR(25)     NOT NULL,
    title               VARCHAR(200)    NOT NULL,
    message             TEXT            NOT NULL,
    target_role         ENUM('ALL','STU','LIB','ADM') NOT NULL DEFAULT 'ALL',
    active              BOOLEAN         NOT NULL DEFAULT TRUE,
    created_at          DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    expires_at          DATETIME,

    PRIMARY KEY (ann_id),
    FOREIGN KEY fk_ann_creator (created_by) REFERENCES users(system_id) ON DELETE RESTRICT,
    INDEX idx_ann_active (active),
    INDEX idx_ann_role   (target_role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- 9. ai_cache — Gemini API recommendation cache (24h TTL)
-- ============================================================
CREATE TABLE IF NOT EXISTS ai_cache (
    member_id           VARCHAR(25)     NOT NULL,
    recommendations     JSON            NOT NULL,
    cached_at           DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (member_id),
    FOREIGN KEY fk_ai_member (member_id) REFERENCES users(system_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE TABLE IF NOT EXISTS password_reset_tokens (
    reset_id             BIGINT          NOT NULL AUTO_INCREMENT,
    token                VARCHAR(64)     NOT NULL,
    user_id              VARCHAR(25)     NOT NULL,
    expires_at           DATETIME        NOT NULL,
    used_at              DATETIME,
    created_at           DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (reset_id),
    UNIQUE KEY uq_prt_token (token),
    FOREIGN KEY fk_prt_user (user_id) REFERENCES users(system_id) ON DELETE CASCADE,
    INDEX idx_prt_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SHOW TABLES;