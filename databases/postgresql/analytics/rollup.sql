SELECT
    d.molecule_type,
    d.structure_type,
    COUNT(*)
FROM
    chembl_29.molecule_dictionary AS d
WHERE
    d.molecule_type IS NOT NULL
GROUP BY
    ROLLUP(
        d.molecule_type,
        d.structure_type
    )
;

-- ROLLUP is just a convinience function for 
-- a specific GROUPING SET case.
-- The same with grouping sets:
SELECT
    d.molecule_type,
    d.structure_type,
    COUNT(*)
FROM
    chembl_29.molecule_dictionary AS d
WHERE
    d.molecule_type IS NOT NULL
GROUP BY
    GROUPING SETS(
        (),
        (d.molecule_type),
        (d.molecule_type, d.structure_type)
    )
;
