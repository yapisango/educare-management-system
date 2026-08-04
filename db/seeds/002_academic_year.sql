-- ============================================================================
-- EduCare School Management System
-- Seed File : 002_academic_year.sql
-- Description:
-- Creates the default Academic Year and School Terms.
-- This script is safe to rerun.
-- ============================================================================

BEGIN;

-- ============================================================================
-- 2026 ACADEMIC YEAR
-- ============================================================================

INSERT INTO academic_years
(
    school_id,
    academic_year_name,
    start_date,
    end_date,
    is_current
)

SELECT
    s.id,
    '2026',
    DATE '2026-01-15',
    DATE '2026-12-10',
    TRUE

FROM schools s

WHERE s.school_code = 'ECHS001'

AND NOT EXISTS
(
    SELECT 1
    FROM academic_years ay
    WHERE ay.school_id = s.id
      AND ay.academic_year_name = '2026'
);

-- ============================================================================
-- TERMS
-- ============================================================================

INSERT INTO terms
(
    academic_year_id,
    term_number,
    term_name,
    start_date,
    end_date,
    is_current
)

SELECT
    ay.id,
    t.term_number,
    t.term_name,
    t.start_date,
    t.end_date,
    t.is_current

FROM academic_years ay

CROSS JOIN
(
    VALUES

    (1, 'Term 1', DATE '2026-01-15', DATE '2026-03-28', FALSE),
    (2, 'Term 2', DATE '2026-04-08', DATE '2026-06-21', FALSE),
    (3, 'Term 3', DATE '2026-07-16', DATE '2026-09-27', TRUE),
    (4, 'Term 4', DATE '2026-10-08', DATE '2026-12-10', FALSE)

) AS t
(
    term_number,
    term_name,
    start_date,
    end_date,
    is_current
)

WHERE ay.academic_year_name = '2026'

AND NOT EXISTS
(
    SELECT 1
    FROM terms tt
    WHERE tt.academic_year_id = ay.id
      AND tt.term_number = t.term_number
);

-- ============================================================================
-- VERIFY ACADEMIC YEAR
-- ============================================================================

SELECT
    id,
    academic_year_name,
    start_date,
    end_date,
    is_current
FROM academic_years
ORDER BY id;

-- ============================================================================
-- VERIFY TERMS
-- ============================================================================

SELECT
    term_number,
    term_name,
    start_date,
    end_date,
    is_current
FROM terms
ORDER BY term_number;

COMMIT;