\timing

-- The result set of a subquery equivalend to this executed by crosstab
-- is transformed to a crosstab.
SELECT
    max_phase::VARCHAR,
    molecule_type,
    COUNT(*)
FROM
    chembl_29.molecule_dictionary
WHERE
    molecule_type IS NOT NULL
GROUP BY
    molecule_type,
    max_phase
ORDER BY
    1,2
;

-- More convulated than filtering and CASE-based alternatives
-- PostgreSQL extension
-- Has the best efficincy
-- Persumably not as memory efficinet than filtering and CAS-based alternatives
-- Must be protected from SQLinjection
SELECT
    *
FROM
    CROSSTAB($$
        SELECT
            molecule_type,
            max_phase::VARCHAR,
            COUNT(*)
        FROM
            chembl_29.molecule_dictionary
        WHERE
            molecule_type IS NOT NULL
        GROUP BY
            molecule_type,
            max_phase
        ORDER BY
            1,2;
        $$
    ) AS t(max_phase VARCHAR, "0" bigint, "1" bigint, "2" bigint, "3" bigint, "4" bigint)
;
