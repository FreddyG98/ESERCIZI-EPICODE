USE `sakila`;

/* ESERCIZIO 1: Effettuate un’esplorazione preliminare del database. Di cosa si tratta? Quante e quali tabelle contiene? 
Fate in modo di avere un’idea abbastanza chiara riguardo a e con cosa state lavorando. */


-- ESERCIZIO 2: Scoprite quanti clienti si sono registrati nel 2006.

SELECT
	COUNT(YEAR(`create_date`)) AS N°_REGISTRAZIONICLIENTI_NEL2006
FROM
	`customer`
WHERE 
	YEAR(`create_date`) = 2006
;

-- ESERCIZIO 3: Trovate il numero totale di noleggi effettuati il giorno 1/1/2006.

SELECT
	COUNT(DATE_FORMAT(`rental_date`, '%d-%m-%Y')) AS 'N°_NOLEGGI_1/1/2006'
FROM 
	`rental`
WHERE
	DATE(`rental_date`) = 1-1-2006
;

-- ESERCIZIO 4: Elencate tutti i film noleggiati nell’ultima settimana e tutte le informazioni legate al cliente che li ha noleggiati.
-- HO ESEGUITO UNA INNER JOIN PERCHE ALTRIMENTI PRENDIAMO FILM CHE NON SONO ASSOCIATI AD UN NOLEGGIO

SELECT
	f.`title` AS TITOLI
    , c.`store_id` 
    , CONCAT(c.`first_name`, " ", c.`last_name`) AS CLIENTE
    , c.`email` 
    , c.`address_id` AS ID_INDIRIZZO
    , r.`rental_date`
FROM 
	`rental` r
JOIN
	`customer` c
ON
	r.`customer_id` = c.`customer_id`
JOIN
	`inventory` i
ON
	r.`inventory_id` = i.`inventory_id`
JOIN
	`film` f
ON
	i.`film_id` = f.`film_id`
WHERE 
	r.`rental_date` BETWEEN 
						(SELECT SUBDATE(MAX(`rental_date`), INTERVAL 7 DAY) FROM `rental`)
                        AND
                        (SELECT MAX(`rental_date`) FROM `rental`)
;


-- ESERCIZIO 5: Calcolate la durata media del noleggio per ogni categoria di film.

SELECT
	c.`category_id` AS CATEGORIA
    , ROUND(AVG(f.`rental_duration`)) DURATA_MEDIA_NOLEGGIO
    , ROUND(AVG(DATEDIFF(r.`return_date`, r.`rental_date`))) D_M_N_COMPRESI_RITARDI
FROM
	`rental` r
JOIN
	`inventory` i
ON
	r.`inventory_id` = i.`inventory_id`
JOIN
	`film` f
ON
	i.`film_id` = f.`film_id`
JOIN 
	`film_category` c
ON
	f.`film_id` = c.`film_id`
GROUP BY 
	CATEGORIA
;


-- ESERCIZIO 6: Trovate la durata del noleggio più lungo.
-- IL NOLEGGIO IN ASSOLUTO PIU GRANDE
SELECT
	MAX(DATEDIFF(return_date, rental_date)) AS DURATA
FROM 
	`info_genereali`
;

-- TUTTI I NOLEGGI PIU LUNGHI IN ASSOLUTO
SELECT
	`rental_id` NOLEGGIO
	, DATEDIFF(return_date, rental_date) AS DURATA
FROM 
	`info_genereali`
WHERE
	DATEDIFF(return_date, rental_date) = (
				SELECT MAX(DATEDIFF(return_date, rental_date))
                FROM `info_genereali`
				)
;

