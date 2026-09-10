BEGIN;

-- ============================================================
-- 1. Five historical returned loans
-- ============================================================

WITH selected_copies AS (
    SELECT id AS book_copy_id,
           ROW_NUMBER() OVER (ORDER BY id) AS rn
    FROM public.book_copies
    WHERE is_active = TRUE
),
selected_members AS (
    SELECT id AS library_member_id,
           ROW_NUMBER() OVER (ORDER BY id) AS rn
    FROM public.library_members
    WHERE is_active = TRUE
      AND status = 'ACTIVE'
      AND membership_type = 'LEARNER'
)
INSERT INTO public.library_loans (
    public_id, school_id, book_copy_id, library_member_id,
    loan_date, due_date, returned_date, status, renewal_count,
    issued_by, returned_to, notes
)
SELECT
    gen_random_uuid(),
    1,
    c.book_copy_id,
    m.library_member_id,
    DATE '2026-06-01',
    DATE '2026-06-15',
    DATE '2026-06-10',
    'RETURNED',
    0,
    1,
    1,
    'Initial returned library loan'
FROM selected_copies c
JOIN selected_members m ON m.rn = c.rn
WHERE c.rn <= 5
  AND NOT EXISTS (
      SELECT 1
      FROM public.library_loans ll
      WHERE ll.book_copy_id = c.book_copy_id
  );

-- ============================================================
-- 2. Five overdue loans
-- ============================================================

WITH selected_copies AS (
    SELECT id AS book_copy_id,
           ROW_NUMBER() OVER (ORDER BY id) AS rn
    FROM public.book_copies bc
    WHERE is_active = TRUE
      AND NOT EXISTS (
          SELECT 1
          FROM public.library_loans ll
          WHERE ll.book_copy_id = bc.id
      )
),
selected_members AS (
    SELECT id AS library_member_id,
           ROW_NUMBER() OVER (ORDER BY id) AS rn
    FROM public.library_members
    WHERE is_active = TRUE
      AND status = 'ACTIVE'
      AND membership_type = 'LEARNER'
      AND id NOT IN (
          SELECT library_member_id
          FROM public.library_loans
      )
)
INSERT INTO public.library_loans (
    public_id, school_id, book_copy_id, library_member_id,
    loan_date, due_date, returned_date, status, renewal_count,
    issued_by, returned_to, notes
)
SELECT
    gen_random_uuid(),
    1,
    c.book_copy_id,
    m.library_member_id,
    DATE '2026-08-10',
    DATE '2026-08-24',
    NULL,
    'OVERDUE',
    0,
    1,
    NULL,
    'Initial overdue library loan'
FROM selected_copies c
JOIN selected_members m ON m.rn = c.rn
WHERE c.rn <= 5;

-- ============================================================
-- 3. Five currently borrowed loans
-- ============================================================

WITH selected_copies AS (
    SELECT id AS book_copy_id,
           ROW_NUMBER() OVER (ORDER BY id) AS rn
    FROM public.book_copies bc
    WHERE is_active = TRUE
      AND NOT EXISTS (
          SELECT 1
          FROM public.library_loans ll
          WHERE ll.book_copy_id = bc.id
      )
),
selected_members AS (
    SELECT id AS library_member_id,
           ROW_NUMBER() OVER (ORDER BY id) AS rn
    FROM public.library_members
    WHERE is_active = TRUE
      AND status = 'ACTIVE'
      AND membership_type = 'LEARNER'
      AND id NOT IN (
          SELECT library_member_id
          FROM public.library_loans
      )
)
INSERT INTO public.library_loans (
    public_id, school_id, book_copy_id, library_member_id,
    loan_date, due_date, returned_date, status, renewal_count,
    issued_by, returned_to, notes
)
SELECT
    gen_random_uuid(),
    1,
    c.book_copy_id,
    m.library_member_id,
    DATE '2026-09-01',
    DATE '2026-09-15',
    NULL,
    'BORROWED',
    0,
    1,
    NULL,
    'Initial active library loan'
FROM selected_copies c
JOIN selected_members m ON m.rn = c.rn
WHERE c.rn <= 5;

-- ============================================================
-- 4. Synchronise physical copy statuses
-- ============================================================

UPDATE public.book_copies bc
SET
    status = CASE
        WHEN ll.status = 'RETURNED' THEN 'AVAILABLE'
        WHEN ll.status IN ('BORROWED', 'OVERDUE') THEN 'ON_LOAN'
        WHEN ll.status = 'LOST' THEN 'LOST'
        ELSE bc.status
    END,
    updated_at = NOW()
FROM public.library_loans ll
WHERE ll.book_copy_id = bc.id
  AND ll.is_active = TRUE;

COMMIT;
