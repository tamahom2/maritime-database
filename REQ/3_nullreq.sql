--- Valeur total de chaque produit dans toutes les cargaisons
SELECT id_produit,SUM(val_kg*volume) AS valeurglobal FROM produit GROUP BY id_produit;
