-- ============================================================================
-- EduCare Management System
-- EDGE (EduCare Data Generator Engine)
-- ----------------------------------------------------------------------------
-- Function:
-- edge_random_email_domain()
--
-- Purpose:
-- Returns one random active email domain.
--
-- Safe to rerun.
-- ============================================================================

CREATE OR REPLACE FUNCTION edge_random_email_domain()

RETURNS VARCHAR

LANGUAGE sql

AS
$$

SELECT domain

FROM generator_email_domains

WHERE is_active = TRUE

ORDER BY random()

LIMIT 1;

$$;

-- ============================================================================
-- Test
-- ============================================================================

SELECT edge_random_email_domain();

SELECT
    edge_random_email_domain(),
    edge_random_email_domain(),
    edge_random_email_domain();