-- ============================================================================
-- EduCare Management System
-- Generator Table: First Names
-- ----------------------------------------------------------------------------
-- Purpose:
-- Stores reusable first names for generating demo learners, teachers,
-- guardians and employees.
--
-- Safe to rerun.
-- ============================================================================

BEGIN;

DROP TABLE IF EXISTS generator_first_names;

CREATE TABLE generator_first_names
(
    id BIGSERIAL PRIMARY KEY,

    first_name VARCHAR(100) NOT NULL,

    gender VARCHAR(10)
        CHECK (gender IN ('Male','Female')),

    is_active BOOLEAN DEFAULT TRUE
);

INSERT INTO generator_first_names
(
    first_name,
    gender
)
VALUES

-- =========================
-- Male
-- =========================

('Sipho','Male'),
('Sibusiso','Male'),
('Thabo','Male'),
('Themba','Male'),
('Mandla','Male'),
('Bongani','Male'),
('Lwazi','Male'),
('Ayanda','Male'),
('Lindokuhle','Male'),
('Vusi','Male'),
('Mpho','Male'),
('Andile','Male'),
('Kagiso','Male'),
('Neo','Male'),
('Tshepo','Male'),
('Lebo','Male'),
('Gift','Male'),
('Justice','Male'),
('Trevor','Male'),
('Brian','Male'),
('Samuel','Male'),
('Daniel','Male'),
('John','Male'),
('Peter','Male'),
('Michael','Male'),
('David','Male'),
('Christopher','Male'),
('Nicholas','Male'),
('Richard','Male'),
('Patrick','Male'),
('Kevin','Male'),
('Ryan','Male'),
('Jason','Male'),
('Moses','Male'),
('Isaac','Male'),
('Elijah','Male'),
('Joseph','Male'),
('Blessing','Male'),
('Lucky','Male'),
('Siyabonga','Male'),
('Nkosinathi','Male'),
('Mlondi','Male'),
('Khaya','Male'),
('Bheki','Male'),
('Sizwe','Male'),
('Mthokozisi','Male'),
('Luthando','Male'),
('Phumlani','Male'),
('Jabulani','Male'),
('Khulekani','Male'),

-- =========================
-- Female
-- =========================

('Nomsa','Female'),
('Nomfundo','Female'),
('Nosipho','Female'),
('Lindiwe','Female'),
('Thandi','Female'),
('Nokuthula','Female'),
('Zanele','Female'),
('Buhle','Female'),
('Hlengiwe','Female'),
('Ayanda','Female'),
('Ntombi','Female'),
('Nompumelelo','Female'),
('Amanda','Female'),
('Precious','Female'),
('Faith','Female'),
('Hope','Female'),
('Grace','Female'),
('Mercy','Female'),
('Joy','Female'),
('Anna','Female'),
('Sarah','Female'),
('Mary','Female'),
('Deborah','Female'),
('Ruth','Female'),
('Rebecca','Female'),
('Rachel','Female'),
('Esther','Female'),
('Lebo','Female'),
('Boitumelo','Female'),
('Naledi','Female'),
('Palesa','Female'),
('Karabo','Female'),
('Keabetswe','Female'),
('Tebogo','Female'),
('Nandi','Female'),
('Phindile','Female'),
('Sindisiwe','Female'),
('Busisiwe','Female'),
('Nonhlanhla','Female'),
('Ntandoyenkosi','Female'),
('Samukelisiwe','Female'),
('Mbali','Female'),
('Anele','Female'),
('Zinhle','Female'),
('Khanyisile','Female'),
('Nosizwe','Female'),
('Lerato','Female'),
('Puleng','Female'),
('Refilwe','Female'),
('Mmatlou','Female');

-- ============================================================================
-- Verification
-- ============================================================================

SELECT
    COUNT(*) AS total_first_names
FROM generator_first_names;

COMMIT;