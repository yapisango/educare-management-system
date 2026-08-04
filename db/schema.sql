/*
===============================================================================
                                EduCare Management System
                                Database Schema (schema.sql)
===============================================================================

Project        : EduCare Management System
Company        : YapiTech Innovations (Pty) Ltd
Framework      : YapiTech Blueprint Framework (YBF)
Methodology    : Blueprint Before Build

Database       : PostgreSQL
Version        : 1.0.0
Status         : Development
Schema Version : 1.0

Author         : YapiTech Engineering
Created        : July 2026
Last Updated   : July 2026

===============================================================================

DESCRIPTION

This file contains the complete relational database schema for the
EduCare Management System.

The schema has been designed using the YapiTech Blueprint Framework (YBF)
and follows the principle:

    "Blueprint Before Build"

The database models the business before implementation.

Every table represents a real business entity.
Every relationship represents a real business relationship.
Every constraint enforces a real business rule.

===============================================================================

BUSINESS DOMAINS

01. School Management
02. Academic Management
03. People Management
04. Teaching Management
05. Attendance Management
06. Assessment Management
07. Communication Management
08. Reporting
09. Security & Administration

===============================================================================

FILE STRUCTURE

1. PostgreSQL Extensions
2. Enumerations
3. School Domain
4. Academic Domain
5. People Domain
6. Teaching Domain
7. Attendance Domain
8. Assessment Domain
9. Communication Domain
10. Reporting
11. Security
12. Indexes
13. Views

===============================================================================

NAMING CONVENTIONS

Tables
-------
snake_case plural nouns

Examples:
schools
teachers
learners
attendance_records

Primary Keys
------------
id

Foreign Keys
------------
<entity>_id

Examples:
school_id
teacher_id
learner_id

Indexes
-------
idx_<table>_<column>

Examples:
idx_learners_school_id

Unique Constraints
------------------
uq_<table>_<column>

Examples:
uq_users_email

Check Constraints
-----------------
chk_<table>_<rule>

Examples:
chk_attendance_status

===============================================================================

ENGINEERING PRINCIPLES

✓ Business First
✓ Blueprint Before Build
✓ Simplicity over Complexity
✓ Consistency Creates Quality
✓ Documentation is Part of the Product

===============================================================================
*/

-- =============================================================================
-- PostgreSQL Extensions
-- =============================================================================
-- Purpose:
-- Enable PostgreSQL extensions required by the EduCare Management System.
--
-- Extensions are installed once per database and provide additional
-- functionality that is not available in the PostgreSQL core.
--
-- =============================================================================


-- -----------------------------------------------------------------------------
-- UUID Generation
-- -----------------------------------------------------------------------------
-- Provides functions for generating universally unique identifiers (UUIDs).
--
-- Example:
-- gen_random_uuid()
--
-- Used for:
-- - Primary Keys (optional)
-- - Public identifiers
-- - Distributed systems
-- -----------------------------------------------------------------------------

CREATE EXTENSION IF NOT EXISTS pgcrypto;


-- -----------------------------------------------------------------------------
-- UUID OSSP (Optional)
-- -----------------------------------------------------------------------------
-- Alternative UUID generation methods.
--
-- Uncomment if your project requires uuid-ossp instead of pgcrypto.
--
-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- Extension Verification
-- -----------------------------------------------------------------------------
-- Verify installed extensions.
--
-- SELECT * FROM pg_extension;
-- -----------------------------------------------------------------------------

-- =============================================================================
-- ENUMERATIONS (ENUM TYPES)
-- =============================================================================
-- Purpose:
-- Define reusable business value types used throughout the EduCare
-- Management System.
--
-- ENUM types improve:
-- • Data consistency
-- • Validation
-- • Readability
-- • Database integrity
--
-- =============================================================================


-- =============================================================================
-- User Roles
-- =============================================================================

CREATE TYPE user_role AS ENUM (
    'SUPER_ADMIN',
    'ADMIN',
    'PRINCIPAL',
    'TEACHER',
    'STAFF',
    'PARENT',
    'LEARNER'
);


-- =============================================================================
-- Gender
-- =============================================================================

CREATE TYPE gender_type AS ENUM (
    'MALE',
    'FEMALE',
    'OTHER',
    'PREFER_NOT_TO_SAY'
);


-- =============================================================================
-- Account Status
-- =============================================================================

CREATE TYPE account_status AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'SUSPENDED',
    'PENDING'
);


-- =============================================================================
-- School Status
-- =============================================================================

CREATE TYPE school_status AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'ARCHIVED'
);


-- =============================================================================
-- Academic Year Status
-- =============================================================================

CREATE TYPE academic_year_status AS ENUM (
    'PLANNED',
    'ACTIVE',
    'COMPLETED',
    'ARCHIVED'
);


-- =============================================================================
-- Enrolment Status
-- =============================================================================

CREATE TYPE enrolment_status AS ENUM (
    'APPLIED',
    'ENROLLED',
    'TRANSFERRED',
    'GRADUATED',
    'WITHDRAWN'
);


-- =============================================================================
-- Attendance Status
-- =============================================================================

CREATE TYPE attendance_status AS ENUM (
    'PRESENT',
    'ABSENT',
    'LATE',
    'EXCUSED'
);


-- =============================================================================
-- Assessment Type
-- =============================================================================

CREATE TYPE assessment_type AS ENUM (
    'ASSIGNMENT',
    'QUIZ',
    'TEST',
    'EXAM',
    'PROJECT'
);


-- =============================================================================
-- Notification Type
-- =============================================================================

