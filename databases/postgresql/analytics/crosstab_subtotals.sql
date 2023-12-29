\timing

SELECT
    d.molecule_type,
    COUNT(molregno) FILTER(WHERE max_phase = 0) AS phase_0,
    COUNT(molregno) FILTER(WHERE max_phase = 1) AS phase_1,
    COUNT(molregno) FILTER(WHERE max_phase = 2) AS phase_2,
    COUNT(molregno) FILTER(WHERE max_phase = 3) AS phase_3,
    COUNT(molregno) FILTER(WHERE max_phase = 4) AS phase_4,
    COUNT(molregno)                             AS row_totals
FROM
    chembl_29.molecule_dictionary AS d
WHERE
    d.molecule_type IS NOT NULL
GROUP BY
    ROLLUP(d.molecule_type)
;

WITH crosstab AS (
    SELECT
        d.molecule_type,
        COUNT(molregno) FILTER(WHERE max_phase = 0) AS phase_0,
        COUNT(molregno) FILTER(WHERE max_phase = 1) AS phase_1,
        COUNT(molregno) FILTER(WHERE max_phase = 2) AS phase_2,
        COUNT(molregno) FILTER(WHERE max_phase = 3) AS phase_3,
        COUNT(molregno) FILTER(WHERE max_phase = 4) AS phase_4,
        COUNT(molregno)                             AS row_totals
    FROM
        chembl_29.molecule_dictionary AS d
    WHERE
        d.molecule_type IS NOT NULL
    GROUP BY
        d.molecule_type
    ORDER BY
        d.molecule_type
), column_totals AS (
    SELECT
        'total' AS molecule_type,
        SUM(c.phase_0)    AS phase_0,
        SUM(c.phase_1)    AS phase_1,
        SUM(c.phase_2)    AS phase_2,
        SUM(c.phase_3)    AS phase_3,
        SUM(c.phase_4)    AS phase_4,
        SUM(c.row_totals) AS row_totals
    FROM
        crosstab AS c
)
SELECT
    *
FROM
    crosstab

UNION ALL

SELECT
    *
FROM
    column_totals
