-- ============================================================================
-- EduCare Management System
-- EDGE (EduCare Data Generator Engine)
-- ----------------------------------------------------------------------------
-- Function:
-- edge_random_gender()
--
-- Purpose:
-- Returns a random valid gender_type value.
--
-- Valid values:
-- MALE
-- FEMALE
-- OTHER
-- ============================================================================

CREATE OR REPLACE FUNCTION edge_random_gender()

RETURNS gender_type

LANGUAGE sql

AS
$$

SELECT
    CASE
        WHEN r < 0.50 THEN 'MALE'::gender_type
        WHEN r < 0.90 THEN 'FEMALE'::gender_type
        ELSE 'OTHER'::gender_type
    END
FROM
(
    SELECT random() AS r
) AS x;

$$;

-- ============================================================================
-- Test
-- ============================================================================

SELECT edge_random_gender();

SELECT
    edge_random_gender(),
    edge_random_gender(),
    edge_random_gender();