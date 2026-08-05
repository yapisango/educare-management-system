-- ============================================================================
-- EduCare Management System
-- EDGE (EduCare Data Generator Engine)
-- ----------------------------------------------------------------------------
-- Generator Table: Email Domains
--
-- Purpose:
-- Stores reusable email domains for generating realistic demo data.
--
-- Safe to rerun.
-- ============================================================================

BEGIN;

-- ============================================================================
-- Drop Existing Table
-- ============================================================================

DROP TABLE IF EXISTS generator_email_domains;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE generator_email_domains
(
    id              BIGSERIAL PRIMARY KEY,

    domain          VARCHAR(150) NOT NULL UNIQUE,

    is_active       BOOLEAN NOT NULL DEFAULT TRUE,

    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================================
-- Seed Data
-- ============================================================================

INSERT INTO generator_email_domains
(domain)
VALUES

-- ==========================================================
-- Free Email Providers
-- ==========================================================

('gmail.com'),
('outlook.com'),
('hotmail.com'),
('icloud.com'),
('yahoo.com'),
('proton.me'),
('live.com'),

-- ==========================================================
-- South African
-- ==========================================================

('mweb.co.za'),
('webmail.co.za'),
('vodamail.co.za'),
('telkomsa.net'),

-- ==========================================================
-- Education
-- ==========================================================

('edu.za'),
('ac.za'),
('schoolmail.co.za'),

-- ==========================================================
-- Government
-- ==========================================================

('gov.za'),

-- ==========================================================
-- Business
-- ==========================================================

('company.co.za'),
('business.co.za'),
('corporate.co.za'),

-- ==========================================================
-- EduCare
-- ==========================================================

('educare.co.za'),

-- ==========================================================
-- YapiTech
-- ==========================================================

('yapitech.co.za'),

-- ==========================================================
-- Technology Companies
-- ==========================================================

('google.com'),
('microsoft.com'),
('amazon.com'),
('apple.com'),
('oracle.com'),
('ibm.com'),
('intel.com'),
('meta.com')

ON CONFLICT (domain)
DO NOTHING;

COMMIT;

-- ============================================================================
-- Verification
-- ============================================================================

SELECT COUNT(*) AS total_domains
FROM generator_email_domains;

SELECT *
FROM generator_email_domains
ORDER BY domain;