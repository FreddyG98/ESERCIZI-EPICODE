USE AdventureWorksDW;

# 1.Esponi l’anagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria (DimProduct, DimProductSubcategory):
# Con JOIN

SELECT 
	EnglishProductName Nome
	, EnglishProductSubcategoryName Nome_sottocategoria
	, s.ProductSubcategoryKey
FROM
	dimproduct p
LEFT JOIN
	dimproductsubcategory s
ON
	p.ProductSubcategoryKey = s.ProductSubcategoryKey
;

# Con SubQuery

SELECT
	EnglishProductName
	, EnglishProductSubcategoryName;

# 2.Esponi l’anagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria e la sua categoria (DimProduct, DimProductSubcategory, DimProductCategory):
# Con JOIN

SELECT 
	EnglishProductName Nome_prodotto
    , EnglishProductSubcategoryName Nome_sottocategoria
    , EnglishProductCategoryName Nome_categoria
    , s.ProductSubcategoryKey
    , s.ProductCategoryKey
FROM
	dimproduct p
INNER JOIN
	dimproductsubcategory s
ON
	p.ProductSubcategoryKey = s.ProductSubcategoryKey
INNER JOIN
	dimproductcategory c
ON
	c.ProductCategoryKey = s.ProductCategoryKey
;

# Con SubQuery




# 3.Esponi l’elenco dei soli prodotti venduti (DimProduct, FactResellerSales):
# Con JOIN

SELECT DISTINCT
	SalesOrderNumber Ordine
    , OrderDate Data_ordine
    , EnglishProductName Nome
    , OrderQuantity Quantita
    , f.ProductKey
FROM
	dimproduct p
INNER JOIN
	factresellersales f
ON
	p.ProductKey = f.ProductKey
;

# Con SubQuery




# 4.Esponi l’elenco dei prodotti non venduti (considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1):
# Con JOIN

SELECT
	f.`ProductKey`
    , `EnglishProductName` Nome
    , `StandardCost`
FROM
	`dimproduct` p
LEFT JOIN
	factresellersales f
ON 
	p.`ProductKey` = f.`ProductKey`
WHERE
	`FinishedGoodsFlag` = 1
AND 
	f.`ProductKey` IS NULL
;

# Con SubQuery

SELECT
	f.`ProductKey`
    , `EnglishProductName` Nome
    , `StandardCost`
FROM
	`dimproduct` p
WHERE 
	`FinishedGoodsFlag` = 1 
    AND p.`ProductKey` NOT IN
		(SELECT
			SalesOrderNumber Ordine
			, OrderDate Data_ordine
			, EnglishProductName Nome
			, OrderQuantity Quantita
			, f.ProductKey
		FROM
			dimproduct p
		INNER JOIN
			factresellersales f
		ON
			p.ProductKey = f.ProductKey)
;


# 5.Esponi l’elenco delle transazioni di vendita (FactResellerSales) indicando anche il nome del prodotto venduto (DimProduct):
# Con JOIN

SELECT
	f.`ProductKey`
	, `SalesOrderNumber` Ordine
    , `SalesOrderLineNumber` Scontrino
    , `OrderDate` Data_ordine
    , `EnglishProductName` Nome
FROM
	`dimproduct` p
INNER JOIN
	`factresellersales` f
ON
	p.`ProductKey` = f.`ProductKey`
;

# Con SubQuery






# 6.Esponi l’elenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto:
# Con JOIN

SELECT
	f.`ProductKey`
	, `SalesOrderNumber` Ordine
    , `SalesOrderLineNumber` Scontrino
    , `OrderDate` Data_ordine
    , `EnglishProductName` Nome_prodotto
   -- , `EnglishProductSubcategoryName` Nome_sottocategoria
    , `EnglishProductCategoryName` Nome_categoria
FROM
	`dimproduct` p
INNER JOIN
	`factresellersales` f
ON
	p.`ProductKey` = f.`ProductKey`
INNER JOIN
	`dimproductsubcategory` s
ON
	p.`ProductSubcategoryKey` = s.`ProductSubcategoryKey`
INNER JOIN
	`dimproductcategory` c
ON
	s.`ProductCategoryKey` = c.`ProductCategoryKey`
;	

# Con SubQuery







# 8.Esponi in output l’elenco dei reseller indicando, per ciascun reseller, anche la sua area geografica:
# Con JOIN

SELECT
	`ResellerName`
    , g.`GeographyKey`
    , `City`
    , `EnglishCountryRegionName` Nazione
    , `BusinessType`
    , `Phone`
    , `OrderFrequency` Frequenza_ordini
    , `BankName` Banca
FROM
	`dimreseller` r
INNER JOIN
	`dimgeography` g
ON
	r.`GeographyKey` = g.`GeographyKey`
;

# Con SubQuery






/* 9-Esponi l’elenco delle transazioni di vendita. Il result set deve esporre i campi: SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost. 
Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, il nome del reseller e l’area geografica: */
# Con JOIN

SELECT
	`SalesOrderNumber` Ordine
    , `SalesOrderLineNumber` Scontrino
    , `OrderDate` Data_ordine
    , `UnitPrice` Prezzo
    , `OrderQuantity` Quantita
    , `TotalProductCost` 
    
    , `EnglishProductName` Nome_prodotto
    -- , `EnglishProductSubcategoryName` Nome_sottocategoria
    , `EnglishProductCategoryName` Nome_categoria
    
    , `ResellerName`
    , `EnglishCountryRegionName` Nazione
    , `City`
FROM
	`dimproduct` p
INNER JOIN
	`factresellersales` f
ON
	p.`ProductKey` = f.`ProductKey`
INNER JOIN
	`dimproductsubcategory` s
ON
	p.`ProductSubcategoryKey` = s.`ProductSubcategoryKey`
INNER JOIN
	`dimproductcategory` c
ON
	s.`ProductCategoryKey` = c.`ProductCategoryKey`
INNER JOIN
	`dimreseller` r
ON
	f.`ResellerKey` = r.`ResellerKey`
INNER JOIN
	`dimgeography` g
ON
	r.`GeographyKey` = g.`GeographyKey`
;	
	






