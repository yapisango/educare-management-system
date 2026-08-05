-- ============================================================================
-- EduCare Management System
-- EDGE (EduCare Data Generator Engine)
-- ----------------------------------------------------------------------------
-- Seed: 003_users.sql
--
-- Purpose:
-- Generates realistic demo people using the EDGE random generators.
--
-- Dependencies:
--   enums.sql
--   schema.sql
--   generator_first_names
--   generator_last_names
--   generator_addresses
--   generator_email_domains
--   generator_phone_prefixes
--   generator_companies
--
-- Safe to rerun.
-- ============================================================================

BEGIN;

-- ----------------------------------------------------------
-- Remove existing demo data
-- ----------------------------------------------------------

DELETE FROM users;

-- ----------------------------------------------------------
-- Generate 1000 users
-- ----------------------------------------------------------

INSERT INTO users
(
    first_name,
    last_name,
    email,
    phone,
    password_hash,
    role,
    account_status
)
SELECT

    fn.first_name,

    ln.last_name,

    LOWER(
        fn.first_name || '.' ||
        ln.last_name || gs.i || '@' ||
        edge_random_email_domain()
    ),

    edge_random_phone_number(),

    '$2b$12$CHANGE_THIS_TO_A_REAL_BCRYPT_HASH',

    CASE
        WHEN gs.i <= 1 THEN 'PRINCIPAL'::user_role
        WHEN gs.i <= 5 THEN 'ADMIN'::user_role
        WHEN gs.i <= 85 THEN 'TEACHER'::user_role
        WHEN gs.i <= 110 THEN 'STAFF'::user_role
        WHEN gs.i <= 910 THEN 'LEARNER'::user_role
        ELSE 'PARENT'::user_role
    END,

    'ACTIVE'::account_status

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

SELECT *
FROM users
LIMIT 20;