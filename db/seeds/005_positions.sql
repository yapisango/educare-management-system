-- ============================================================================
-- EduCare Management System
-- EDGE (EduCare Data Generator Engine)
-- ----------------------------------------------------------------------------
-- Seed: 005_positions.sql
--
-- Purpose
-- --------
-- Creates positions for the 8 existing departments.
--
-- Existing departments:
--   1 - Academics
--   2 - Administration
--   3 - Finance
--   4 - Human Resources
--   5 - ICT
--   6 - Sports
--   7 - Facilities
--   8 - Student Affairs
--
-- This script is safe to rerun.
-- ============================================================================

BEGIN;

-- ============================================================================
-- Remove existing positions
-- ============================================================================

TRUNCATE TABLE positions RESTART IDENTITY CASCADE;


-- ============================================================================
-- Insert Positions
-- ============================================================================

INSERT INTO positions
(
    id,
    department_id,
    position_name,
    position_code,
    description,
    is_active
)
VALUES

-- ============================================================================
-- 1. ACADEMICS
-- ============================================================================

(1, 1, 'Principal',
 'PRIN',
 'Provides overall academic and institutional leadership.',
 TRUE),

(2, 1, 'Deputy Principal',
 'DPRIN',
 'Supports the principal in academic and school management.',
 TRUE),

(3, 1, 'Head of Department',
 'HOD',
 'Leads an academic department and oversees teaching quality.',
 TRUE),

(4, 1, 'Teacher',
 'TCHR',
 'Responsible for classroom teaching, assessment and learner development.',
 TRUE),

(5, 1, 'Academic Coordinator',
 'ACADCO',
 'Coordinates academic programmes, schedules and academic activities.',
 TRUE),

(6, 1, 'Curriculum Coordinator',
 'CURRCO',
 'Coordinates curriculum implementation and curriculum development.',
 TRUE),


-- ============================================================================
-- 2. ADMINISTRATION
-- ============================================================================

(7, 2, 'School Administrator',
 'SADM',
 'Manages general school administration and administrative operations.',
 TRUE),

(8, 2, 'Receptionist',
 'RECEP',
 'Handles reception, enquiries and front-office administration.',
 TRUE),

(9, 2, 'Registrar',
 'REG',
 'Maintains official learner and school records.',
 TRUE),

(10, 2, 'Admissions Officer',
 'ADMS',
 'Manages learner admissions and registration processes.',
 TRUE),

(11, 2, 'Executive Assistant',
 'EXECASST',
 'Provides administrative support to school leadership.',
 TRUE),


-- ============================================================================
-- 3. FINANCE
-- ============================================================================

(12, 3, 'Finance Manager',
 'FINMGR',
 'Manages financial operations, reporting and financial controls.',
 TRUE),

(13, 3, 'Accountant',
 'ACCT',
 'Maintains accounting records and prepares financial reports.',
 TRUE),

(14, 3, 'Accounts Clerk',
 'ACCTCLERK',
 'Processes financial transactions and maintains supporting records.',
 TRUE),

(15, 3, 'Payroll Officer',
 'PAYROLL',
 'Manages payroll processing and employee remuneration records.',
 TRUE),

(16, 3, 'Bursar',
 'BURSAR',
 'Manages school fees, collections and related financial administration.',
 TRUE),


-- ============================================================================
-- 4. HUMAN RESOURCES
-- ============================================================================

(17, 4, 'HR Manager',
 'HRMGR',
 'Manages human-resource operations and employee administration.',
 TRUE),

(18, 4, 'HR Officer',
 'HROFF',
 'Handles employee records, HR processes and staff support.',
 TRUE),

(19, 4, 'Recruitment Officer',
 'RECRUIT',
 'Coordinates recruitment and staff appointment processes.',
 TRUE),

(20, 4, 'Employee Relations Officer',
 'EREL',
 'Supports employee relations and workplace processes.',
 TRUE),

(21, 4, 'Training Coordinator',
 'TRAINCO',
 'Coordinates staff training and professional development.',
 TRUE),


-- ============================================================================
-- 5. ICT
-- ============================================================================

