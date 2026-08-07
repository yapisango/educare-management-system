-- ============================================================================
-- EduCare Management System
-- EDGE (EduCare Data Generator Engine)
-- ----------------------------------------------------------------------------
-- Function:
-- edge_random_gender()
--
-- Purpose:
-- Returns a random gender value.
--
-- Values:
-- Male
-- Female
--
-- Example:
-- SELECT edge_random_gender();
-- ============================================================================

CREATE OR REPLACE FUNCTION edge_random_gender()

RETURNS VARCHAR

LANGUAGE sql

AS
$$

SELECT
(
    ARRAY[
        'Male',
        'Female'
    ]
)[
    FLOOR(random() * 2 + 1)::INTEGER
];

$$;

-- ============================================================================
-- Tests
-- ============================================================================

SELECT edge_random_gender();

SELECT
    edge_random_gender(),
    edge_random_gender(),
    edge_random_gender(),
    edge_random_gender(),
    edge_random_gender();