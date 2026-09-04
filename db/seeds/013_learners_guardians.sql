BEGIN;

-- ============================================================
-- 013_learners_guardians.sql
-- Seed learner and guardian domain records
-- ============================================================

-- ------------------------------------------------------------
-- Learners
-- ------------------------------------------------------------
-- 800 learner users exist.
-- Classes have capacity 30, so the first 600 learners are
-- distributed across the 20 classes (30 per class).
-- The remaining 200 learners remain unassigned.
INSERT INTO public.learners (
    user_id,
    school_id,
    class_id,
    learner_number,
    admission_date,
    previous_school,
    emergency_contact_name,
    emergency_contact_phone
)
SELECT
    u.id,
    1 AS school_id,
    CASE
        WHEN ROW_NUMBER() OVER (ORDER BY u.id) <= 600
        THEN ((ROW_NUMBER() OVER (ORDER BY u.id) - 1) / 30) + 1
        ELSE NULL
    END AS class_id,
    'LRN-' || LPAD(ROW_NUMBER() OVER (ORDER BY u.id)::text, 4, '0'),
    DATE '2026-01-15' AS admission_date,
    CASE
        WHEN ROW_NUMBER() OVER (ORDER BY u.id) % 4 = 0
        THEN 'Previous School'
        ELSE NULL
    END AS previous_school,
    'Emergency Contact ' || ROW_NUMBER() OVER (ORDER BY u.id),
    '+27 71 ' || LPAD((ROW_NUMBER() OVER (ORDER BY u.id) % 10000000)::text, 7, '0')
FROM public.users u
WHERE u.role = 'LEARNER'
  AND u.is_active = TRUE
ORDER BY u.id;

-- ------------------------------------------------------------
-- Guardians
-- ------------------------------------------------------------
INSERT INTO public.guardians (
    user_id,
    occupation,
    employer,
    work_phone,
    relationship_to_learner,
    preferred_contact_method
)
SELECT
    u.id,
    CASE
        WHEN ROW_NUMBER() OVER (ORDER BY u.id) % 4 = 0 THEN 'Teacher'
        WHEN ROW_NUMBER() OVER (ORDER BY u.id) % 4 = 1 THEN 'Business Owner'
        WHEN ROW_NUMBER() OVER (ORDER BY u.id) % 4 = 2 THEN 'Administrator'
        ELSE 'Healthcare Worker'
    END AS occupation,
    CASE
        WHEN ROW_NUMBER() OVER (ORDER BY u.id) % 3 = 0
        THEN 'Local Business'
        WHEN ROW_NUMBER() OVER (ORDER BY u.id) % 3 = 1
        THEN 'Private Company'
        ELSE 'Public Sector'
    END AS employer,
    '+27 11 ' || LPAD((ROW_NUMBER() OVER (ORDER BY u.id) % 1000000)::text, 6, '0'),
    CASE
        WHEN ROW_NUMBER() OVER (ORDER BY u.id) % 3 = 0 THEN 'Mother'
        WHEN ROW_NUMBER() OVER (ORDER BY u.id) % 3 = 1 THEN 'Father'
        ELSE 'Guardian'
    END AS relationship_to_learner,
    CASE
        WHEN ROW_NUMBER() OVER (ORDER BY u.id) % 2 = 0 THEN 'EMAIL'
        ELSE 'PHONE'
    END AS preferred_contact_method
FROM public.users u
WHERE u.role = 'GUARDIAN'
  AND u.is_active = TRUE
ORDER BY u.id;

COMMIT;
