--Avoir l'historique des relations diplomatiques pour chaque nation 
SELECT * FROM nation AS nat
Right JOIN relationdiplo as rd 
ON nat.id_nation = rd.id_nationA or nat.id_nation = rd.id_nationB
order by nat.id_nation;