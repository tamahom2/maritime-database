--Avoir les produits et leurs prix tel que leur valeur moyenne au kilo est inferieure à la moitie de la valeur maximal du tout les produits au sein du meme navire et voyage
SELECT nom,SUM(val_kg) FROM produit  group by nom having avg(val_kg) <(SELECT max(val_kg) FROM produit prod, navire nav1,cargaison car,voyage voy
WHERE nav1.id_navire=car.id_navire AND prod.id_carg = car.id_carg  AND voy.id_voy = car.id_voy)/2;