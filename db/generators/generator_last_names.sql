-- ============================================================================
-- EduCare Management System
-- EDGE (EduCare Data Generator Engine)
-- ----------------------------------------------------------------------------
-- File: generator_last_names.sql
-- Description:
-- Stores reusable surnames for generating realistic demo data.
--
-- Safe to rerun.
-- ============================================================================

BEGIN;

-- ============================================================================
-- Drop Existing Table
-- ============================================================================

DROP TABLE IF EXISTS generator_last_names;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE generator_last_names
(
    id              BIGSERIAL PRIMARY KEY,

    last_name       VARCHAR(100) UNIQUE,

    is_active       BOOLEAN NOT NULL DEFAULT TRUE,

    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================================
-- Seed Data
-- ============================================================================

INSERT INTO generator_last_names
(last_name)
VALUES

-- =========================
-- South African
-- =========================

('Nkosi'),
('Dlamini'),
('Zulu'),
('Mokoena'),
('Ndlovu'),
('Khumalo'),
('Mthembu'),
('Mabaso'),
('Mahlangu'),
('Mokoena'),
('Moloi'),
('Molefe'),
('Mokgosi'),
('Mabena'),
('Mashego'),
('Maseko'),
('Mabunda'),
('Mabena'),
('Mokoena'),
('Mogale'),
('Mofokeng'),
('Mokoena'),
('Mokhele'),
('Mokone'),
('Mokwena'),
('Mokoatle'),
('Mokgatle'),
('Mokgosi'),
('Mphahlele'),
('Msimang'),
('Mtshali'),
('Ngcobo'),
('Ngubane'),
('Nxumalo'),
('Ntuli'),
('Shabalala'),
('Sibiya'),
('Sithole'),
('Vilakazi'),
('Xaba'),

-- =========================
-- English
-- =========================

('Smith'),
('Johnson'),
('Brown'),
('Williams'),
('Jones'),
('Taylor'),
('Wilson'),
('Thomas'),
('Moore'),
('Martin'),
('Clark'),
('Walker'),
('Young'),
('Allen'),
('King'),
('Scott'),
('Green'),
('Baker'),
('Hill'),
('Cooper'),

-- =========================
-- Afrikaans
-- =========================

('Botha'),
('Van Wyk'),
('Van Zyl'),
('Pretorius'),
('Du Toit'),
('Steyn'),
('Smit'),
('Joubert'),
('Kruger'),
('De Villiers'),
('Visser'),
('Bosman'),
('Fourie'),
('Lombard'),
('Marais'),

-- =========================
-- Indian South African
-- =========================

('Naidoo'),
('Pillay'),
('Govender'),
('Moodley'),
('Reddy'),
('Singh'),
('Patel'),
('Maharaj'),
('Chetty'),
('Desai'),

-- =========================
-- Other
-- =========================

('Yapi'),
('Mensah'),
('Boateng'),
('Diallo'),
('Kamara'),
('Traore'),
('Kone'),
('Keita'),
('Bah'),
('Sow')
ON CONFLICT (last_name)
DO NOTHING;

-- ============================================================================
-- Verification
-- ============================================================================

SELECT
    COUNT(*) AS total_last_names
FROM generator_last_names;

COMMIT;