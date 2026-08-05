-- ============================================================================
-- EduCare Management System
-- EDGE (EduCare Data Generator Engine)
-- ----------------------------------------------------------------------------
-- Generator Table: Phone Prefixes
--
-- Purpose:
-- Stores South African mobile prefixes for generating realistic phone numbers.
--
-- Safe to rerun.
-- ============================================================================

BEGIN;

DROP TABLE IF EXISTS generator_phone_prefixes;

CREATE TABLE generator_phone_prefixes
(
    id              BIGSERIAL PRIMARY KEY,

    prefix          VARCHAR(5) NOT NULL UNIQUE,

    network_name    VARCHAR(50) NOT NULL,

    is_active       BOOLEAN NOT NULL DEFAULT TRUE,

    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

INSERT INTO generator_phone_prefixes
(
    prefix,
    network_name
)
VALUES

-- Vodacom
('060','Vodacom'),
('061','Vodacom'),
('062','Vodacom'),
('063','Vodacom'),
('064','Vodacom'),
('072','Vodacom'),
('082','Vodacom'),

-- MTN
('065','MTN'),
('066','MTN'),
('067','MTN'),
('068','MTN'),
('073','MTN'),
('083','MTN'),

-- Cell C
('071','Cell C'),
('074','Cell C'),
('084','Cell C'),

-- Telkom
('081','Telkom'),

-- Rain
('087','Rain')

ON CONFLICT (prefix)
DO NOTHING;

COMMIT;

-- ============================================================================
-- Verification
-- ============================================================================

SELECT COUNT(*) AS total_prefixes
FROM generator_phone_prefixes;

SELECT *
FROM generator_phone_prefixes
ORDER BY prefix;