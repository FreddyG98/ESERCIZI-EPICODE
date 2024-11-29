USE `AdventureWorksDW`;

-- 1.Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria. Quali considerazioni/ragionamenti è necessario che tu faccia?

SELECT 
	COUNT(*) -- OPPURE COUNT(`ProductKey`)
FROM
	`dimproduct`
;

SELECT DISTINCT
	COUNT(`ProductKey`)
FROM
	`dimproduct`
;

-- OPPURE
SELECT 
	COUNT(*) Record_totali
    , COUNT(DISTINCT p.`ProductKey`) valori_univoci
FROM
	`dimproduct` p
;

-- 2.Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK.

SELECT
	CONCAT(`SalesOrderNumber`, "-", `SalesOrderLineNumber`) PK_Combinata
FROM
	`factresellersales`
;

SELECT
	COUNT(
		CONCAT(`SalesOrderNumber`, "-", `SalesOrderLineNumber`)) PK_Combinata
FROM
	`factresellersales`
;

SELECT DISTINCT
	COUNT(
		CONCAT(`SalesOrderNumber`, "-", `SalesOrderLineNumber`)) PK_Combinata
FROM
	`factresellersales`
;

DESCRIBE `factresellersales`;

-- OPPURE

SELECT
	COUNT(*) Righe_Tot  -- COUNT(`SalesOrderNumber`, `SalesOrderLineNumber`)
    , COUNT(DISTINCT `SalesOrderNumber`, `SalesOrderLineNumber`) PK   -- CON O SENZA DISTINCT
FROM
	`factresellersales`
;

-- 3.Conta il numero transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020.

SELECT
	`OrderDate` "Data"
	, COUNT(`SalesOrderLineNumber`) Transazioni
FROM
	`factresellersales`
WHERE
	`OrderDate` > '2019-12-31'
GROUP BY
	`OrderDate`
;

/* 4.Calcola il fatturato totale (FactResellerSales.SalesAmount), la quantità totale venduta (FactResellerSales.OrderQuantity) 
e il prezzo medio di vendita (FactResellerSales.UnitPrice) per prodotto (DimProduct) a partire dal 1 Gennaio 2020. 
Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e il prezzo medio di vendita. 
I campi in output devono essere parlanti! */

SELECT
	p.`EnglishProductName` Prodotto
   -- , `OrderDate` "Data"
	, SUM(`SalesAmount`) Fatturato_TOT
    , SUM(`OrderQuantity`) Quantita_TOT_venduta
    , AVG(`UnitPrice`) Prezzo_medio
FROM
	`factresellersales` r
LEFT JOIN
	`dimproduct` p
ON
	r.`ProductKey` = p.`ProductKey`
WHERE
	`OrderDate` > '2019-12-31'
GROUP BY
	p.`ProductKey`
;

-- CON E SENZA JOIN I RISULTATI SONO GLI STESSI: SIGNIFICA O CHE HO SBAGLIATO OPPURE NON CI SONO PRODOTTO INVENDUTI

SELECT
	`ProductKey` Prodotto
    , `OrderDate`
	, SUM(`SalesAmount`) Fatturato_TOT
    , SUM(`OrderQuantity`) Quantita_TOT_venduta
    , AVG(`UnitPrice`) Prezzo_medio
FROM
	`factresellersales` r
WHERE
	`OrderDate` > '2019-12-31'
GROUP BY
	`ProductKey`
;

-- I PRODOTTI DI DIMPRODUCT NON CORRISPONDONO AD ESEMPIO MANCANO QUELLI DAL 600 IN SU IN TEORICA PERCHE NON SONO STATI VENDUTI, MA CON LA JOIN NE DOVREBBE AVER TENUTO CONTO

SELECT
	`ProductKey`
FROM
	`dimproduct`
;

/* 5.Calcola il fatturato totale (FactResellerSales.SalesAmount) e la quantità totale venduta (FactResellerSales.OrderQuantity) per Categoria prodotto (DimProductCategory). 
Il result set deve esporre pertanto il nome della categoria prodotto, il fatturato totale e la quantità totale venduta. I campi in output devono essere parlanti! */

SELECT
	`EnglishProductCategoryName` Categoria
	, SUM(`SalesAmount`) Fatturato_TOT
    , SUM(`OrderQuantity`) Quantita_TOT_venduta
FROM
	`factresellersales` r
LEFT JOIN
	`dimproduct` p
ON
	r.`ProductKey` = p.`ProductKey`
LEFT JOIN
	`dimproductsubcategory` s
ON
	p.`ProductSubcategoryKey` = s.`ProductSubcategoryKey`
LEFT JOIN
	`dimproductcategory` c
ON
	s.`ProductCategoryKey` = c.`ProductCategoryKey`
GROUP BY
	c.`ProductCategoryKey`
;

-- VERIFICA

SELECT DISTINCT
	`EnglishProductCategoryName`
FROM
	`dimproductcategory`
;

/* 6.Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020. 
Il result set deve esporre l’elenco delle città con fatturato realizzato superiore a 60K. */

-- PIU JOIN
SELECT
	`City` Citta
	, SUM(`SalesAmount`) Fatturato_TOT
FROM
	`factresellersales` r
LEFT JOIN
	`dimreseller` dr
ON
	r.`ResellerKey` = dr.`ResellerKey`
LEFT JOIN
	`dimgeography` g
ON
	dr.`GeographyKey` = g.`GeographyKey`
WHERE
	`OrderDate` > '2019-12-31'
GROUP BY
	`City`
HAVING 
	Fatturato_TOT > 60000
ORDER BY
	Citta
;

DESCRIBE `dimgeography`;

