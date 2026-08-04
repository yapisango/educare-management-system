-- ============================================================================
-- EduCare Management System
-- EDGE (EduCare Data Generator Engine)
-- ----------------------------------------------------------------------------
-- Function:
-- edge_random_street()
--
-- Returns one random active street name.
-- ============================================================================

CREATE OR REPLACE FUNCTION edge_random_street()
RETURNS VARCHAR
LANGUAGE sql
AS
$$

SELECT street_name

FROM generator_streets

WHERE is_active = TRUE

ORDER BY random()

LIMIT 1;

$$;

-- ============================================================================
-- Test
-- ============================================================================

SELECT edge_random_street();

SELECT
    edge_random_street(),
    edge_random_street(),
    edge_random_street();