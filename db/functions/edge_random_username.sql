-- ============================================================================
-- EDGE Function
-- edge_random_username()
-- ----------------------------------------------------------------------------
-- Generates a unique username.
-- Example:
-- john.smith001
-- mary.jones127
-- ============================================================================
CREATE OR REPLACE FUNCTION edge_random_username
(
    p_first_name TEXT,
    p_last_name TEXT,
    p_sequence INTEGER
)
RETURNS TEXT
LANGUAGE plpgsql
AS
$$
BEGIN

    RETURN
        LOWER(
            regexp_replace(p_first_name,'[^A-Za-z]','','g')
        )
        || '.'
        ||
        LOWER(
            regexp_replace(p_last_name,'[^A-Za-z]','','g')
        )
        ||
        LPAD(p_sequence::TEXT,3,'0');

END;
$$;

