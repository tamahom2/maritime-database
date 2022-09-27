--Avoir les nations en guerre
SELECT nat.id_nation, nat1.id_nation FROM nation nat,nation nat1,relationdiplo rd
WHERE nat.id_nation<>nat1.id_nation AND nat.id_nation = rd.id_nationA AND nat1.id_nation = rd.id_nationB
AND rd.relation='en guerre' 