--Avoir les types de navires 

SELECT type_nav
FROM navire
GROUP BY type_nav
HAVING COUNT(DISTINCT type_nav)=1;
