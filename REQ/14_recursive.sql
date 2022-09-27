--le nom des pays visité par un navire entre deux date
WITH RECURSIVE Access(prov,dest,id_nation) AS
(
SELECT voy.provenance,voy.destination,e.id_nation FROM voyage voy,etape e WHERE e.id_voy = voy.id_voy
UNION
SELECT voy.provenance, A.dest, e.id_nation
FROM voyage voy , Access A, etape e
WHERE voy.destination = A.prov AND e.id_voy = voy.id_voy
)
SELECT DISTINCT nat.nom_nation FROM voyage voy,Access A,nation nat,port po where (A.id_nation=nat.id_nation OR (A.prov = po.id_port AND po.id_nation = nat.id_nation ) OR (A.dest = po.id_port AND po.id_nation = nat.id_nation )) AND voy.date_debut>'1992-12-04' AND voy.date_fin<'2021-09-23' AND voy.id_navire=18 AND voy.provenance = A.prov AND voy.destination = A.dest;
