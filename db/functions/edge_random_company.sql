-- ============================================================================
-- EduCare Management System
-- EDGE (EduCare Data Generator Engine)
-- ----------------------------------------------------------------------------
-- Function:
-- edge_random_company()
--
-- Purpose:
-- Returns one random active company.
--
-- Safe to rerun.
-- ============================================================================

CREATE OR REPLACE FUNCTION edge_random_company()

RETURNS VARCHAR

LANGUAGE sql

AS
$$

SELECT company_name

FROM generator_companies

WHERE is_active = TRUE

ORDER BY random()

LIMIT 1;

$$;

-- ============================================================================
-- Test
-- ============================================================================

SELECT edge_random_company();

SELECT

    edge_random_company(),
    edge_random_company(),
    edge_random_company();