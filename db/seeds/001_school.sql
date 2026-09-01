-- ============================================================================
-- EduCare School Management System
-- Seed File : 001_school.sql
-- Description:
-- Creates the default school for the EduCare Management System.
-- This script is safe to rerun.
-- ============================================================================

BEGIN;

-- ============================================================================
-- DEFAULT SCHOOL
-- ============================================================================

INSERT INTO schools
(
    school_name,
    school_code,
    email,
    phone,
    address,
    principal_name,
    is_active
)

SELECT
    'EduCare High School',
    'ECHS001',
    'info@educare.co.za',
    '0115551234',
    '123 Main Road, Johannesburg',
    'Mr John Smith',
    TRUE

WHERE NOT EXISTS
(
    SELECT 1
    FROM schools
    WHERE school_code = 'ECHS001'
);

-- ============================================================================
-- VERIFY
-- ============================================================================

SELECT
    id,
    school_name,
    school_code,
    email,
    phone,
    address,
    principal_name,
    is_active
FROM schools
WHERE school_code = 'ECHS001';

COMMIT;