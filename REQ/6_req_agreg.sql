---Avoir les navires qui ont le plus grand nombre de passagers
SELECT * FROM navire WHERE nb_passager >= (SELECT MAX(nb_passager) FROM navire);