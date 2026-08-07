-- ============================================================================
-- EduCare Management System
-- EDGE (EduCare Data Generator Engine)
-- ----------------------------------------------------------------------------
-- Seed: 002_users.sql
--
-- Purpose
-- --------
-- Generates realistic demo users for the EduCare Management System.
--
-- This script is safe to rerun.
-- ============================================================================
--

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

    fn.first_name,

    ln.last_name,

    LOWER(
        fn.first_name || '.' ||
        ln.last_name ||
        LPAD(gs.i::TEXT,3,'0')
        || '@' ||
        edge_random_email_domain()
    ),

    edge_random_phone_number(),

    CASE

        WHEN gs.i = 1
            THEN edge_random_birth_date(40,65)

        WHEN gs.i <= 5
            THEN edge_random_birth_date(28,60)

        WHEN gs.i <= 85
            THEN edge_random_birth_date(24,65)

        WHEN gs.i <= 110
            THEN edge_random_birth_date(22,60)

        WHEN gs.i <= 910
            THEN edge_random_birth_date(13,18)

        ELSE
            edge_random_birth_date(28,70)

    END,

    edge_random_gender(),

    edge_random_username
    (
        fn.first_name,
        ln.last_name,
        gs.i
    ),

    '$2b$12$CHANGE_THIS_WITH_REAL_BCRYPT_HASH',

    CASE

        WHEN gs.i = 1
            THEN 'PRINCIPAL'::user_role

        WHEN gs.i <= 5
            THEN 'ADMIN'::user_role

        WHEN gs.i <= 85
            THEN 'TEACHER'::user_role

        WHEN gs.i <= 110
            THEN 'STAFF'::user_role

        WHEN gs.i <= 910
            THEN 'LEARNER'::user_role

        ELSE
            'PARENT'::user_role

    END,

    CASE

        WHEN random() < 0.10
            THEN NULL

        ELSE
            NOW() -
            (random() * INTERVAL '30 days')

    END,

    TRUE

FROM generate_series(1,1000) gs(i)

CROSS JOIN LATERAL
(
    SELECT edge_random_first_name() AS first_name
) fn

CROSS JOIN LATERAL
(
    SELECT edge_random_last_name() AS last_name
) ln;

COMMIT;

-- ============================================================================
-- Verification
-- ============================================================================

SELECT COUNT(*) AS total_users
FROM users;

SELECT role, COUNT(*)
FROM users
GROUP BY role
ORDER BY role;

SELECT
    id,
    username,
    first_name,
    last_name,
    role
FROM users
LIMIT 20;