--Avoir les pays qui ont le nombre de navires >2 :

select id_nation,count(id_navire) 
from navire 
group by id_nation 
having count(id_navire)>2 order by count(id_navire) asc;