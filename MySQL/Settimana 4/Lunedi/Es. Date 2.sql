USE `sakila`;

-- CREAZIONE DI UNA VISTA:

CREATE OR REPLACE VIEW VW_INFO_GENEREALI AS
SELECT 
	-- TABELLA CUSTOMER
	c.`customer_id`
    , c.`store_id`
	, CONCAT(`first_name`, ' ', `last_name`) AS CLIENTE
    , `email`
    , `address_id`
    , `active`
    , `create_date`
    -- TABELLA FILM
    , f.`film_id`
    , `title`
    , `length`
    , `rental_duration`
    , `rental_rate`
    , `replacement_cost`
    -- TABELLA INVENTORY
    , i.`inventory_id`
    -- TABELLA RENTAL
    , r.`rental_id`
    , `rental_date`
    , `return_date`
    , r.`staff_id`
    -- TABELLA PAYMENT
    , `payment_id`
    , `amount`
    , `payment_date`
FROM 
	`rental` r
LEFT JOIN
	`customer` c
ON
	r.`customer_id` = c.`customer_id`
LEFT JOIN
	`inventory` i
ON
	r.`inventory_id` = i.`inventory_id`
LEFT JOIN
	`film` f
ON
	i.`film_id` = f.`film_id`
LEFT JOIN
	`payment` p
ON
	r.`rental_id` = p.`rental_id`
;

/* ESERCIZIO 1: Identificate tutti i clienti che non hanno effettuato nessun noleggio a gennaio 2006. */
-- NON CI SONO NOLEGGI A GENNAIO 2006 (PROVARE FILTRANDO SOLO I 2006 SONO PRESENTI TIPO A FEBBRAIO)
-- I CUSTOMER NON SONO SICURO CHE NON CI SIANO I NULL

SELECT
	`customer_id` 
FROM 
	`customer`
WHERE 
	`customer_id` NOT IN (
							SELECT `customer_id`
							FROM `rental` r 
                            WHERE `rental_date` BETWEEN 2006-01-01 AND 2006-01-31
                            )
GROUP BY	
	`customer_id` 
;

-- ALTRO METODO:

SELECT
	c.`customer_id` 
FROM 
	`customer` c
LEFT JOIN
	`rental` r 
ON 
	c.`customer_id` = r.`customer_id` AND r.`rental_date` BETWEEN 2006-01-01 AND 2006-01-31
WHERE 
	r.`rental_date` IS NULL
;

-- VERIFICA: CI SONO EFFETTIVAMENTE DEI CUSTOMER MANCANTI! (Es.: 4, 6, 8, 9, 11 ECC...)

SELECT
	c.`customer_id` 
  --  , YEAR(`rental_date`)
  --  , MONTH(`rental_date`)
FROM 
	`customer` c 
CROSS JOIN 
	`rental` r 
ON 
	c.`customer_id` = r.`customer_id`
;
    
-- ESERCIZIO 2: Elencate tutti i film che sono stati noleggiati più di 10 volte nell’ultimo quarto del 2005
-- NON CI SONO NOLEGGI TRA OTTOBRE E DICEMBRE 2005:
-- SENZA VISTA:
SELECT
	`title` TITOLO
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
WHERE 
	YEAR(`rental_date`) = 2005
AND 
	MONTH(`rental_date`) = 12
GROUP BY
	i.`film_id` 
HAVING
	COUNT(i.`film_id`) > 10
;

-- CON VISTA:
SELECT
	`title` TITOLO
FROM 
	`vw_info_genereali`
WHERE 
	YEAR(`rental_date`) = 2005
AND 
	MONTH(`rental_date`) = 12
GROUP BY
	`film_id`
HAVING 
	COUNT(`film_id`) > 10
;

-- ESERCIZIO 3: Trovate il numero totale di noleggi effettuati il giorno 1/1/2006.
-- NON CI SONO NOLEGGI A GENNAIO 2006

SELECT
	COUNT(DATE_FORMAT(`rental_date`, '%d-%m-%Y')) CONTEGGIO
FROM
	`vw_info_genereali`
WHERE
	DATE(`rental_date`) = 01-01-2006
;

-- ESERCIZIO 4: Calcolate la somma degli incassi generati nei weekend (sabato e domenica).
-- TOTALE:

SELECT 
	SUM(`amount`) INCASSI
FROM 
	`vw_info_genereali`
WHERE 
	DAYNAME(`payment_date`) IN ('Saturday', 'Sunday');

-- SABATI E DOMENICHE SEPARATE:

SELECT 
	SUM(CASE WHEN DAYNAME(`payment_date`) = 'Saturday' THEN `amount` ELSE 0 END) INCASSI_SABATO
    , SUM(CASE WHEN DAYNAME(`payment_date`) = 'Sunday' THEN `amount` ELSE 0 END) INCASSI_DOMENICA
FROM 
	`vw_info_genereali`
;


-- ESERCIZIO 5: Individuate il cliente che ha speso di più in noleggi.

SELECT
	`customer_id`
    , `CLIENTE`
    , SUM(`amount`)
FROM
	`vw_info_genereali`
GROUP BY
	`customer_id`
ORDER BY
	SUM(`amount`) DESC
LIMIT 1
;

-- ESERCIZIO 6: Elencate i 5 film con la maggior durata media di noleggio.

SELECT
	`film_id`
    , `title` TITOLO
    , AVG(DATEDIFF(`return_date`, `rental_date`)) DURATA_MEDIA
FROM
	`vw_info_genereali`
GROUP BY
	`film_id`
ORDER BY
	DURATA_MEDIA DESC
LIMIT 5
;

-- ESERCIZIO 7: Calcolate il tempo medio tra due noleggi consecutivi da parte di un cliente.

SELECT
	`customer_id`
	, MIN(`rental_date`) PRIMO_NOLEGGIO
    , MAX(`rental_date`) ULTIMO_NOLEGGIO
    , COUNT(`rental_id`) NOLEGGI_TOT
    , DATEDIFF(MAX(`rental_date`), MIN(`rental_date`)) / COUNT(`rental_id`) MEDIA
FROM
	`vw_info_genereali`
GROUP BY
	`customer_id`
ORDER BY 
	`customer_id`
;

-- ESERCIZIO 8: Individuate il numero di noleggi per ogni mese del 2005.
-- SENZA IL 2005 AGGIUNGE 182 NOLEGGI DI UN QUALCHE FEBBRAIO

SELECT
	COUNT(`rental_id`)
    , MONTH(`rental_date`)
FROM
	`vw_info_genereali`
WHERE
	YEAR(`rental_date`) = 2005
GROUP BY
	MONTH(`rental_date`)
;


-- ESERCIZIO 9: Trovate i film che sono stati noleggiati almeno due volte lo stesso giorno.

SELECT
	`title`
    , COUNT(DATE(`rental_date`))
FROM
	`vw_info_genereali`
GROUP BY
	`title`
HAVING
	COUNT(DATE(`rental_date`)) >= 2
ORDER BY
	COUNT(DATE(`rental_date`)) DESC
;

-- ESERCIZIO 10: Calcolate il tempo medio di noleggio.

SELECT
	AVG(`rental_duration`) DURATA_MEDIA_NOLEGGIO
    , AVG(DATEDIFF(`return_date`, `rental_date`)) D_M_N_COMPRESI_RITARDI
FROM
	`vw_info_genereali`
;
