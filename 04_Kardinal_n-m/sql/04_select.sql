-- 04. SELECTS
USE mydb;
-- EInzeltabelle 
SELECT * FROM cats;
SELECT * FROM servants;
SELECT * FROM products;
SELECT * FROM purchases; 
/*
-- Inner Join 1/ Kombi (servants / products / purchases)
SELECT 
	*
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
;

-- Welchen Artikel hat Jan gekauft?
SELECT 
	product_name AS "Von Jan gekaufte Artikel"
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
WHERE servants_id = 2
;

-- Welche Artikel hat Jan gekauft?
SELECT
	#servant_name AS "Diener"
    #servant_name AS Diener -- Variante 1
    #servant_name  Diener -- Variante 2
    #product_name AS "Von Dieter gekaufte Artikel"
    concat(servant_name, " kauft ", product_name, ".") AS "Kaufhandlung"
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
#WHERE servant_name = "Dieter"
WHERE servant_name = "Peter"
#WHERE servants_id = 2
;

-- Variante Christine
SELECT
concat	(
		servant_name, 
        " hat ", 
		count(product_name), 
		" Produkte gekauft und insgesamt EURO ", 
		sum(product_price), " ausgegeben." 
		) AS Produktzahl
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
WHERE servant_name = "Dieter"
;

-- Wie viel Produkte hat Dieter gekauft?
-- Wie viel Geld hat Dieter ausgegeben? 
SELECT 
	COUNT(product_name) AS "Dieter hat soviel Produkte gekauft",
	SUM(product_price) AS "Dieter hat soviel Geld ausgegeben"
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
WHERE servants_id = 2
;

-- Wer hat das Produkt X gekauft? 
-- Irgendwas mit lachs / Irgendwas mir sauce like
SELECT 
	servant_name AS "Diener",
    product_name AS "Produkt mit jeweiligem Inhalt"
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
WHERE product_name LIKE "%Sauce%" OR product_name LIKE "%Lachs%"
;

-- Wie oft wurde das Produkt X gekauft?
SELECT 
	product_name AS Produkt,
    count(product_name) AS "Wie häufig wurde das Produkt gekauft"
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
GROUP BY product_name
;

-- Welche Umsätze hat das Produkt X?
SELECT 
	product_name AS Produkt,
    count(product_name) AS "Wie häufig wurde das Produkt gekauft",
    sum(product_price) AS " Umsätze des Produktes"
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
GROUP BY product_name
ORDER BY  sum(product_price) DESC
;

-- Lösung A: Berechnung in gleicher Tabelle 
SELECT 
	product_name AS Produkt,
    product_price As Preis,
    count(product_name) AS Anzhal,
    count(product_price) * product_price AS Umsatz
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
GROUP BY Produkt,Preis
ORDER BY Umsatz  DESC
;

-- Lösung B: Berechnung mit tmp-Tabelle
DROP TABLE IF EXISTS tmp;
CREATE TABLE tmp
(
	product_name VARCHAR (45) NOT NULL,
    product_price DECIMAL(4,2) NOT NULL,
    anzahl INT NOT NULL
);

-- tmp: Struktur
DESCRIBE tmp;

-- Daten aus SELECT in Tabelle tmp
INSERT INTO tmp
SELECT 
	product_name AS Produkt,
    product_price As Preis,
    count(product_name) AS Anzhal
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
GROUP BY product_name,product_price
;

-- tmp: Inhalte
SELECT * FROM tmp;

-- Berechnung Umsätze 
SELECT
	product_name AS Produkt,
    product_price AS Preis,
	Anzahl,
    Anzahl * product_price AS Umsatz
FROM tmp
ORDER BY Umsatz DESC;
*/
-- Wer bekommt den Lachs?
-- Ansatz: Produkt --> Diener : cats_id --> cat: Name 
/**/
SELECT 
    CONCAT(servant_name, " ist der Diener von ", cat_name," er Kauft, ",product_name, " somit bekommt ",cat_name "den Lachs") AS "Wer bekommt den Lachs?"
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
INNER JOIN cats ON cats.id = servants.cats_id
WHERE product_name LIKE "%Lachs%"
;

/*
SELECT 
    servant_name AS "DIENER",
    product_name AS "PRODUKT",
    cat_name AS "HERRSCHER"
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
INNER JOIN cats ON cats.id = servants.cats_id
WHERE product_name LIKE "%Lachs%";
*/

