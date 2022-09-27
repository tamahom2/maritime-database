--1) Les ports de categories>2 n'ayant pas la meme localisation que les port de Germany
SELECT * 
FROM port 
WHERE localisation NOT IN ( SELECT localisation 
FROM port NATURAL JOIN nation nat 
WHERE nat.nom_nation='Serbia');

--2) Avoir les produits et leurs prix tel que leur valeur moyenne au kilo est inferieure à la moitie de la valeur maximal du tout les produits au sein du meme navire et voyage
SELECT nom,SUM(val_kg) 
FROM produit  
group by nom 
having avg(val_kg) <(SELECT max(val_kg) 
FROM produit prod, navire nav1,cargaison car,voyage voy
WHERE nav1.id_navire=car.id_navire AND prod.id_carg = car.id_carg  AND voy.id_voy = car.id_voy)/2;

---3) Valeur total de chaque produit dans toutes les cargaisons
SELECT id_produit,SUM(val_kg*volume) AS valeurglobal 
FROM produit 
GROUP BY id_produit;

---4) Valeur total de chaque produit dans toutes les cargaisons
SELECT id_produit,SUM(val_kg)*SUM(volume) AS valeurglobal 
FROM produit 
GROUP BY id_produit;

---5) Avoir les navires qui ont le plus grand nombre de passagers
SELECT * 
FROM navire 
WHERE nb_passager >= ALL(SELECT nb_passager FROM navire);

---6) Avoir les navires qui ont le plus grand nombre de passagers
SELECT * 
FROM navire 
WHERE nb_passager >= (SELECT MAX(nb_passager) FROM navire);

--7)Avoir les types de navires 
SELECT type_nav
FROM navire
GROUP BY type_nav
HAVING COUNT(DISTINCT type_nav)=1;

--8)Avoir les types de navires 
select  distinct type_nav from navire ;

--9)Avoir les voyages avec des Galion et tel que la destination est de categorie 5 :
SELECT id_voy from voyage as voy 
join navire on navire.id_navire=voy.id_navire 
join port on  port.id_port=voy.destination
where navire.type_nav='Galion' and port.port_categ=5; 

--10)Avoir les pays qui ont le nombre de navires >2 :

select id_nation,count(id_navire) 
from navire 
group by id_nation 
having count(id_navire)>2 order by count(id_navire) asc;

---11)Avoir tous les ports d'europe
SELECT * 
FROM port 
WHERE localisation NOT IN (SELECT localisation FROM port WHERE localisation<>'Europe');

--12)Avoir les détails de la nation et de leurs ports europeens  où leur catégorie est 2 ou 4

SELECT * FROM nation AS nat
INNER JOIN port  ON nat.id_nation=port.id_nation
WHERE port.port_categ IN (2,4) and port.localisation='Europe';

--13)Avoir l'historique des relations diplomatiques pour chaque nation 
SELECT * FROM nation AS nat
Right JOIN relationdiplo as rd 
ON nat.id_nation = rd.id_nationA or nat.id_nation = rd.id_nationB
order by nat.id_nation;

--14)le nom des pays visité par un navire entre deux date
WITH RECURSIVE Access(prov,dest,id_nation) AS
(
SELECT voy.provenance,voy.destination,e.id_nation FROM voyage voy,etape e WHERE e.id_voy = voy.id_voy
UNION
SELECT voy.provenance, A.dest, e.id_nation
FROM voyage voy , Access A, etape e
WHERE voy.destination = A.prov AND e.id_voy = voy.id_voy
)
SELECT DISTINCT nat.nom_nation FROM voyage voy,Access A,nation nat,port po where (A.id_nation=nat.id_nation OR (A.prov = po.id_port AND po.id_nation = nat.id_nation ) OR (A.dest = po.id_port AND po.id_nation = nat.id_nation )) AND voy.date_debut>'1992-12-04' AND voy.date_fin<'2021-09-23' AND voy.id_navire=18 AND voy.provenance = A.prov AND voy.destination = A.dest;

--15)Avoir le prix le plus bas dans une cargaison telque la moyenne des prix est superieure à 5000euros
SELECT p.id_produit, MIN(p.val_kg*p.volume+po.frais_port) as prix_minimum 
FROM produit p,port po,cargaison c,voyage v
WHERE p.id_carg = c.id_carg AND c.id_voy = v.id_voy AND v.destination = po.id_port 
GROUP BY p.id_produit 
HAVING AVG(p.val_kg*p.volume)>5000;

---16)Avoir les navires (id,type)qui on effectuer des voyages et avec un volume >3500 :

select a.id_navire,a.type_nav from (select * from navire where volume>3500) AS a join voyage b on a.id_navire=b.id_navire;

--17)Avoir les nationalites des ports qui appartiennent au provenance des voyages :
select Distinct  id_nation from port where id_nation in (select provenance from voyage );

--18)Avoir les ports de l'Europe  de categories superieure à 2:
SELECT * FROM (SELECT * from port where localisation='Europe' and port_categ>2) port_europe;

--19)Avoir les nations en guerre
SELECT nat.id_nation, nat1.id_nation FROM nation nat,nation nat1,relationdiplo rd
WHERE nat.id_nation<>nat1.id_nation AND nat.id_nation = rd.id_nationA AND nat1.id_nation = rd.id_nationB
AND rd.relation='en guerre';

--20)Avoir les voyages qui sont finis apres lannee 2000:
select * from voyage as v  where v.date_fin > '12-12-2000';

--21)Avoir les produits qui ont une duree de conservation max dans leurs cargaison:
SELECT nom FROM produit AS prod
WHERE prod.duree_de_conserv=(SELECT MAX(prod1.duree_de_conserv) FROM produit AS prod1 WHERE prod.id_carg=prod1.id_carg)
group by prod.nom;