CREATE DATABASE Università;
SHOW DATABASES;
USE Università;
CREATE TABLE Dipartimenti(
 Nome_dipartimento VARCHAR(150)
, Indirizzo_sede_principale VARCHAR(150)
);

ALTER TABLE Dipartimenti
MODIFY Nome_dipartimento VARCHAR(150) NOT NULL
, MODIFY Indirizzo_sede_principale VARCHAR(150) NOT NULL;

ALTER TABLE Dipartimenti
ADD CONSTRAINT PRIMARY KEY (Nome_dipartimento);

SHOW TABLES;
SELECT * FROM Dipartimenti; 

DESCRIBE Dipartimenti;

CREATE TABLE Contratti(
IdContratto INT NOT NULL AUTO_INCREMENT
, IdDocente INT NOT NULL
, Nome_dipartimento VARCHAR(150) NOT NULL
, PRIMARY KEY (IdContratto)
);

#Ho creato la tabella Docenti con la barra degli strumenti per provarla, dopodichè l'ho eliminata con il comando qui sotto
DROP TABLE Docenti;

-- Poi l'ho ricreata allo stesso modo conservando la finestra in alto, per provare a inserire le chiavi esterne

ALTER TABLE Contratti
ADD CONSTRAINT FOREIGN KEY (IdDocente) REFERENCES Docenti (IdDocente)
, ADD CONSTRAINT FOREIGN KEY (Nome_dipartimento) REFERENCES Dipartimenti (Nome_dipartimento);

DESCRIBE Contratti;

CREATE TABLE Cattedre(
IdCattedra INT NOT NULL AUTO_INCREMENT
, IdDocente INT NOT NULL
, IdCorso INT NOT NULL
, PRIMARY KEY (IdCattedra)
);

ALTER TABLE Cattedre
ADD CONSTRAINT FOREIGN KEY (IdDocente) REFERENCES Docenti (IdDocente);

USE Università;

CREATE TABLE Corsi(
IdCorso INT NOT NULL AUTO_INCREMENT PRIMARY KEY
, CFU_Totali SMALLINT NOT NULL
, Nome VARCHAR (150) NOT NULL
);

ALTER TABLE Cattedre
ADD FOREIGN KEY (IdCorso) REFERENCES Corsi (IdCorso);

CREATE TABLE Studenti(
Matricola INT AUTO_INCREMENT PRIMARY KEY NOT NULL
, Nome VARCHAR (150) NOT NULL 
, Data_di_nascita DATE NOT NULL
);

CREATE TABLE Esami(
IdEsame INT NOT NULL AUTO_INCREMENT PRIMARY KEY
, Voto TINYINT NOT NULL
, Data_esame DATE NOT NULL
, CFU TINYINT NOT NULL
, Matricola INT NOT NULL 
, IdCorso INT NOT NULL 
);

ALTER TABLE Esami
ADD FOREIGN KEY (Matricola) REFERENCES Studenti (Matricola)
, ADD FOREIGN KEY (IdCorso) REFERENCES Corsi (IdCorso);

CREATE TABLE Sedi(
IdSede INT AUTO_INCREMENT NOT NULL
, Indirizzo_sede VARCHAR(150) NOT NULL
, Nome_dipartimento VARCHAR(150) NOT NULL
, IdCorso INT NOT NULL
, PRIMARY KEY (IdSede)
);

ALTER TABLE Sedi
ADD FOREIGN KEY (Nome_dipartimento) REFERENCES Dipartimenti (Nome_dipartimento)
, ADD FOREIGN KEY (IdCorso) REFERENCES Corsi (IdCorso);

-- Nella tabella "ESAMI" ho sbagliato a dare alle tabelle "VOTO","DATA" e "CFU" i valori "NOT NULL": DA CAMBIARE --

ALTER TABLE Esami
MODIFY Voto TINYINT
, MODIFY Data_esame DATE
, MODIFY CFU TINYINT;