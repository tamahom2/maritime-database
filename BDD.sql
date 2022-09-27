drop table if exists nation CASCADE  ;
drop table if exists relationdiplo CASCADE ; 
drop table if exists port CASCADE;
drop table if exists navire CASCADE;
drop table if exists voyage CASCADE; 
drop table if exists cargaison CASCADE; 
drop table if exists etape CASCADE ; 
drop table if exists produit CASCADE; 



CREATE TABLE nation (
    id_nation integer primary key , 
    nom_nation VARCHAR NOT NULL
 
);

CREATE TABLE  relationdiplo (
    id_nationA integer ,
    id_nationB INTEGER ,
    relation VARCHAR NOT NULL CHECK(relation='en guerre' OR relation='allies' OR relation='allies commerciaux' OR relation='neutres'),
  	PRIMARY KEY(id_nationA, id_nationB),
  	Foreign key (id_nationA) references nation (id_nation),
  	Foreign key (id_nationB) references nation (id_nation)
) ;

CREATE TABLE port (
    id_port integer  primary key  ,
    nom varchar NOT NULL,
    localisation varchar NOT NULL CHECK(localisation='South America' OR localisation='Asia' OR localisation='Europe' OR localisation='North America' or localisation='Oceania' or localisation='Africa' or localisation='Antarctica'),
    id_nation INTEGER   NOT NULL,
    port_categ integer   NOT NULL  CONSTRAINT entre_1_5 CHECK(port_categ >=1 and port_categ <=5),
	frais_port INTEGER NOT NULL,
  	Foreign key (id_nation) references nation (id_nation)
);

CREATE TABLE navire (
    id_navire integer PRIMARY key    ,
    type_nav char(15)   NOT NULL CHECK(type_nav='Yacht' OR type_nav='Flute' OR type_nav='Galion' OR type_nav='Gabare' or type_nav='Post-Panamax'),
    nav_categ integer   NOT NULL CONSTRAINT entre_1_5 CHECK(nav_categ >=1 and nav_categ <=5),
    id_nation INTEGER   NOT NULL,
    volume INTEGER NOT NULL CHECK(volume>0),
    nb_passager integer   NOT NULL CHECK(nb_passager>0),
   
   	Foreign key (id_nation) references nation (id_nation)
);


CREATE TABLE voyage (
    id_voy integer primary key  ,
    date_debut date NOT NULL,
    date_fin date NOT NULL,
    provenance integer NOT NULL,
    destination integer not NULL,
    id_navire INTEGER NOT NULL,
  	distance INTEGER NOT NULL CHECK(distance>=0),
   	type_voy VARCHAR NOT NULL CHECK(type_voy='South America' OR type_voy='Asia' OR type_voy='Europe' OR type_voy='North America' or type_voy='Oceania' or type_voy='Africa' OR type_voy='Intercontinental' or type_voy='Antarctica') , 
     
     CHECK (date_debut < date_fin),
     Foreign key (provenance) references port (id_port) ,
     Foreign key (destination) references port (id_port),
     Foreign key (id_navire) references navire (id_navire)

); 

CREATE TABLE cargaison (
    id_carg integer  primary key , 
  	id_voy integer NOT NULL,
  	id_navire INTEGER NOT NULL,
  	Foreign key (id_navire) references navire (id_navire),
 	Foreign key (id_voy) references voyage (id_voy) 
);

CREATE TABLE  etape (
    id_etape integer   primary key ,
	id_voy INTEGER NOT NULL,
	id_nation INTEGER NOT NULL,
    nb_passagerdes  integer   NOT NULL, 
    nb_passagermt integer not NULL,
	numero INTEGER NOT NULL,
    Foreign key (id_voy) references voyage (id_voy) ,
	Foreign key (id_nation) references nation (id_nation) 

) ; 

CREATE TABLE produit (
    id_produit integer PRIMARY key ,   
  	id_carg INTEGER NOT NULL,
	id_etape INTEGER,
    nom VARCHAR NOT NULL,
    duree_de_conserv INTEGER, 
    val_kg INTEGER NOT NULL CHECK(val_kg>0),
    volume INTEGER NOT NULL CHECK(volume>0),
	ajout BOOLEAN NOT NULL,
  	Foreign key (id_carg) references cargaison (id_carg), 
    Foreign key (id_etape) REFERENCES etape (id_etape)
);


\COPY nation FROM 'CSV/nation.csv' WITH csv;
\COPY relationdiplo FROM 'CSV/relationdiplo.csv'  WITH csv;
\COPY port FROM 'CSV/port.csv' WITH csv;
\COPY navire FROM 'CSV/navire.csv' WITH csv;
\COPY voyage FROM 'CSV/voyage.csv'  WITH csv;
\COPY cargaison FROM 'CSV/cargaison.csv' WITH csv;
\COPY etape FROM 'CSV/etape.csv' WITH csv;
\COPY produit FROM 'CSV/produit.csv' WITH csv;
