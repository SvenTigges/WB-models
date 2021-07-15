-- 03. SELECTS

-- Einzeltabellen
SELECT * FROM cats;
SELECT * FROM kittens;

-- Inner Join 1 / Gesamte Kombi-Tabelle
SELECT
	*
FROM cats INNER JOIN kittens
on cats.id = kittens.cats_id
;

-- Inner Join 2 / Verwandschaft
SELECT
	cat_name AS Mutter,
    kitten_name as Kind,
    CONCAT(cat_name, " ist die Mutter von ", kitten_name) AS Verwandschaft
FROM cats INNER JOIN kittens
on cats.id = kittens.cats_id
;

-- Inner Join 3 / Wie viel Kinder haben die Katzen?
SELECT
	cat_name AS Katzer,
    COUNT(cat_name) AS Kinderzahl,
    CONCAT(cat_name, " ist die Mutter von ", kitten_name) AS Verwandschaft
FROM cats INNER JOIN kittens
on cats.id = kittens.cats_id
GROUP BY cat_name # Wichtig bei Kombi Aggr. /Nicht-Aggr.
;