(22, 5, 'ICT Manager',
 'ICTMGR',
 'Manages ICT infrastructure, systems and technology operations.',
 TRUE),

(23, 5, 'Systems Administrator',
 'SYSADMIN',
 'Maintains servers, systems and core ICT services.',
 TRUE),

(24, 5, 'Network Administrator',
 'NETADMIN',
 'Maintains school network infrastructure and connectivity.',
 TRUE),

(25, 5, 'IT Support Technician',
 'ITSUP',
 'Provides technical support to staff and learners.',
 TRUE),

(26, 5, 'Database Administrator',
 'DBADMIN',
 'Maintains databases, access controls and database operations.',
 TRUE),


-- ============================================================================
-- 6. SPORTS
-- ============================================================================

(27, 6, 'Sports Coordinator',
 'SPORTCO',
 'Coordinates sporting programmes and school sports activities.',
 TRUE),

(28, 6, 'Head Coach',
 'HCOACH',
 'Leads coaching programmes and sporting teams.',
 TRUE),

(29, 6, 'Coach',
 'COACH',
 'Provides coaching and training for school sporting teams.',
 TRUE),

(30, 6, 'Physical Education Coordinator',
 'PECO',
 'Coordinates physical education programmes.',
 TRUE),

(31, 6, 'Sports Administrator',
 'SPORTADM',
 'Provides administrative support for sporting activities.',
 TRUE),


-- ============================================================================
-- 7. FACILITIES
-- ============================================================================

(32, 7, 'Facilities Manager',
 'FACMGR',
 'Manages school buildings, facilities and physical resources.',
 TRUE),

(33, 7, 'Maintenance Supervisor',
 'MAINTSUP',
 'Supervises maintenance and repair activities.',
 TRUE),

(34, 7, 'Maintenance Technician',
 'MAINTTECH',
 'Performs technical maintenance and repair work.',
 TRUE),

(35, 7, 'Groundskeeper',
 'GROUND',
 'Maintains school grounds and outdoor facilities.',
 TRUE),

(36, 7, 'Security Coordinator',
 'SECCO',
 'Coordinates school security operations.',
 TRUE),


-- ============================================================================
-- 8. STUDENT AFFAIRS
-- ============================================================================

(37, 8, 'Student Affairs Manager',
 'SAMGR',
 'Manages learner support and student-affairs operations.',
 TRUE),

(38, 8, 'Student Counsellor',
 'COUNSEL',
 'Provides learner counselling and wellbeing support.',
 TRUE),

(39, 8, 'Student Support Officer',
 'STUSUP',
 'Provides learner support and assists with student services.',
 TRUE),

(40, 8, 'Learner Affairs Coordinator',
 'LAC',
 'Coordinates learner-affairs programmes and activities.',
 TRUE),

(41, 8, 'Activities Coordinator',
 'ACTCO',
 'Coordinates learner activities and extracurricular programmes.',
 TRUE);


-- ============================================================================
-- Synchronise sequence
-- ============================================================================

SELECT setval(
    pg_get_serial_sequence('positions', 'id'),
    COALESCE((SELECT MAX(id) FROM positions), 1),
    true
);


COMMIT;


-- ============================================================================
-- VERIFICATION
-- ============================================================================

-- Total positions
SELECT
    COUNT(*) AS total_positions
FROM positions;


-- Positions by department
SELECT
    d.id AS department_id,
    d.department_name,
    d.department_code,
    COUNT(p.id) AS total_positions
FROM departments d
LEFT JOIN positions p
    ON p.department_id = d.id
GROUP BY
    d.id,
    d.department_name,
    d.department_code
ORDER BY
    d.id;


-- Complete position list
SELECT
    p.id,
    p.position_name,
    p.position_code,
    p.department_id,
    d.department_name,
    d.department_code,
    p.is_active
FROM positions p
JOIN departments d
    ON d.id = p.department_id
ORDER BY
    p.id;


-- Check position-code uniqueness
SELECT
    position_code,
    COUNT(*) AS occurrences
FROM positions
GROUP BY position_code
HAVING COUNT(*) > 1
ORDER BY position_code;