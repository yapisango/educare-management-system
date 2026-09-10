BEGIN;

INSERT INTO public.library_members (
    public_id,
    user_id,
    school_id,
    learner_id,
    employee_id,
    guardian_id,
    membership_number,
    membership_type,
    membership_date,
    expiry_date,
    max_books,
    status,
    notes
)
SELECT
    gen_random_uuid(),
    l.user_id,
    l.school_id,
    l.id,
    NULL,
    NULL,
    'LIB-LRN-' || LPAD(l.id::text, 4, '0'),
    'LEARNER',
    DATE '2026-01-15',
    DATE '2026-12-10',
    3,
    'ACTIVE',
    'Initial learner library membership'
FROM public.learners l
WHERE l.is_active = TRUE
  AND NOT EXISTS (
      SELECT 1
      FROM public.library_members lm
      WHERE lm.user_id = l.user_id
        AND lm.school_id = l.school_id
  );

INSERT INTO public.library_members (
    public_id,
    user_id,
    school_id,
    learner_id,
    employee_id,
    guardian_id,
    membership_number,
    membership_type,
    membership_date,
    expiry_date,
    max_books,
    status,
    notes
)
SELECT
    gen_random_uuid(),
    e.user_id,
    e.school_id,
    NULL,
    e.id,
    NULL,
    'LIB-EMP-' || LPAD(e.id::text, 4, '0'),
    'EMPLOYEE',
    DATE '2026-01-15',
    DATE '2026-12-10',
    5,
    'ACTIVE',
    'Initial employee library membership'
FROM public.employees e
WHERE e.is_active = TRUE
  AND NOT EXISTS (
      SELECT 1
      FROM public.library_members lm
      WHERE lm.user_id = e.user_id
        AND lm.school_id = e.school_id
  );

INSERT INTO public.library_members (
    public_id,
    user_id,
    school_id,
    learner_id,
    employee_id,
    guardian_id,
    membership_number,
    membership_type,
    membership_date,
    expiry_date,
    max_books,
    status,
    notes
)
SELECT
    gen_random_uuid(),
    g.user_id,
    1,
    NULL,
    NULL,
    g.id,
    'LIB-GUA-' || LPAD(g.id::text, 4, '0'),
    'GUARDIAN',
    DATE '2026-01-15',
    DATE '2026-12-10',
    3,
    'ACTIVE',
    'Initial guardian library membership'
FROM public.guardians g
WHERE g.is_active = TRUE
  AND NOT EXISTS (
      SELECT 1
      FROM public.library_members lm
      WHERE lm.user_id = g.user_id
        AND lm.school_id = 1
  );

COMMIT;

