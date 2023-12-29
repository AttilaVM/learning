EXPLAIN (ANALYZE, BUFFERS)
SELECT
    length,
    release_year
FROM
    marketing.film
WHERE
    title = 'HOLY TADPOLE'
