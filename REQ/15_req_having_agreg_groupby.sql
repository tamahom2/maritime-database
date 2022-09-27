--Avoir le prix le plus bas dans une cargaison telque la moyenne des prix est superieure à 5000euros
SELECT p.id_produit, MIN(p.val_kg*p.volume+po.frais_port) as prix_minimum 
FROM produit p,port po,cargaison c,voyage v
WHERE p.id_carg = c.id_carg AND c.id_voy = v.id_voy AND v.destination = po.id_port 
GROUP BY p.id_produit 
HAVING AVG(p.val_kg*p.volume)>5000 