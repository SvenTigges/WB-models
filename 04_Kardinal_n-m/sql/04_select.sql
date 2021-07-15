-- 04. SELECTS
USE mydb;
-- EInzeltabelle 
SELECT * FROM cats;
SELECT * FROM servants;
SELECT * FROM products;
SELECT * FROM purchases; 

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
/*
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
*/
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
