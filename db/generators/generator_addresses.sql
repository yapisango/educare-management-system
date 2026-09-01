-- ============================================================================
-- EduCare Management System
-- EDGE (EduCare Data Generator Engine)
-- ----------------------------------------------------------------------------
-- Generator Table: Addresses
--
-- Purpose:
-- Stores realistic South African addresses generated from EDGE functions.
--
-- Safe to rerun.
-- ============================================================================

BEGIN;

DROP TABLE IF EXISTS generator_addresses;

CREATE TABLE generator_addresses
(
    id              BIGSERIAL PRIMARY KEY,

    house_number    INTEGER NOT NULL,

    street_name     VARCHAR(150) NOT NULL,

    city            VARCHAR(100) NOT NULL,

    province        VARCHAR(100) NOT NULL,

    postal_code     VARCHAR(10) NOT NULL,

    is_active       BOOLEAN NOT NULL DEFAULT TRUE,

    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================================
-- Generate 1 000 Addresses
-- ============================================================================

INSERT INTO public.generator_addresses
(
    house_number,
    street_name,
    city,
    province,
    postal_code
)
SELECT
    FLOOR(random() * 999 + 1)::INTEGER,
    edge_random_street(),
    c.city,
    c.province,
    c.postal_code
FROM generate_series(1, 1000) AS gs(n)
CROSS JOIN LATERAL
(
    SELECT
        city,
        province,
        postal_code
    FROM public.generator_cities
    WHERE is_active = TRUE
    ORDER BY random() + (gs.n * 0)
    LIMIT 1
) AS c;

COMMIT;

-- ============================================================================
-- Verification
-- ============================================================================

SELECT COUNT(*) AS total_addresses
FROM generator_addresses;

SELECT *
FROM generator_addresses
LIMIT 20;