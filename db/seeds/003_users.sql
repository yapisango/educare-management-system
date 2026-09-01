-- ============================================================================
-- EduCare Management System
-- EDGE (EduCare Data Generator Engine)
-- ----------------------------------------------------------------------------
-- Seed: 003_users.sql
--
-- Purpose
-- --------
-- Generates 1,000 realistic demo users for the EduCare Management System.
--
-- User distribution
-- -----------------
-- 1       SUPER_ADMIN
-- 29      SCHOOL_ADMIN
-- 80      TEACHER
-- 800     LEARNER
-- 90      GUARDIAN
--
-- Total: 1,000 users
--
-- This script is safe to rerun.
-- ============================================================================

BEGIN;

-- ============================================================================
-- Remove existing users
-- ============================================================================

TRUNCATE TABLE users RESTART IDENTITY CASCADE;

-- ============================================================================
-- Generate Demo Users
-- ============================================================================

INSERT INTO users
(
    first_name,
    last_name,
    email,
    phone,
    date_of_birth,
    gender,
    username,
    password_hash,
    role,
    last_login,
    is_active
)

SELECT

    -- ========================================================================
    -- First Name
    -- ========================================================================

    fn.first_name,

    -- ========================================================================
    -- Last Name
    -- ========================================================================

    fn.last_name,

    -- ========================================================================
    -- Email
    --
    -- Uses the SAME first name and last name as the user record.
    -- Sequence number guarantees uniqueness.
    -- ========================================================================

    LOWER(
        REGEXP_REPLACE(
            fn.first_name ||
            '.' ||
            fn.last_name ||
            LPAD(gs.i::TEXT, 4, '0') ||
            '@' ||
            edge_random_email_domain(),
            '[^a-zA-Z0-9.@_-]',
            '',
            'g'
        )
    ),

    -- ========================================================================
    -- Phone
    -- ========================================================================

    edge_random_phone_number(),

    -- ========================================================================
    -- Date of Birth
    -- ========================================================================

    CASE

        -- SUPER_ADMIN
        WHEN gs.i = 1
            THEN edge_random_birth_date(40, 65)

        -- SCHOOL_ADMIN users 2–5
        WHEN gs.i <= 5
            THEN edge_random_birth_date(35, 60)

        -- TEACHERS users 6–85
        WHEN gs.i <= 85
            THEN edge_random_birth_date(24, 65)

        -- SCHOOL_ADMIN users 86–110
        WHEN gs.i <= 110
            THEN edge_random_birth_date(30, 60)

        -- LEARNERS users 111–910
        WHEN gs.i <= 910
            THEN edge_random_birth_date(13, 18)

        -- GUARDIANS users 911–1000
        ELSE
            edge_random_birth_date(28, 70)

    END,

    -- ========================================================================
    -- Gender
    --
    -- edge_random_gender() returns VARCHAR.
    -- users.gender requires gender_type.
    -- ========================================================================

    edge_random_gender()::gender_type,

    -- ========================================================================
    -- Username
    --
    -- Uses the SAME first name and last name as the user record.
    --
    -- Examples:
    --
    -- sibusiso.nkosi_0001
    -- thandi.mabena_0002
    -- neo.vanwyk_0003
    --
    -- Sequence number guarantees uniqueness.
    -- ========================================================================

    LOWER(
        REGEXP_REPLACE(
            fn.first_name ||
            '.' ||
            fn.last_name ||
            '_' ||
            LPAD(gs.i::TEXT, 4, '0'),
            '[^a-zA-Z0-9._-]',
            '',
            'g'
        )
    ),

    -- ========================================================================
    -- Password
    --
    -- Placeholder bcrypt hash.
    -- Replace when authentication testing is required.
    -- ========================================================================

    '$2b$12$CHANGE_THIS_WITH_REAL_BCRYPT_HASH',

    -- ========================================================================
    -- User Role
    --
    -- Actual enum values:
    --
    -- SUPER_ADMIN
    -- SCHOOL_ADMIN
    -- TEACHER
    -- LEARNER
    -- GUARDIAN
    -- ========================================================================

    CASE

        -- User 1
        WHEN gs.i = 1
            THEN 'SUPER_ADMIN'::user_role

        -- Users 2–5
        WHEN gs.i <= 5
            THEN 'SCHOOL_ADMIN'::user_role

        -- Users 6–85
        WHEN gs.i <= 85
            THEN 'TEACHER'::user_role

        -- Users 86–110
        WHEN gs.i <= 110
            THEN 'SCHOOL_ADMIN'::user_role

        -- Users 111–910
        WHEN gs.i <= 910
            THEN 'LEARNER'::user_role

        -- Users 911–1000
        ELSE
            'GUARDIAN'::user_role

    END,

    -- ========================================================================
    -- Last Login
    --
    -- Approximately 10% have never logged in.
    -- Others logged in sometime during the last 30 days.
    -- ========================================================================

    CASE

        WHEN random() < 0.10
            THEN NULL

        ELSE
            NOW() -
            (random() * INTERVAL '30 days')

    END,

    -- ========================================================================
    -- Active
    -- ========================================================================

    TRUE

