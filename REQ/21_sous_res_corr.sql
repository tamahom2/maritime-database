--Avoir les produits qui ont une duree de conservation max dans leurs cargaison:
SELECT nom FROM produit AS prod
WHERE prod.duree_de_conserv=(SELECT MAX(prod1.duree_de_conserv) FROM produit AS prod1 WHERE prod.id_carg=prod1.id_carg)
group by prod.nom;