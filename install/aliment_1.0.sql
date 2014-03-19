

ALTER TABLE sturio.public.ration_distribuee DROP CONSTRAINT aliment_ration_distribuee_fk;

ALTER TABLE sturio.public.ration_repart DROP CONSTRAINT aliment_aliment_repartition_part_fk;

ALTER TABLE sturio.public.ration DROP CONSTRAINT aliment_repartition_ration_fk;

ALTER TABLE sturio.public.ration_repart DROP CONSTRAINT aliment_repartition_aliment_repartition_part_fk;

ALTER TABLE sturio.public.ration DROP CONSTRAINT bassin_ration_fk;

ALTER TABLE sturio.public.ration_distribuee DROP CONSTRAINT bassin_ration_distribuee_fk;

ALTER TABLE sturio.public.ration DROP CONSTRAINT bassin_biomasse_ration_fk;

ALTER TABLE ONLY sturio.public.aliment ALTER COLUMN actif TYPE SMALLINT, ALTER COLUMN actif SET NOT NULL;

ALTER TABLE ONLY sturio.public.aliment ALTER COLUMN aliment_libelle TYPE VARCHAR, ALTER COLUMN aliment_libelle SET NOT NULL;

CREATE TABLE sturio.public.aliment_categorie (
                aliment_id INTEGER NOT NULL,
                categorie_id INTEGER NOT NULL,
                CONSTRAINT aliment_categorie_pk PRIMARY KEY (aliment_id, categorie_id)
);
COMMENT ON TABLE sturio.public.aliment_categorie IS 'Caractérisation de l''aliment par rapport à la catégorie de poisson nourri (adulte, juvénile, repro)';

DROP TABLE sturio.public.aliment_repartition;

ALTER TABLE sturio.public.bassin_usage ADD COLUMN categorie_id INTEGER;

CREATE SEQUENCE sturio.public.categorie_categorie_id_seq;

CREATE TABLE sturio.public.categorie (
                categorie_id INTEGER NOT NULL DEFAULT nextval('sturio.public.categorie_categorie_id_seq'),
                categorie_libelle VARCHAR NOT NULL,
                CONSTRAINT categorie_pk PRIMARY KEY (categorie_id)
);
COMMENT ON TABLE sturio.public.categorie IS 'Catégorie ou destination de l''aliment (juvénile, adulte, reproduction...)';
COMMENT ON COLUMN sturio.public.categorie.categorie_libelle IS 'Adulte, juvénile, reproduction...';


ALTER SEQUENCE sturio.public.categorie_categorie_id_seq OWNED BY sturio.public.categorie.categorie_id;

CREATE SEQUENCE sturio.public.distribution_distribution_id_seq;

CREATE TABLE sturio.public.distribution (
                distribution_id INTEGER NOT NULL DEFAULT nextval('sturio.public.distribution_distribution_id_seq'),
                repartition_id INTEGER NOT NULL,
                bassin_id INTEGER NOT NULL,
                taux_nourrissage_precedent REAL,
                reste_precedent REAL,
                evol_taux_nourrissage REAL,
                taux_nourrissage REAL,
                total_distribue REAL,
                ration_commentaire VARCHAR,
                CONSTRAINT distribution_pk PRIMARY KEY (distribution_id)
);
COMMENT ON TABLE sturio.public.distribution IS 'Table de distribution des aliments pour une période donnée';
COMMENT ON COLUMN sturio.public.distribution.taux_nourrissage_precedent IS 'Taux de nourrissage lors de la période précédente';
COMMENT ON COLUMN sturio.public.distribution.reste_precedent IS 'Quantité de nourriture restant à la fin de la période précédente, en grammes';
COMMENT ON COLUMN sturio.public.distribution.evol_taux_nourrissage IS 'Evolution du taux de nourrissage par rapport à la semaine précédente, (pourcentage de la biomasse * 100)';
COMMENT ON COLUMN sturio.public.distribution.taux_nourrissage IS 'Taux quotidien de nourrissage (pourcentage de la biomasse  * 100)';
COMMENT ON COLUMN sturio.public.distribution.total_distribue IS 'Ration totale distribuee, en grammes';


ALTER SEQUENCE sturio.public.distribution_distribution_id_seq OWNED BY sturio.public.distribution.distribution_id;

ALTER TABLE sturio.public.parent_poisson DROP CONSTRAINT parent_pk;

ALTER TABLE sturio.public.parent_poisson ADD PRIMARY KEY (parent_poisson_id);

DROP TABLE sturio.public.ration;

DROP TABLE sturio.public.ration_distribuee;

DROP TABLE sturio.public.ration_repart;

CREATE SEQUENCE sturio.public.repart_aliment_repart_aliment_id;

