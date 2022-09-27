---Avoir les navires (id,type)qui on effectuer des voyages et avec un volume >3500 :

select a.id_navire,a.type_nav from (select * from navire where volume>3500) AS a join voyage b on a.id_navire=b.id_navire;