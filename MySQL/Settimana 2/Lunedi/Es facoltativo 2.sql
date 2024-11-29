#ESERCIZI FACOLTATIVI 2:
#TRACCIA 1: CREA UN DATABASE COMPOSTO DA 3 TABELLE

CREATE DATABASE Magazzino;

USE Magazzino;

CREATE TABLE Prodotti(
IDProdotto INT
, Nome_Prodotto VARCHAR(100)
, Prezzo DECIMAL(10,2)
, PRIMARY KEY (IDProdotto)
);

CREATE TABLE Clienti(
IDCliente INT
, Nome VARCHAR(50)
, Email VARCHAR(100)
, PRIMARY KEY (IDCliente)
);

CREATE TABLE Ordini(
IDOrdine INT 
, IDProdotto INT 
, IDCliente INT 
, Quantita INT 
, PRIMARY KEY (IDOrdine)
, FOREIGN KEY (IDProdotto) REFERENCES Prodotti (IDProdotto)
, FOREIGN KEY (IDCliente) REFERENCES Clienti (IDCliente)
);

#TRACCIA BONUS: TABELLA BONUS CON CHIAVE PRIMARIA COMPOSITA
#BONUS NEL BONUS: CAMPO CALCOLATO PREZZO TOTALE

CREATE TABLE Dettaglio_ordini(
IDOrdine INT
, IDProdotto INT 
, IDCliente INT 
, Prezzo DECIMAL(10,2)
, Quantita INT 
, Prezzo_totale DECIMAL(10,2) AS (Prezzo * Quantita)
, PRIMARY KEY (IDOrdine, IDProdotto, IDCliente)
, FOREIGN KEY (IDOrdine) REFERENCES Ordini (IDOrdine)
, FOREIGN KEY (IDProdotto) REFERENCES Prodotti (IDProdotto)
, FOREIGN KEY (IDCliente) REFERENCES Clienti (IDCliente)
);

#TRACCIA 2: POPOLARE LE TABELLE CON I DATI FORNITI

INSERT INTO Prodotti VALUES
(1,'Tablet',300.00)
, (2,'Mouse',20.00)
, (3,'Tastiera',25.00)
, (4,'Monitor',180.00)
, (5,'HHD',90.00)
, (6,'SSD',200.00)
, (7,'RAM',100.00)
, (8,'Router',80.00)
, (9,'Webcam',45.00)
, (10,'GPU',1250.00)
, (11,'Trackpad',500.00)
, (12,'Techmagazine',5.00)
, (13,'Martech',50.00)
;

SELECT *
FROM Prodotti;

/*PER LA TABELLA ORDINI IL CAMPO IDCLIENTE NON è PRESENTE NELLE SLIDE, PERTANTO AVEVO 2 SCELTE: LASCIARE TUTTO VUOTO OPPURE COMPILARLI A CASO.
LASCIANDO TUTTO VUOTO LA FOREIGN KEY NON AVREBBE SENSO DI ESISTERE: PERTANTO HO INSERITO VALORI A CASO*/

INSERT INTO Ordini VALUES
(1, 2, 1, 10)
, (2, 6, 2, 2)
, (3, 5, 3, 3)
, (4, 1, 4, 1)
, (5, 9, 5, 1)
, (6, 4, 6, 2)
, (7, 11, 7, 6)
, (8, 10, 1, 2)
, (9, 3, 2, 3)
, (10, 3, 3, 1)
, (11, 2, 4, 1)
;

SELECT *
FROM Ordini;

INSERT INTO Clienti VALUES
(1, 'Antonio', NULL)
, (2, 'Battista', 'battista@mailmail.it')
, (3, 'Maria', 'maria@posta.it')
, (4, 'Franca', 'franca@lettere.it')
, (5, 'Ettore', NULL)
, (6, 'Arianna', 'arianna@posta.it')
, (7, 'Piero', 'piero@lavoro.it')
;

SELECT *
FROM Clienti;

#TRACCIA BONUS: COME INSERIAMO I DATI ALL'INTERNO DELLA TABELLA DETTAGLIO_ORDINI?
/* HO PRIMA CONFRONTATO LE TABELLE ORDINI E DETTAGLIO_ORDINI, DOPODICHE HO INIZIATO A INSERIRE I CAMPI IN COMUNE DELLE 2 TABELLE*/

INSERT INTO Dettaglio_ordini (IDOrdine , IDProdotto , IDCliente , Quantita) VALUES
(1, 2, 1, 10)
, (2, 6, 2, 2)
, (3, 5, 3, 3)
, (4, 1, 4, 1)
, (5, 9, 5, 1)
, (6, 4, 6, 2)
, (7, 11, 7, 6)
, (8, 10, 1, 2)
, (9, 3, 2, 3)
, (10, 3, 3, 1)
, (11, 2, 4, 1)
;

SELECT *
FROM Dettaglio_ordini;

INSERT INTO Dettaglio_ordini (Prezzo) VALUES
(20.00)
, (200.00)
, (90.00)
, (300.00)
, (45.00)
, (180.00)
, (500.00)
, (1250.00)
, (25.00)
, (25.00)
, (20.00)
;

#BISOGNA AGGIORNARE LA TABELLA CON UN UPDATE

SELECT *
FROM Dettaglio_ordini;

ALTER TABLE Dettaglio_ordini
MODIFY IDOrdine INT NOT NULL;

ALTER TABLE Dettaglio_ordini
MODIFY IDProdotto INT NOT NULL;

ALTER TABLE Dettaglio_ordini
MODIFY IDCliente INT NOT NULL;

ALTER TABLE Dettaglio_ordini
MODIFY Quantita INT NOT NULL;
