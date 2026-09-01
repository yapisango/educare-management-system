-- ============================================================================
-- EduCare Management System
-- EDGE (EduCare Data Generator Engine)
-- ----------------------------------------------------------------------------
-- Seed: 004_user_roles.sql
--
-- Purpose
-- --------
-- Assigns each generated user a role and school.
--
-- School:
--   EduCare High School (school_id = 1)
--
-- Role mapping:
--   SUPER_ADMIN  -> System Administrator
--   SCHOOL_ADMIN -> Principal
--   TEACHER      -> Teacher
--   LEARNER      -> Learner
--   GUARDIAN     -> Guardian
--
-- This script is safe to rerun.
-- ============================================================================

BEGIN;

-- ============================================================================
-- REMOVE EXISTING USER-ROLE ASSIGNMENTS
-- ============================================================================

TRUNCATE TABLE user_roles RESTART IDENTITY;

-- ============================================================================
-- GENERATE USER ROLE ASSIGNMENTS
-- ============================================================================

INSERT INTO user_roles
(
    user_id,
    role_id,
    school_id,
    created_at,
    created_by,
    is_active
)

SELECT
    u.id,

    CASE u.role

        WHEN 'SUPER_ADMIN'::user_role
            THEN 1

        WHEN 'SCHOOL_ADMIN'::user_role
            THEN 2

        WHEN 'TEACHER'::user_role
            THEN 4

        WHEN 'LEARNER'::user_role
            THEN 6

        WHEN 'GUARDIAN'::user_role
            THEN 5

    END AS role_id,

    1 AS school_id,

    NOW() AS created_at,

    NULL AS created_by,

    TRUE AS is_active

FROM users u

WHERE u.is_active = TRUE;

COMMIT;

-- ============================================================================
-- VERIFICATION
-- ============================================================================


-- ============================================================================
-- 1. TOTAL USER-ROLE ASSIGNMENTS
-- ============================================================================

SELECT
    COUNT(*) AS total_user_roles
FROM user_roles;


-- ============================================================================
-- 2. USERS BY ASSIGNED ROLE
-- ============================================================================
-- IMPORTANT:
-- This verifies the role actually stored in user_roles.
-- ============================================================================

SELECT
    r.role_name,
    COUNT(ur.user_id) AS total_users

FROM user_roles ur

JOIN roles r
    ON r.id = ur.role_id

WHERE ur.is_active = TRUE

GROUP BY
    r.role_name

ORDER BY
    r.role_name;


-- ============================================================================
-- 3. USERS BY SCHOOL
-- ============================================================================

SELECT
    s.school_name,
    COUNT(*) AS total

FROM user_roles ur

JOIN schools s
    ON s.id = ur.school_id

WHERE ur.is_active = TRUE

GROUP BY
    s.school_name

ORDER BY
    s.school_name;


-- ============================================================================
-- 4. VERIFY THAT EVERY ACTIVE USER HAS A ROLE
-- ============================================================================

SELECT
    COUNT(*) AS active_users_without_role

FROM users u

LEFT JOIN user_roles ur
    ON ur.user_id = u.id
    AND ur.is_active = TRUE

WHERE u.is_active = TRUE
  AND ur.id IS NULL;


-- ============================================================================
-- 5. SAMPLE ASSIGNMENTS
-- ============================================================================

SELECT
    ur.id,
    u.id AS user_id,
    u.username,
    u.first_name,
    u.last_name,
    r.role_name,
    s.school_name,
    ur.is_active

FROM user_roles ur

JOIN users u
    ON u.id = ur.user_id

JOIN roles r
    ON r.id = ur.role_id

JOIN schools s
    ON s.id = ur.school_id

ORDER BY
    ur.id

LIMIT 20;


-- ============================================================================
-- 6. VERIFY ASSIGNMENT COUNTS AGAINST USERS
-- ============================================================================

SELECT
    u.role AS user_role,
    COUNT(u.id) AS users,
    COUNT(ur.id) AS role_assignments

FROM users u

LEFT JOIN user_roles ur
    ON ur.user_id = u.id
    AND ur.is_active = TRUE

WHERE u.is_active = TRUE

GROUP BY
    u.role

ORDER BY
    u.role;