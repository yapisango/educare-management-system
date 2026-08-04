-- ==========================================================
-- EDGE
-- Function:
-- edge_random_first_name()
--
-- Returns one random active first name.
-- ==========================================================

CREATE OR REPLACE FUNCTION edge_random_first_name()

RETURNS VARCHAR

LANGUAGE sql

AS
$$

SELECT first_name

FROM generator_first_names

WHERE is_active = TRUE

ORDER BY random()

LIMIT 1;

$$;

-- ============================================================================
-- Test
-- ============================================================================

-- SELECT edge_random_first_name();