CREATE TYPE notification_type AS ENUM (
    'EMAIL',
    'SMS',
    'IN_APP'
);


-- =============================================================================
-- Audit Action
-- =============================================================================

CREATE TYPE audit_action AS ENUM (
    'CREATE',
    'UPDATE',
    'DELETE',
    'LOGIN',
    'LOGOUT'
);

-- =============================================================================
-- SCHOOL MANAGEMENT DOMAIN
-- =============================================================================
-- Purpose:
-- The School Management Domain forms the foundation of the EduCare
-- Management System.
--
-- Every learner, teacher, class, academic year, attendance record,
-- assessment, report and communication belongs to a school.
--
-- This domain establishes the organisational structure upon which all
-- other business domains are built.
--
-- Business Entities
--
-- • Schools
-- • Campuses
--
-- =============================================================================



-- =============================================================================
-- TABLE: schools
-- =============================================================================
-- Description:
-- Stores information about registered schools using the EduCare platform.
--
-- A school is the highest-level business entity in the system.
--
-- Relationships
--
-- One School
--    ├── Many Campuses
--    ├── Many Academic Years
--    ├── Many Teachers
--    ├── Many Learners
--    ├── Many Classes
--    └── Many Reports
--
-- =============================================================================

CREATE TABLE schools (

    -- -------------------------------------------------------------------------
    -- Primary Identifier
    -- -------------------------------------------------------------------------

    id BIGSERIAL PRIMARY KEY,

    public_id UUID 
        NOT NULL
        DEFAULT gen_random_uuid()
        UNIQUE,



    -- -------------------------------------------------------------------------
    -- Business Information
    -- -------------------------------------------------------------------------

    school_name VARCHAR(200) NOT NULL,

    school_code VARCHAR(30)
        NOT NULL
        UNIQUE,

    registration_number VARCHAR(100),

    emis_number VARCHAR(50),

    school_type VARCHAR(100),

    education_phase VARCHAR(100),


    -- -------------------------------------------------------------------------
    -- Contact Information
    -- -------------------------------------------------------------------------

    email VARCHAR(255)
        CHECK (
            email IS NULL
            OR trim(email) <> ''
        ),

    phone VARCHAR(30),

    website VARCHAR(500),



    -- -------------------------------------------------------------------------
    -- Physical Address
    -- -------------------------------------------------------------------------

    address_line_1 VARCHAR(255),

    address_line_2 VARCHAR(255),

    suburb VARCHAR(120),

    city VARCHAR(120),

    province VARCHAR(120),

    postal_code VARCHAR(20),

    country VARCHAR(100)
        NOT NULL
        DEFAULT 'South Africa',



    -- -------------------------------------------------------------------------
    -- School Status
    -- -------------------------------------------------------------------------

    status school_status
        NOT NULL
        DEFAULT 'ACTIVE',

    -- -------------------------------------------------------------------------
    -- Audit Information
    -- -------------------------------------------------------------------------

    created_at TIMESTAMPTZ
        NOT NULL
        DEFAULT NOW(),

    updated_at TIMESTAMPTZ
        NOT NULL
        DEFAULT NOW(),

    created_by BIGINT,

    updated_by BIGINT,

    is_active BOOLEAN
        NOT NULL
        DEFAULT TRUE

);

-- =============================================================================
-- INDEXES: schools
-- =============================================================================

CREATE INDEX idx_schools_name
ON schools (school_name);

CREATE INDEX idx_schools_status
ON schools (status);

CREATE INDEX idx_schools_city
ON schools (city);

CREATE INDEX idx_schools_province
ON schools (province);


-- =============================================================================
-- TABLE: campuses
-- =============================================================================
-- Description:
-- Represents a physical campus that belongs to a school.
--
-- A school may operate from one or more campuses.
--
-- Examples:
--
-- Johannesburg Campus
-- Pretoria Campus
-- Durban Campus
--
-- =============================================================================

CREATE TABLE campuses (

    -- -------------------------------------------------------------------------
    -- Primary Identifier
    -- -------------------------------------------------------------------------

    id BIGSERIAL PRIMARY KEY,

    public_id UUID NOT NULL
        DEFAULT gen_random_uuid()
        UNIQUE,



    -- -------------------------------------------------------------------------
    -- Relationship
    -- -------------------------------------------------------------------------

    school_id BIGINT
        NOT NULL,



    -- -------------------------------------------------------------------------
    -- Campus Information
    -- -------------------------------------------------------------------------

    campus_name VARCHAR(200)
        NOT NULL,

    campus_code VARCHAR(30),

    email VARCHAR(255),

    phone VARCHAR(30),



    -- -------------------------------------------------------------------------
    -- Address
    -- -------------------------------------------------------------------------

    address_line_1 VARCHAR(255),

    address_line_2 VARCHAR(255),

    suburb VARCHAR(120),

    city VARCHAR(120),

    province VARCHAR(120),

    postal_code VARCHAR(20),

    country VARCHAR(100)
        DEFAULT 'South Africa',



    -- -------------------------------------------------------------------------
    -- Audit Information
    -- -------------------------------------------------------------------------

    created_at TIMESTAMPTZ
        NOT NULL
        DEFAULT NOW(),

    updated_at TIMESTAMPTZ
        NOT NULL
        DEFAULT NOW(),

    created_by BIGINT,

    updated_by BIGINT,

    is_active BOOLEAN
        NOT NULL
        DEFAULT TRUE,



    -- -------------------------------------------------------------------------
    -- Constraints
    -- -------------------------------------------------------------------------

    CONSTRAINT fk_campus_school
        FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE RESTRICT

);

