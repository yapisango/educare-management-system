--
-- PostgreSQL database dump
--

\restrict uMUEIs3UXLtJdrkEZAtT1koSLooga0G323EY9rKdzxxyr6V9vBASk1kvuq2cfjj

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

-- Started on 2026-08-05 19:06:41

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2 (class 3079 OID 16597)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 5981 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 1231 (class 1247 OID 18714)
-- Name: account_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.account_status AS ENUM (
    'ACTIVE',
    'LOCKED',
    'DISABLED'
);


ALTER TYPE public.account_status OWNER TO postgres;

--
-- TOC entry 1225 (class 1247 OID 18692)
-- Name: assessment_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.assessment_type AS ENUM (
    'HOMEWORK',
    'CLASS_TEST',
    'ASSIGNMENT',
    'PROJECT',
    'EXAM'
);


ALTER TYPE public.assessment_type OWNER TO postgres;

--
-- TOC entry 1219 (class 1247 OID 18672)
-- Name: attendance_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.attendance_status AS ENUM (
    'PRESENT',
    'ABSENT',
    'LATE',
    'EXCUSED'
);


ALTER TYPE public.attendance_status OWNER TO postgres;

--
-- TOC entry 1021 (class 1247 OID 16714)
-- Name: audit_action; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.audit_action AS ENUM (
    'CREATE',
    'UPDATE',
    'DELETE',
    'LOGIN',
    'LOGOUT'
);


ALTER TYPE public.audit_action OWNER TO postgres;

--
-- TOC entry 1105 (class 1247 OID 17739)
-- Name: day_of_week; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.day_of_week AS ENUM (
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY'
);


ALTER TYPE public.day_of_week OWNER TO postgres;

--
-- TOC entry 1120 (class 1247 OID 17890)
-- Name: delivery_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.delivery_status AS ENUM (
    'PENDING',
    'SENT',
    'DELIVERED',
    'FAILED',
    'READ'
);


ALTER TYPE public.delivery_status OWNER TO postgres;

--
-- TOC entry 1048 (class 1247 OID 16954)
-- Name: employment_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.employment_status AS ENUM (
    'ACTIVE',
    'ON_LEAVE',
    'SUSPENDED',
    'TERMINATED',
    'RETIRED'
);


ALTER TYPE public.employment_status OWNER TO postgres;

--
-- TOC entry 1045 (class 1247 OID 16943)
-- Name: employment_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.employment_type AS ENUM (
    'FULL_TIME',
    'PART_TIME',
    'CONTRACT',
    'TEMPORARY',
    'VOLUNTEER'
);


ALTER TYPE public.employment_type OWNER TO postgres;

--
-- TOC entry 1015 (class 1247 OID 16672)
-- Name: enrolment_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enrolment_status AS ENUM (
    'ENROLLED',
    'SUSPENDED',
    'TRANSFERRED',
    'GRADUATED',
    'WITHDRAWN'
);


ALTER TYPE public.enrolment_status OWNER TO postgres;

--
-- TOC entry 1210 (class 1247 OID 18647)
-- Name: gender; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.gender AS ENUM (
    'MALE',
    'FEMALE'
);


ALTER TYPE public.gender OWNER TO postgres;

--
-- TOC entry 1012 (class 1247 OID 16658)
-- Name: gender_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.gender_type AS ENUM (
    'MALE',
    'FEMALE',
    'OTHER'
);


ALTER TYPE public.gender_type OWNER TO postgres;

--
-- TOC entry 1138 (class 1247 OID 18060)
-- Name: invoice_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.invoice_status AS ENUM (
    'PENDING',
    'PARTIALLY_PAID',
    'PAID',
    'OVERDUE',
    'CANCELLED'
);


ALTER TYPE public.invoice_status OWNER TO postgres;

--
-- TOC entry 1228 (class 1247 OID 18704)
-- Name: library_item_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.library_item_status AS ENUM (
    'AVAILABLE',
    'LOANED',
    'LOST',
    'DAMAGED'
);


ALTER TYPE public.library_item_status OWNER TO postgres;

--
-- TOC entry 1018 (class 1247 OID 16706)
-- Name: notification_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.notification_type AS ENUM (
    'EMAIL',
    'SMS',
    'IN_APP'
);


ALTER TYPE public.notification_type OWNER TO postgres;

--
-- TOC entry 1222 (class 1247 OID 18682)
-- Name: payment_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.payment_status AS ENUM (
    'PENDING',
    'PAID',
    'OVERDUE',
    'CANCELLED'
);


ALTER TYPE public.payment_status OWNER TO postgres;

--
-- TOC entry 1213 (class 1247 OID 18652)
-- Name: person_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.person_role AS ENUM (
    'LEARNER',
    'GUARDIAN',
    'TEACHER',
    'STAFF',
    'ADMIN'
);


ALTER TYPE public.person_role OWNER TO postgres;

--
-- TOC entry 1093 (class 1247 OID 17616)
-- Name: room_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.room_type AS ENUM (
    'CLASSROOM',
    'LABORATORY',
    'COMPUTER_LAB',
    'SCIENCE_LAB',
    'LIBRARY',
    'HALL',
    'SPORTS_FIELD',
    'STAFF_ROOM',
    'OFFICE'
);


ALTER TYPE public.room_type OWNER TO postgres;

--
-- TOC entry 1216 (class 1247 OID 18664)
-- Name: school_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.school_status AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'ARCHIVED'
);


ALTER TYPE public.school_status OWNER TO postgres;

--
-- TOC entry 1009 (class 1247 OID 16636)
-- Name: user_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_role AS ENUM (
    'SUPER_ADMIN',
    'SCHOOL_ADMIN',
    'TEACHER',
    'LEARNER',
    'GUARDIAN'
);


ALTER TYPE public.user_role OWNER TO postgres;

