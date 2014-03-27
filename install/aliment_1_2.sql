

ALTER TABLE sturio.public.bassin_biomasse DROP CONSTRAINT bassin_bassin_biomasse_fk;

CREATE SEQUENCE sturio.public.aliment_quotidien_aliment_quotidien_id_seq;

CREATE TABLE sturio.public.aliment_quotidien (
                aliment_quotidien_id INTEGER NOT NULL DEFAULT nextval('sturio.public.aliment_quotidien_aliment_quotidien_id_seq'),
                aliment_id INTEGER NOT NULL,
                quantite REAL,
                distrib_quotidien_id INTEGER NOT NULL,
                CONSTRAINT aliment_quotidien_pk PRIMARY KEY (aliment_quotidien_id)
);
COMMENT ON TABLE sturio.public.aliment_quotidien IS 'Table des répartitions quotidiennes d''aliments';
COMMENT ON COLUMN sturio.public.aliment_quotidien.quantite IS 'Quantité quotidienne distribuée, en grammes';


ALTER SEQUENCE sturio.public.aliment_quotidien_aliment_quotidien_id_seq OWNED BY sturio.public.aliment_quotidien.aliment_quotidien_id;


DROP TABLE sturio.public.bassin_biomasse;


CREATE SEQUENCE sturio.public.distrib_quotidien_distrib_quotidien_id_seq;

CREATE TABLE sturio.public.distrib_quotidien (
                distrib_quotidien_id INTEGER NOT NULL DEFAULT nextval('sturio.public.distrib_quotidien_distrib_quotidien_id_seq'),
                bassin_id INTEGER NOT NULL,
                distrib_quotidien_date DATE NOT NULL,
                total_distribue REAL,
                reste REAL,
                CONSTRAINT distrib_quotidien_pk PRIMARY KEY (distrib_quotidien_id)
);
COMMENT ON TABLE sturio.public.distrib_quotidien IS 'Table générale récapitulant les distributions quotidiennes';
COMMENT ON COLUMN sturio.public.distrib_quotidien.total_distribue IS 'Quantité totale distribuée, en grammes';
COMMENT ON COLUMN sturio.public.distrib_quotidien.reste IS 'Reste estimé, en grammes';


ALTER SEQUENCE sturio.public.distrib_quotidien_distrib_quotidien_id_seq OWNED BY sturio.public.distrib_quotidien.distrib_quotidien_id;


COMMENT ON COLUMN sturio.public.repart_aliment.matin IS 'Taux de répartition le matin';

COMMENT ON COLUMN sturio.public.repart_aliment.midi IS 'Taux de répartition le midi';

COMMENT ON COLUMN sturio.public.repart_aliment.nuit IS 'Taux de répartition la nuit';


COMMENT ON COLUMN sturio.public.repart_aliment.soir IS 'Taux de répartition le soir';


ALTER TABLE sturio.public.aliment_quotidien ADD CONSTRAINT aliment_bassin_aliment_fk
FOREIGN KEY (aliment_id)
REFERENCES sturio.public.aliment (aliment_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.distrib_quotidien ADD CONSTRAINT bassin_distrib_quotidien_fk
FOREIGN KEY (bassin_id)
REFERENCES sturio.public.bassin (bassin_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.aliment_quotidien ADD CONSTRAINT distrib_quotidien_aliment_quotidien_fk
FOREIGN KEY (distrib_quotidien_id)
REFERENCES sturio.public.distrib_quotidien (distrib_quotidien_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.distribution ADD COLUMN reste_precedent_zone_calcul VARCHAR;
comment on column distribution.reste_precedent_zone_calcul is 'Zone permettant de saisir les différents restes quotidiens, pour totalisation.
Accepte uniquement des chiffres et le signe +';
