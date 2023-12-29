\timing

SELECT
    d.max_phase,
    d.structure_type,
    COUNT(*)
FROM
    chembl_29.molecule_dictionary AS d
WHERE
    d.molecule_type IS NOT NULL
GROUP BY
    CUBE(
        d.molecule_type,
        d.structure_type
    )
;

