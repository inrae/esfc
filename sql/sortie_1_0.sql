

ALTER TABLE sturio.public.lacher DROP CONSTRAINT evenement_lacher_fk;

ALTER TABLE sturio.public.lacher DROP CONSTRAINT lacher_lieu_lacher_fk;

ALTER TABLE sturio.public.lacher DROP CONSTRAINT poisson_lacher_fk;


DROP TABLE sturio.public.lacher;

DROP TABLE sturio.public.lacher_lieu;
COMMENT ON TABLE sturio.public.mime_type IS 'Table des types mime, pour les documents associés';

ALTER TABLE sturio.public.poisson ADD COLUMN poisson_categorie_id INTEGER DEFAULT 2 NOT NULL;

CREATE SEQUENCE sturio.public.poisson_categorie_poisson_categorie_id_seq;

CREATE TABLE sturio.public.poisson_categorie (
                poisson_categorie_id INTEGER NOT NULL DEFAULT nextval('sturio.public.poisson_categorie_poisson_categorie_id_seq'),
                poisson_categorie_libelle VARCHAR NOT NULL,
                CONSTRAINT poisson_categorie_pk PRIMARY KEY (poisson_categorie_id)
);
COMMENT ON TABLE sturio.public.poisson_categorie IS 'Table des catégories de poisson (adulte, juvénile, alevin)';


ALTER SEQUENCE sturio.public.poisson_categorie_poisson_categorie_id_seq OWNED BY sturio.public.poisson_categorie.poisson_categorie_id;

CREATE SEQUENCE sturio.public.sortie_sortie_id_seq;

CREATE TABLE sturio.public.sortie (
                sortie_id INTEGER NOT NULL DEFAULT nextval('sturio.public.sortie_sortie_id_seq'),
                poisson_id INTEGER NOT NULL,
                evenement_id INTEGER NOT NULL,
                sortie_lieu_id INTEGER NOT NULL,
                lacher_date DATE,
                lacher_commentaire VARCHAR,
                sevre VARCHAR,
                CONSTRAINT sortie_pk PRIMARY KEY (sortie_id)
);
COMMENT ON TABLE sturio.public.sortie IS 'Table des sorties du stock';
COMMENT ON COLUMN sturio.public.sortie.lacher_date IS 'Date du lâcher';
COMMENT ON COLUMN sturio.public.sortie.lacher_commentaire IS 'Remarques sur le lâcher';
COMMENT ON COLUMN sturio.public.sortie.sevre IS 'Poisson sevré : oui, non, mixte...';


ALTER SEQUENCE sturio.public.sortie_sortie_id_seq OWNED BY sturio.public.sortie.sortie_id;

CREATE SEQUENCE sturio.public.sortie_lieu_sortie_lieu_id_seq;

CREATE TABLE sturio.public.sortie_lieu (
                sortie_lieu_id INTEGER NOT NULL DEFAULT nextval('sturio.public.sortie_lieu_sortie_lieu_id_seq'),
                localisation VARCHAR NOT NULL,
                longitude_dd DOUBLE PRECISION,
                latitude_dd DOUBLE PRECISION,
                actif SMALLINT DEFAULT 1 NOT NULL,
                poisson_statut_id INTEGER,
                CONSTRAINT sortie_lieu_pk PRIMARY KEY (sortie_lieu_id)
);
select addGeometryColumn('public','sortie_lieu','point_geom',4326, 'POINT',2);

COMMENT ON TABLE sturio.public.sortie_lieu IS 'Lieux des sorties du stock des poissons';
COMMENT ON COLUMN sturio.public.sortie_lieu.localisation IS 'information textuelle sur le lieu de lacher';
COMMENT ON COLUMN sturio.public.sortie_lieu.longitude_dd IS 'Longitude du point de lâcher, en valeur décimale';
COMMENT ON COLUMN sturio.public.sortie_lieu.latitude_dd IS 'Latitude du point de lâcher, en décimal';
COMMENT ON COLUMN sturio.public.sortie_lieu.point_geom IS 'Point géographique, en WGS84';
COMMENT ON COLUMN sturio.public.sortie_lieu.actif IS '1 : point utilisé actuellement
0 : ancien point de lâcher';
COMMENT ON COLUMN sturio.public.sortie_lieu.poisson_statut_id IS 'Statut que prend le poisson après sortie du stock';


ALTER SEQUENCE sturio.public.sortie_lieu_sortie_lieu_id_seq OWNED BY sturio.public.sortie_lieu.sortie_lieu_id;

ALTER TABLE sturio.public.sortie ADD CONSTRAINT evenement_sortie_fk
FOREIGN KEY (evenement_id)
REFERENCES sturio.public.evenement (evenement_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.sortie ADD CONSTRAINT poisson_lacher_fk
FOREIGN KEY (poisson_id)
REFERENCES sturio.public.poisson (poisson_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

insert into poisson_categorie (poisson_categorie_id, poisson_categorie_libelle) values (1, 'adulte');
insert into poisson_categorie (poisson_categorie_id, poisson_categorie_libelle) values (2, 'juvenile');

update poisson set poisson_categorie_id = 1 where poisson_statut_id = 1;
update poisson set poisson_categorie_id = 1, poisson_statut_id = 2 where date_naissance is null and poisson_statut_id = 3;
update poisson set poisson_statut_id = 2 where date_naissance is not null and poisson_statut_id = 3;

update poisson_statut set poisson_statut_libelle = 'vivant' where poisson_statut_id = 1;
update poisson_statut set poisson_statut_libelle = 'mort' where poisson_statut_id = 2;
update poisson_statut set poisson_statut_libelle = 'transféré dans un autre lieu' where poisson_statut_id = 3;


ALTER TABLE sturio.public.poisson ADD CONSTRAINT poisson_categorie_poisson_fk
FOREIGN KEY (poisson_categorie_id)
REFERENCES sturio.public.poisson_categorie (poisson_categorie_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.sortie_lieu ADD CONSTRAINT poisson_statut_sortie_lieu_fk
FOREIGN KEY (poisson_statut_id)
REFERENCES sturio.public.poisson_statut (poisson_statut_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.sortie ADD CONSTRAINT sortie_lieu_sortie_fk
FOREIGN KEY (sortie_lieu_id)
REFERENCES sturio.public.sortie_lieu (sortie_lieu_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
