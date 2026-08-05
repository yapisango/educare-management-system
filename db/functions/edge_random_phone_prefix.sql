-- ============================================================================
-- EduCare Management System
-- EDGE (EduCare Data Generator Engine)
-- ----------------------------------------------------------------------------
-- Function:
-- edge_random_phone_prefix()
--
-- Purpose:
-- Returns one random active South African phone prefix.
--
-- Safe to rerun.
-- ============================================================================

CREATE OR REPLACE FUNCTION edge_random_phone_prefix()

RETURNS VARCHAR

LANGUAGE sql

AS
$$

SELECT prefix

FROM generator_phone_prefixes

WHERE is_active = TRUE

ORDER BY random()

LIMIT 1;

$$;

-- ============================================================================
-- Test
-- ============================================================================

SELECT edge_random_phone_prefix();

SELECT
    edge_random_phone_prefix(),
    edge_random_phone_prefix(),
    edge_random_phone_prefix();