BEGIN;

-- ============================================================
-- 1. Five overdue library fines
-- ============================================================

INSERT INTO public.library_fines (
    public_id,
    school_id,
    loan_id,
    library_member_id,
    fine_type,
    amount,
    amount_paid,
    issued_date,
    paid_date,
    status,
    description
)
SELECT
    gen_random_uuid(),
    ll.school_id,
    ll.id,
    ll.library_member_id,
    'OVERDUE',
    CASE ll.id
        WHEN 6 THEN 25.00
        WHEN 7 THEN 30.00
        WHEN 8 THEN 20.00
        WHEN 9 THEN 35.00
        WHEN 10 THEN 15.00
    END,
    0.00,
    ll.due_date,
    NULL,
    'OUTSTANDING',
    'Overdue library book fine'
FROM public.library_loans ll
WHERE ll.id BETWEEN 6 AND 10
  AND ll.status = 'OVERDUE'
  AND NOT EXISTS (
      SELECT 1
      FROM public.library_fines lf
      WHERE lf.loan_id = ll.id
        AND lf.fine_type = 'OVERDUE'
  );

COMMIT;
