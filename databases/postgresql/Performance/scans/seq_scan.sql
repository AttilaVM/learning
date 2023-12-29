EXPLAIN (ANALYZE, BUFFERS)
SELECT
    length,
    release_year
FROM
    marketing.film
;

EXPLAIN (ANALYZE, BUFFERS)
SELECT
    title
FROM
    marketing.rental
WHERE
    city = 'Woodridge'
