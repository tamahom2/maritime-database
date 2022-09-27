--Avoir les nationalites des ports qui appartiennent au provenance des voyages :
select Distinct  id_nation from port where id_nation in (select provenance from voyage );