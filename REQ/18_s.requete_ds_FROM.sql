--Avoir les ports de l'Europe  de categories superieure à 2:
SELECT * FROM (SELECT * from port where localisation='Europe' and port_categ>2) port_europe;