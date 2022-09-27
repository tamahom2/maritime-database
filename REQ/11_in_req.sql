---Avoir tous les ports d'europe
SELECT * 
FROM port 
WHERE localisation NOT IN (SELECT localisation FROM port WHERE localisation<>'Europe');