BEGIN;

-- ============================================================
-- 014_guardian_learners.sql
-- Seed primary guardian relationships
-- ============================================================

WITH learner_assignment AS (
    SELECT
        id AS learner_id,
        ROW_NUMBER() OVER (ORDER BY id) AS learner_rn
    FROM public.learners
),
guardian_assignment AS (
    SELECT
        id AS guardian_id,
        ROW_NUMBER() OVER (ORDER BY id) AS guardian_rn
    FROM public.guardians
),
guardian_count AS (
    SELECT COUNT(*) AS total_guardians
    FROM public.guardians
)
INSERT INTO public.guardian_learners (
    guardian_id,
    learner_id,
    relationship,
    is_primary_contact,
    has_legal_custody,
    pickup_authorized,
    financial_responsibility
)
SELECT
    g.guardian_id,
    l.learner_id,
    CASE
        WHEN g.guardian_rn % 3 = 1 THEN 'Mother'
        WHEN g.guardian_rn % 3 = 2 THEN 'Father'
        ELSE 'Guardian'
    END AS relationship,
    TRUE AS is_primary_contact,
    TRUE AS has_legal_custody,
    TRUE AS pickup_authorized,
    TRUE AS financial_responsibility
FROM learner_assignment l
CROSS JOIN guardian_count gc
JOIN guardian_assignment g
    ON g.guardian_rn =
       ((l.learner_rn - 1) % gc.total_guardians) + 1
ORDER BY l.learner_id;

COMMIT;