CREATE TABLE sturio.public.repart_aliment (
                repart_aliment_id INTEGER NOT NULL DEFAULT nextval('sturio.public.repart_aliment_repart_aliment_id'),
                repart_template_id INTEGER NOT NULL,
                aliment_id INTEGER NOT NULL,
                repart_alim_taux REAL,
                distribution VARCHAR,
                distribution_semaine VARCHAR DEFAULT '1,1,1,1,1,1,1' NOT NULL,
                consigne VARCHAR,
                CONSTRAINT repart_aliment_pk PRIMARY KEY (repart_aliment_id)
);
COMMENT ON TABLE sturio.public.repart_aliment IS 'Taux de repartition des aliments pour la repartition consideree';
COMMENT ON COLUMN sturio.public.repart_aliment.distribution IS 'Répartition quotidienne :
en pourcentage, séparé par une virgule
exemple : 25,25,50';
COMMENT ON COLUMN sturio.public.repart_aliment.distribution_semaine IS 'Jours de distribution : 1,1,1,1,1,1,1
La première valeur correspond au lundi, 0 : pas de distribution';
COMMENT ON COLUMN sturio.public.repart_aliment.consigne IS 'Consignes lors de la distribution';


ALTER SEQUENCE sturio.public.repart_aliment_repart_aliment_id OWNED BY sturio.public.repart_aliment.repart_aliment_id;

CREATE SEQUENCE sturio.public.repart_template_repart_template_id_seq;

CREATE TABLE sturio.public.repart_template (
                repart_template_id INTEGER NOT NULL DEFAULT nextval('sturio.public.repart_template_repart_template_id_seq'),
                categorie_id INTEGER NOT NULL,
                repart_template_libelle VARCHAR,
                repart_template_date DATE NOT NULL,
                actif SMALLINT DEFAULT 1 NOT NULL,
                CONSTRAINT repart_template_pk PRIMARY KEY (repart_template_id)
);
COMMENT ON TABLE sturio.public.repart_template IS 'Modèles de répartition des aliments';
COMMENT ON COLUMN sturio.public.repart_template.repart_template_libelle IS 'Nom de la répartition';
COMMENT ON COLUMN sturio.public.repart_template.repart_template_date IS 'Date de création';
COMMENT ON COLUMN sturio.public.repart_template.actif IS '0 : non actif, 1 : actif';


ALTER SEQUENCE sturio.public.repart_template_repart_template_id_seq OWNED BY sturio.public.repart_template.repart_template_id;

CREATE SEQUENCE sturio.public.repartition_repartition_id_seq;

CREATE TABLE sturio.public.repartition (
                repartition_id INTEGER NOT NULL DEFAULT nextval('sturio.public.repartition_repartition_id_seq'),
                categorie_id INTEGER NOT NULL,
                date_debut_periode DATE NOT NULL,
                date_fin_periode DATE NOT NULL,
                CONSTRAINT repartition_pk PRIMARY KEY (repartition_id)
);
COMMENT ON TABLE sturio.public.repartition IS 'Tableau hebdomadaire (ou autre) de répartition des aliments';
COMMENT ON COLUMN sturio.public.repartition.date_debut_periode IS 'Date de début de la répartition';
COMMENT ON COLUMN sturio.public.repartition.date_fin_periode IS 'Date de fin d''action du tableau de répartition';

ALTER SEQUENCE sturio.public.repartition_repartition_id_seq OWNED BY sturio.public.repartition.repartition_id;

ALTER TABLE sturio.public.aliment_categorie ADD CONSTRAINT aliment_aliment_categorie_fk
FOREIGN KEY (aliment_id)
REFERENCES sturio.public.aliment (aliment_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.repart_aliment ADD CONSTRAINT aliment_aliment_repartition_part_fk
FOREIGN KEY (aliment_id)
REFERENCES sturio.public.aliment (aliment_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.distribution ADD CONSTRAINT bassin_distribution_fk
FOREIGN KEY (bassin_id)
REFERENCES sturio.public.bassin (bassin_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.aliment_categorie ADD CONSTRAINT categorie_aliment_categorie_fk
FOREIGN KEY (categorie_id)
REFERENCES sturio.public.categorie (categorie_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.bassin_usage ADD CONSTRAINT aliment_categorie_bassin_usage_fk
FOREIGN KEY (categorie_id)
REFERENCES sturio.public.categorie (categorie_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.repart_template ADD CONSTRAINT categorie_repart_template_fk
FOREIGN KEY (categorie_id)
REFERENCES sturio.public.categorie (categorie_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.repartition ADD CONSTRAINT categorie_repartition_fk
FOREIGN KEY (categorie_id)
REFERENCES sturio.public.categorie (categorie_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.repart_aliment ADD CONSTRAINT repart_template_repart_aliment_fk
FOREIGN KEY (repart_template_id)
REFERENCES sturio.public.repart_template (repart_template_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.distribution ADD CONSTRAINT repartition_distribution_fk
FOREIGN KEY (repartition_id)
REFERENCES sturio.public.repartition (repartition_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
