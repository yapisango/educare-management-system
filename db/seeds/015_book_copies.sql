BEGIN;

INSERT INTO public.book_copies (
    public_id,
    book_id,
    school_id,
    copy_number,
    barcode,
    acquisition_date,
    purchase_price,
    condition,
    status,
    shelf_location,
    notes
)
SELECT
    gen_random_uuid(),
    b.id,
    b.school_id,
    copy_no,
    'BC-' || LPAD(b.id::text, 4, '0') || '-' || copy_no,
    DATE '2026-01-15',
    450.00,
    'NEW',
    'AVAILABLE',
    'Shelf-' || LPAD(b.id::text, 2, '0'),
    'Initial library stock'
FROM public.books b
CROSS JOIN generate_series(1, 3) AS copy_no
WHERE b.is_active = TRUE
  AND NOT EXISTS (
      SELECT 1
      FROM public.book_copies bc
      WHERE bc.book_id = b.id
  )
ORDER BY b.id, copy_no;

COMMIT;
