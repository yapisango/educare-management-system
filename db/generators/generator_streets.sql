-- ============================================================================
-- EduCare Management System
-- EDGE (EduCare Data Generator Engine)
-- ----------------------------------------------------------------------------
-- Generator Table: Streets
--
-- Purpose:
-- Stores reusable South African street names.
--
-- Safe to rerun.
-- ============================================================================

BEGIN;

DROP TABLE IF EXISTS generator_streets;

CREATE TABLE generator_streets
(
    id              BIGSERIAL PRIMARY KEY,

    street_name     VARCHAR(150) NOT NULL UNIQUE,

    is_active       BOOLEAN NOT NULL DEFAULT TRUE,

    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

INSERT INTO generator_streets
(street_name)
VALUES

-- Johannesburg
('Church Street'),
('Oxford Road'),
('Jan Smuts Avenue'),
('William Nicol Drive'),
('Beyers Naude Drive'),
('Malibongwe Drive'),
('Republic Road'),
('Hendrik Potgieter Road'),
('Ontdekkers Road'),

-- Pretoria
('Lynnwood Road'),
('Atterbury Road'),
('Pretorius Street'),
('Paul Kruger Street'),
('Steve Biko Road'),
('Francis Baard Street'),
('Hamilton Street'),
('Schoeman Street'),

-- Cape Town
('Long Street'),
('Adderley Street'),
('Bree Street'),
('Loop Street'),
('Kloof Street'),
('Main Road'),
('Voortrekker Road'),

-- Durban
('Smith Street'),
('West Street'),
('Florida Road'),
('Musgrave Road'),
('Umgeni Road'),

-- Generic
('School Road'),
('Park Avenue'),
('Station Road'),
('Market Street'),
('High Street'),
('Oak Avenue'),
('Pine Street'),
('Cedar Road'),
('Acacia Avenue'),
('Sunset Boulevard'),
('River Road'),
('Garden Street'),
('Palm Avenue'),
('Rose Street'),
('King Street'),
('Queen Street'),
('Nelson Mandela Drive'),
('Freedom Way'),
('Unity Road'),
('Education Street');

COMMIT;

-- ============================================================================
-- Verification
-- ============================================================================

SELECT COUNT(*) AS total_streets
FROM generator_streets;

SELECT *
FROM generator_streets
LIMIT 10;