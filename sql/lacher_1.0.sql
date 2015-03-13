create extension postgis;
CREATE SEQUENCE sturio.public.lacher_lacher_id_seq;

CREATE TABLE sturio.public.lacher (
                lacher_id INTEGER NOT NULL DEFAULT nextval('sturio.public.lacher_lacher_id_seq'),
                poisson_id INTEGER NOT NULL,
                evenement_id INTEGER,
                lacher_lieu_id INTEGER,
                lacher_date DATE,
                CONSTRAINT lacher_pk PRIMARY KEY (lacher_id)
);
COMMENT ON TABLE sturio.public.lacher IS 'Table des lâchers';
COMMENT ON COLUMN sturio.public.lacher.lacher_date IS 'Date du lâcher';


ALTER SEQUENCE sturio.public.lacher_lacher_id_seq OWNED BY sturio.public.lacher.lacher_id;

CREATE SEQUENCE sturio.public.lacher_lieu_lacher_lieu_id_seq;

CREATE TABLE sturio.public.lacher_lieu (
                lacher_lieu_id INTEGER NOT NULL DEFAULT nextval('sturio.public.lacher_lieu_lacher_lieu_id_seq'),
                localisation VARCHAR NOT NULL,
                longitude_dd DOUBLE PRECISION,
                latitude_dd DOUBLE PRECISION,
           
                actif SMALLINT DEFAULT 1 NOT NULL,
                CONSTRAINT lacher_lieu_pk PRIMARY KEY (lacher_lieu_id)
);
select addGeometryColumn('public','lacher_lieu','point_geom',4326, 'POINT',2);
COMMENT ON TABLE sturio.public.lacher_lieu IS 'Lieux des lâchers de poissons';
COMMENT ON COLUMN sturio.public.lacher_lieu.localisation IS 'information textuelle sur le lieu de lacher';
COMMENT ON COLUMN sturio.public.lacher_lieu.longitude_dd IS 'Longitude du point de lâcher, en valeur décimale';
COMMENT ON COLUMN sturio.public.lacher_lieu.latitude_dd IS 'Latitude du point de lâcher, en décimal';
COMMENT ON COLUMN sturio.public.lacher_lieu.point_geom IS 'Point géographique, en WGS84';
COMMENT ON COLUMN sturio.public.lacher_lieu.actif IS '1 : point utilisé actuellement
0 : ancien point de lâcher';


ALTER SEQUENCE sturio.public.lacher_lieu_lacher_lieu_id_seq OWNED BY sturio.public.lacher_lieu.lacher_lieu_id;
COMMENT ON TABLE sturio.public.mime_type IS 'Table des types mime, pour les documents associés';


ALTER TABLE sturio.public.lacher ADD CONSTRAINT evenement_lacher_fk
FOREIGN KEY (evenement_id)
REFERENCES sturio.public.evenement (evenement_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.lacher ADD CONSTRAINT lacher_lieu_lacher_fk
FOREIGN KEY (lacher_lieu_id)
REFERENCES sturio.public.lacher_lieu (lacher_lieu_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.lacher ADD CONSTRAINT poisson_lacher_fk
FOREIGN KEY (poisson_id)
REFERENCES sturio.public.poisson (poisson_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

alter table lacher add column lacher_commentaire varchar ;
comment on column lacher.lacher_commentaire is 'Commentaire sur le lâcher';
