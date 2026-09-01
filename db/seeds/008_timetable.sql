-- ============================================================
-- EduCare Management System
-- Seed: 008_timetable.sql
-- Purpose: Populate the 400 validated Term 3 timetable entries.
--
-- Design:
--   20 active classes
--   5 teaching days
--   4 lessons per class per day
--   400 entries total
--
-- Safety:
--   * Runs inside a transaction.
--   * Uses the existing timetable/class_subject/teacher/room records.
--   * Checks for an existing entry before inserting.
--   * The timetable_entries unique constraint also protects against
--     duplicate (timetable_id, day_of_week, period_id) entries.
--
-- IMPORTANT:
--   This file is prepared only. Do not execute it as part of this
--   checkpoint until the seed files are being run.
-- ============================================================

BEGIN;

WITH
class_order AS (
    SELECT
        c.id AS class_id,
        ROW_NUMBER() OVER (ORDER BY c.id) AS class_position
    FROM public.classes c
    WHERE c.school_id = 1
      AND c.is_active = TRUE
),

-- Weekly subject rotation:
--   1 = Mathematics
--   2 = English
--   3 = Physical Sciences
--   4 = Life Sciences
--   5 = History
schedule AS (
    SELECT *
    FROM (
        VALUES
            ('MONDAY'::day_of_week,    1, 1),
            ('MONDAY'::day_of_week,    2, 2),
            ('MONDAY'::day_of_week,    3, 3),
            ('MONDAY'::day_of_week,    4, 4),

            ('TUESDAY'::day_of_week,   1, 5),
            ('TUESDAY'::day_of_week,   2, 1),
            ('TUESDAY'::day_of_week,   3, 2),
            ('TUESDAY'::day_of_week,   4, 3),

            ('WEDNESDAY'::day_of_week, 1, 4),
            ('WEDNESDAY'::day_of_week, 2, 5),
            ('WEDNESDAY'::day_of_week, 3, 1),
            ('WEDNESDAY'::day_of_week, 4, 2),

            ('THURSDAY'::day_of_week,  1, 3),
            ('THURSDAY'::day_of_week,  2, 4),
            ('THURSDAY'::day_of_week,  3, 5),
            ('THURSDAY'::day_of_week,  4, 1),

            ('FRIDAY'::day_of_week,    1, 2),
            ('FRIDAY'::day_of_week,    2, 3),
            ('FRIDAY'::day_of_week,    3, 4),
            ('FRIDAY'::day_of_week,    4, 5)
    ) AS x(day_of_week, lesson_number, subject_id)
),

-- Logical lesson 1-4 use the first four periods for classes 1-10.
-- Classes 11-20 use periods 5-8 at the same time.
period_map AS (
    SELECT *
    FROM (
        VALUES
            (1, 7),
            (2, 9),
            (3, 3),
            (4, 10),
            (5, 1),
            (6, 5),
            (7, 4),
            (8, 8)
    ) AS x(lesson_slot, period_id)
),

proposed AS (
    SELECT
        tt.id AS timetable_id,
        s.day_of_week,
        pm.period_id,
        cs.subject_id,
        cs.teacher_id,
        r.id AS room_id
    FROM class_order co

    JOIN public.timetables tt
        ON tt.class_id = co.class_id
       AND tt.school_id = 1
       AND tt.academic_year_id = 1
       AND tt.term_id = 11
       AND tt.is_active = TRUE

    JOIN schedule s
        ON TRUE

    JOIN period_map pm
        ON pm.lesson_slot =
           CASE
               WHEN co.class_position <= 10
               THEN s.lesson_number
               ELSE s.lesson_number + 4
           END

    JOIN public.class_subjects cs
        ON cs.class_id = co.class_id
       AND cs.subject_id = s.subject_id
       AND cs.academic_year_id = 1

    JOIN public.rooms r
        ON r.id = ((co.class_position - 1) % 10) + 1
       AND r.school_id = 1
       AND r.is_active = TRUE
)

INSERT INTO public.timetable_entries (
    public_id,
    timetable_id,
    day_of_week,
    period_id,
    subject_id,
    teacher_id,
    room_id,
    created_at,
    updated_at,
    created_by,
    updated_by,
    is_active
)
SELECT
    gen_random_uuid(),
    p.timetable_id,
    p.day_of_week,
    p.period_id,
    p.subject_id,
    p.teacher_id,
    p.room_id,
    NOW(),
    NOW(),
    1,
    1,
    TRUE
FROM proposed p
WHERE NOT EXISTS (
    SELECT 1
    FROM public.timetable_entries te
    WHERE te.timetable_id = p.timetable_id
      AND te.day_of_week = p.day_of_week
      AND te.period_id = p.period_id
);

COMMIT;

-- ============================================================
-- Post-seed verification queries
-- Run these AFTER executing this seed.
-- ============================================================

-- 1. Total timetable entries for Term 3 / Academic Year 2026
SELECT COUNT(*) AS timetable_entry_count
FROM public.timetable_entries te
JOIN public.timetables tt
  ON tt.id = te.timetable_id
WHERE tt.academic_year_id = 1
  AND tt.term_id = 11
  AND tt.is_active = TRUE
  AND te.is_active = TRUE;

-- Expected: 400


-- 2. Entries per class
SELECT
    tt.class_id,
    c.class_name,
    COUNT(*) AS lesson_count
FROM public.timetable_entries te
JOIN public.timetables tt
  ON tt.id = te.timetable_id
JOIN public.classes c
  ON c.id = tt.class_id
WHERE tt.academic_year_id = 1
  AND tt.term_id = 11
  AND tt.is_active = TRUE
  AND te.is_active = TRUE
GROUP BY tt.class_id, c.class_name
ORDER BY tt.class_id;

-- Expected: 20 rows, each with 20 lessons.


-- 3. Duplicate timetable slots
SELECT
    timetable_id,
    day_of_week,
    period_id,
    COUNT(*) AS duplicate_count
FROM public.timetable_entries
GROUP BY timetable_id, day_of_week, period_id
HAVING COUNT(*) > 1
ORDER BY timetable_id, day_of_week, period_id;

-- Expected: 0 rows.