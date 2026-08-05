-- ============================================================================
-- EduCare Management System
-- EDGE (EduCare Data Generator Engine)
-- ----------------------------------------------------------------------------
-- Function:
-- edge_random_gender()
--
-- Purpose:
-- Returns a random gender.
--
-- Safe to rerun.
-- ============================================================================

CREATE OR REPLACE FUNCTION edge_random_gender()

RETURNS gender

LANGUAGE sql

AS
$$

SELECT

CASE

    WHEN random() < 0.5

    THEN 'MALE'::gender

    ELSE 'FEMALE'::gender

END;

$$;

-- ============================================================================
-- Test
-- ============================================================================

SELECT edge_random_gender();

SELECT

    edge_random_gender(),
    edge_random_gender(),
    edge_random_gender(),
    edge_random_gender(),
    edge_random_gender();