FROM generate_series(1, 1000) AS gs(i)

-- ============================================================================
-- Generate ONE random first name and ONE random surname PER USER
--
-- The reference to gs.i makes this a row-correlated LATERAL operation.
-- fn.first_name and fn.last_name are then reused for:
--
--   users.first_name
--   users.last_name
--   users.email
--   users.username
--
-- This prevents inconsistent records such as:
--
--   first_name = Sibusiso
--   last_name  = Nkosi
--   username   = thandi.green_0001
-- ============================================================================

CROSS JOIN LATERAL
(
    SELECT
        edge_random_first_name() AS first_name,
        edge_random_last_name() AS last_name,
        gs.i AS user_sequence

) fn;

-- ============================================================================
-- Finish Transaction
-- ============================================================================

COMMIT;

-- ============================================================================
-- Verification
-- ============================================================================

-- ============================================================================
-- Total users
-- ============================================================================

SELECT
    COUNT(*) AS total_users
FROM users;

-- ============================================================================
-- Users by role
-- ============================================================================

SELECT
    role,
    COUNT(*) AS total
FROM users
GROUP BY role
ORDER BY role;

-- ============================================================================
-- Users by gender
-- ============================================================================

SELECT
    gender,
    COUNT(*) AS total
FROM users
GROUP BY gender
ORDER BY gender;

-- ============================================================================
-- Check username uniqueness
-- ============================================================================

SELECT
    COUNT(*) AS total_usernames,
    COUNT(DISTINCT username) AS unique_usernames
FROM users;

-- ============================================================================
-- Check email uniqueness
-- ============================================================================

SELECT
    COUNT(*) AS total_emails,
    COUNT(DISTINCT email) AS unique_emails
FROM users;

-- ============================================================================
-- Check name diversity
-- ============================================================================

SELECT
    COUNT(DISTINCT first_name) AS unique_first_names,
    COUNT(DISTINCT last_name) AS unique_last_names
FROM users;

-- ============================================================================
-- Check for duplicate usernames
-- ============================================================================

SELECT
    username,
    COUNT(*) AS occurrences
FROM users
GROUP BY username
HAVING COUNT(*) > 1
ORDER BY occurrences DESC, username;

-- ============================================================================
-- Check for duplicate emails
-- ============================================================================

SELECT
    email,
    COUNT(*) AS occurrences
FROM users
GROUP BY email
HAVING COUNT(*) > 1
ORDER BY occurrences DESC, email;

-- ============================================================================
-- Sample users
-- ============================================================================

SELECT
    id,
    username,
    first_name,
    last_name,
    email,
    phone,
    date_of_birth,
    gender,
    role
FROM users
ORDER BY id
LIMIT 20;