-- =============================================================================
-- ACADEMIC MANAGEMENT DOMAIN
-- =============================================================================
-- Purpose:
-- Defines the academic structure of a school.
--
-- This domain models:
--
-- • Academic Years
-- • Terms
-- • Grades
-- • Sections
-- • Classes
--
-- Every learner and teacher will eventually belong to this academic
-- hierarchy.
--
-- =============================================================================



-- =============================================================================
-- TABLE: academic_years
-- =============================================================================
-- Description:
-- Represents an academic year for a school.
--
-- Example:
--
-- 2026 Academic Year
-- 2027 Academic Year
--
-- One School
--     └── Many Academic Years
--
-- =============================================================================

CREATE TABLE academic_years (

    -- Primary Identifier
    id BIGSERIAL PRIMARY KEY,

    public_id UUID NOT NULL
        DEFAULT gen_random_uuid()
        UNIQUE,

    -- Relationship
    school_id BIGINT NOT NULL,

    -- Business Information
    year_name VARCHAR(20) NOT NULL,

    start_date DATE NOT NULL,

    end_date DATE NOT NULL,

    status academic_year_status
        NOT NULL
        DEFAULT 'PLANNED',

    -- Audit Information
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    created_by BIGINT,

    updated_by BIGINT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    -- Constraints
    CONSTRAINT fk_academic_year_school
        FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE RESTRICT,

    CONSTRAINT uq_school_year
        UNIQUE (school_id, year_name)

);



-- =============================================================================
-- TABLE: terms
-- =============================================================================
-- Description:
-- Represents school terms within an academic year.
--
-- Example:
--
-- Term 1
-- Term 2
-- Term 3
-- Term 4
--
-- =============================================================================

CREATE TABLE terms (

    id BIGSERIAL PRIMARY KEY,

    public_id UUID NOT NULL
        DEFAULT gen_random_uuid()
        UNIQUE,

    academic_year_id BIGINT NOT NULL,

    term_name VARCHAR(50) NOT NULL,

    start_date DATE NOT NULL,

    end_date DATE NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    created_by BIGINT,

    updated_by BIGINT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_term_academic_year
        FOREIGN KEY (academic_year_id)
        REFERENCES academic_years(id)
        ON DELETE RESTRICT

);



-- =============================================================================
-- TABLE: grades
-- =============================================================================
-- Description:
-- Represents grades offered by a school.
--
-- Examples:
--
-- Grade R
-- Grade 1
-- Grade 7
-- Grade 12
--
-- =============================================================================

CREATE TABLE grades (

    id BIGSERIAL PRIMARY KEY,

    public_id UUID NOT NULL
        DEFAULT gen_random_uuid()
        UNIQUE,

    school_id BIGINT NOT NULL,

    grade_name VARCHAR(50) NOT NULL,

    grade_level INTEGER NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    created_by BIGINT,

    updated_by BIGINT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_grade_school
        FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE RESTRICT,

    CONSTRAINT uq_school_grade
        UNIQUE (school_id, grade_name)

);



-- =============================================================================
-- TABLE: sections
-- =============================================================================
-- Description:
-- Represents streams or sections within a grade.
--
-- Examples:
--
-- Grade 8A
-- Grade 8B
-- Grade 8C
--
-- =============================================================================

CREATE TABLE sections (

    id BIGSERIAL PRIMARY KEY,

    public_id UUID NOT NULL
        DEFAULT gen_random_uuid()
        UNIQUE,

    grade_id BIGINT NOT NULL,

    section_name VARCHAR(20) NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    created_by BIGINT,

    updated_by BIGINT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_section_grade
        FOREIGN KEY (grade_id)
        REFERENCES grades(id)
        ON DELETE RESTRICT,

    CONSTRAINT uq_grade_section
        UNIQUE (grade_id, section_name)

);



-- =============================================================================
-- TABLE: classes
-- =============================================================================
-- Description:
-- Represents an operational teaching class.
--
-- A class belongs to:
--
-- • School
-- • Academic Year
-- • Grade
-- • Section
--
-- Later, learners, teachers and subjects will all connect to this table.
--
-- =============================================================================

