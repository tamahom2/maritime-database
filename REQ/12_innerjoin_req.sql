--Avoir les détails de la nation et de leurs ports europeens  où leur catégorie est 2 ou 4

SELECT * FROM nation AS nat
INNER JOIN port  ON nat.id_nation=port.id_nation
WHERE port.port_categ IN (2,4) and port.localisation='Europe';
