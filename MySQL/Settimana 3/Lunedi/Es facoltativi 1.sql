USE `chinook`;

-- Esercizio 1 Cominciate facendo un’analisi esplorativa del database, ad esempio:

DESCRIBE `album`;
DESCRIBE `artist`;
DESCRIBE `customer`;
DESCRIBE `employee`;
DESCRIBE `genre`;
DESCRIBE `invoice`;
DESCRIBE `invoiceline`;
DESCRIBE `mediatype`;
DESCRIBE `playlist`;
DESCRIBE `playlisttrack`;
DESCRIBE `track`;

SELECT 
	COUNT(`Name`)
FROM
	`track`
;

-- Esercizio 2 Recuperate il nome di tutte le tracce e del genere associato.

SELECT
	t.`Name` Traccia
    , g.`Name` Genere
FROM
	`track` t
INNER JOIN
	`genre` g
ON
	t.`GenreId` = g.`GenreId`
;

-- Esercizio 3 Recuperate il nome di tutti gli artisti che hanno almeno un album nel database. Esistono artisti senza album nel database?

-- QUI HO PRIMA USATO UNA LEFT JOIN PER OTTENERE TUTTI GLI ARTISTI E CAPIRE SE CE NE FOSSERO ANCHE SENZA ALBUM
SELECT
	`Name` Cantante
    , `Title` Album
FROM
	`artist` ar
LEFT JOIN 
	`album` al
ON
	ar.`ArtistId` = al.`ArtistId`
;

-- QUI INVECE HO USATO UNA INNER PER AVERE SOLTANTO QUELLI CON GLI ALBUM
SELECT
	`Name` Cantante
    , `Title` Album
FROM
	`artist` ar
INNER JOIN
	`album` al
ON
	ar.`ArtistId` = al.`ArtistId`
;

-- QUI INVECE HO USATO UN COUNT ED UN GROUP BY PER VEDERE OGNI ARTISTA QUANTI ALBUM HA REALIZZATO
SELECT
	`Name` Cantante
    , COUNT(`Title`) Album
FROM
	`artist` ar
INNER JOIN
	`album` al
ON
	ar.`ArtistId` = al.`ArtistId`
GROUP BY
	`Name`
;

-- Esercizio 4 Recuperate il nome di tutte le tracce, del genere associato e della tipologia di media. Esiste un modo per recuperare il nome della tipologia di media?

SELECT
	t.`Name` Traccia
    , g.`Name` Genere
    , m.`Name` Media
FROM
	`track` t
INNER JOIN
	`genre` g
ON
	t.`GenreId` = g.`GenreId`
INNER JOIN
	`mediatype` m
ON
	t.`MediaTypeId` = m.`MediaTypeId`
;

-- Esercizio 5 Elencate i nomi di tutti gli artisti e dei loro album.

SELECT
	`Name` Cantante
    , `Title` Album
FROM
	`artist` ar
INNER JOIN
	`album` al
ON
	ar.`ArtistId` = al.`ArtistId`
ORDER BY
	Cantante
;

