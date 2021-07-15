-- SELECTS

-- Einzeltabellen
SELECT * FROM mydb.cats;
SELECT * FROM mydb.servants;

-- Kreuzprodukt (Kartesisches Produkt)
SELECT * FROM mydb.cats JOIN mydb.servants;

-- Inner Join 1 / Gesamte Tabelle
SELECT
	*
FROM mydb.cats INNER JOIN mydb.servants
ON cats.id = servants.cats_id
;

-- Inner Join 2 / (Wer dient wem?)
-- Wer dient Grizabella
-- Wem dient Juniad?
SELECT
	cat_name AS Katze,
    servant_name AS Diener
FROM mydb.cats INNER JOIN mydb.servants
ON cats.id = servants.cats_id
#WHERE cat_name = "Grizabella"
WHERE servant_name = "Juniad"
;

-- Inner Join 2a / (Wer dient wem?)
-- "X ist der Diener von Y"
SELECT
	concat(servant_name, " ist der Diener von ", cat_name,".") AS Dienstverhältnis
FROM mydb.cats INNER JOIN mydb.servants
ON cats.id = servants.cats_id
#WHERE cat_name = "Grizabella"
#WHERE servant_name = "Juniad"
WHERE servant_name = "Holger"
;

-- Inner Join 3 / Dienstzeit
SELECT
	servant_name AS Diener,
    yrs_served AS Dienstzeit
FROM mydb.cats INNER JOIN mydb.servants
ON cats.id = servants.cats_id
ORDER BY yrs_served DESC
;

-- Inner Join 4 / Dienstzeit 
-- "X - der diener von Y- ist der Diener mit der Längsten Dienstzeit" // MAX()
SELECT
	servant_name AS Diener,
    yrs_served AS Dienstzeit,
    CONCAT(servant_name, " der diener von ", cat_name," ist der Diener mit der Längsten Dienstzeit.") AS "Dienstzeit Veteran",
    MAX(yrs_served) AS"Dienstzeit in Jahren"
FROM mydb.cats INNER JOIN mydb.servants
ON cats.id = servants.cats_id
;

SELECT
  MAX(yrs_served) AS "Dienstzeit in Jahren",
  CONCAT(servant_name, " der Diener von ", cat_name," ist der Diener mit der Längsten Dienstzeit.") AS "Dienstzeit Veteran"
FROM mydb.cats INNER JOIN mydb.servants
ON cats.id = servants.cats_id
;

-- Inner Join 4 / Dienstzeit / SUBQUERY
-- "X - der diener von Y- ist der Diener mit der Längsten Dienstzeit" // MAX()
--  SUBQERY 
CREATE VIEW max_time as

SELECT
  MAX(yrs_served) AS Dienstzeit
FROM mydb.cats INNER JOIN mydb.servants
ON cats.id = servants.cats_id
;

SELECT
	CONCAT(servant_name, " der Diener von ", cat_name," ist der Diener mit der Längsten Dienstzeit.") AS Dienstzeit
	FROM mydb.cats INNER JOIN mydb.servants
	ON cats.id = servants.cats_id
WHERE yrs_served = (
						MAX(yrs_served) AS Dienstzeit
						FROM mydb.cats INNER JOIN mydb.servants
						ON cats.id = servants.cats_id
					)
;

SELECT
  CONCAT(servant_name, " der Diener von ", cat_name," ist der Diener mit der Längsten Dienstzeit.") AS Dienstzeit
FROM mydb.cats INNER JOIN mydb.servants
ON cats.id = servants.cats_id
WHERE yrs_served = (max_time)
;


SELECT
CONCAT(servant_name, " der Diener von ", cat_name, ", ist der Diener mit der längsten Dienstzeit.") AS "Ausgabe String"
FROM mydb.cats INNER JOIN mydb.servants
ON cats.id = servants.cats_id
WHERE yrs_served = (SELECT MAX(yrs_served) FROM mydb.servants);