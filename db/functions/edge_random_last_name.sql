-- ============================================================================
-- EDGE
-- ----------------------------------------------------------------------------
-- Function:
-- edge_random_last_name()
--
-- Returns one random active surname.
-- ============================================================================

CREATE OR REPLACE FUNCTION edge_random_last_name()

RETURNS VARCHAR

LANGUAGE sql

AS
$$

SELECT last_name

FROM generator_last_names

WHERE is_active = TRUE

ORDER BY random()

LIMIT 1;

$$;

-- ============================================================================
-- Test
-- ============================================================================

SELECT edge_random_last_name();