-- ============================================================================
-- EduCare Management System
-- EDGE (EduCare Data Generator Engine)
-- ----------------------------------------------------------------------------
-- Function:
-- edge_random_city()
--
-- Returns one random active city.
--
-- Safe to rerun.
-- ============================================================================

CREATE OR REPLACE FUNCTION edge_random_city()

RETURNS VARCHAR

LANGUAGE sql

AS
$$

SELECT city

FROM generator_cities

WHERE is_active = TRUE

ORDER BY random()

LIMIT 1;

$$;

-- ============================================================================
-- Test
-- ============================================================================

SELECT edge_random_city();