CREATE TABLE classes (

    id BIGSERIAL PRIMARY KEY,

    public_id UUID NOT NULL
        DEFAULT gen_random_uuid()
        UNIQUE,

    school_id BIGINT NOT NULL,

    academic_year_id BIGINT NOT NULL,

    grade_id BIGINT NOT NULL,

    section_id BIGINT NOT NULL,

    class_name VARCHAR(100) NOT NULL,

    classroom VARCHAR(100),

    capacity INTEGER,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    created_by BIGINT,

    updated_by BIGINT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_class_school
        FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_class_academic_year
        FOREIGN KEY (academic_year_id)
        REFERENCES academic_years(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_class_grade
        FOREIGN KEY (grade_id)
        REFERENCES grades(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_class_section
        FOREIGN KEY (section_id)
        REFERENCES sections(id)
        ON DELETE RESTRICT

);

-- =============================================================================
-- PEOPLE MANAGEMENT DOMAIN
-- =============================================================================
-- Purpose:
--
-- The People Management Domain manages every person who interacts with
-- the EduCare Management System.
--
-- Authentication is separated from business information.
--
-- Every authenticated individual exists only once in the Users table.
--
-- Business-specific information is stored in dedicated profile tables.
--
-- Business Entities
--
-- • Users
-- • Learners
-- • Guardians
-- • Teachers
-- • Staff
--
-- =============================================================================

-- =============================================================================
-- TABLE: users
-- =============================================================================
-- Description:
--
-- Stores authentication and identity information.
--
-- Every authenticated person has exactly one user account.
--
-- =============================================================================

CREATE TABLE users (

    -- Primary Identifier

    id BIGSERIAL PRIMARY KEY,

    public_id UUID NOT NULL
        DEFAULT gen_random_uuid()
        UNIQUE,



    -- Identity

    first_name VARCHAR(100) NOT NULL,

    last_name VARCHAR(100) NOT NULL,

    email VARCHAR(255)
        NOT NULL
        UNIQUE,

    phone VARCHAR(30),



    -- Authentication

    password_hash TEXT NOT NULL,

    role user_role NOT NULL,

    account_status account_status
        NOT NULL
        DEFAULT 'ACTIVE',



    -- Audit

    created_at TIMESTAMPTZ
        NOT NULL
        DEFAULT NOW(),

    updated_at TIMESTAMPTZ
        NOT NULL
        DEFAULT NOW(),

    created_by BIGINT,

    updated_by BIGINT,

    is_active BOOLEAN
        NOT NULL
        DEFAULT TRUE

);

CREATE TABLE learners (

    id BIGSERIAL PRIMARY KEY,

    public_id UUID NOT NULL
        DEFAULT gen_random_uuid()
        UNIQUE,



    -- Relationship

    user_id BIGINT NOT NULL,

    school_id BIGINT NOT NULL,

    class_id BIGINT,



    -- Learner Information

    learner_number VARCHAR(50)
        UNIQUE,

    admission_date DATE,

    gender gender_type,

    date_of_birth DATE,

    enrolment_status enrolment_status
        NOT NULL
        DEFAULT 'ENROLLED',



    -- Audit

    created_at TIMESTAMPTZ
        NOT NULL
        DEFAULT NOW(),

    updated_at TIMESTAMPTZ
        NOT NULL
        DEFAULT NOW(),

    created_by BIGINT,

    updated_by BIGINT,

    is_active BOOLEAN
        NOT NULL
        DEFAULT TRUE,



    CONSTRAINT fk_learner_user
        FOREIGN KEY (user_id)
        REFERENCES users(id),

    CONSTRAINT fk_learner_school
        FOREIGN KEY (school_id)
        REFERENCES schools(id),

    CONSTRAINT fk_learner_class
        FOREIGN KEY (class_id)
        REFERENCES classes(id)

);

CREATE TABLE guardians (

    id BIGSERIAL PRIMARY KEY,

    public_id UUID NOT NULL
        DEFAULT gen_random_uuid()
        UNIQUE,

    user_id BIGINT NOT NULL,

    occupation VARCHAR(150),

    relationship_to_learner VARCHAR(50),

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    created_by BIGINT,

    updated_by BIGINT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_guardian_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)

);

-- Mentor Relationship
-- References another teacher who acts as the mentor.
mentor_id BIGINT,

CREATE TABLE teachers (

    id BIGSERIAL PRIMARY KEY,

    public_id UUID NOT NULL
        DEFAULT gen_random_uuid()
        UNIQUE,

    user_id BIGINT NOT NULL,

    school_id BIGINT NOT NULL,

    mentor_id BIGINT,

    employee_number VARCHAR(50)
        UNIQUE,

    hire_date DATE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    created_by BIGINT,

    updated_by BIGINT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_teacher_user
        FOREIGN KEY (user_id)
        REFERENCES users(id),

    CONSTRAINT fk_teacher_school
        FOREIGN KEY (school_id)
        REFERENCES schools(id),

    CONSTRAINT fk_teacher_mentor
    FOREIGN KEY (mentor_id)
    REFERENCES teachers(id)
    ON DELETE SET NULL

);

CREATE TABLE staff (

    id BIGSERIAL PRIMARY KEY,

    public_id UUID NOT NULL
        DEFAULT gen_random_uuid()
        UNIQUE,

    user_id BIGINT NOT NULL,

    school_id BIGINT NOT NULL,

    department VARCHAR(100),

    job_title VARCHAR(100),

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    created_by BIGINT,

    updated_by BIGINT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_staff_user
        FOREIGN KEY (user_id)
        REFERENCES users(id),

    CONSTRAINT fk_staff_school
        FOREIGN KEY (school_id)
        REFERENCES schools(id)

);

-- =============================================================================
-- TABLE: guardian_learners
-- =============================================================================
-- Description:
-- Links guardians to learners.
--
-- A guardian may be responsible for multiple learners.
-- A learner may have multiple guardians.
-- =============================================================================

CREATE TABLE guardian_learners (

    id BIGSERIAL PRIMARY KEY,

    guardian_id BIGINT NOT NULL,

    learner_id BIGINT NOT NULL,

    relationship VARCHAR(50) NOT NULL,

    is_primary_contact BOOLEAN NOT NULL DEFAULT FALSE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_gl_guardian
        FOREIGN KEY (guardian_id)
        REFERENCES guardians(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_gl_learner
        FOREIGN KEY (learner_id)
        REFERENCES learners(id)
        ON DELETE CASCADE,

    CONSTRAINT uq_guardian_learner
        UNIQUE (guardian_id, learner_id)

);

-- =============================================================================
-- TABLE: emergency_contacts
-- =============================================================================

CREATE TABLE emergency_contacts (

    id BIGSERIAL PRIMARY KEY,

    learner_id BIGINT NOT NULL,

    full_name VARCHAR(200) NOT NULL,

    relationship VARCHAR(100),

    phone VARCHAR(30) NOT NULL,

    email VARCHAR(255),

    priority INTEGER DEFAULT 1,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_emergency_learner
        FOREIGN KEY (learner_id)
        REFERENCES learners(id)
        ON DELETE CASCADE

);

-- =============================================================================
-- TABLE: user_sessions
-- =============================================================================

CREATE TABLE user_sessions (

    id BIGSERIAL PRIMARY KEY,

    user_id BIGINT NOT NULL,

    session_token UUID NOT NULL
        DEFAULT gen_random_uuid(),

    ip_address VARCHAR(100),

    user_agent TEXT,

    login_time TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    expires_at TIMESTAMPTZ NOT NULL,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_session_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE

);

-- =============================================================================
-- TABLE: password_reset_tokens
-- =============================================================================

CREATE TABLE password_reset_tokens (

    id BIGSERIAL PRIMARY KEY,

    user_id BIGINT NOT NULL,

    reset_token UUID NOT NULL
        DEFAULT gen_random_uuid(),

    expires_at TIMESTAMPTZ NOT NULL,

    used BOOLEAN NOT NULL DEFAULT FALSE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_password_reset_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE

);



-- =============================================================================
-- TEACHING MANAGEMENT DOMAIN
-- =============================================================================
-- Purpose:
--
-- The Teaching Management Domain manages the delivery of education.
--
-- It defines:
--
-- • Subjects
-- • Teacher Assignments
-- • Class Subject Offerings
--
-- This domain connects teachers, subjects and classes, enabling
-- attendance, assessments and reporting.
--
-- Business Entities
--
-- • Subjects
-- • Teacher Subjects
-- • Class Subjects
--
-- =============================================================================

-- =============================================================================
-- TABLE: subjects
-- =============================================================================

CREATE TABLE subjects (

    -- Primary Identifier
    id BIGSERIAL PRIMARY KEY,

    public_id UUID NOT NULL
        DEFAULT gen_random_uuid()
        UNIQUE,

    -- Relationship
    school_id BIGINT NOT NULL,

    -- Business Information
    subject_code VARCHAR(30)
        NOT NULL,

    subject_name VARCHAR(150)
        NOT NULL,

    description TEXT,

    is_compulsory BOOLEAN NOT NULL DEFAULT TRUE,

    -- Audit Information
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    created_by BIGINT,

    updated_by BIGINT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    -- Constraints
    CONSTRAINT fk_subject_school
        FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE RESTRICT,

    CONSTRAINT uq_school_subject
        UNIQUE (school_id, subject_code)

);

-- =============================================================================
-- TABLE: teacher_subjects
-- =============================================================================

CREATE TABLE teacher_subjects (

    id BIGSERIAL PRIMARY KEY,

    teacher_id BIGINT NOT NULL,

    subject_id BIGINT NOT NULL,

    academic_year_id BIGINT NOT NULL,

    assigned_date DATE DEFAULT CURRENT_DATE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_teacher_subject_teacher
        FOREIGN KEY (teacher_id)
        REFERENCES teachers(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_teacher_subject_subject
        FOREIGN KEY (subject_id)
        REFERENCES subjects(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_teacher_subject_year
        FOREIGN KEY (academic_year_id)
        REFERENCES academic_years(id)
        ON DELETE RESTRICT,

    CONSTRAINT uq_teacher_subject_year
        UNIQUE (teacher_id, subject_id, academic_year_id)

);

-- =============================================================================
-- TABLE: class_subjects
-- =============================================================================

CREATE TABLE class_subjects (

    id BIGSERIAL PRIMARY KEY,

    class_id BIGINT NOT NULL,

    subject_id BIGINT NOT NULL,

    teacher_id BIGINT NOT NULL,

    academic_year_id BIGINT NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_class_subject_class
        FOREIGN KEY (class_id)
        REFERENCES classes(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_class_subject_subject
        FOREIGN KEY (subject_id)
        REFERENCES subjects(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_class_subject_teacher
        FOREIGN KEY (teacher_id)
        REFERENCES teachers(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_class_subject_year
        FOREIGN KEY (academic_year_id)
        REFERENCES academic_years(id)
        ON DELETE RESTRICT,

    CONSTRAINT uq_class_subject
        UNIQUE (
            class_id,
            subject_id,
            academic_year_id
        )

);



-- =============================================================================
-- ATTENDANCE MANAGEMENT DOMAIN
-- =============================================================================
-- Purpose:
--
-- The Attendance Management Domain records learner attendance for
-- academic activities.
--
-- Attendance is recorded in two levels:
--
-- 1. Attendance Session (Header)
-- 2. Attendance Entries (Individual Learners)
--
-- This design:
--
-- • Eliminates duplicated information
-- • Improves reporting
-- • Supports class and subject attendance
-- • Supports future timetable integration
--
-- Business Entities
--
-- • Attendance Sessions
-- • Attendance Entries
--
-- =============================================================================

-- =============================================================================
-- TABLE: attendance_sessions
-- =============================================================================

CREATE TABLE attendance_sessions (

    -- Primary Identifier
    id BIGSERIAL PRIMARY KEY,

    public_id UUID NOT NULL
        DEFAULT gen_random_uuid()
        UNIQUE,

    -- Relationships
    school_id BIGINT NOT NULL,

    academic_year_id BIGINT NOT NULL,

    term_id BIGINT NOT NULL,

    class_id BIGINT NOT NULL,

    subject_id BIGINT NOT NULL,

    teacher_id BIGINT NOT NULL,

    -- Session Information
    attendance_date DATE NOT NULL,

    lesson_number INTEGER,

    remarks TEXT,

    -- Audit Information
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    created_by BIGINT,

    updated_by BIGINT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    -- Constraints
    CONSTRAINT fk_attendance_school
        FOREIGN KEY (school_id)
        REFERENCES schools(id),

    CONSTRAINT fk_attendance_year
        FOREIGN KEY (academic_year_id)
        REFERENCES academic_years(id),

    CONSTRAINT fk_attendance_term
        FOREIGN KEY (term_id)
        REFERENCES terms(id),

    CONSTRAINT fk_attendance_class
        FOREIGN KEY (class_id)
        REFERENCES classes(id),

    CONSTRAINT fk_attendance_subject
        FOREIGN KEY (subject_id)
        REFERENCES subjects(id),

    CONSTRAINT fk_attendance_teacher
        FOREIGN KEY (teacher_id)
        REFERENCES teachers(id)

);

-- =============================================================================
-- TABLE: attendance_entries
-- =============================================================================

CREATE TABLE attendance_entries (

    -- Primary Identifier
    id BIGSERIAL PRIMARY KEY,

    -- Relationships
    attendance_session_id BIGINT NOT NULL,

    learner_id BIGINT NOT NULL,

    -- Attendance Information
    status attendance_status
        NOT NULL
        DEFAULT 'PRESENT',

    reason TEXT,

    recorded_at TIMESTAMPTZ
        DEFAULT NOW(),

    -- Constraints
    CONSTRAINT fk_entry_session
        FOREIGN KEY (attendance_session_id)
        REFERENCES attendance_sessions(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_entry_learner
        FOREIGN KEY (learner_id)
        REFERENCES learners(id)
        ON DELETE CASCADE,

    recorded_by BIGINT,

    CONSTRAINT fk_entry_recorded_by
        FOREIGN KEY (recorded_by)
        REFERENCES users(id),

    CONSTRAINT uq_session_learner
        UNIQUE (
            attendance_session_id,
            learner_id
    )

    CONSTRAINT fk_entry_recorded_by
        FOREIGN KEY (recorded_by)
        REFERENCES users(id)

);



-- =============================================================================
-- ASSESSMENT MANAGEMENT DOMAIN
-- =============================================================================
-- Purpose:
--
-- The Assessment Management Domain manages learner assessments,
-- marks, grades and report cards.
--
-- Assessment data is organised using the Header–Detail pattern.
--
-- Business Entities
--
-- • Assessments
-- • Assessment Results
-- • Report Cards
-- • Report Card Items
--
-- =============================================================================

-- =============================================================================
-- TABLE: assessments
-- =============================================================================

CREATE TABLE assessments (

    -- Primary Identifier
    id BIGSERIAL PRIMARY KEY,

    public_id UUID NOT NULL
        DEFAULT gen_random_uuid()
        UNIQUE,

    -- Relationships
    school_id BIGINT NOT NULL,

    academic_year_id BIGINT NOT NULL,

    term_id BIGINT NOT NULL,

    class_id BIGINT NOT NULL,

    subject_id BIGINT NOT NULL,

    teacher_id BIGINT NOT NULL,

    -- Assessment Information
    assessment_name VARCHAR(200) NOT NULL,

    assessment_type assessment_type NOT NULL,

    assessment_date DATE NOT NULL,

    total_marks NUMERIC(6,2) NOT NULL,

    weighting NUMERIC(5,2) DEFAULT 100,

    description TEXT,

    -- Audit Information
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    created_by BIGINT,

    updated_by BIGINT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    -- Constraints
    CONSTRAINT fk_assessment_school
        FOREIGN KEY (school_id)
        REFERENCES schools(id),

    CONSTRAINT fk_assessment_year
        FOREIGN KEY (academic_year_id)
        REFERENCES academic_years(id),

    CONSTRAINT fk_assessment_term
        FOREIGN KEY (term_id)
        REFERENCES terms(id),

    CONSTRAINT fk_assessment_class
        FOREIGN KEY (class_id)
        REFERENCES classes(id),

    CONSTRAINT fk_assessment_subject
        FOREIGN KEY (subject_id)
        REFERENCES subjects(id),

    CONSTRAINT fk_assessment_teacher
        FOREIGN KEY (teacher_id)
        REFERENCES teachers(id)

);

-- =============================================================================
-- TABLE: assessment_results
-- =============================================================================

CREATE TABLE assessment_results (

    id BIGSERIAL PRIMARY KEY,

    assessment_id BIGINT NOT NULL,

    learner_id BIGINT NOT NULL,

    marks_obtained NUMERIC(6,2) NOT NULL,

    percentage NUMERIC(5,2),

    grade VARCHAR(5),

    remarks TEXT,

    recorded_by BIGINT,

    recorded_at TIMESTAMPTZ DEFAULT NOW(),

    CONSTRAINT fk_result_assessment
        FOREIGN KEY (assessment_id)
        REFERENCES assessments(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_result_learner
        FOREIGN KEY (learner_id)
        REFERENCES learners(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_result_recorded_by
        FOREIGN KEY (recorded_by)
        REFERENCES users(id),

    CONSTRAINT uq_assessment_learner
        UNIQUE (
            assessment_id,
            learner_id
        )

);

-- =============================================================================
-- TABLE: report_cards
-- =============================================================================

CREATE TABLE report_cards (

    id BIGSERIAL PRIMARY KEY,

    public_id UUID NOT NULL
        DEFAULT gen_random_uuid()
        UNIQUE,

    learner_id BIGINT NOT NULL,

    academic_year_id BIGINT NOT NULL,

    term_id BIGINT NOT NULL,

    average_percentage NUMERIC(5,2),

    overall_grade VARCHAR(10),

    teacher_comment TEXT,

    principal_comment TEXT,

    issued_date DATE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_report_learner
        FOREIGN KEY (learner_id)
        REFERENCES learners(id),

    CONSTRAINT fk_report_year
        FOREIGN KEY (academic_year_id)
        REFERENCES academic_years(id),

    CONSTRAINT fk_report_term
        FOREIGN KEY (term_id)
        REFERENCES terms(id),

    CONSTRAINT uq_report
        UNIQUE (
            learner_id,
            academic_year_id,
            term_id
        )

);

-- =============================================================================
-- TABLE: report_card_items
-- =============================================================================

CREATE TABLE report_card_items (

    id BIGSERIAL PRIMARY KEY,

    report_card_id BIGINT NOT NULL,

    subject_id BIGINT NOT NULL,

    final_mark NUMERIC(6,2),

    percentage NUMERIC(5,2),

    grade VARCHAR(5),

    teacher_comment TEXT,

    CONSTRAINT fk_report_item_report
        FOREIGN KEY (report_card_id)
        REFERENCES report_cards(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_report_item_subject
        FOREIGN KEY (subject_id)
        REFERENCES subjects(id),

    CONSTRAINT uq_report_subject
        UNIQUE (
            report_card_id,
            subject_id
        )

);



-- =============================================================================
-- COMMUNICATION MANAGEMENT DOMAIN
-- =============================================================================
-- Purpose:
--
-- The Communication Management Domain manages all communication within
-- the EduCare Management System.
--
-- It supports:
--
-- • School-wide announcements
-- • Individual notifications
-- • Direct messaging
-- • Message recipients
--
-- Communication is designed to support one-to-one, one-to-many and
-- many-to-many interactions.
--
-- Business Entities
--
-- • Announcements
-- • Notifications
-- • Messages
-- • Message Recipients
--
-- =============================================================================

-- =============================================================================
-- TABLE: announcements
-- =============================================================================

CREATE TABLE announcements (

    id BIGSERIAL PRIMARY KEY,

    public_id UUID NOT NULL
        DEFAULT gen_random_uuid()
        UNIQUE,

    school_id BIGINT NOT NULL,

    created_by BIGINT NOT NULL,

    title VARCHAR(255) NOT NULL,

    content TEXT NOT NULL,

    publish_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    expiry_date TIMESTAMPTZ,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_announcement_school
        FOREIGN KEY (school_id)
        REFERENCES schools(id),

    CONSTRAINT fk_announcement_user
        FOREIGN KEY (created_by)
        REFERENCES users(id)

);

-- =============================================================================
-- TABLE: notifications
-- =============================================================================

CREATE TABLE notifications (

    id BIGSERIAL PRIMARY KEY,

    public_id UUID NOT NULL
        DEFAULT gen_random_uuid()
        UNIQUE,

    user_id BIGINT NOT NULL,

    notification_type notification_type NOT NULL,

    title VARCHAR(255) NOT NULL,

    message TEXT NOT NULL,

    is_read BOOLEAN NOT NULL DEFAULT FALSE,

    sent_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    read_at TIMESTAMPTZ,

    CONSTRAINT fk_notification_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)

);

-- =============================================================================
-- TABLE: messages
-- =============================================================================

CREATE TABLE messages (

    id BIGSERIAL PRIMARY KEY,

    public_id UUID NOT NULL
        DEFAULT gen_random_uuid()
        UNIQUE,

    sender_id BIGINT NOT NULL,

    subject VARCHAR(255),

    message_body TEXT NOT NULL,

    sent_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_message_sender
        FOREIGN KEY (sender_id)
        REFERENCES users(id)

);

-- =============================================================================
-- TABLE: message_recipients
-- =============================================================================

CREATE TABLE message_recipients (

    id BIGSERIAL PRIMARY KEY,

    message_id BIGINT NOT NULL,

    recipient_id BIGINT NOT NULL,

    is_read BOOLEAN NOT NULL DEFAULT FALSE,

    read_at TIMESTAMPTZ,

    CONSTRAINT fk_message_recipient_message
        FOREIGN KEY (message_id)
        REFERENCES messages(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_message_recipient_user
        FOREIGN KEY (recipient_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    CONSTRAINT uq_message_recipient
        UNIQUE (
            message_id,
            recipient_id
        )

);


-- =============================================================================
-- REPORTING & ANALYTICS DOMAIN
-- =============================================================================
-- Purpose:
--
-- The Reporting & Analytics Domain provides the foundation for
-- operational reporting, management dashboards and business intelligence.
--
-- It does not duplicate operational data unnecessarily.
--
-- Reports are generated from trusted business domains through
-- reporting tables and SQL views.
--
-- Business Entities
--
-- • Dashboard Summaries
-- • Attendance Summaries
-- • Academic Performance Summaries
-- • Reporting Views
--
-- =============================================================================

-- =============================================================================
-- TABLE: dashboard_statistics
-- =============================================================================

CREATE TABLE dashboard_statistics (

    id BIGSERIAL PRIMARY KEY,

    school_id BIGINT NOT NULL,

    academic_year_id BIGINT NOT NULL,

    total_learners INTEGER DEFAULT 0,

    total_teachers INTEGER DEFAULT 0,

    total_classes INTEGER DEFAULT 0,

    total_subjects INTEGER DEFAULT 0,

    attendance_percentage NUMERIC(5,2),

    overall_pass_rate NUMERIC(5,2),

    generated_at TIMESTAMPTZ
        NOT NULL
        DEFAULT NOW(),

    CONSTRAINT fk_dashboard_school
        FOREIGN KEY (school_id)
        REFERENCES schools(id),

    CONSTRAINT fk_dashboard_year
        FOREIGN KEY (academic_year_id)
        REFERENCES academic_years(id)

);

-- =============================================================================
-- TABLE: attendance_summary
-- =============================================================================

CREATE TABLE attendance_summary (

    id BIGSERIAL PRIMARY KEY,

    learner_id BIGINT NOT NULL,

    academic_year_id BIGINT NOT NULL,

    term_id BIGINT NOT NULL,

    total_days INTEGER DEFAULT 0,

    present_days INTEGER DEFAULT 0,

    absent_days INTEGER DEFAULT 0,

    late_days INTEGER DEFAULT 0,

    excused_days INTEGER DEFAULT 0,

    attendance_percentage NUMERIC(5,2),

    generated_at TIMESTAMPTZ
        DEFAULT NOW(),

    CONSTRAINT fk_summary_learner
        FOREIGN KEY (learner_id)
        REFERENCES learners(id),

    CONSTRAINT fk_summary_year
        FOREIGN KEY (academic_year_id)
        REFERENCES academic_years(id),

    CONSTRAINT fk_summary_term
        FOREIGN KEY (term_id)
        REFERENCES terms(id)

);

-- =============================================================================
-- TABLE: academic_performance_summary
-- =============================================================================

CREATE TABLE academic_performance_summary (

    id BIGSERIAL PRIMARY KEY,

    learner_id BIGINT NOT NULL,

    academic_year_id BIGINT NOT NULL,

    term_id BIGINT NOT NULL,

    average_mark NUMERIC(5,2),

    overall_grade VARCHAR(10),

    ranking INTEGER,

    generated_at TIMESTAMPTZ
        DEFAULT NOW(),

    CONSTRAINT fk_performance_learner
        FOREIGN KEY (learner_id)
        REFERENCES learners(id),

    CONSTRAINT fk_performance_year
        FOREIGN KEY (academic_year_id)
        REFERENCES academic_years(id),

    CONSTRAINT fk_performance_term
        FOREIGN KEY (term_id)
        REFERENCES terms(id)

);

-- =============================================================================
-- VIEW: vw_learner_attendance
-- =============================================================================

CREATE VIEW vw_learner_attendance AS

SELECT

    l.id,
    u.first_name,
    u.last_name,
    ats.attendance_percentage

FROM learners l

JOIN users u
ON u.id = l.user_id

JOIN attendance_summary ats
ON ats.learner_id = l.id;

-- =============================================================================
-- VIEW: vw_school_dashboard
-- =============================================================================

CREATE VIEW vw_school_dashboard AS

SELECT

    s.school_name,

    ds.total_learners,

    ds.total_teachers,

    ds.total_classes,

    ds.attendance_percentage,

    ds.overall_pass_rate

FROM dashboard_statistics ds

JOIN schools s
ON s.id = ds.school_id;



-- =============================================================================
-- SECURITY & ADMINISTRATION DOMAIN
-- =============================================================================
-- Purpose:
--
-- The Security & Administration Domain manages system security,
-- authorisation, auditing and configuration.
--
-- It ensures that users have the correct permissions,
-- system activity is traceable,
-- and administrators can configure the platform safely.
--
-- Business Entities
--
-- • Roles
-- • Permissions
-- • Role Permissions
-- • Audit Logs
-- • System Settings
--
-- =============================================================================

-- =============================================================================
-- TABLE: roles
-- =============================================================================

CREATE TABLE roles (

    id BIGSERIAL PRIMARY KEY,

    public_id UUID NOT NULL
        DEFAULT gen_random_uuid()
        UNIQUE,

    role_name VARCHAR(100)
        NOT NULL
        UNIQUE,

    description TEXT,

    created_at TIMESTAMPTZ
        NOT NULL
        DEFAULT NOW()

);

-- =============================================================================
-- TABLE: permissions
-- =============================================================================

CREATE TABLE permissions (

    id BIGSERIAL PRIMARY KEY,

    permission_name VARCHAR(150)
        NOT NULL
        UNIQUE,

    module_name VARCHAR(100),

    description TEXT

);

-- =============================================================================
-- TABLE: role_permissions
-- =============================================================================

CREATE TABLE role_permissions (

    id BIGSERIAL PRIMARY KEY,

    role_id BIGINT NOT NULL,

    permission_id BIGINT NOT NULL,

    CONSTRAINT fk_role_permission_role
        FOREIGN KEY (role_id)
        REFERENCES roles(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_role_permission_permission
        FOREIGN KEY (permission_id)
        REFERENCES permissions(id)
        ON DELETE CASCADE,

    CONSTRAINT uq_role_permission
        UNIQUE (
            role_id,
            permission_id
        )

);

-- =============================================================================
-- TABLE: audit_logs
-- =============================================================================

CREATE TABLE audit_logs (

    id BIGSERIAL PRIMARY KEY,

    public_id UUID NOT NULL
        DEFAULT gen_random_uuid()
        UNIQUE,

    user_id BIGINT,

    action audit_action NOT NULL,

    entity_name VARCHAR(100),

    entity_id BIGINT,

    description TEXT,

    ip_address VARCHAR(100),

    user_agent TEXT,

    created_at TIMESTAMPTZ
        NOT NULL
        DEFAULT NOW(),

    CONSTRAINT fk_audit_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)

);

-- =============================================================================
-- TABLE: system_settings
-- =============================================================================

CREATE TABLE system_settings (

    id BIGSERIAL PRIMARY KEY,

    setting_key VARCHAR(150)
        NOT NULL
        UNIQUE,

    setting_value TEXT,

    description TEXT,

    updated_at TIMESTAMPTZ
        NOT NULL
        DEFAULT NOW()

);


