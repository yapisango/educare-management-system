-- ============================================================================
-- EduCare School Management System
-- Seed File : 007_classes.sql
--
-- Purpose
-- --------
-- Creates school sections and classes for the 2026 academic year.
--
-- Structure
-- ---------
-- School:
--   EduCare High School
--
-- Grades:
--   Grade 8
--   Grade 9
--   Grade 10
--   Grade 11
--   Grade 12
--
-- Sections:
--   A
--   B
--   C
--   D
--
-- Classes:
--   5 grades x 4 sections = 20 classes
--
-- Safe to rerun.
-- ============================================================================

BEGIN;

-- ============================================================================
-- 1. CREATE SECTIONS
-- ============================================================================
--
-- Sections belong to the school, not directly to a grade.
--
-- ============================================================================

INSERT INTO sections
(
    school_id,
    section_name,
    section_code,
    display_order,
    is_active
)

SELECT
    s.id,
    sec.section_name,
    sec.section_code,
    sec.display_order,
    TRUE

FROM schools s

CROSS JOIN
(
    VALUES
        ('Section A', 'A', 1),
        ('Section B', 'B', 2),
        ('Section C', 'C', 3),
        ('Section D', 'D', 4)
) AS sec
(
    section_name,
    section_code,
    display_order
)

WHERE s.school_code = 'ECHS001'

AND NOT EXISTS
(
    SELECT 1
    FROM sections existing
    WHERE existing.school_id = s.id
      AND existing.section_code = sec.section_code
);

-- ============================================================================
-- 2. CREATE CLASSES
-- ============================================================================
--
-- Creates one class for every Grade + Section combination.
--
-- Example:
--
-- Grade 8 A
-- Grade 8 B
-- Grade 8 C
-- Grade 8 D
--
-- ...
--
-- Grade 12 A
-- Grade 12 B
-- Grade 12 C
-- Grade 12 D
--
-- ============================================================================

INSERT INTO classes
(
    school_id,
    academic_year_id,
    grade_id,
    section_id,
    class_name,
    classroom,
    capacity,
    is_active
)

SELECT
    s.id AS school_id,

    ay.id AS academic_year_id,

    g.id AS grade_id,

    sec.id AS section_id,

    g.grade_name || ' ' || sec.section_code AS class_name,

    'Room ' ||
        LPAD(
            (
                100
                + ((g.display_order - 1) * 4)
                + sec.display_order
            )::TEXT,
            3,
            '0'
        ) AS classroom,

    30 AS capacity,

    TRUE AS is_active

FROM schools s

JOIN academic_years ay
    ON ay.school_id = s.id
   AND ay.academic_year_name = '2026'

JOIN grades g
    ON g.school_id = s.id
   AND g.is_active = TRUE

CROSS JOIN sections sec

WHERE s.school_code = 'ECHS001'

  AND sec.school_id = s.id
  AND sec.is_active = TRUE

  AND NOT EXISTS
  (
      SELECT 1
      FROM classes c
      WHERE c.school_id = s.id
        AND c.academic_year_id = ay.id
        AND c.grade_id = g.id
        AND c.section_id = sec.id
  );

COMMIT;

-- ============================================================================
-- VERIFICATION
-- ============================================================================

-- ============================================================================
-- 1. Verify sections
-- ============================================================================

SELECT
    id,
    school_id,
    section_name,
    section_code,
    display_order,
    is_active
FROM sections
ORDER BY
    school_id,
    display_order;

-- ============================================================================
-- 2. Verify classes
-- ============================================================================

SELECT
    c.id,
    c.school_id,
    ay.academic_year_name,
    g.grade_name,
    sec.section_name,
    sec.section_code,
    c.class_name,
    c.classroom,
    c.capacity,
    c.is_active
FROM classes c

JOIN academic_years ay
    ON ay.id = c.academic_year_id

JOIN grades g
    ON g.id = c.grade_id

JOIN sections sec
    ON sec.id = c.section_id

ORDER BY
    g.display_order,
    sec.display_order;

-- ============================================================================
-- 3. Count sections
-- ============================================================================

SELECT
    COUNT(*) AS total_sections
FROM sections
WHERE school_id = 1;

-- ============================================================================
-- 4. Count classes
-- ============================================================================

SELECT
    COUNT(*) AS total_classes
FROM classes
WHERE school_id = 1;

-- ============================================================================
-- 5. Classes by grade
-- ============================================================================

SELECT
    g.grade_name,
    COUNT(c.id) AS total_classes
FROM classes c

JOIN grades g
    ON g.id = c.grade_id

WHERE c.school_id = 1

GROUP BY
    g.id,
    g.grade_name,
    g.display_order

ORDER BY
    g.display_order;