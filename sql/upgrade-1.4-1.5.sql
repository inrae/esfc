

CREATE SEQUENCE sturio.public.devenir_devenir_id_seq;

CREATE TABLE sturio.public.devenir (
                devenir_id INTEGER NOT NULL DEFAULT nextval('sturio.public.devenir_devenir_id_seq'),
                devenir_type_id INTEGER NOT NULL,
                lot_id INTEGER,
                sortie_lieu_id INTEGER,
                categorie_id INTEGER NOT NULL,
                devenir_date TIMESTAMP NOT NULL,
                poisson_nombre INTEGER,
                CONSTRAINT devenir_pk PRIMARY KEY (devenir_id)
);
COMMENT ON TABLE sturio.public.devenir IS 'Table des devenirs des lots, et des lachers non rattachables';
COMMENT ON COLUMN sturio.public.devenir.devenir_date IS 'Date de lâcher ou d''intégration dans le stock';
COMMENT ON COLUMN sturio.public.devenir.poisson_nombre IS 'Nombre de poissons concernés';


ALTER SEQUENCE sturio.public.devenir_devenir_id_seq OWNED BY sturio.public.devenir.devenir_id;

CREATE TABLE sturio.public.devenir_type (
                devenir_type_id INTEGER NOT NULL,
                devenir_type_libelle VARCHAR NOT NULL,
                CONSTRAINT devenir_type_pk PRIMARY KEY (devenir_type_id)
);
COMMENT ON TABLE sturio.public.devenir_type IS 'Table des types de devenir :
1 : lâcher
2 : stock captif';


ALTER TABLE sturio.public.devenir ADD CONSTRAINT categorie_devenir_fk
FOREIGN KEY (categorie_id)
REFERENCES sturio.public.categorie (categorie_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.devenir ADD CONSTRAINT devenir_type_devenir_fk
FOREIGN KEY (devenir_type_id)
REFERENCES sturio.public.devenir_type (devenir_type_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.devenir ADD CONSTRAINT lot_devenir_fk
FOREIGN KEY (lot_id)
REFERENCES sturio.public.lot (lot_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.devenir ADD CONSTRAINT sortie_lieu_devenir_fk
FOREIGN KEY (sortie_lieu_id)
REFERENCES sturio.public.sortie_lieu (sortie_lieu_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

insert into categorie (categorie_id, categorie_libelle) values (4, 'Larves');
insert into devenir_type (devenir_type_id, devenir_type_libelle) 
values
(1, 'lâcher'),
(2, 'stock captif');
