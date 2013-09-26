CREATE TABLE LoginGestion(
id integer NOT NULL,
login varchar(32) NOT NULL,
password varchar(255),
nom varchar(32),
prenom varchar(32),
mail varchar(255),
datemodif date
) ;


CREATE SEQUENCE SEQ_LoginGestion_id
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 999999
	START WITH 1
	NO CYCLE
	OWNED BY LoginGestion.id	
;
ALTER TABLE LoginGestion ALTER COLUMN id SET DEFAULT nextval('SEQ_LoginGestion_id');




ALTER TABLE LoginGestion ADD CONSTRAINT PK_LoginGestion PRIMARY KEY (id);

INSERT INTO LoginGestion (id, login, password, nom, prenom, mail, datemodif) VALUES
(1, 'admin', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 'Administrateur', NULL, NULL, NULL),
(5, 'gestion', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 'Gestionnaire', NULL, NULL, NULL);	
 
	
