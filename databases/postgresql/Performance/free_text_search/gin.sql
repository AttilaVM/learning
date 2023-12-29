
DO $$
DECLARE
text_par TEXT;
lexemes_par TSVECTOR;
BEGIN

    CREATE TEMP TABLE temp_docs (
        doc_id INT,
        doc TEXT,
        lexemes TSVECTOR
    );

    text_par := '
A nagy erény nem jótékonykodik,
ezért jó.
A kis erény jótékonykodik,
ezért nem jó.
A nagy erény cselekszik,
nem-cselekvéssel cselekszik.
A kis erény sürög,
erővel cselekszik.
A szeretet cselekszik,
eredményes, ha nem cselekszik.
Az erkölcs sürög,
erővel cselekszik.
A tisztelet cselekszik,
s mert nem viszonozzák,
kényszerít a tiszteletre.';

    lexemes_par := TO_TSVECTOR(text_par);

    INSERT INTO
        temp_docs
    VALUES (
        1,
        text_par,
        lexemes_par
    )
;

END;
$$ LANGUAGE plpgsql;

SELECT
    *
FROM
    temp_docs
;

SELECT
    doc_id,
    (unnest(lexemes)).lexeme,
    (unnest(lexemes)).positions
FROM
    temp_docs
;

SELECT
    ARRAY[doc_id, unnest((unnest(lexemes)).positions)],
    (unnest(lexemes)).lexeme
FROM
    temp_docs
LIMIT 10
;