--
-- TOC entry 373 (class 1255 OID 18589)
-- Name: edge_random_address(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.edge_random_address() RETURNS TABLE(house_number integer, street_name character varying, city character varying, province character varying, postal_code character varying)
    LANGUAGE sql
    AS $$

SELECT

    house_number,
    street_name,
    city,
    province,
    postal_code

FROM generator_addresses

WHERE is_active = TRUE

ORDER BY random()

LIMIT 1;

$$;


ALTER FUNCTION public.edge_random_address() OWNER TO postgres;

--
-- TOC entry 371 (class 1255 OID 18512)
-- Name: edge_random_city(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.edge_random_city() RETURNS character varying
    LANGUAGE sql
    AS $$

SELECT city

FROM generator_cities

WHERE is_active = TRUE

ORDER BY random()

LIMIT 1;

$$;


ALTER FUNCTION public.edge_random_city() OWNER TO postgres;

--
-- TOC entry 376 (class 1255 OID 18639)
-- Name: edge_random_company(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.edge_random_company() RETURNS character varying
    LANGUAGE sql
    AS $$

SELECT company_name

FROM generator_companies

WHERE is_active = TRUE

ORDER BY random()

LIMIT 1;

$$;


ALTER FUNCTION public.edge_random_company() OWNER TO postgres;

--
-- TOC entry 374 (class 1255 OID 18605)
-- Name: edge_random_email_domain(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.edge_random_email_domain() RETURNS character varying
    LANGUAGE sql
    AS $$

SELECT domain

FROM generator_email_domains

WHERE is_active = TRUE

ORDER BY random()

LIMIT 1;

$$;


ALTER FUNCTION public.edge_random_email_domain() OWNER TO postgres;

--
-- TOC entry 370 (class 1255 OID 18495)
-- Name: edge_random_first_name(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.edge_random_first_name() RETURNS character varying
    LANGUAGE sql
    AS $$

SELECT first_name

FROM generator_first_names

WHERE is_active = TRUE

ORDER BY random()

LIMIT 1;

$$;


ALTER FUNCTION public.edge_random_first_name() OWNER TO postgres;

--
-- TOC entry 369 (class 1255 OID 18494)
-- Name: edge_random_last_name(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.edge_random_last_name() RETURNS character varying
    LANGUAGE sql
    AS $$

SELECT last_name

FROM generator_last_names

WHERE is_active = TRUE

ORDER BY random()

LIMIT 1;

$$;


ALTER FUNCTION public.edge_random_last_name() OWNER TO postgres;

--
-- TOC entry 375 (class 1255 OID 18622)
-- Name: edge_random_phone_prefix(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.edge_random_phone_prefix() RETURNS character varying
    LANGUAGE sql
    AS $$

SELECT prefix

FROM generator_phone_prefixes

WHERE is_active = TRUE

ORDER BY random()

LIMIT 1;

$$;


ALTER FUNCTION public.edge_random_phone_prefix() OWNER TO postgres;

--
-- TOC entry 372 (class 1255 OID 18571)
-- Name: edge_random_street(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.edge_random_street() RETURNS character varying
    LANGUAGE sql
    AS $$

SELECT street_name

FROM generator_streets

WHERE is_active = TRUE

ORDER BY random()

LIMIT 1;

$$;


ALTER FUNCTION public.edge_random_street() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 16752)
-- Name: academic_years; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.academic_years (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    school_id bigint NOT NULL,
    academic_year_name character varying(20) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    is_current boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.academic_years OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16751)
-- Name: academic_years_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.academic_years_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.academic_years_id_seq OWNER TO postgres;

--
-- TOC entry 5982 (class 0 OID 0)
-- Dependencies: 222
-- Name: academic_years_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.academic_years_id_seq OWNED BY public.academic_years.id;


--
-- TOC entry 261 (class 1259 OID 17579)
-- Name: assessment_results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assessment_results (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    assessment_id bigint NOT NULL,
    learner_id bigint NOT NULL,
    marks_obtained numeric(6,2) NOT NULL,
    percentage numeric(5,2),
    grade_symbol character varying(5),
    teacher_comment text,
    is_absent boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.assessment_results OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 17578)
-- Name: assessment_results_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.assessment_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.assessment_results_id_seq OWNER TO postgres;

--
-- TOC entry 5983 (class 0 OID 0)
-- Dependencies: 260
-- Name: assessment_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.assessment_results_id_seq OWNED BY public.assessment_results.id;


--
-- TOC entry 259 (class 1259 OID 17520)
-- Name: assessments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assessments (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    school_id bigint NOT NULL,
    academic_year_id bigint NOT NULL,
    term_id bigint NOT NULL,
    subject_id bigint NOT NULL,
    class_id bigint NOT NULL,
    teacher_id bigint NOT NULL,
    assessment_name character varying(200) NOT NULL,
    total_marks numeric(6,2) NOT NULL,
    pass_mark numeric(5,2) DEFAULT 50,
    assessment_date date NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.assessments OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 17519)
-- Name: assessments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.assessments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.assessments_id_seq OWNER TO postgres;

--
-- TOC entry 5984 (class 0 OID 0)
-- Dependencies: 258
-- Name: assessments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.assessments_id_seq OWNED BY public.assessments.id;


--
-- TOC entry 255 (class 1259 OID 17381)
-- Name: attendance_entries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attendance_entries (
    id bigint NOT NULL,
    attendance_session_id bigint NOT NULL,
    learner_id bigint NOT NULL,
    remarks text,
    recorded_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.attendance_entries OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 17380)
-- Name: attendance_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.attendance_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attendance_entries_id_seq OWNER TO postgres;

--
-- TOC entry 5985 (class 0 OID 0)
-- Dependencies: 254
-- Name: attendance_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.attendance_entries_id_seq OWNED BY public.attendance_entries.id;


--
-- TOC entry 253 (class 1259 OID 17336)
-- Name: attendance_sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attendance_sessions (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    class_id bigint NOT NULL,
    subject_id bigint NOT NULL,
    teacher_id bigint NOT NULL,
    academic_year_id bigint NOT NULL,
    attendance_date date NOT NULL,
    period_number integer,
    notes text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.attendance_sessions OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 17335)
-- Name: attendance_sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.attendance_sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attendance_sessions_id_seq OWNER TO postgres;

--
-- TOC entry 5986 (class 0 OID 0)
-- Dependencies: 252
-- Name: attendance_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.attendance_sessions_id_seq OWNED BY public.attendance_sessions.id;


--
-- TOC entry 305 (class 1259 OID 18288)
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.audit_logs (
    id bigint NOT NULL,
    user_id bigint,
    table_name character varying(100) NOT NULL,
    record_id bigint,
    action_type character varying(50) NOT NULL,
    old_values jsonb,
    new_values jsonb,
    action_timestamp timestamp with time zone DEFAULT now() NOT NULL,
    ip_address character varying(100)
);


ALTER TABLE public.audit_logs OWNER TO postgres;

--
-- TOC entry 304 (class 1259 OID 18287)
-- Name: audit_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.audit_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.audit_logs_id_seq OWNER TO postgres;

--
-- TOC entry 5987 (class 0 OID 0)
-- Dependencies: 304
-- Name: audit_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.audit_logs_id_seq OWNED BY public.audit_logs.id;


--
-- TOC entry 315 (class 1259 OID 18414)
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    school_id bigint NOT NULL,
    isbn character varying(20),
    title character varying(255) NOT NULL,
    author character varying(255),
    publisher character varying(255),
    publication_year integer,
    edition character varying(50),
    subject_id bigint,
    grade_id bigint,
    category character varying(100),
    language character varying(50),
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.books OWNER TO postgres;

--
-- TOC entry 314 (class 1259 OID 18413)
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.books_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.books_id_seq OWNER TO postgres;

--
-- TOC entry 5988 (class 0 OID 0)
-- Dependencies: 314
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.books_id_seq OWNED BY public.books.id;


--
-- TOC entry 251 (class 1259 OID 17300)
-- Name: class_subjects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.class_subjects (
    id bigint NOT NULL,
    class_id bigint NOT NULL,
    subject_id bigint NOT NULL,
    teacher_id bigint NOT NULL,
    academic_year_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.class_subjects OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 17299)
-- Name: class_subjects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.class_subjects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.class_subjects_id_seq OWNER TO postgres;

--
-- TOC entry 5989 (class 0 OID 0)
-- Dependencies: 250
-- Name: class_subjects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.class_subjects_id_seq OWNED BY public.class_subjects.id;


--
-- TOC entry 229 (class 1259 OID 16839)
-- Name: classes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.classes (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    school_id bigint NOT NULL,
    academic_year_id bigint NOT NULL,
    grade_id bigint NOT NULL,
    section_id bigint NOT NULL,
    class_name character varying(100) NOT NULL,
    classroom character varying(100),
    capacity integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL,
    CONSTRAINT chk_class_capacity CHECK (((capacity IS NULL) OR (capacity > 0)))
);


ALTER TABLE public.classes OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16838)
-- Name: classes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.classes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.classes_id_seq OWNER TO postgres;

--
-- TOC entry 5990 (class 0 OID 0)
-- Dependencies: 228
-- Name: classes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.classes_id_seq OWNED BY public.classes.id;


--
-- TOC entry 271 (class 1259 OID 17805)
-- Name: communication_channels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.communication_channels (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    channel_name character varying(50) NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.communication_channels OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 17804)
-- Name: communication_channels_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.communication_channels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.communication_channels_id_seq OWNER TO postgres;

--
-- TOC entry 5991 (class 0 OID 0)
-- Dependencies: 270
-- Name: communication_channels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.communication_channels_id_seq OWNED BY public.communication_channels.id;


--
-- TOC entry 273 (class 1259 OID 17828)
-- Name: communication_templates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.communication_templates (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    template_name character varying(150) NOT NULL,
    channel_id bigint NOT NULL,
    subject character varying(255),
    message_body text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.communication_templates OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 17827)
-- Name: communication_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.communication_templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.communication_templates_id_seq OWNER TO postgres;

--
-- TOC entry 5992 (class 0 OID 0)
-- Dependencies: 272
-- Name: communication_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.communication_templates_id_seq OWNED BY public.communication_templates.id;


--
-- TOC entry 231 (class 1259 OID 16885)
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departments (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    school_id bigint NOT NULL,
    department_name character varying(100) NOT NULL,
    department_code character varying(20),
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.departments OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16884)
-- Name: departments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.departments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.departments_id_seq OWNER TO postgres;

--
-- TOC entry 5993 (class 0 OID 0)
-- Dependencies: 230
-- Name: departments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.departments_id_seq OWNED BY public.departments.id;


--
-- TOC entry 313 (class 1259 OID 18391)
-- Name: document_access_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_access_logs (
    id bigint NOT NULL,
    document_id bigint NOT NULL,
    user_id bigint NOT NULL,
    action character varying(50) NOT NULL,
    accessed_at timestamp with time zone DEFAULT now() NOT NULL,
    ip_address character varying(100)
);


ALTER TABLE public.document_access_logs OWNER TO postgres;

--
-- TOC entry 312 (class 1259 OID 18390)
-- Name: document_access_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.document_access_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.document_access_logs_id_seq OWNER TO postgres;

--
-- TOC entry 5994 (class 0 OID 0)
-- Dependencies: 312
-- Name: document_access_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.document_access_logs_id_seq OWNED BY public.document_access_logs.id;


--
-- TOC entry 307 (class 1259 OID 18308)
-- Name: document_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_categories (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    category_name character varying(100) NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.document_categories OWNER TO postgres;

--
-- TOC entry 306 (class 1259 OID 18307)
-- Name: document_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.document_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.document_categories_id_seq OWNER TO postgres;

--
-- TOC entry 5995 (class 0 OID 0)
-- Dependencies: 306
-- Name: document_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.document_categories_id_seq OWNED BY public.document_categories.id;


--
-- TOC entry 311 (class 1259 OID 18366)
-- Name: document_versions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_versions (
    id bigint NOT NULL,
    document_id bigint NOT NULL,
    version_number integer NOT NULL,
    storage_path text NOT NULL,
    uploaded_at timestamp with time zone DEFAULT now() NOT NULL,
    uploaded_by bigint
);


ALTER TABLE public.document_versions OWNER TO postgres;

--
-- TOC entry 310 (class 1259 OID 18365)
-- Name: document_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.document_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.document_versions_id_seq OWNER TO postgres;

--
-- TOC entry 5996 (class 0 OID 0)
-- Dependencies: 310
-- Name: document_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.document_versions_id_seq OWNED BY public.document_versions.id;


--
-- TOC entry 309 (class 1259 OID 18331)
-- Name: documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documents (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    category_id bigint NOT NULL,
    uploaded_by bigint NOT NULL,
    document_name character varying(255) NOT NULL,
    original_file_name character varying(255) NOT NULL,
    file_type character varying(50),
    file_size bigint,
    storage_path text NOT NULL,
    mime_type character varying(100),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.documents OWNER TO postgres;

--
-- TOC entry 308 (class 1259 OID 18330)
-- Name: documents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.documents_id_seq OWNER TO postgres;

--
-- TOC entry 5997 (class 0 OID 0)
-- Dependencies: 308
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.documents_id_seq OWNED BY public.documents.id;


--
-- TOC entry 237 (class 1259 OID 17056)
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id bigint NOT NULL,
    school_id bigint NOT NULL,
    department_id bigint NOT NULL,
    position_id bigint NOT NULL,
    employee_number character varying(50) NOT NULL,
    employment_type public.employment_type NOT NULL,
    employment_status public.employment_status DEFAULT 'ACTIVE'::public.employment_status NOT NULL,
    hire_date date NOT NULL,
    termination_date date,
    salary numeric(12,2),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 17055)
-- Name: employees_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employees_id_seq OWNER TO postgres;

--
-- TOC entry 5998 (class 0 OID 0)
-- Dependencies: 236
-- Name: employees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employees_id_seq OWNED BY public.employees.id;


--
-- TOC entry 281 (class 1259 OID 17951)
-- Name: fee_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fee_categories (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    school_id bigint NOT NULL,
    category_name character varying(100) NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.fee_categories OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 17950)
-- Name: fee_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fee_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fee_categories_id_seq OWNER TO postgres;

--
-- TOC entry 5999 (class 0 OID 0)
-- Dependencies: 280
-- Name: fee_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fee_categories_id_seq OWNED BY public.fee_categories.id;


--
-- TOC entry 283 (class 1259 OID 17980)
-- Name: fee_structures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fee_structures (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    school_id bigint NOT NULL,
    academic_year_id bigint NOT NULL,
    grade_id bigint NOT NULL,
    fee_category_id bigint NOT NULL,
    fee_name character varying(150) NOT NULL,
    amount numeric(12,2) NOT NULL,
    due_date date,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.fee_structures OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 17979)
-- Name: fee_structures_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fee_structures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fee_structures_id_seq OWNER TO postgres;

--
-- TOC entry 6000 (class 0 OID 0)
-- Dependencies: 282
-- Name: fee_structures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fee_structures_id_seq OWNED BY public.fee_structures.id;


--
-- TOC entry 325 (class 1259 OID 18573)
-- Name: generator_addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.generator_addresses (
    id bigint NOT NULL,
    house_number integer NOT NULL,
    street_name character varying(150) NOT NULL,
    city character varying(100) NOT NULL,
    province character varying(100) NOT NULL,
    postal_code character varying(10) NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.generator_addresses OWNER TO postgres;

--
-- TOC entry 324 (class 1259 OID 18572)
-- Name: generator_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.generator_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.generator_addresses_id_seq OWNER TO postgres;

--
-- TOC entry 6001 (class 0 OID 0)
-- Dependencies: 324
-- Name: generator_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.generator_addresses_id_seq OWNED BY public.generator_addresses.id;


--
-- TOC entry 321 (class 1259 OID 18497)
-- Name: generator_cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.generator_cities (
    id bigint NOT NULL,
    city character varying(100) NOT NULL,
    province character varying(100) NOT NULL,
    postal_code character varying(10),
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.generator_cities OWNER TO postgres;

--
-- TOC entry 320 (class 1259 OID 18496)
-- Name: generator_cities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.generator_cities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.generator_cities_id_seq OWNER TO postgres;

--
-- TOC entry 6002 (class 0 OID 0)
-- Dependencies: 320
-- Name: generator_cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.generator_cities_id_seq OWNED BY public.generator_cities.id;


--
-- TOC entry 331 (class 1259 OID 18624)
-- Name: generator_companies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.generator_companies (
    id bigint NOT NULL,
    company_name character varying(200) NOT NULL,
    industry character varying(100) NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.generator_companies OWNER TO postgres;

--
-- TOC entry 330 (class 1259 OID 18623)
-- Name: generator_companies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.generator_companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.generator_companies_id_seq OWNER TO postgres;

--
-- TOC entry 6003 (class 0 OID 0)
-- Dependencies: 330
-- Name: generator_companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.generator_companies_id_seq OWNED BY public.generator_companies.id;


--
-- TOC entry 327 (class 1259 OID 18591)
-- Name: generator_email_domains; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.generator_email_domains (
    id bigint NOT NULL,
    domain character varying(150) NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.generator_email_domains OWNER TO postgres;

--
-- TOC entry 326 (class 1259 OID 18590)
-- Name: generator_email_domains_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.generator_email_domains_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.generator_email_domains_id_seq OWNER TO postgres;

--
-- TOC entry 6004 (class 0 OID 0)
-- Dependencies: 326
-- Name: generator_email_domains_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.generator_email_domains_id_seq OWNED BY public.generator_email_domains.id;


--
-- TOC entry 317 (class 1259 OID 18455)
-- Name: generator_first_names; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.generator_first_names (
    id bigint NOT NULL,
    first_name character varying(100) NOT NULL,
    gender character varying(10),
    is_active boolean DEFAULT true,
    CONSTRAINT generator_first_names_gender_check CHECK (((gender)::text = ANY ((ARRAY['Male'::character varying, 'Female'::character varying])::text[])))
);


ALTER TABLE public.generator_first_names OWNER TO postgres;

--
-- TOC entry 316 (class 1259 OID 18454)
-- Name: generator_first_names_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.generator_first_names_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.generator_first_names_id_seq OWNER TO postgres;

--
-- TOC entry 6005 (class 0 OID 0)
-- Dependencies: 316
-- Name: generator_first_names_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.generator_first_names_id_seq OWNED BY public.generator_first_names.id;


--
-- TOC entry 319 (class 1259 OID 18481)
-- Name: generator_last_names; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.generator_last_names (
    id bigint NOT NULL,
    last_name character varying(100),
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.generator_last_names OWNER TO postgres;

--
-- TOC entry 318 (class 1259 OID 18480)
-- Name: generator_last_names_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.generator_last_names_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.generator_last_names_id_seq OWNER TO postgres;

--
-- TOC entry 6006 (class 0 OID 0)
-- Dependencies: 318
-- Name: generator_last_names_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.generator_last_names_id_seq OWNED BY public.generator_last_names.id;


--
-- TOC entry 329 (class 1259 OID 18607)
-- Name: generator_phone_prefixes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.generator_phone_prefixes (
    id bigint NOT NULL,
    prefix character varying(5) NOT NULL,
    network_name character varying(50) NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.generator_phone_prefixes OWNER TO postgres;

--
-- TOC entry 328 (class 1259 OID 18606)
-- Name: generator_phone_prefixes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.generator_phone_prefixes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.generator_phone_prefixes_id_seq OWNER TO postgres;

--
-- TOC entry 6007 (class 0 OID 0)
-- Dependencies: 328
-- Name: generator_phone_prefixes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.generator_phone_prefixes_id_seq OWNED BY public.generator_phone_prefixes.id;


--
-- TOC entry 323 (class 1259 OID 18557)
-- Name: generator_streets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.generator_streets (
    id bigint NOT NULL,
    street_name character varying(150) NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.generator_streets OWNER TO postgres;

--
-- TOC entry 322 (class 1259 OID 18556)
-- Name: generator_streets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.generator_streets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.generator_streets_id_seq OWNER TO postgres;

--
-- TOC entry 6008 (class 0 OID 0)
-- Dependencies: 322
-- Name: generator_streets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.generator_streets_id_seq OWNED BY public.generator_streets.id;


--
-- TOC entry 225 (class 1259 OID 16783)
-- Name: grades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grades (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    school_id bigint NOT NULL,
    grade_name character varying(50) NOT NULL,
    grade_code character varying(20),
    display_order integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.grades OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16782)
-- Name: grades_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.grades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.grades_id_seq OWNER TO postgres;

--
-- TOC entry 6009 (class 0 OID 0)
-- Dependencies: 224
-- Name: grades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.grades_id_seq OWNED BY public.grades.id;


--
-- TOC entry 245 (class 1259 OID 17204)
-- Name: guardian_learners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.guardian_learners (
    id bigint NOT NULL,
    guardian_id bigint NOT NULL,
    learner_id bigint NOT NULL,
    relationship character varying(50) NOT NULL,
    is_primary_contact boolean DEFAULT false NOT NULL,
    has_legal_custody boolean DEFAULT false NOT NULL,
    pickup_authorized boolean DEFAULT true NOT NULL,
    financial_responsibility boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.guardian_learners OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 17203)
-- Name: guardian_learners_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.guardian_learners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.guardian_learners_id_seq OWNER TO postgres;

--
-- TOC entry 6010 (class 0 OID 0)
-- Dependencies: 244
-- Name: guardian_learners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.guardian_learners_id_seq OWNED BY public.guardian_learners.id;


--
-- TOC entry 243 (class 1259 OID 17178)
-- Name: guardians; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.guardians (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id bigint NOT NULL,
    occupation character varying(150),
    employer character varying(200),
    work_phone character varying(30),
    relationship_to_learner character varying(50),
    preferred_contact_method character varying(30),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.guardians OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 17177)
-- Name: guardians_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.guardians_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.guardians_id_seq OWNER TO postgres;

--
-- TOC entry 6011 (class 0 OID 0)
-- Dependencies: 242
-- Name: guardians_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.guardians_id_seq OWNED BY public.guardians.id;


--
-- TOC entry 287 (class 1259 OID 18072)
-- Name: invoices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoices (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    learner_id bigint NOT NULL,
    invoice_number character varying(50) NOT NULL,
    invoice_date date NOT NULL,
    due_date date NOT NULL,
    total_amount numeric(12,2) NOT NULL,
    balance_due numeric(12,2) NOT NULL,
    invoice_status public.invoice_status DEFAULT 'PENDING'::public.invoice_status NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.invoices OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 18071)
-- Name: invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invoices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invoices_id_seq OWNER TO postgres;

--
-- TOC entry 6012 (class 0 OID 0)
-- Dependencies: 286
-- Name: invoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invoices_id_seq OWNED BY public.invoices.id;


--
-- TOC entry 285 (class 1259 OID 18025)
-- Name: learner_fee_assignments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.learner_fee_assignments (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    learner_id bigint NOT NULL,
    fee_structure_id bigint NOT NULL,
    assigned_amount numeric(12,2) NOT NULL,
    discount_amount numeric(12,2) DEFAULT 0,
    final_amount numeric(12,2) NOT NULL,
    assigned_date date DEFAULT CURRENT_DATE NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.learner_fee_assignments OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 18024)
-- Name: learner_fee_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.learner_fee_assignments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.learner_fee_assignments_id_seq OWNER TO postgres;

--
-- TOC entry 6013 (class 0 OID 0)
-- Dependencies: 284
-- Name: learner_fee_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.learner_fee_assignments_id_seq OWNED BY public.learner_fee_assignments.id;


--
-- TOC entry 241 (class 1259 OID 17133)
-- Name: learners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.learners (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id bigint NOT NULL,
    school_id bigint NOT NULL,
    class_id bigint,
    learner_number character varying(50) NOT NULL,
    admission_date date NOT NULL,
    enrolment_status public.enrolment_status DEFAULT 'ENROLLED'::public.enrolment_status NOT NULL,
    previous_school character varying(200),
    medical_notes text,
    emergency_contact_name character varying(200),
    emergency_contact_phone character varying(30),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.learners OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 17132)
-- Name: learners_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.learners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.learners_id_seq OWNER TO postgres;

--
-- TOC entry 6014 (class 0 OID 0)
-- Dependencies: 240
-- Name: learners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.learners_id_seq OWNED BY public.learners.id;


--
-- TOC entry 303 (class 1259 OID 18270)
-- Name: login_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.login_history (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    login_time timestamp with time zone DEFAULT now() NOT NULL,
    logout_time timestamp with time zone,
    login_status character varying(50),
    ip_address character varying(100),
    device_information text
);


ALTER TABLE public.login_history OWNER TO postgres;

--
-- TOC entry 302 (class 1259 OID 18269)
-- Name: login_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.login_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.login_history_id_seq OWNER TO postgres;

--
-- TOC entry 6015 (class 0 OID 0)
-- Dependencies: 302
-- Name: login_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.login_history_id_seq OWNED BY public.login_history.id;


--
-- TOC entry 279 (class 1259 OID 17926)
-- Name: notification_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification_logs (
    id bigint NOT NULL,
    notification_id bigint NOT NULL,
    channel_id bigint NOT NULL,
    log_message text,
    response_code character varying(100),
    logged_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.notification_logs OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 17925)
-- Name: notification_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notification_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notification_logs_id_seq OWNER TO postgres;

--
-- TOC entry 6016 (class 0 OID 0)
-- Dependencies: 278
-- Name: notification_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notification_logs_id_seq OWNED BY public.notification_logs.id;


--
-- TOC entry 277 (class 1259 OID 17902)
-- Name: notification_recipients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification_recipients (
    id bigint NOT NULL,
    notification_id bigint NOT NULL,
    user_id bigint NOT NULL,
    delivery_status public.delivery_status DEFAULT 'PENDING'::public.delivery_status NOT NULL,
    delivered_at timestamp with time zone,
    read_at timestamp with time zone
);


ALTER TABLE public.notification_recipients OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 17901)
-- Name: notification_recipients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notification_recipients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notification_recipients_id_seq OWNER TO postgres;

--
-- TOC entry 6017 (class 0 OID 0)
-- Dependencies: 276
-- Name: notification_recipients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notification_recipients_id_seq OWNED BY public.notification_recipients.id;


--
-- TOC entry 275 (class 1259 OID 17858)
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    template_id bigint NOT NULL,
    sender_user_id bigint,
    notification_title character varying(255),
    notification_message text NOT NULL,
    scheduled_at timestamp with time zone,
    sent_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 17857)
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_id_seq OWNER TO postgres;

--
-- TOC entry 6018 (class 0 OID 0)
-- Dependencies: 274
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- TOC entry 289 (class 1259 OID 18105)
-- Name: payment_methods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_methods (
    id bigint NOT NULL,
    method_name character varying(50) NOT NULL,
    description text,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.payment_methods OWNER TO postgres;

--
-- TOC entry 288 (class 1259 OID 18104)
-- Name: payment_methods_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_methods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_methods_id_seq OWNER TO postgres;

--
-- TOC entry 6019 (class 0 OID 0)
-- Dependencies: 288
-- Name: payment_methods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_methods_id_seq OWNED BY public.payment_methods.id;


--
-- TOC entry 291 (class 1259 OID 18120)
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    invoice_id bigint NOT NULL,
    payment_method_id bigint NOT NULL,
    payment_date date NOT NULL,
    amount_paid numeric(12,2) NOT NULL,
    reference_number character varying(100),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 18119)
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_id_seq OWNER TO postgres;

--
-- TOC entry 6020 (class 0 OID 0)
-- Dependencies: 290
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- TOC entry 265 (class 1259 OID 17664)
-- Name: periods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.periods (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    school_id bigint NOT NULL,
    period_number integer NOT NULL,
    period_name character varying(50) NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    is_break boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.periods OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 17663)
-- Name: periods_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.periods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.periods_id_seq OWNER TO postgres;

--
-- TOC entry 6021 (class 0 OID 0)
-- Dependencies: 264
-- Name: periods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.periods_id_seq OWNED BY public.periods.id;


--
-- TOC entry 297 (class 1259 OID 18204)
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permissions (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    permission_name character varying(150) NOT NULL,
    description text,
    module_name character varying(100),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.permissions OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 18203)
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permissions_id_seq OWNER TO postgres;

--
-- TOC entry 6022 (class 0 OID 0)
-- Dependencies: 296
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- TOC entry 233 (class 1259 OID 16914)
-- Name: positions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.positions (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    department_id bigint NOT NULL,
    position_name character varying(100) NOT NULL,
    position_code character varying(20),
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.positions OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16913)
-- Name: positions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.positions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.positions_id_seq OWNER TO postgres;

--
-- TOC entry 6023 (class 0 OID 0)
-- Dependencies: 232
-- Name: positions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.positions_id_seq OWNED BY public.positions.id;


--
-- TOC entry 293 (class 1259 OID 18152)
-- Name: receipts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.receipts (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    payment_id bigint NOT NULL,
    receipt_number character varying(50) NOT NULL,
    receipt_date date NOT NULL,
    amount numeric(12,2) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.receipts OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 18151)
-- Name: receipts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.receipts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.receipts_id_seq OWNER TO postgres;

--
-- TOC entry 6024 (class 0 OID 0)
-- Dependencies: 292
-- Name: receipts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.receipts_id_seq OWNED BY public.receipts.id;


--
-- TOC entry 299 (class 1259 OID 18225)
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_permissions (
    id bigint NOT NULL,
    role_id bigint NOT NULL,
    permission_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.role_permissions OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 18224)
-- Name: role_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.role_permissions_id_seq OWNER TO postgres;

--
-- TOC entry 6025 (class 0 OID 0)
-- Dependencies: 298
-- Name: role_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_permissions_id_seq OWNED BY public.role_permissions.id;


--
-- TOC entry 295 (class 1259 OID 18181)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    role_name character varying(100) NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 18180)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 6026 (class 0 OID 0)
-- Dependencies: 294
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 263 (class 1259 OID 17636)
-- Name: rooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rooms (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    school_id bigint NOT NULL,
    room_name character varying(100) NOT NULL,
    room_code character varying(20),
    room_type public.room_type NOT NULL,
    capacity integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.rooms OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 17635)
-- Name: rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rooms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rooms_id_seq OWNER TO postgres;

--
-- TOC entry 6027 (class 0 OID 0)
-- Dependencies: 262
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rooms_id_seq OWNED BY public.rooms.id;


--
-- TOC entry 221 (class 1259 OID 16726)
-- Name: schools; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schools (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    school_name character varying(200) NOT NULL,
    school_code character varying(30) NOT NULL,
    email character varying(255),
    phone character varying(30),
    address text,
    principal_name character varying(200),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.schools OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16725)
-- Name: schools_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schools_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.schools_id_seq OWNER TO postgres;

--
-- TOC entry 6028 (class 0 OID 0)
-- Dependencies: 220
-- Name: schools_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schools_id_seq OWNED BY public.schools.id;


--
-- TOC entry 227 (class 1259 OID 16811)
-- Name: sections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sections (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    school_id bigint NOT NULL,
    section_name character varying(50) NOT NULL,
    section_code character varying(20),
    display_order integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.sections OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16810)
-- Name: sections_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sections_id_seq OWNER TO postgres;

--
-- TOC entry 6029 (class 0 OID 0)
-- Dependencies: 226
-- Name: sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sections_id_seq OWNED BY public.sections.id;


--
-- TOC entry 247 (class 1259 OID 17237)
-- Name: subjects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subjects (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    school_id bigint NOT NULL,
    subject_code character varying(30) NOT NULL,
    subject_name character varying(150) NOT NULL,
    description text,
    is_compulsory boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.subjects OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 17236)
-- Name: subjects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subjects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subjects_id_seq OWNER TO postgres;

--
-- TOC entry 6030 (class 0 OID 0)
-- Dependencies: 246
-- Name: subjects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subjects_id_seq OWNED BY public.subjects.id;


--
-- TOC entry 249 (class 1259 OID 17269)
-- Name: teacher_subjects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teacher_subjects (
    id bigint NOT NULL,
    teacher_id bigint NOT NULL,
    subject_id bigint NOT NULL,
    academic_year_id bigint NOT NULL,
    assigned_date date DEFAULT CURRENT_DATE,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.teacher_subjects OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 17268)
-- Name: teacher_subjects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teacher_subjects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.teacher_subjects_id_seq OWNER TO postgres;

--
-- TOC entry 6031 (class 0 OID 0)
-- Dependencies: 248
-- Name: teacher_subjects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teacher_subjects_id_seq OWNED BY public.teacher_subjects.id;


--
-- TOC entry 239 (class 1259 OID 17107)
-- Name: teachers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teachers (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    employee_id bigint NOT NULL,
    teacher_registration_number character varying(50),
    highest_qualification character varying(150),
    specialization character varying(150),
    years_experience integer,
    hire_date date,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.teachers OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 17106)
-- Name: teachers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teachers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.teachers_id_seq OWNER TO postgres;

--
-- TOC entry 6032 (class 0 OID 0)
-- Dependencies: 238
-- Name: teachers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teachers_id_seq OWNED BY public.teachers.id;


--
-- TOC entry 257 (class 1259 OID 17487)
-- Name: terms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.terms (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    academic_year_id bigint NOT NULL,
    term_number integer NOT NULL,
    term_name character varying(50) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    is_current boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.terms OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 17486)
-- Name: terms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.terms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.terms_id_seq OWNER TO postgres;

--
-- TOC entry 6033 (class 0 OID 0)
-- Dependencies: 256
-- Name: terms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.terms_id_seq OWNED BY public.terms.id;


--
-- TOC entry 269 (class 1259 OID 17754)
-- Name: timetable_entries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.timetable_entries (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    timetable_id bigint NOT NULL,
    day_of_week public.day_of_week NOT NULL,
    period_id bigint NOT NULL,
    subject_id bigint NOT NULL,
    teacher_id bigint NOT NULL,
    room_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.timetable_entries OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 17753)
-- Name: timetable_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.timetable_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.timetable_entries_id_seq OWNER TO postgres;

--
-- TOC entry 6034 (class 0 OID 0)
-- Dependencies: 268
-- Name: timetable_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.timetable_entries_id_seq OWNED BY public.timetable_entries.id;


--
-- TOC entry 267 (class 1259 OID 17696)
-- Name: timetables; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.timetables (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    school_id bigint NOT NULL,
    academic_year_id bigint NOT NULL,
    term_id bigint NOT NULL,
    class_id bigint NOT NULL,
    timetable_name character varying(100) NOT NULL,
    effective_from date,
    effective_to date,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.timetables OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 17695)
-- Name: timetables_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.timetables_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.timetables_id_seq OWNER TO postgres;

--
-- TOC entry 6035 (class 0 OID 0)
-- Dependencies: 266
-- Name: timetables_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.timetables_id_seq OWNED BY public.timetables.id;


--
-- TOC entry 301 (class 1259 OID 18249)
-- Name: user_sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_sessions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    session_token text NOT NULL,
    login_time timestamp with time zone DEFAULT now() NOT NULL,
    logout_time timestamp with time zone,
    ip_address character varying(100),
    device_information text,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.user_sessions OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 18248)
-- Name: user_sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_sessions_id_seq OWNER TO postgres;

--
-- TOC entry 6036 (class 0 OID 0)
-- Dependencies: 300
-- Name: user_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_sessions_id_seq OWNED BY public.user_sessions.id;


--
-- TOC entry 235 (class 1259 OID 17024)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(30),
    date_of_birth date,
    gender public.gender_type,
    username character varying(100) NOT NULL,
    password_hash text NOT NULL,
    role public.user_role NOT NULL,
    last_login timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint,
    updated_by bigint,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 17023)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 6037 (class 0 OID 0)
-- Dependencies: 234
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 5239 (class 2604 OID 16755)
-- Name: academic_years id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_years ALTER COLUMN id SET DEFAULT nextval('public.academic_years_id_seq'::regclass);


--
-- TOC entry 5332 (class 2604 OID 17582)
-- Name: assessment_results id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assessment_results ALTER COLUMN id SET DEFAULT nextval('public.assessment_results_id_seq'::regclass);


--
-- TOC entry 5326 (class 2604 OID 17523)
-- Name: assessments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assessments ALTER COLUMN id SET DEFAULT nextval('public.assessments_id_seq'::regclass);


--
-- TOC entry 5318 (class 2604 OID 17384)
-- Name: attendance_entries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_entries ALTER COLUMN id SET DEFAULT nextval('public.attendance_entries_id_seq'::regclass);


--
-- TOC entry 5314 (class 2604 OID 17339)
-- Name: attendance_sessions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_sessions ALTER COLUMN id SET DEFAULT nextval('public.attendance_sessions_id_seq'::regclass);


--
-- TOC entry 5429 (class 2604 OID 18291)
-- Name: audit_logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs ALTER COLUMN id SET DEFAULT nextval('public.audit_logs_id_seq'::regclass);


--
-- TOC entry 5445 (class 2604 OID 18417)
-- Name: books id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books ALTER COLUMN id SET DEFAULT nextval('public.books_id_seq'::regclass);


--
-- TOC entry 5312 (class 2604 OID 17303)
-- Name: class_subjects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class_subjects ALTER COLUMN id SET DEFAULT nextval('public.class_subjects_id_seq'::regclass);


--
-- TOC entry 5255 (class 2604 OID 16842)
-- Name: classes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes ALTER COLUMN id SET DEFAULT nextval('public.classes_id_seq'::regclass);


--
-- TOC entry 5359 (class 2604 OID 17808)
-- Name: communication_channels id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.communication_channels ALTER COLUMN id SET DEFAULT nextval('public.communication_channels_id_seq'::regclass);


--
-- TOC entry 5364 (class 2604 OID 17831)
-- Name: communication_templates id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.communication_templates ALTER COLUMN id SET DEFAULT nextval('public.communication_templates_id_seq'::regclass);


--
-- TOC entry 5260 (class 2604 OID 16888)
-- Name: departments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments ALTER COLUMN id SET DEFAULT nextval('public.departments_id_seq'::regclass);


--
-- TOC entry 5443 (class 2604 OID 18394)
-- Name: document_access_logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_access_logs ALTER COLUMN id SET DEFAULT nextval('public.document_access_logs_id_seq'::regclass);


--
-- TOC entry 5431 (class 2604 OID 18311)
-- Name: document_categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_categories ALTER COLUMN id SET DEFAULT nextval('public.document_categories_id_seq'::regclass);


--
-- TOC entry 5441 (class 2604 OID 18369)
-- Name: document_versions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_versions ALTER COLUMN id SET DEFAULT nextval('public.document_versions_id_seq'::regclass);


--
-- TOC entry 5436 (class 2604 OID 18334)
-- Name: documents id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents ALTER COLUMN id SET DEFAULT nextval('public.documents_id_seq'::regclass);


--
-- TOC entry 5275 (class 2604 OID 17059)
-- Name: employees id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees ALTER COLUMN id SET DEFAULT nextval('public.employees_id_seq'::regclass);


--
-- TOC entry 5378 (class 2604 OID 17954)
-- Name: fee_categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fee_categories ALTER COLUMN id SET DEFAULT nextval('public.fee_categories_id_seq'::regclass);


--
-- TOC entry 5383 (class 2604 OID 17983)
-- Name: fee_structures id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fee_structures ALTER COLUMN id SET DEFAULT nextval('public.fee_structures_id_seq'::regclass);


--
-- TOC entry 5461 (class 2604 OID 18576)
-- Name: generator_addresses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generator_addresses ALTER COLUMN id SET DEFAULT nextval('public.generator_addresses_id_seq'::regclass);


--
-- TOC entry 5455 (class 2604 OID 18500)
-- Name: generator_cities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generator_cities ALTER COLUMN id SET DEFAULT nextval('public.generator_cities_id_seq'::regclass);


--
-- TOC entry 5470 (class 2604 OID 18627)
-- Name: generator_companies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generator_companies ALTER COLUMN id SET DEFAULT nextval('public.generator_companies_id_seq'::regclass);


--
-- TOC entry 5464 (class 2604 OID 18594)
-- Name: generator_email_domains id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generator_email_domains ALTER COLUMN id SET DEFAULT nextval('public.generator_email_domains_id_seq'::regclass);


--
-- TOC entry 5450 (class 2604 OID 18458)
-- Name: generator_first_names id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generator_first_names ALTER COLUMN id SET DEFAULT nextval('public.generator_first_names_id_seq'::regclass);


--
-- TOC entry 5452 (class 2604 OID 18484)
-- Name: generator_last_names id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generator_last_names ALTER COLUMN id SET DEFAULT nextval('public.generator_last_names_id_seq'::regclass);


--
-- TOC entry 5467 (class 2604 OID 18610)
-- Name: generator_phone_prefixes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generator_phone_prefixes ALTER COLUMN id SET DEFAULT nextval('public.generator_phone_prefixes_id_seq'::regclass);


--
-- TOC entry 5458 (class 2604 OID 18560)
-- Name: generator_streets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generator_streets ALTER COLUMN id SET DEFAULT nextval('public.generator_streets_id_seq'::regclass);


--
-- TOC entry 5245 (class 2604 OID 16786)
-- Name: grades id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades ALTER COLUMN id SET DEFAULT nextval('public.grades_id_seq'::regclass);


--
-- TOC entry 5297 (class 2604 OID 17207)
-- Name: guardian_learners id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guardian_learners ALTER COLUMN id SET DEFAULT nextval('public.guardian_learners_id_seq'::regclass);


--
-- TOC entry 5292 (class 2604 OID 17181)
-- Name: guardians id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guardians ALTER COLUMN id SET DEFAULT nextval('public.guardians_id_seq'::regclass);


--
-- TOC entry 5395 (class 2604 OID 18075)
-- Name: invoices id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices ALTER COLUMN id SET DEFAULT nextval('public.invoices_id_seq'::regclass);


--
-- TOC entry 5388 (class 2604 OID 18028)
-- Name: learner_fee_assignments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learner_fee_assignments ALTER COLUMN id SET DEFAULT nextval('public.learner_fee_assignments_id_seq'::regclass);


--
-- TOC entry 5286 (class 2604 OID 17136)
-- Name: learners id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learners ALTER COLUMN id SET DEFAULT nextval('public.learners_id_seq'::regclass);


--
-- TOC entry 5427 (class 2604 OID 18273)
-- Name: login_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_history ALTER COLUMN id SET DEFAULT nextval('public.login_history_id_seq'::regclass);


--
-- TOC entry 5376 (class 2604 OID 17929)
-- Name: notification_logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_logs ALTER COLUMN id SET DEFAULT nextval('public.notification_logs_id_seq'::regclass);


--
-- TOC entry 5374 (class 2604 OID 17905)
-- Name: notification_recipients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_recipients ALTER COLUMN id SET DEFAULT nextval('public.notification_recipients_id_seq'::regclass);


--
-- TOC entry 5369 (class 2604 OID 17861)
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- TOC entry 5401 (class 2604 OID 18108)
-- Name: payment_methods id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_methods ALTER COLUMN id SET DEFAULT nextval('public.payment_methods_id_seq'::regclass);


--
-- TOC entry 5403 (class 2604 OID 18123)
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- TOC entry 5343 (class 2604 OID 17667)
-- Name: periods id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.periods ALTER COLUMN id SET DEFAULT nextval('public.periods_id_seq'::regclass);


--
-- TOC entry 5418 (class 2604 OID 18207)
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- TOC entry 5265 (class 2604 OID 16917)
-- Name: positions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions ALTER COLUMN id SET DEFAULT nextval('public.positions_id_seq'::regclass);


--
-- TOC entry 5408 (class 2604 OID 18155)
-- Name: receipts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receipts ALTER COLUMN id SET DEFAULT nextval('public.receipts_id_seq'::regclass);


--
-- TOC entry 5422 (class 2604 OID 18228)
-- Name: role_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions ALTER COLUMN id SET DEFAULT nextval('public.role_permissions_id_seq'::regclass);


--
-- TOC entry 5413 (class 2604 OID 18184)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 5338 (class 2604 OID 17639)
-- Name: rooms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms ALTER COLUMN id SET DEFAULT nextval('public.rooms_id_seq'::regclass);


--
-- TOC entry 5234 (class 2604 OID 16729)
-- Name: schools id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schools ALTER COLUMN id SET DEFAULT nextval('public.schools_id_seq'::regclass);


--
-- TOC entry 5250 (class 2604 OID 16814)
-- Name: sections id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sections ALTER COLUMN id SET DEFAULT nextval('public.sections_id_seq'::regclass);


--
-- TOC entry 5303 (class 2604 OID 17240)
-- Name: subjects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects ALTER COLUMN id SET DEFAULT nextval('public.subjects_id_seq'::regclass);


--
-- TOC entry 5309 (class 2604 OID 17272)
-- Name: teacher_subjects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_subjects ALTER COLUMN id SET DEFAULT nextval('public.teacher_subjects_id_seq'::regclass);


--
-- TOC entry 5281 (class 2604 OID 17110)
-- Name: teachers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers ALTER COLUMN id SET DEFAULT nextval('public.teachers_id_seq'::regclass);


--
-- TOC entry 5320 (class 2604 OID 17490)
-- Name: terms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.terms ALTER COLUMN id SET DEFAULT nextval('public.terms_id_seq'::regclass);


--
-- TOC entry 5354 (class 2604 OID 17757)
-- Name: timetable_entries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetable_entries ALTER COLUMN id SET DEFAULT nextval('public.timetable_entries_id_seq'::regclass);


--
-- TOC entry 5349 (class 2604 OID 17699)
-- Name: timetables id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetables ALTER COLUMN id SET DEFAULT nextval('public.timetables_id_seq'::regclass);


--
-- TOC entry 5424 (class 2604 OID 18252)
-- Name: user_sessions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_sessions ALTER COLUMN id SET DEFAULT nextval('public.user_sessions_id_seq'::regclass);


--
-- TOC entry 5270 (class 2604 OID 17027)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5482 (class 2606 OID 16772)
-- Name: academic_years academic_years_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_years
    ADD CONSTRAINT academic_years_pkey PRIMARY KEY (id);


--
-- TOC entry 5484 (class 2606 OID 16774)
-- Name: academic_years academic_years_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_years
    ADD CONSTRAINT academic_years_public_id_key UNIQUE (public_id);


--
-- TOC entry 5590 (class 2606 OID 17600)
-- Name: assessment_results assessment_results_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assessment_results
    ADD CONSTRAINT assessment_results_pkey PRIMARY KEY (id);


--
-- TOC entry 5592 (class 2606 OID 17602)
-- Name: assessment_results assessment_results_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assessment_results
    ADD CONSTRAINT assessment_results_public_id_key UNIQUE (public_id);


--
-- TOC entry 5586 (class 2606 OID 17545)
-- Name: assessments assessments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assessments
    ADD CONSTRAINT assessments_pkey PRIMARY KEY (id);


--
-- TOC entry 5588 (class 2606 OID 17547)
-- Name: assessments assessments_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assessments
    ADD CONSTRAINT assessments_public_id_key UNIQUE (public_id);


--
-- TOC entry 5576 (class 2606 OID 17394)
-- Name: attendance_entries attendance_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_entries
    ADD CONSTRAINT attendance_entries_pkey PRIMARY KEY (id);


--
-- TOC entry 5570 (class 2606 OID 17355)
-- Name: attendance_sessions attendance_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_sessions
    ADD CONSTRAINT attendance_sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 5572 (class 2606 OID 17357)
-- Name: attendance_sessions attendance_sessions_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_sessions
    ADD CONSTRAINT attendance_sessions_public_id_key UNIQUE (public_id);


--
-- TOC entry 5694 (class 2606 OID 18300)
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 5710 (class 2606 OID 18436)
-- Name: books books_isbn_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_isbn_key UNIQUE (isbn);


--
-- TOC entry 5712 (class 2606 OID 18432)
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- TOC entry 5714 (class 2606 OID 18434)
-- Name: books books_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_public_id_key UNIQUE (public_id);


--
-- TOC entry 5566 (class 2606 OID 17312)
-- Name: class_subjects class_subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class_subjects
    ADD CONSTRAINT class_subjects_pkey PRIMARY KEY (id);


--
-- TOC entry 5500 (class 2606 OID 16859)
-- Name: classes classes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_pkey PRIMARY KEY (id);


--
-- TOC entry 5502 (class 2606 OID 16861)
-- Name: classes classes_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_public_id_key UNIQUE (public_id);


--
-- TOC entry 5618 (class 2606 OID 17826)
-- Name: communication_channels communication_channels_channel_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.communication_channels
    ADD CONSTRAINT communication_channels_channel_name_key UNIQUE (channel_name);


--
-- TOC entry 5620 (class 2606 OID 17822)
-- Name: communication_channels communication_channels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.communication_channels
    ADD CONSTRAINT communication_channels_pkey PRIMARY KEY (id);


--
-- TOC entry 5622 (class 2606 OID 17824)
-- Name: communication_channels communication_channels_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.communication_channels
    ADD CONSTRAINT communication_channels_public_id_key UNIQUE (public_id);


--
-- TOC entry 5624 (class 2606 OID 17847)
-- Name: communication_templates communication_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.communication_templates
    ADD CONSTRAINT communication_templates_pkey PRIMARY KEY (id);


--
-- TOC entry 5626 (class 2606 OID 17849)
-- Name: communication_templates communication_templates_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.communication_templates
    ADD CONSTRAINT communication_templates_public_id_key UNIQUE (public_id);


--
-- TOC entry 5628 (class 2606 OID 17851)
-- Name: communication_templates communication_templates_template_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.communication_templates
    ADD CONSTRAINT communication_templates_template_name_key UNIQUE (template_name);


--
-- TOC entry 5506 (class 2606 OID 16903)
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);


--
-- TOC entry 5508 (class 2606 OID 16905)
-- Name: departments departments_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_public_id_key UNIQUE (public_id);


--
-- TOC entry 5708 (class 2606 OID 18402)
-- Name: document_access_logs document_access_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_access_logs
    ADD CONSTRAINT document_access_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 5696 (class 2606 OID 18329)
-- Name: document_categories document_categories_category_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_categories
    ADD CONSTRAINT document_categories_category_name_key UNIQUE (category_name);


--
-- TOC entry 5698 (class 2606 OID 18325)
-- Name: document_categories document_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_categories
    ADD CONSTRAINT document_categories_pkey PRIMARY KEY (id);


--
-- TOC entry 5700 (class 2606 OID 18327)
-- Name: document_categories document_categories_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_categories
    ADD CONSTRAINT document_categories_public_id_key UNIQUE (public_id);


--
-- TOC entry 5706 (class 2606 OID 18379)
-- Name: document_versions document_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_versions
    ADD CONSTRAINT document_versions_pkey PRIMARY KEY (id);


--
-- TOC entry 5702 (class 2606 OID 18352)
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- TOC entry 5704 (class 2606 OID 18354)
-- Name: documents documents_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_public_id_key UNIQUE (public_id);


--
-- TOC entry 5526 (class 2606 OID 17083)
-- Name: employees employees_employee_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_employee_number_key UNIQUE (employee_number);


--
-- TOC entry 5528 (class 2606 OID 17079)
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- TOC entry 5530 (class 2606 OID 17081)
-- Name: employees employees_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_public_id_key UNIQUE (public_id);


--
-- TOC entry 5640 (class 2606 OID 17969)
-- Name: fee_categories fee_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fee_categories
    ADD CONSTRAINT fee_categories_pkey PRIMARY KEY (id);


--
-- TOC entry 5642 (class 2606 OID 17971)
-- Name: fee_categories fee_categories_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fee_categories
    ADD CONSTRAINT fee_categories_public_id_key UNIQUE (public_id);


--
-- TOC entry 5646 (class 2606 OID 18000)
-- Name: fee_structures fee_structures_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fee_structures
    ADD CONSTRAINT fee_structures_pkey PRIMARY KEY (id);


--
-- TOC entry 5648 (class 2606 OID 18002)
-- Name: fee_structures fee_structures_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fee_structures
    ADD CONSTRAINT fee_structures_public_id_key UNIQUE (public_id);


--
-- TOC entry 5730 (class 2606 OID 18588)
-- Name: generator_addresses generator_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generator_addresses
    ADD CONSTRAINT generator_addresses_pkey PRIMARY KEY (id);


--
-- TOC entry 5722 (class 2606 OID 18511)
-- Name: generator_cities generator_cities_city_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generator_cities
    ADD CONSTRAINT generator_cities_city_key UNIQUE (city);


--
-- TOC entry 5724 (class 2606 OID 18509)
-- Name: generator_cities generator_cities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generator_cities
    ADD CONSTRAINT generator_cities_pkey PRIMARY KEY (id);


--
-- TOC entry 5740 (class 2606 OID 18638)
-- Name: generator_companies generator_companies_company_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generator_companies
    ADD CONSTRAINT generator_companies_company_name_key UNIQUE (company_name);


--
-- TOC entry 5742 (class 2606 OID 18636)
-- Name: generator_companies generator_companies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generator_companies
    ADD CONSTRAINT generator_companies_pkey PRIMARY KEY (id);


--
-- TOC entry 5732 (class 2606 OID 18604)
-- Name: generator_email_domains generator_email_domains_domain_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generator_email_domains
    ADD CONSTRAINT generator_email_domains_domain_key UNIQUE (domain);


--
-- TOC entry 5734 (class 2606 OID 18602)
-- Name: generator_email_domains generator_email_domains_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generator_email_domains
    ADD CONSTRAINT generator_email_domains_pkey PRIMARY KEY (id);


--
-- TOC entry 5716 (class 2606 OID 18464)
-- Name: generator_first_names generator_first_names_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generator_first_names
    ADD CONSTRAINT generator_first_names_pkey PRIMARY KEY (id);


--
-- TOC entry 5718 (class 2606 OID 18493)
-- Name: generator_last_names generator_last_names_last_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generator_last_names
    ADD CONSTRAINT generator_last_names_last_name_key UNIQUE (last_name);


--
-- TOC entry 5720 (class 2606 OID 18491)
-- Name: generator_last_names generator_last_names_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generator_last_names
    ADD CONSTRAINT generator_last_names_pkey PRIMARY KEY (id);


--
-- TOC entry 5736 (class 2606 OID 18619)
-- Name: generator_phone_prefixes generator_phone_prefixes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generator_phone_prefixes
    ADD CONSTRAINT generator_phone_prefixes_pkey PRIMARY KEY (id);


--
-- TOC entry 5738 (class 2606 OID 18621)
-- Name: generator_phone_prefixes generator_phone_prefixes_prefix_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generator_phone_prefixes
    ADD CONSTRAINT generator_phone_prefixes_prefix_key UNIQUE (prefix);


--
-- TOC entry 5726 (class 2606 OID 18568)
-- Name: generator_streets generator_streets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generator_streets
    ADD CONSTRAINT generator_streets_pkey PRIMARY KEY (id);


--
-- TOC entry 5728 (class 2606 OID 18570)
-- Name: generator_streets generator_streets_street_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generator_streets
    ADD CONSTRAINT generator_streets_street_name_key UNIQUE (street_name);


--
-- TOC entry 5488 (class 2606 OID 16800)
-- Name: grades grades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_pkey PRIMARY KEY (id);


--
-- TOC entry 5490 (class 2606 OID 16802)
-- Name: grades grades_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_public_id_key UNIQUE (public_id);


--
-- TOC entry 5552 (class 2606 OID 17223)
-- Name: guardian_learners guardian_learners_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guardian_learners
    ADD CONSTRAINT guardian_learners_pkey PRIMARY KEY (id);


--
-- TOC entry 5546 (class 2606 OID 17193)
-- Name: guardians guardians_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guardians
    ADD CONSTRAINT guardians_pkey PRIMARY KEY (id);


--
-- TOC entry 5548 (class 2606 OID 17195)
-- Name: guardians guardians_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guardians
    ADD CONSTRAINT guardians_public_id_key UNIQUE (public_id);


--
-- TOC entry 5550 (class 2606 OID 17197)
-- Name: guardians guardians_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guardians
    ADD CONSTRAINT guardians_user_id_key UNIQUE (user_id);


--
-- TOC entry 5654 (class 2606 OID 18098)
-- Name: invoices invoices_invoice_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_invoice_number_key UNIQUE (invoice_number);


--
-- TOC entry 5656 (class 2606 OID 18094)
-- Name: invoices invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_pkey PRIMARY KEY (id);


--
-- TOC entry 5658 (class 2606 OID 18096)
-- Name: invoices invoices_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_public_id_key UNIQUE (public_id);


--
-- TOC entry 5650 (class 2606 OID 18046)
-- Name: learner_fee_assignments learner_fee_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learner_fee_assignments
    ADD CONSTRAINT learner_fee_assignments_pkey PRIMARY KEY (id);


--
-- TOC entry 5652 (class 2606 OID 18048)
-- Name: learner_fee_assignments learner_fee_assignments_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learner_fee_assignments
    ADD CONSTRAINT learner_fee_assignments_public_id_key UNIQUE (public_id);


--
-- TOC entry 5538 (class 2606 OID 17161)
-- Name: learners learners_learner_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learners
    ADD CONSTRAINT learners_learner_number_key UNIQUE (learner_number);


--
-- TOC entry 5540 (class 2606 OID 17155)
-- Name: learners learners_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learners
    ADD CONSTRAINT learners_pkey PRIMARY KEY (id);


--
-- TOC entry 5542 (class 2606 OID 17157)
-- Name: learners learners_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learners
    ADD CONSTRAINT learners_public_id_key UNIQUE (public_id);


--
-- TOC entry 5544 (class 2606 OID 17159)
-- Name: learners learners_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learners
    ADD CONSTRAINT learners_user_id_key UNIQUE (user_id);


--
-- TOC entry 5692 (class 2606 OID 18281)
-- Name: login_history login_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_history
    ADD CONSTRAINT login_history_pkey PRIMARY KEY (id);


--
-- TOC entry 5638 (class 2606 OID 17938)
-- Name: notification_logs notification_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_logs
    ADD CONSTRAINT notification_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 5634 (class 2606 OID 17912)
-- Name: notification_recipients notification_recipients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_recipients
    ADD CONSTRAINT notification_recipients_pkey PRIMARY KEY (id);


--
-- TOC entry 5630 (class 2606 OID 17876)
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- TOC entry 5632 (class 2606 OID 17878)
-- Name: notifications notifications_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_public_id_key UNIQUE (public_id);


--
-- TOC entry 5660 (class 2606 OID 18118)
-- Name: payment_methods payment_methods_method_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_methods
    ADD CONSTRAINT payment_methods_method_name_key UNIQUE (method_name);


--
-- TOC entry 5662 (class 2606 OID 18116)
-- Name: payment_methods payment_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_methods
    ADD CONSTRAINT payment_methods_pkey PRIMARY KEY (id);


--
-- TOC entry 5664 (class 2606 OID 18138)
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- TOC entry 5666 (class 2606 OID 18140)
-- Name: payments payments_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_public_id_key UNIQUE (public_id);


--
-- TOC entry 5602 (class 2606 OID 17685)
-- Name: periods periods_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.periods
    ADD CONSTRAINT periods_pkey PRIMARY KEY (id);


--
-- TOC entry 5604 (class 2606 OID 17687)
-- Name: periods periods_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.periods
    ADD CONSTRAINT periods_public_id_key UNIQUE (public_id);


--
-- TOC entry 5680 (class 2606 OID 18223)
-- Name: permissions permissions_permission_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_permission_name_key UNIQUE (permission_name);


--
-- TOC entry 5682 (class 2606 OID 18219)
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 5684 (class 2606 OID 18221)
-- Name: permissions permissions_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_public_id_key UNIQUE (public_id);


--
-- TOC entry 5512 (class 2606 OID 16932)
-- Name: positions positions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_pkey PRIMARY KEY (id);


--
-- TOC entry 5514 (class 2606 OID 16934)
-- Name: positions positions_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_public_id_key UNIQUE (public_id);


--
-- TOC entry 5668 (class 2606 OID 18170)
-- Name: receipts receipts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receipts
    ADD CONSTRAINT receipts_pkey PRIMARY KEY (id);


--
-- TOC entry 5670 (class 2606 OID 18172)
-- Name: receipts receipts_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receipts
    ADD CONSTRAINT receipts_public_id_key UNIQUE (public_id);


--
-- TOC entry 5672 (class 2606 OID 18174)
-- Name: receipts receipts_receipt_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receipts
    ADD CONSTRAINT receipts_receipt_number_key UNIQUE (receipt_number);


--
-- TOC entry 5686 (class 2606 OID 18235)
-- Name: role_permissions role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 5674 (class 2606 OID 18198)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 5676 (class 2606 OID 18200)
-- Name: roles roles_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_public_id_key UNIQUE (public_id);


--
-- TOC entry 5678 (class 2606 OID 18202)
-- Name: roles roles_role_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_role_name_key UNIQUE (role_name);


--
-- TOC entry 5596 (class 2606 OID 17653)
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- TOC entry 5598 (class 2606 OID 17655)
-- Name: rooms rooms_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_public_id_key UNIQUE (public_id);


--
-- TOC entry 5476 (class 2606 OID 16746)
-- Name: schools schools_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schools
    ADD CONSTRAINT schools_pkey PRIMARY KEY (id);


--
-- TOC entry 5478 (class 2606 OID 16748)
-- Name: schools schools_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schools
    ADD CONSTRAINT schools_public_id_key UNIQUE (public_id);


--
-- TOC entry 5480 (class 2606 OID 16750)
-- Name: schools schools_school_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schools
    ADD CONSTRAINT schools_school_code_key UNIQUE (school_code);


--
-- TOC entry 5494 (class 2606 OID 16828)
-- Name: sections sections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_pkey PRIMARY KEY (id);


--
-- TOC entry 5496 (class 2606 OID 16830)
-- Name: sections sections_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_public_id_key UNIQUE (public_id);


--
-- TOC entry 5556 (class 2606 OID 17258)
-- Name: subjects subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT subjects_pkey PRIMARY KEY (id);


--
-- TOC entry 5558 (class 2606 OID 17260)
-- Name: subjects subjects_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT subjects_public_id_key UNIQUE (public_id);


--
-- TOC entry 5562 (class 2606 OID 17281)
-- Name: teacher_subjects teacher_subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_subjects
    ADD CONSTRAINT teacher_subjects_pkey PRIMARY KEY (id);


--
-- TOC entry 5532 (class 2606 OID 17126)
-- Name: teachers teachers_employee_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_employee_id_key UNIQUE (employee_id);


--
-- TOC entry 5534 (class 2606 OID 17122)
-- Name: teachers teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (id);


--
-- TOC entry 5536 (class 2606 OID 17124)
-- Name: teachers teachers_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_public_id_key UNIQUE (public_id);


--
-- TOC entry 5580 (class 2606 OID 17508)
-- Name: terms terms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.terms
    ADD CONSTRAINT terms_pkey PRIMARY KEY (id);


--
-- TOC entry 5582 (class 2606 OID 17510)
-- Name: terms terms_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.terms
    ADD CONSTRAINT terms_public_id_key UNIQUE (public_id);


--
-- TOC entry 5612 (class 2606 OID 17774)
-- Name: timetable_entries timetable_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetable_entries
    ADD CONSTRAINT timetable_entries_pkey PRIMARY KEY (id);


--
-- TOC entry 5614 (class 2606 OID 17776)
-- Name: timetable_entries timetable_entries_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetable_entries
    ADD CONSTRAINT timetable_entries_public_id_key UNIQUE (public_id);


--
-- TOC entry 5608 (class 2606 OID 17715)
-- Name: timetables timetables_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetables
    ADD CONSTRAINT timetables_pkey PRIMARY KEY (id);


--
-- TOC entry 5610 (class 2606 OID 17717)
-- Name: timetables timetables_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetables
    ADD CONSTRAINT timetables_public_id_key UNIQUE (public_id);


--
-- TOC entry 5594 (class 2606 OID 17604)
-- Name: assessment_results uq_assessment_learner; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assessment_results
    ADD CONSTRAINT uq_assessment_learner UNIQUE (assessment_id, learner_id);


--
-- TOC entry 5574 (class 2606 OID 17359)
-- Name: attendance_sessions uq_attendance_session; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_sessions
    ADD CONSTRAINT uq_attendance_session UNIQUE (class_id, subject_id, attendance_date, period_number);


--
-- TOC entry 5504 (class 2606 OID 16863)
-- Name: classes uq_class; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT uq_class UNIQUE (school_id, academic_year_id, grade_id, section_id);


--
-- TOC entry 5568 (class 2606 OID 17314)
-- Name: class_subjects uq_class_subject; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class_subjects
    ADD CONSTRAINT uq_class_subject UNIQUE (class_id, subject_id, academic_year_id);


--
-- TOC entry 5516 (class 2606 OID 16936)
-- Name: positions uq_department_position; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT uq_department_position UNIQUE (department_id, position_name);


--
-- TOC entry 5554 (class 2606 OID 17225)
-- Name: guardian_learners uq_guardian_learner; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guardian_learners
    ADD CONSTRAINT uq_guardian_learner UNIQUE (guardian_id, learner_id);


--
-- TOC entry 5636 (class 2606 OID 17914)
-- Name: notification_recipients uq_notification_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_recipients
    ADD CONSTRAINT uq_notification_user UNIQUE (notification_id, user_id);


--
-- TOC entry 5688 (class 2606 OID 18237)
-- Name: role_permissions uq_role_permission; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT uq_role_permission UNIQUE (role_id, permission_id);


--
-- TOC entry 5486 (class 2606 OID 16776)
-- Name: academic_years uq_school_academic_year; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_years
    ADD CONSTRAINT uq_school_academic_year UNIQUE (school_id, academic_year_name);


--
-- TOC entry 5510 (class 2606 OID 16907)
-- Name: departments uq_school_department; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT uq_school_department UNIQUE (school_id, department_name);


--
-- TOC entry 5644 (class 2606 OID 17973)
-- Name: fee_categories uq_school_fee_category; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fee_categories
    ADD CONSTRAINT uq_school_fee_category UNIQUE (school_id, category_name);


--
-- TOC entry 5492 (class 2606 OID 16804)
-- Name: grades uq_school_grade; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT uq_school_grade UNIQUE (school_id, grade_name);


--
-- TOC entry 5606 (class 2606 OID 17689)
-- Name: periods uq_school_period; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.periods
    ADD CONSTRAINT uq_school_period UNIQUE (school_id, period_number);


--
-- TOC entry 5600 (class 2606 OID 17657)
-- Name: rooms uq_school_room; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT uq_school_room UNIQUE (school_id, room_name);


--
-- TOC entry 5498 (class 2606 OID 16832)
-- Name: sections uq_school_section; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT uq_school_section UNIQUE (school_id, section_name);


--
-- TOC entry 5560 (class 2606 OID 17262)
-- Name: subjects uq_school_subject; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT uq_school_subject UNIQUE (school_id, subject_code);


--
-- TOC entry 5578 (class 2606 OID 17396)
-- Name: attendance_entries uq_session_learner; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_entries
    ADD CONSTRAINT uq_session_learner UNIQUE (attendance_session_id, learner_id);


--
-- TOC entry 5564 (class 2606 OID 17283)
-- Name: teacher_subjects uq_teacher_subject; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_subjects
    ADD CONSTRAINT uq_teacher_subject UNIQUE (teacher_id, subject_id, academic_year_id);


--
-- TOC entry 5616 (class 2606 OID 17778)
-- Name: timetable_entries uq_timetable_slot; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetable_entries
    ADD CONSTRAINT uq_timetable_slot UNIQUE (timetable_id, day_of_week, period_id);


--
-- TOC entry 5584 (class 2606 OID 17512)
-- Name: terms uq_year_term; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.terms
    ADD CONSTRAINT uq_year_term UNIQUE (academic_year_id, term_number);


--
-- TOC entry 5690 (class 2606 OID 18263)
-- Name: user_sessions user_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 5518 (class 2606 OID 17052)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 5520 (class 2606 OID 17048)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 5522 (class 2606 OID 17050)
-- Name: users users_public_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_public_id_key UNIQUE (public_id);


--
-- TOC entry 5524 (class 2606 OID 17054)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 5743 (class 2606 OID 16777)
-- Name: academic_years fk_academic_year_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_years
    ADD CONSTRAINT fk_academic_year_school FOREIGN KEY (school_id) REFERENCES public.schools(id) ON DELETE RESTRICT;


--
-- TOC entry 5824 (class 2606 OID 18403)
-- Name: document_access_logs fk_access_document; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_access_logs
    ADD CONSTRAINT fk_access_document FOREIGN KEY (document_id) REFERENCES public.documents(id);


--
-- TOC entry 5825 (class 2606 OID 18408)
-- Name: document_access_logs fk_access_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_access_logs
    ADD CONSTRAINT fk_access_user FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 5778 (class 2606 OID 17568)
-- Name: assessments fk_assessment_class; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assessments
    ADD CONSTRAINT fk_assessment_class FOREIGN KEY (class_id) REFERENCES public.classes(id);


--
-- TOC entry 5779 (class 2606 OID 17548)
-- Name: assessments fk_assessment_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assessments
    ADD CONSTRAINT fk_assessment_school FOREIGN KEY (school_id) REFERENCES public.schools(id);


--
-- TOC entry 5780 (class 2606 OID 17563)
-- Name: assessments fk_assessment_subject; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assessments
    ADD CONSTRAINT fk_assessment_subject FOREIGN KEY (subject_id) REFERENCES public.subjects(id);


--
-- TOC entry 5781 (class 2606 OID 17573)
-- Name: assessments fk_assessment_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assessments
    ADD CONSTRAINT fk_assessment_teacher FOREIGN KEY (teacher_id) REFERENCES public.teachers(id);


--
-- TOC entry 5782 (class 2606 OID 17558)
-- Name: assessments fk_assessment_term; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assessments
    ADD CONSTRAINT fk_assessment_term FOREIGN KEY (term_id) REFERENCES public.terms(id);


--
-- TOC entry 5783 (class 2606 OID 17553)
-- Name: assessments fk_assessment_year; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assessments
    ADD CONSTRAINT fk_assessment_year FOREIGN KEY (academic_year_id) REFERENCES public.academic_years(id);


--
-- TOC entry 5809 (class 2606 OID 18054)
-- Name: learner_fee_assignments fk_assignment_fee; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learner_fee_assignments
    ADD CONSTRAINT fk_assignment_fee FOREIGN KEY (fee_structure_id) REFERENCES public.fee_structures(id);


--
-- TOC entry 5810 (class 2606 OID 18049)
-- Name: learner_fee_assignments fk_assignment_learner; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learner_fee_assignments
    ADD CONSTRAINT fk_assignment_learner FOREIGN KEY (learner_id) REFERENCES public.learners(id);


--
-- TOC entry 5819 (class 2606 OID 18301)
-- Name: audit_logs fk_audit_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT fk_audit_user FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 5826 (class 2606 OID 18447)
-- Name: books fk_book_grade; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT fk_book_grade FOREIGN KEY (grade_id) REFERENCES public.grades(id);


--
-- TOC entry 5827 (class 2606 OID 18437)
-- Name: books fk_book_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT fk_book_school FOREIGN KEY (school_id) REFERENCES public.schools(id);


--
-- TOC entry 5828 (class 2606 OID 18442)
-- Name: books fk_book_subject; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT fk_book_subject FOREIGN KEY (subject_id) REFERENCES public.subjects(id);


--
-- TOC entry 5746 (class 2606 OID 16869)
-- Name: classes fk_class_academic_year; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT fk_class_academic_year FOREIGN KEY (academic_year_id) REFERENCES public.academic_years(id) ON DELETE RESTRICT;


--
-- TOC entry 5747 (class 2606 OID 16874)
-- Name: classes fk_class_grade; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT fk_class_grade FOREIGN KEY (grade_id) REFERENCES public.grades(id) ON DELETE RESTRICT;


--
-- TOC entry 5748 (class 2606 OID 16864)
-- Name: classes fk_class_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT fk_class_school FOREIGN KEY (school_id) REFERENCES public.schools(id) ON DELETE RESTRICT;


--
-- TOC entry 5749 (class 2606 OID 16879)
-- Name: classes fk_class_section; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT fk_class_section FOREIGN KEY (section_id) REFERENCES public.sections(id) ON DELETE RESTRICT;


--
-- TOC entry 5767 (class 2606 OID 17315)
-- Name: class_subjects fk_class_subject_class; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class_subjects
    ADD CONSTRAINT fk_class_subject_class FOREIGN KEY (class_id) REFERENCES public.classes(id) ON DELETE CASCADE;


--
-- TOC entry 5768 (class 2606 OID 17320)
-- Name: class_subjects fk_class_subject_subject; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class_subjects
    ADD CONSTRAINT fk_class_subject_subject FOREIGN KEY (subject_id) REFERENCES public.subjects(id) ON DELETE CASCADE;


--
-- TOC entry 5769 (class 2606 OID 17325)
-- Name: class_subjects fk_class_subject_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class_subjects
    ADD CONSTRAINT fk_class_subject_teacher FOREIGN KEY (teacher_id) REFERENCES public.teachers(id) ON DELETE RESTRICT;


--
-- TOC entry 5770 (class 2606 OID 17330)
-- Name: class_subjects fk_class_subject_year; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class_subjects
    ADD CONSTRAINT fk_class_subject_year FOREIGN KEY (academic_year_id) REFERENCES public.academic_years(id) ON DELETE RESTRICT;


--
-- TOC entry 5750 (class 2606 OID 16908)
-- Name: departments fk_department_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT fk_department_school FOREIGN KEY (school_id) REFERENCES public.schools(id) ON DELETE RESTRICT;


--
-- TOC entry 5820 (class 2606 OID 18355)
-- Name: documents fk_document_category; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT fk_document_category FOREIGN KEY (category_id) REFERENCES public.document_categories(id);


--
-- TOC entry 5821 (class 2606 OID 18360)
-- Name: documents fk_document_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT fk_document_user FOREIGN KEY (uploaded_by) REFERENCES public.users(id);


--
-- TOC entry 5752 (class 2606 OID 17094)
-- Name: employees fk_employee_department; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT fk_employee_department FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- TOC entry 5753 (class 2606 OID 17099)
-- Name: employees fk_employee_position; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT fk_employee_position FOREIGN KEY (position_id) REFERENCES public.positions(id);


--
-- TOC entry 5754 (class 2606 OID 17089)
-- Name: employees fk_employee_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT fk_employee_school FOREIGN KEY (school_id) REFERENCES public.schools(id);


--
-- TOC entry 5755 (class 2606 OID 17084)
-- Name: employees fk_employee_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT fk_employee_user FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 5775 (class 2606 OID 17402)
-- Name: attendance_entries fk_entry_learner; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_entries
    ADD CONSTRAINT fk_entry_learner FOREIGN KEY (learner_id) REFERENCES public.learners(id);


--
-- TOC entry 5776 (class 2606 OID 17397)
-- Name: attendance_entries fk_entry_session; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_entries
    ADD CONSTRAINT fk_entry_session FOREIGN KEY (attendance_session_id) REFERENCES public.attendance_sessions(id) ON DELETE CASCADE;


--
-- TOC entry 5805 (class 2606 OID 18018)
-- Name: fee_structures fk_fee_category; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fee_structures
    ADD CONSTRAINT fk_fee_category FOREIGN KEY (fee_category_id) REFERENCES public.fee_categories(id);


--
-- TOC entry 5804 (class 2606 OID 17974)
-- Name: fee_categories fk_fee_category_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fee_categories
    ADD CONSTRAINT fk_fee_category_school FOREIGN KEY (school_id) REFERENCES public.schools(id);


--
-- TOC entry 5806 (class 2606 OID 18013)
-- Name: fee_structures fk_fee_grade; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fee_structures
    ADD CONSTRAINT fk_fee_grade FOREIGN KEY (grade_id) REFERENCES public.grades(id);


--
-- TOC entry 5807 (class 2606 OID 18003)
-- Name: fee_structures fk_fee_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fee_structures
    ADD CONSTRAINT fk_fee_school FOREIGN KEY (school_id) REFERENCES public.schools(id);


--
-- TOC entry 5808 (class 2606 OID 18008)
-- Name: fee_structures fk_fee_year; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fee_structures
    ADD CONSTRAINT fk_fee_year FOREIGN KEY (academic_year_id) REFERENCES public.academic_years(id);


--
-- TOC entry 5761 (class 2606 OID 17226)
-- Name: guardian_learners fk_gl_guardian; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guardian_learners
    ADD CONSTRAINT fk_gl_guardian FOREIGN KEY (guardian_id) REFERENCES public.guardians(id) ON DELETE CASCADE;


--
-- TOC entry 5762 (class 2606 OID 17231)
-- Name: guardian_learners fk_gl_learner; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guardian_learners
    ADD CONSTRAINT fk_gl_learner FOREIGN KEY (learner_id) REFERENCES public.learners(id) ON DELETE CASCADE;


--
-- TOC entry 5744 (class 2606 OID 16805)
-- Name: grades fk_grade_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT fk_grade_school FOREIGN KEY (school_id) REFERENCES public.schools(id) ON DELETE RESTRICT;


--
-- TOC entry 5760 (class 2606 OID 17198)
-- Name: guardians fk_guardian_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guardians
    ADD CONSTRAINT fk_guardian_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- TOC entry 5811 (class 2606 OID 18099)
-- Name: invoices fk_invoice_learner; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT fk_invoice_learner FOREIGN KEY (learner_id) REFERENCES public.learners(id);


--
-- TOC entry 5757 (class 2606 OID 17172)
-- Name: learners fk_learner_class; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learners
    ADD CONSTRAINT fk_learner_class FOREIGN KEY (class_id) REFERENCES public.classes(id) ON DELETE SET NULL;


--
-- TOC entry 5758 (class 2606 OID 17167)
-- Name: learners fk_learner_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learners
    ADD CONSTRAINT fk_learner_school FOREIGN KEY (school_id) REFERENCES public.schools(id) ON DELETE RESTRICT;


--
-- TOC entry 5759 (class 2606 OID 17162)
-- Name: learners fk_learner_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learners
    ADD CONSTRAINT fk_learner_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- TOC entry 5802 (class 2606 OID 17944)
-- Name: notification_logs fk_log_channel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_logs
    ADD CONSTRAINT fk_log_channel FOREIGN KEY (channel_id) REFERENCES public.communication_channels(id);


--
-- TOC entry 5803 (class 2606 OID 17939)
-- Name: notification_logs fk_log_notification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_logs
    ADD CONSTRAINT fk_log_notification FOREIGN KEY (notification_id) REFERENCES public.notifications(id);


--
-- TOC entry 5818 (class 2606 OID 18282)
-- Name: login_history fk_login_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_history
    ADD CONSTRAINT fk_login_user FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 5798 (class 2606 OID 17884)
-- Name: notifications fk_notification_sender; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_notification_sender FOREIGN KEY (sender_user_id) REFERENCES public.users(id);


--
-- TOC entry 5799 (class 2606 OID 17879)
-- Name: notifications fk_notification_template; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_notification_template FOREIGN KEY (template_id) REFERENCES public.communication_templates(id);


--
-- TOC entry 5812 (class 2606 OID 18141)
-- Name: payments fk_payment_invoice; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_payment_invoice FOREIGN KEY (invoice_id) REFERENCES public.invoices(id);


--
-- TOC entry 5813 (class 2606 OID 18146)
-- Name: payments fk_payment_method; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_payment_method FOREIGN KEY (payment_method_id) REFERENCES public.payment_methods(id);


--
-- TOC entry 5787 (class 2606 OID 17690)
-- Name: periods fk_period_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.periods
    ADD CONSTRAINT fk_period_school FOREIGN KEY (school_id) REFERENCES public.schools(id);


--
-- TOC entry 5751 (class 2606 OID 16937)
-- Name: positions fk_position_department; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT fk_position_department FOREIGN KEY (department_id) REFERENCES public.departments(id) ON DELETE RESTRICT;


--
-- TOC entry 5814 (class 2606 OID 18175)
-- Name: receipts fk_receipt_payment; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receipts
    ADD CONSTRAINT fk_receipt_payment FOREIGN KEY (payment_id) REFERENCES public.payments(id);


--
-- TOC entry 5800 (class 2606 OID 17915)
-- Name: notification_recipients fk_recipient_notification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_recipients
    ADD CONSTRAINT fk_recipient_notification FOREIGN KEY (notification_id) REFERENCES public.notifications(id) ON DELETE CASCADE;


--
-- TOC entry 5801 (class 2606 OID 17920)
-- Name: notification_recipients fk_recipient_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_recipients
    ADD CONSTRAINT fk_recipient_user FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 5784 (class 2606 OID 17605)
-- Name: assessment_results fk_result_assessment; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assessment_results
    ADD CONSTRAINT fk_result_assessment FOREIGN KEY (assessment_id) REFERENCES public.assessments(id) ON DELETE CASCADE;


--
-- TOC entry 5785 (class 2606 OID 17610)
-- Name: assessment_results fk_result_learner; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assessment_results
    ADD CONSTRAINT fk_result_learner FOREIGN KEY (learner_id) REFERENCES public.learners(id);


--
-- TOC entry 5786 (class 2606 OID 17658)
-- Name: rooms fk_room_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT fk_room_school FOREIGN KEY (school_id) REFERENCES public.schools(id);


--
-- TOC entry 5815 (class 2606 OID 18243)
-- Name: role_permissions fk_rp_permission; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT fk_rp_permission FOREIGN KEY (permission_id) REFERENCES public.permissions(id);


--
-- TOC entry 5816 (class 2606 OID 18238)
-- Name: role_permissions fk_rp_role; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT fk_rp_role FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- TOC entry 5745 (class 2606 OID 16833)
-- Name: sections fk_section_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT fk_section_school FOREIGN KEY (school_id) REFERENCES public.schools(id) ON DELETE RESTRICT;


--
-- TOC entry 5771 (class 2606 OID 17360)
-- Name: attendance_sessions fk_session_class; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_sessions
    ADD CONSTRAINT fk_session_class FOREIGN KEY (class_id) REFERENCES public.classes(id);


--
-- TOC entry 5772 (class 2606 OID 17365)
-- Name: attendance_sessions fk_session_subject; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_sessions
    ADD CONSTRAINT fk_session_subject FOREIGN KEY (subject_id) REFERENCES public.subjects(id);


--
-- TOC entry 5773 (class 2606 OID 17370)
-- Name: attendance_sessions fk_session_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_sessions
    ADD CONSTRAINT fk_session_teacher FOREIGN KEY (teacher_id) REFERENCES public.teachers(id);


--
-- TOC entry 5817 (class 2606 OID 18264)
-- Name: user_sessions fk_session_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT fk_session_user FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 5774 (class 2606 OID 17375)
-- Name: attendance_sessions fk_session_year; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_sessions
    ADD CONSTRAINT fk_session_year FOREIGN KEY (academic_year_id) REFERENCES public.academic_years(id);


--
-- TOC entry 5763 (class 2606 OID 17263)
-- Name: subjects fk_subject_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT fk_subject_school FOREIGN KEY (school_id) REFERENCES public.schools(id) ON DELETE RESTRICT;


--
-- TOC entry 5756 (class 2606 OID 17127)
-- Name: teachers fk_teacher_employee; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT fk_teacher_employee FOREIGN KEY (employee_id) REFERENCES public.employees(id) ON DELETE RESTRICT;


--
-- TOC entry 5764 (class 2606 OID 17289)
-- Name: teacher_subjects fk_teacher_subject_subject; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_subjects
    ADD CONSTRAINT fk_teacher_subject_subject FOREIGN KEY (subject_id) REFERENCES public.subjects(id) ON DELETE CASCADE;


--
-- TOC entry 5765 (class 2606 OID 17284)
-- Name: teacher_subjects fk_teacher_subject_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_subjects
    ADD CONSTRAINT fk_teacher_subject_teacher FOREIGN KEY (teacher_id) REFERENCES public.teachers(id) ON DELETE CASCADE;


--
-- TOC entry 5766 (class 2606 OID 17294)
-- Name: teacher_subjects fk_teacher_subject_year; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_subjects
    ADD CONSTRAINT fk_teacher_subject_year FOREIGN KEY (academic_year_id) REFERENCES public.academic_years(id) ON DELETE RESTRICT;


--
-- TOC entry 5797 (class 2606 OID 17852)
-- Name: communication_templates fk_template_channel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.communication_templates
    ADD CONSTRAINT fk_template_channel FOREIGN KEY (channel_id) REFERENCES public.communication_channels(id);


--
-- TOC entry 5777 (class 2606 OID 17513)
-- Name: terms fk_term_year; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.terms
    ADD CONSTRAINT fk_term_year FOREIGN KEY (academic_year_id) REFERENCES public.academic_years(id) ON DELETE RESTRICT;


--
-- TOC entry 5788 (class 2606 OID 17733)
-- Name: timetables fk_tt_class; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetables
    ADD CONSTRAINT fk_tt_class FOREIGN KEY (class_id) REFERENCES public.classes(id);


--
-- TOC entry 5789 (class 2606 OID 17718)
-- Name: timetables fk_tt_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetables
    ADD CONSTRAINT fk_tt_school FOREIGN KEY (school_id) REFERENCES public.schools(id);


--
-- TOC entry 5790 (class 2606 OID 17728)
-- Name: timetables fk_tt_term; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetables
    ADD CONSTRAINT fk_tt_term FOREIGN KEY (term_id) REFERENCES public.terms(id);


--
-- TOC entry 5791 (class 2606 OID 17723)
-- Name: timetables fk_tt_year; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetables
    ADD CONSTRAINT fk_tt_year FOREIGN KEY (academic_year_id) REFERENCES public.academic_years(id);


--
-- TOC entry 5792 (class 2606 OID 17784)
-- Name: timetable_entries fk_tte_period; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetable_entries
    ADD CONSTRAINT fk_tte_period FOREIGN KEY (period_id) REFERENCES public.periods(id);


--
-- TOC entry 5793 (class 2606 OID 17799)
-- Name: timetable_entries fk_tte_room; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetable_entries
    ADD CONSTRAINT fk_tte_room FOREIGN KEY (room_id) REFERENCES public.rooms(id);


--
-- TOC entry 5794 (class 2606 OID 17789)
-- Name: timetable_entries fk_tte_subject; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetable_entries
    ADD CONSTRAINT fk_tte_subject FOREIGN KEY (subject_id) REFERENCES public.subjects(id);


--
-- TOC entry 5795 (class 2606 OID 17794)
-- Name: timetable_entries fk_tte_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetable_entries
    ADD CONSTRAINT fk_tte_teacher FOREIGN KEY (teacher_id) REFERENCES public.teachers(id);


--
-- TOC entry 5796 (class 2606 OID 17779)
-- Name: timetable_entries fk_tte_tt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetable_entries
    ADD CONSTRAINT fk_tte_tt FOREIGN KEY (timetable_id) REFERENCES public.timetables(id) ON DELETE CASCADE;


--
-- TOC entry 5822 (class 2606 OID 18380)
-- Name: document_versions fk_version_document; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_versions
    ADD CONSTRAINT fk_version_document FOREIGN KEY (document_id) REFERENCES public.documents(id) ON DELETE CASCADE;


--
-- TOC entry 5823 (class 2606 OID 18385)
-- Name: document_versions fk_version_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_versions
    ADD CONSTRAINT fk_version_user FOREIGN KEY (uploaded_by) REFERENCES public.users(id);


-- Completed on 2026-08-05 19:06:49

--
-- PostgreSQL database dump complete
--

\unrestrict uMUEIs3UXLtJdrkEZAtT1koSLooga0G323EY9rKdzxxyr6V9vBASk1kvuq2cfjj

