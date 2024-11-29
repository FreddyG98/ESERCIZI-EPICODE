USE `adventureworks`;

/* ESERCIZIO 1: Implementa una vista denominata Product al fine di creare unʼanagrafica (dimensione) prodotto completa. 
La vista, se interrogata o utilizzata come sorgente dati, deve esporre: 
il nome prodotto, il nome della sottocategoria associata e il nome della categoria associata. */

CREATE OR REPLACE VIEW Product 
AS (
	SELECT
		`ProductKey`
        , `EnglishProductName` Prodotto
        , IFNULL(`EnglishProductSubcategoryName`, "NON IN CATALOGO") SottoCategoria
        , IFNULL(`EnglishProductCategoryName`, "NON IN CATALOGO") Categoria
	FROM
		`dimproduct` p
	LEFT JOIN
		`dimproductsubcategory` s
	ON
		p.`ProductSubcategoryKey` = s.`ProductSubcategoryKey`
	LEFT JOIN 
		`dimproductcategory` c
	ON
		s.`ProductCategoryKey` = c.`ProductCategoryKey`
	);

/* ESERCIZIO 2: Implementa una vista denominata Reseller al fine di creare unʼanagrafica (dimensione) reseller completa. 
La vista, se interrogata o utilizzata come sorgente dati, deve esporre: il nome del reseller, il nome della città e il nome della regione. */

CREATE OR REPLACE VIEW Reseller 
AS (
	SELECT
		`ResellerKey`
		, `ResellerName` Rivenditore
        , `City` Citta
        , `EnglishCountryRegionName` Regione
	FROM
		`dimreseller` r
	INNER JOIN
		`dimgeography` g
	ON
		r.`GeographyKey` = g.`GeographyKey`
	);

/* ESERCIZIO 3: Crea una vista denominata Sales che deve restituire: 
la data dellʼordine, il codice documento, la riga di corpo del documento, la quantità venduta, lʼimporto totale e il profitto. */

CREATE OR REPLACE VIEW Sales
AS (
	SELECT
		p.`ProductKey`
        , `ResellerKey`
		, `OrderDate` DataOrdine
        , `SalesOrderNumber` Documento
        , `SalesOrderLineNumber` RigheCorpoDocumento
        , `OrderQuantity` QuantitaVenduta
        , `SalesAmount` Ricavi
        , IFNULL(`TotalProductCost`, `StandardCost` * `OrderQuantity`) AS CostoTotaleProduzione
        , `SalesAmount` - IFNULL(`TotalProductCost`, `StandardCost` * `OrderQuantity`) AS Profitto
	FROM
		`factresellersales` r 
	LEFT JOIN
		`dimproduct` p
	ON
		r.`ProductKey` = p.`ProductKey`
	);

-- VERIFICHE:

-- PER PRODUCT:
SELECT
	*
FROM
	`product`
;

-- PER RESELLER:
SELECT
	*
FROM
	`reseller`
;

-- PER SALES:
SELECT
	*
FROM
	`sales`
;

-- PERDITE DI BIKES:
SELECT
	Categoria
    , SUM(Profitto)
FROM
	`sales` s
INNER JOIN 
	`product` p
ON
	s.`ProductKey` = p.`ProductKey`
GROUP BY 
	Categoria
;

-- MOSTRA LA STRUTTURA DELLA TABELLA:
SHOW CREATE TABLE `dimproduct`;

/* ESERCIZIO 4: Crea un report in Excel che consenta ad un utente di analizzare quantità venduta, 
importo totale e profitti per prodotto/categoria prodotto e reseller/regione. */