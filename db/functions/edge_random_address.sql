-- ============================================================================
-- EduCare Management System
-- EDGE (EduCare Data Generator Engine)
-- ----------------------------------------------------------------------------
-- Function:
-- edge_random_address()
--
-- Returns one random complete address.
-- ============================================================================

CREATE OR REPLACE FUNCTION edge_random_address()

RETURNS TABLE
(
    house_number INTEGER,
    street_name  VARCHAR,
    city         VARCHAR,
    province     VARCHAR,
    postal_code  VARCHAR
)

LANGUAGE sql

AS
$$

SELECT

    house_number,
    street_name,
    city,
    province,
    postal_code

FROM generator_addresses

WHERE is_active = TRUE

ORDER BY random()

LIMIT 1;

$$;

-- ============================================================================
-- Test
-- ============================================================================

SELECT *
FROM edge_random_address();