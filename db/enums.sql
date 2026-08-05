-- ============================================================================
-- EduCare Management System
-- Database Enums
-- ----------------------------------------------------------------------------
-- File: enums.sql
--
-- Description:
-- Central location for all PostgreSQL ENUM types used throughout EduCare.
--
-- Run this BEFORE schema.sql.
--
-- Safe to rerun.
-- ============================================================================

BEGIN;

-- ============================================================================
-- Gender
-- ============================================================================

DROP TYPE IF EXISTS gender CASCADE;

CREATE TYPE gender AS ENUM
(
    'MALE',
    'FEMALE'
);

-- ============================================================================
-- Person Roles
-- ============================================================================

DROP TYPE IF EXISTS person_role CASCADE;

CREATE TYPE person_role AS ENUM
(
    'LEARNER',
    'GUARDIAN',
    'TEACHER',
    'STAFF',
    'ADMIN'
);

-- ============================================================================
-- School Status
-- ============================================================================

DROP TYPE IF EXISTS school_status CASCADE;

CREATE TYPE school_status AS ENUM
(
    'ACTIVE',
    'INACTIVE',
    'ARCHIVED'
);

-- ============================================================================
-- Attendance
-- ============================================================================

DROP TYPE IF EXISTS attendance_status CASCADE;

CREATE TYPE attendance_status AS ENUM
(
    'PRESENT',
    'ABSENT',
    'LATE',
    'EXCUSED'
);

-- ============================================================================
-- Payment Status
-- ============================================================================

DROP TYPE IF EXISTS payment_status CASCADE;

CREATE TYPE payment_status AS ENUM
(
    'PENDING',
    'PAID',
    'OVERDUE',
    'CANCELLED'
);

-- ============================================================================
-- Assessment Types
-- ============================================================================

DROP TYPE IF EXISTS assessment_type CASCADE;

CREATE TYPE assessment_type AS ENUM
(
    'HOMEWORK',
    'CLASS_TEST',
    'ASSIGNMENT',
    'PROJECT',
    'EXAM'
);

-- ============================================================================
-- Library Item Status
-- ============================================================================

DROP TYPE IF EXISTS library_item_status CASCADE;

CREATE TYPE library_item_status AS ENUM
(
    'AVAILABLE',
    'LOANED',
    'LOST',
    'DAMAGED'
);

-- ============================================================================
-- User Account Status
-- ============================================================================

DROP TYPE IF EXISTS account_status CASCADE;

CREATE TYPE account_status AS ENUM
(
    'ACTIVE',
    'LOCKED',
    'DISABLED'
);

COMMIT;

-- ============================================================================
-- Verification
-- ============================================================================

SELECT typname
FROM pg_type
WHERE typname IN
(
    'gender',
    'person_role',
    'school_status',
    'attendance_status',
    'payment_status',
    'assessment_type',
    'library_item_status',
    'account_status'
)
ORDER BY typname;