
ALTER TABLE
    marketing.rental
CLUSTER ON "rental_date_key"
;

ANALYZE marketing.rental
;

SELECT
    attname,
    correlation
FROM
    pg_stats
WHERE
    schemaname = 'marketing'
    AND tablename = 'rental'
    AND attname = 'rental_date'
;
