--Avoir les voyages avec des Galion et tel que la destination est de categorie 5 :
SELECT id_voy from voyage as voy 
join navire on navire.id_navire=voy.id_navire 
join port on  port.id_port=voy.destination
where navire.type_nav='Galion' and port.port_categ=5; 