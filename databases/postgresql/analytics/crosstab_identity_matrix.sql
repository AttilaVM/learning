\timing

CREATE TEMP TABLE phase_identity (
    -- row names
    phase SMALLINT,
    -- matrix
    phase_0 SMALLINT,
    phase_1 SMALLINT,
    phase_2 SMALLINT,
    phase_3 SMALLINT,
    phase_4 SMALLINT
);


INSERT INTO
    phase_identity
VALUES
    (0, 1, 0, 0, 0, 0),
    (1, 0, 1, 0, 0, 0),
    (2, 0, 0, 1, 0, 0),
    (3, 0, 0, 0, 1, 0),
    (4, 0, 0, 0, 0, 1);

SELECT
    d.molecule_type,
    SUM(1 * i.phase_0) AS phase_0,
    SUM(1 * i.phase_1) AS phase_1,
    SUM(1 * i.phase_2) AS phase_2,
    SUM(1 * i.phase_3) AS phase_3,
    SUM(1 * i.phase_3) AS phase_4
FROM
    phase_identity AS i
    INNER JOIN chembl_29.molecule_dictionary AS d
        ON d.max_phase = i.phase
        AND d.molecule_type IS NOT NULL
GROUP by
    d.molecule_type
ORDER BY
    d.molecule_type
;

