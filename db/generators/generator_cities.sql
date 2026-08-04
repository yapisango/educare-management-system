-- ============================================================================
-- EduCare Management System
-- EDGE (EduCare Data Generator Engine)
-- ----------------------------------------------------------------------------
-- Generator Table: Cities
--
-- Purpose:
-- Stores South African cities for generating realistic addresses.
--
-- Safe to rerun.
-- ============================================================================

BEGIN;

DROP TABLE IF EXISTS generator_cities;

CREATE TABLE generator_cities
(
    id              BIGSERIAL PRIMARY KEY,

    city            VARCHAR(100) NOT NULL UNIQUE,

    province        VARCHAR(100) NOT NULL,

    postal_code     VARCHAR(10),

    is_active       BOOLEAN NOT NULL DEFAULT TRUE,

    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

INSERT INTO generator_cities
(
    city,
    province,
    postal_code
)
VALUES

-- Gauteng
('Johannesburg','Gauteng','2000'),
('Pretoria','Gauteng','0001'),
('Centurion','Gauteng','0157'),
('Midrand','Gauteng','1685'),
('Sandton','Gauteng','2196'),
('Roodepoort','Gauteng','1724'),
('Soweto','Gauteng','1804'),
('Kempton Park','Gauteng','1619'),
('Benoni','Gauteng','1501'),
('Boksburg','Gauteng','1459'),

-- Western Cape
('Cape Town','Western Cape','8001'),
('Stellenbosch','Western Cape','7600'),
('Paarl','Western Cape','7646'),
('George','Western Cape','6529'),
('Mossel Bay','Western Cape','6500'),

-- KwaZulu-Natal
('Durban','KwaZulu-Natal','4001'),
('Pietermaritzburg','KwaZulu-Natal','3201'),
('Richards Bay','KwaZulu-Natal','3900'),
('Newcastle','KwaZulu-Natal','2940'),

-- Eastern Cape
('Gqeberha','Eastern Cape','6001'),
('East London','Eastern Cape','5201'),
('Mthatha','Eastern Cape','5100'),

-- Free State
('Bloemfontein','Free State','9301'),
('Welkom','Free State','9459'),

-- Limpopo
('Polokwane','Limpopo','0700'),
('Thohoyandou','Limpopo','0950'),

-- Mpumalanga
('Mbombela','Mpumalanga','1200'),
('Emalahleni','Mpumalanga','1035'),

-- North West
('Rustenburg','North West','0299'),
('Mahikeng','North West','2745'),

-- Northern Cape
('Kimberley','Northern Cape','8301'),

-- South African Coast
('Knysna','Western Cape','6571'),
('Hermanus','Western Cape','7200'),
('Ballito','KwaZulu-Natal','4420'),
('Jeffreys Bay','Eastern Cape','6330');

COMMIT;

-- ============================================================================
-- Verification
-- ============================================================================

SELECT COUNT(*) AS total_cities
FROM generator_cities;

SELECT *
FROM generator_cities
LIMIT 10;