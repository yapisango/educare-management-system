-- ============================================================================
-- EduCare Management System
-- EDGE (EduCare Data Generator Engine)
-- ----------------------------------------------------------------------------
-- Function:
-- edge_random_phone_number()
--
-- Purpose:
-- Generates a realistic South African mobile phone number.
--
-- Example:
-- 0824567812
-- ============================================================================
CREATE OR REPLACE FUNCTION edge_random_phone_number()

RETURNS VARCHAR

LANGUAGE sql

AS
$$

SELECT

edge_random_phone_prefix()

||

LPAD(

FLOOR(random()*10000000)::TEXT,

7,

'0'

);

$$;

-- ============================================================================
-- Test
-- ============================================================================

SELECT edge_random_phone_number();

SELECT

edge_random_phone_number(),

edge_random_phone_number(),

edge_random_phone_number();