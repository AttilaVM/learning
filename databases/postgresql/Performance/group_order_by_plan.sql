EXPLAIN
SELECT
    DATE_TRUNC('day', rental_date) AS day,
    COUNT(rental_id) AS rent_count
FROM
    marketing.rental AS r
    INNER JOIN marketing.film AS f
        ON r.film_id = f.film_id
    INNER JOIN marketing.customer AS c
        ON c.customer_id = r.customer_id
WHERE
    rental_date < '2006-01-01'::TIMESTAMP
    AND f.rating = 'NC-17'
    AND c.active = 1
GROUP BY
    day
ORDER BY
    day
