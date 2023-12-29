\timing

-- Most simple
-- ANSI SQL, but only supported in PostgreSQL and SQLite
-- Second most efficinet affter CROSSTAB (tablefunc extension)
-- Persumably the most memory efficinet
SELECT
    d.molecule_type,
    COUNT(molregno) FILTER(WHERE max_phase = 0) AS phase_0,
    COUNT(molregno) FILTER(WHERE max_phase = 1) AS phase_1,
    COUNT(molregno) FILTER(WHERE max_phase = 2) AS phase_2,
    COUNT(molregno) FILTER(WHERE max_phase = 3) AS phase_3,
    COUNT(molregno) FILTER(WHERE max_phase = 4) AS phase_4
FROM
    chembl_29.molecule_dictionary AS d
WHERE
    d.molecule_type IS NOT NULL
GROUP by
    d.molecule_type
ORDER BY
    d.molecule_type
;

-- Still easy
-- ANSI SQL and works everywhere
-- third in efficincy CASE WHEN in SELECT is generally discoureaged.
-- Persumably near in memory efficincy to filtering
SELECT
    d.molecule_type,
    SUM(CASE WHEN max_phase = 0 THEN 1 ELSE 0 END) AS phase_0,
    SUM(CASE WHEN max_phase = 1 THEN 1 ELSE 0 END) AS phase_1,
    SUM(CASE WHEN max_phase = 2 THEN 1 ELSE 0 END) AS phase_2,
    SUM(CASE WHEN max_phase = 3 THEN 1 ELSE 0 END) AS phase_3,
    SUM(CASE WHEN max_phase = 4 THEN 1 ELSE 0 END) AS phase_4
FROM
    chembl_29.molecule_dictionary AS d
WHERE
    d.molecule_type IS NOT NULL
GROUP by
    d.molecule_type
ORDER BY
    d.molecule_type
;
