#ESERCIZIO FACOLTATIVO 1:

CREATE DATABASE Store_videogiochi;

USE Store_videogiochi;

CREATE TABLE Store(
Codice_store INT
, Indirizzo_fisico VARCHAR(250) NOT NULL
, Numero_telefonico INT NOT NULL
, PRIMARY KEY (Codice_store)
, UNIQUE (Numero_telefonico)
);

ALTER TABLE Store
MODIFY Numero_telefonico VARCHAR (50);

CREATE TABLE Impiegato(
Codice_fiscale CHAR (16)
, Nome VARCHAR (250) NOT NULL
, Titolo_studio VARCHAR (250)
, Recapito VARCHAR (250)
, PRIMARY KEY (Codice_fiscale)
);

CREATE TABLE Servizio_impiegato(
Codice_fiscale CHAR (16)
, Codice_store INT
, Data_inizio DATE NOT NULL
, Data_fine DATE NOT NULL
, Carica VARCHAR (150)
, FOREIGN KEY (Codice_fiscale) REFERENCES Impiegato (Codice_fiscale)
, FOREIGN KEY (Codice_store) REFERENCES Store (Codice_store)
);

CREATE TABLE Videogioco(
Titolo VARCHAR (250)
, Sviluppatore VARCHAR (250)
, Anno_distribuzione DATE
, Costo_acquisto DECIMAL (4,2)
, Genere VARCHAR (150)
, Remake_di VARCHAR (250) NULL
, PRIMARY KEY (Titolo)
);

/* Ho prima creato il database e poi le varie tabelle che adesso andrò a popolare*/

INSERT INTO Store VALUES
(1, "Via Roma 123, Milano", "+39 02 1234567")
, (2, "Corso Italia 456, Roma", "+39 06 7654321")
, (3, "Piazza San Marco 789, Venezia", "+39 041 98765432")
, (4, "Viale degli Ulivi 234, Napoli", "+39 081 3456789")
, (5, "Via Torino 567, Torino", "+39 011 876432")
, (6, "Corso Vittorio Emanuele 890, Firenze", "+39 055 2345678")
, (7, "Piazza del Duomo 123, Bologna", "+39 051 8765432")
, (8, "Via Garibaldi 456, Genova", "+39 010 2345678")
, (9, "Lungarno Mediceo 789, Pisa", "+39 050 8765432")
, (10, "Corso Cavour 101, Palermo", "+39 091 2345678")
;

SELECT 
*
FROM Store;

INSERT INTO Impiegato VALUES
('ABC12345XYZ67890', 'Mario Rossi', 'Laurea in Economia', 'mario.rossi@email.com')
, ('DEF67890XYZ12345', 'Anna Verdi', 'Diploma di Ragioneria', 'anna.verdi@email.com')
, ('GHI12345XYZ67890', 'Luigi Bianchi', 'Laurea in Informatica', 'luigi.bianchi@email.com')
, ('JKL67890XYZ12345', 'Laura Neri', 'Laurea in Lingue', 'laura.neri@email.com')
, ('MNO12345XYZ67890', 'Andrea Moretti', 'Diploma di Geometra', 'andrea.moretti@email.com')
, ('PQR67890XYZ12345', 'Giulia Ferrara', 'Laurea in Psicologia', 'giulia.ferrara@email.com')
,('STU12345XYZ67890', 'Marco Esposito', 'Diploma di Elettronica', 'marco.esposito@email.com')
, ('VWX67890XYZ12345', 'Sara Romano', 'Laurea in Giurisprudenza', 'sara.romano@email.com')
, ('YZA12345XYZ67890', 'Roberto De Luca', 'Diploma di Informatica', 'roberto.deluca@email.com')
, ('BCD67890XYZ12345', 'Elena Santoro', 'Laurea in Lettere', 'elena.santoro@email.com')
;

SELECT 
*
FROM Impiegato;

INSERT INTO Servizio_impiegato VALUES
('ABC12345XYZ67890', 1, '2023-01-01', '2023-12-31', 'Cassiere')
, ('DEF67890XYZ12345', 2, '2023-02-01', '2023-11-30', 'Commesso')
, ('GHI12345XYZ67890', 3, '2023-03-01', '2023-10-31', 'Magazziniere')
, ('JKL67890XYZ12345', 4,'2023-04-01', '2023-09-30',  'Addetto alle vendite')
, ('MNO12345XYZ67890', 5,  '2023-05-01', '2023-09-30',  'Addetto alle pulizie')
, ('PQR67890XYZ12345', 6,  '2023-06-01', '2023-07-31',  'Commesso')
, ('STU12345XYZ67890', 7,  '2023-07-01', '2023-06-30',  'Commesso')
, ('VWX67890XYZ12345', 8, '2023-08-01', '2023-05-31',  'Cassiere')
, ('YZA12345XYZ67890', 9,  '2023-09-01', '2023-04-30',  'Cassiere')
, ('BCD67890XYZ12345', 10,  '2023-10-01', '2023-03-31',  'Cassiere')
;

SELECT 
*
FROM Servizio_impiegato;

INSERT INTO Videogioco VALUES
( 'Fifa 2023' , 'EA Sports' , '2023-01-01',  49.99,  'Calcio', NULL)
,( "Assassin's Creed: Valhalla" , 'Ubisoft' , '2020-01-01',  59.99, 'Action', NULL)
,( 'Super Mario Odyssey' , 'Nintendo' , '2017-01-01',  39.99,  'Platform', NULL)
,( 'The Last of Us Part II' , 'Naughty Dog' ,  '2020-01-01',  69.99, 'Action', NULL)
,( 'Cyberpunk 2077' , 'CD Projekt Red' ,  '2020-01-01', 49.99,  'RPG', NULL)
,( 'Animal Crossing: New Horizons' ,  'Nintendo' ,  '2020-01-01',  54.99,  'Simulation', NULL)
,( 'Call of Duty: Warzone' , 'Infinity Ward' ,  '2020-01-01',  0.00,  'FPS', NULL)
,( 'The Legend of Zelda: Breath of the Wild' , 'Nintendo' , '2017-01-01', 59.99,  'Action-Adventure', NULL)
,( 'Fortnite' , 'Epic Games' , '2017-01-01', 0.00,  'Battle Royale', NULL)
,( 'Red Dead Redemption 2' , 'Rockstar Games' , '2018-01-01',  39.99,  'Action-Adventure', NULL)
;

SELECT 
*
FROM Videogioco;