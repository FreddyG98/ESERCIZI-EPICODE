USE AdventureWorksDW;

#Esercizi base:
-- Esplora la tabelle dei prodotti (DimProduct): --
/* Interroga la tabella dei prodotti (DimProduct) ed esponi in output i campi ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag. 
Il result set deve essere parlante per cui assegna un alias se lo ritieni opportuno. */

SELECT 
ProductKey AS Codice_prodotto
, ProductAlternateKey AS Codice_modello
, EnglishProductName AS Nome
, Color AS Colore
, StandardCost AS Costo
, FinishedGoodsFlag AS Prodotti_finiti
FROM dimproduct;

/*Partendo dalla query scritta nel passaggio precedente, esponi in output i soli prodotti finiti cioè quelli per cui il campo FinishedGoodsFlag è uguale a 1.*/

SELECT 
ProductKey AS Codice_prodotto
, ProductAlternateKey AS Codice_modello
, EnglishProductName AS Nome
, Color AS Colore
, StandardCost AS Costo
, FinishedGoodsFlag AS Prodotti_finiti
FROM dimproduct
WHERE FinishedGoodsFlag = 1;

/*Scrivi una nuova query al fine di esporre in output i prodotti il cui codice modello (ProductAlternateKey) comincia con FR oppure BK. 
Il result set deve contenere il codice prodotto (ProductKey), il modello, il nome del prodotto, il costo standard (StandardCost) e il prezzo di listino (ListPrice).*/

SELECT
ProductKey AS Codice_prodotto
, ModelName AS Modello
, EnglishProductName AS Nome_prodotto
, StandardCost AS Costo
, ListPrice AS Prezzo
, ProductAlternateKey
FROM dimproduct
WHERE ProductAlternateKey LIKE "FR%" OR ProductAlternateKey LIKE 'BK%';

/*Arricchisci il risultato della query scritta nel passaggio precedente del Markup applicato dall’azienda (ListPrice - StandardCost)*/

SELECT
ProductKey AS Codice_prodotto
, ModelName AS Modello
, EnglishProductName AS Nome_prodotto
, StandardCost AS Costo
, ListPrice AS Prezzo
, ProductAlternateKey
, ListPrice - StandardCost AS "MARKUP(Profitto)"
FROM dimproduct
WHERE ProductAlternateKey LIKE "FR%" OR ProductAlternateKey LIKE 'BK%';

/*Scrivi un’altra query al fine di esporre l’elenco dei prodotti finiti il cui prezzo di listino è compreso tra 1000 e 2000.*/

SELECT 
ProductKey AS Codice_prodotto
, ModelName AS Modello
, EnglishProductName AS Nome_prodotto
, ListPrice AS Prezzo
FROM dimproduct
WHERE FinishedGoodsFlag = 1 and ListPrice BETWEEN 1000 AND 2000;

#Esplora la tabella degli impiegati aziendali (DimEmployee):
/*Esponi, interrogando la tabella degli impiegati aziendali, l’elenco dei soli agenti. Gli agenti sono i dipendenti per i quali il campo SalespersonFlag è uguale a 1.*/

SELECT 
EmployeeKey AS Codice_dipendente
, FirstName AS Nome
, LastName AS Cognome
, Title AS Ruolo
, LoginID
, EmailAddress AS Email
FROM dimemployee
WHERE SalespersonFlag = 1
ORDER BY LastName ASC;              -- HO AGGIUNTO UN ORDER BY --

# Interroga la tabella delle vendite (FactResellerSales). 
/*Esponi in output l’elenco delle transazioni registrate a partire dal 1 gennaio 2020 dei soli codici prodotto: 597, 598, 477, 214. 
Calcola per ciascuna transazione il profitto (SalesAmount - TotalProductCost).*/

SELECT
SalesOrderNumber
, SalesOrderLineNumber
, OrderDate AS Data_ordine
, ProductKey AS Codice_prodotto
, OrderQuantity AS Quantita
, EmployeeKey AS Codice_dipendente
, SalesAmount - TotalProductCost AS Ricavi
FROM factresellersales
WHERE OrderDate >= "2020/01/01" AND ProductKey IN (597, 598, 477, 214);