-- ============================================================================
-- EDGE Function
-- edge_random_birth_date()
-- ----------------------------------------------------------------------------
-- Returns a random birth date based on an age range.
-- ============================================================================

CREATE OR REPLACE FUNCTION edge_random_birth_date
(
    min_age INTEGER,
    max_age INTEGER
)
RETURNS DATE
LANGUAGE plpgsql
AS
$$
DECLARE

    selected_age INTEGER;

    extra_days INTEGER;

BEGIN

    selected_age :=
        FLOOR(
            random() * (max_age - min_age + 1)
        )::INTEGER + min_age;

    extra_days :=
        FLOOR(random() * 365)::INTEGER;

    RETURN
        CURRENT_DATE
        - (selected_age * INTERVAL '1 year')
        - (extra_days * INTERVAL '1 day');

END;
$$;