-- ============================================================================
-- EduCare Management System
-- EDGE (EduCare Data Generator Engine)
-- ----------------------------------------------------------------------------
-- Generator Table: Companies
--
-- Purpose:
-- Stores realistic company names for generating demo employees,
-- guardians, suppliers, and other business-related records.
--
-- Safe to rerun.
-- ============================================================================

BEGIN;

-- ============================================================================
-- Drop Existing Table
-- ============================================================================

DROP TABLE IF EXISTS generator_companies;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE generator_companies
(
    id              BIGSERIAL PRIMARY KEY,

    company_name    VARCHAR(200) NOT NULL UNIQUE,

    industry        VARCHAR(100) NOT NULL,

    is_active       BOOLEAN NOT NULL DEFAULT TRUE,

    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================================
-- Seed Data
-- ============================================================================

INSERT INTO generator_companies
(
    company_name,
    industry
)
VALUES

-- ==========================================================
-- Banking
-- ==========================================================

('Standard Bank','Banking'),
('Absa','Banking'),
('FNB','Banking'),
('Nedbank','Banking'),
('Capitec','Banking'),

-- ==========================================================
-- Telecommunications
-- ==========================================================

('Vodacom','Telecommunications'),
('MTN','Telecommunications'),
('Telkom','Telecommunications'),
('Cell C','Telecommunications'),
('Rain','Telecommunications'),

-- ==========================================================
-- Retail
-- ==========================================================

('Shoprite','Retail'),
('Checkers','Retail'),
('Pick n Pay','Retail'),
('Woolworths','Retail'),
('Makro','Retail'),
('Game','Retail'),
('Clicks','Retail'),
('Dis-Chem','Retail'),

-- ==========================================================
-- Automotive
-- ==========================================================

('BMW South Africa','Automotive'),
('Toyota South Africa','Automotive'),
('Ford South Africa','Automotive'),
('Volkswagen South Africa','Automotive'),
('Mercedes-Benz South Africa','Automotive'),

-- ==========================================================
-- Technology
-- ==========================================================

('Microsoft','Technology'),
('Google','Technology'),
('Apple','Technology'),
('Amazon','Technology'),
('Oracle','Technology'),
('IBM','Technology'),

-- ==========================================================
-- Mining & Energy
-- ==========================================================

('Sasol','Energy'),
('Eskom','Energy'),
('Anglo American','Mining'),
('Exxaro','Mining'),

-- ==========================================================
-- Logistics
-- ==========================================================

('DHL','Logistics'),
('FedEx','Logistics'),
('Aramex','Logistics'),

-- ==========================================================
-- Education
-- ==========================================================

('EduCare High School','Education'),
('University of South Africa','Education'),
('University of Johannesburg','Education'),

-- ==========================================================
-- Healthcare
-- ==========================================================

('Netcare','Healthcare'),
('Life Healthcare','Healthcare'),
('Mediclinic','Healthcare'),

-- ==========================================================
-- Your Company
-- ==========================================================

('YapiTech Innovations','Technology')

ON CONFLICT (company_name)
DO NOTHING;

COMMIT;

-- ============================================================================
-- Verification
-- ============================================================================

SELECT COUNT(*) AS total_companies
FROM generator_companies;

SELECT *
FROM generator_companies
ORDER BY company_name;