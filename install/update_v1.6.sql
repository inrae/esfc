alter table repartition add column repartition_name varchar;
comment on column repartition.repartition_name is 'Libellé permettant de nommer la répartition';

alter table sperme add column sperme_ph float;
comment on column sperme.sperme_ph is 'Valeur mesurée du pH du sperme';

CREATE SEQUENCE "sturio"."public"."anesthesie_anesthesie_id_seq";

CREATE TABLE "sturio"."public"."anesthesie" (
                "anesthesie_id" INTEGER NOT NULL DEFAULT nextval('"sturio"."public"."anesthesie_anesthesie_id_seq"'),
                "poisson_id" INTEGER NOT NULL,
                "evenement_id" INTEGER NOT NULL,
                "anesthesie_produit_id" INTEGER NOT NULL,
                "anesthesie_commentaire" VARCHAR,
                CONSTRAINT "anesthesie_pk" PRIMARY KEY ("anesthesie_id")
);
COMMENT ON TABLE "sturio"."public"."anesthesie" IS 'Tables des anesthésies pratiquées';

alter table anesthesie add column anesthesie_date timestamp not null;
comment on column anesthesie.anesthesie_date is 'Date de l''anesthésie';

alter table anesthesie add column anesthesie_dosage float;
comment on column anesthesie.anesthesie_dosage is 'Dosage du produit, en mg/l';

ALTER SEQUENCE "sturio"."public"."anesthesie_anesthesie_id_seq" OWNED BY "sturio"."public"."anesthesie"."anesthesie_id";

CREATE SEQUENCE "sturio"."public"."anesthesie_produit_anesthesie_produit_id_seq";

CREATE TABLE "sturio"."public"."anesthesie_produit" (
                "anesthesie_produit_id" INTEGER NOT NULL DEFAULT nextval('"sturio"."public"."anesthesie_produit_anesthesie_produit_id_seq"'),
                "anesthesie_produit_libelle" VARCHAR NOT NULL,
                "anesthesie_produit_actif" SMALLINT DEFAULT 1 NOT NULL,
                CONSTRAINT "anesthesie_produit_pk" PRIMARY KEY ("anesthesie_produit_id")
);
COMMENT ON TABLE "sturio"."public"."anesthesie_produit" IS 'Tables des produits utilisés pour l''anesthésie';
COMMENT ON COLUMN "sturio"."public"."anesthesie_produit"."anesthesie_produit_actif" IS 'Le produit est utilisé : 1';

ALTER TABLE "sturio"."public"."anesthesie" ADD CONSTRAINT "anesthesie_produit_anesthesie_fk"
FOREIGN KEY ("anesthesie_produit_id")
REFERENCES "sturio"."public"."anesthesie_produit" ("anesthesie_produit_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "sturio"."public"."anesthesie" ADD CONSTRAINT "evenement_anesthesie_fk"
FOREIGN KEY ("evenement_id")
REFERENCES "sturio"."public"."evenement" ("evenement_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "sturio"."public"."anesthesie" ADD CONSTRAINT "poisson_anesthesie_fk"
FOREIGN KEY ("poisson_id")
REFERENCES "sturio"."public"."poisson" ("poisson_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER SEQUENCE "sturio"."public"."anesthesie_produit_anesthesie_produit_id_seq" OWNED BY "sturio"."public"."anesthesie_produit"."anesthesie_produit_id";

CREATE SEQUENCE "sturio"."public"."ventilation_ventilation_id_seq";

CREATE TABLE "sturio"."public"."ventilation" (
                "ventilation_id" INTEGER NOT NULL DEFAULT nextval('"sturio"."public"."ventilation_ventilation_id_seq"'),
                "poisson_id" INTEGER NOT NULL,
                "ventilation_date" TIMESTAMP NOT NULL,
                "battement_nb" SMALLINT NOT NULL,
                CONSTRAINT "ventilation_pk" PRIMARY KEY ("ventilation_id")
);
alter table ventilation add column ventilation_commentaire varchar;
COMMENT ON TABLE "sturio"."public"."ventilation" IS 'Table des relevés de ventilation pour un poissons (nombre de battements par minute)';
COMMENT ON COLUMN "sturio"."public"."ventilation"."ventilation_date" IS 'Date/heure précise de la mesure';
COMMENT ON COLUMN "sturio"."public"."ventilation"."battement_nb" IS 'Nombre de battements/minute';


ALTER SEQUENCE "sturio"."public"."ventilation_ventilation_id_seq" OWNED BY "sturio"."public"."ventilation"."ventilation_id";

alter table document add column document_date_creation timestamp;
comment on column document.document_date_creation is 'Date de création du document (date de prise de vue de la photo)';

CREATE SEQUENCE "sturio"."public"."circuit_evenement_circuit_evenement_id_seq";

CREATE TABLE "sturio"."public"."circuit_evenement" (
                "circuit_evenement_id" INTEGER NOT NULL DEFAULT nextval('"sturio"."public"."circuit_evenement_circuit_evenement_id_seq"'),
                "circuit_eau_id" INTEGER NOT NULL,
                "circuit_evenement_type_id" INTEGER NOT NULL,
                "circuit_evenement_date" TIMESTAMP NOT NULL,
                "circuit_evenement_commentaire" VARCHAR,
                CONSTRAINT "circuit_evenement_pk" PRIMARY KEY ("circuit_evenement_id")
);
COMMENT ON TABLE "sturio"."public"."circuit_evenement" IS 'Table des événements sur les circuits d''eau';


ALTER SEQUENCE "sturio"."public"."circuit_evenement_circuit_evenement_id_seq" OWNED BY "sturio"."public"."circuit_evenement"."circuit_evenement_id";

CREATE SEQUENCE "sturio"."public"."circuit_evenement_type_circuit_evenement_type_id_seq";

CREATE TABLE "sturio"."public"."circuit_evenement_type" (
                "circuit_evenement_type_id" INTEGER NOT NULL DEFAULT nextval('"sturio"."public"."circuit_evenement_type_circuit_evenement_type_id_seq"'),
                "circuit_evenement_type_libelle" VARCHAR NOT NULL,
                CONSTRAINT "circuit_evenement_type_pk" PRIMARY KEY ("circuit_evenement_type_id")
);
COMMENT ON TABLE "sturio"."public"."circuit_evenement_type" IS 'Table des types d''événement pour les circuits d''eau';


ALTER SEQUENCE "sturio"."public"."circuit_evenement_type_circuit_evenement_type_id_seq" OWNED BY "sturio"."public"."circuit_evenement_type"."circuit_evenement_type_id";

ALTER TABLE "sturio"."public"."circuit_evenement" ADD CONSTRAINT "circuit_eau_circuit_evenement_fk"
FOREIGN KEY ("circuit_eau_id")
REFERENCES "sturio"."public"."circuit_eau" ("circuit_eau_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "sturio"."public"."circuit_evenement" ADD CONSTRAINT "circuit_evenement_type_circuit_evenement_fk"
FOREIGN KEY ("circuit_evenement_type_id")
REFERENCES "sturio"."public"."circuit_evenement_type" ("circuit_evenement_type_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "sturio"."public"."ventilation" ADD CONSTRAINT "poisson_ventilation_fk"
FOREIGN KEY ("poisson_id")
REFERENCES "sturio"."public"."poisson" ("poisson_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

insert into circuit_evenement_type (circuit_evenement_type_libelle) values ('Autres');

comment on column lot.nb_larve_initial is 'Nombre de larves estimées';

/*
 * Modifications liees a l'evolution des tables sperme
 */

ALTER TABLE "sturio"."public"."sperme" DROP CONSTRAINT "sperme_qualite_sperme_fk";

COMMENT ON COLUMN "sturio"."public"."evenement"."evenement_commentaire" IS 'Commentaire général de l''événement';
COMMENT ON COLUMN "sturio"."public"."lot"."nb_larve_initial" IS 'Nombre de larves estimées';

COMMENT ON TABLE "sturio"."public"."mime_type" IS 'Table des types mime, pour les documents associés';

COMMENT ON COLUMN "sturio"."public"."repartition"."densite_artemia" IS 'Densité d''artémia au millilitre';

COMMENT ON TABLE "sturio"."public"."salinite" IS 'Table des salinités d''un bassin';


ALTER TABLE "sturio"."public"."sperme" ADD COLUMN "congelation_date" TIMESTAMP;

ALTER TABLE "sturio"."public"."sperme" ADD COLUMN "congelation_volume" REAL;

ALTER TABLE "sturio"."public"."sperme" DROP COLUMN "motilite_60";

ALTER TABLE "sturio"."public"."sperme" DROP COLUMN "motilite_initiale";

ALTER TABLE "sturio"."public"."sperme" ADD COLUMN "nb_paillette" INTEGER;

ALTER TABLE "sturio"."public"."sperme" ADD COLUMN "numero_canister" VARCHAR;

ALTER TABLE "sturio"."public"."sperme" ADD COLUMN "position_canister" SMALLINT;

ALTER TABLE "sturio"."public"."sperme" ADD COLUMN "sperme_aspect_id" INTEGER ;

ALTER TABLE "sturio"."public"."sperme" ADD COLUMN "sperme_dilueur_id" INTEGER;

ALTER TABLE "sturio"."public"."sperme" DROP COLUMN "sperme_ph";

ALTER TABLE "sturio"."public"."sperme" DROP COLUMN "sperme_qualite_id";

ALTER TABLE "sturio"."public"."sperme" ADD COLUMN "sperme_volume" REAL;

ALTER TABLE "sturio"."public"."sperme" DROP COLUMN "temps_survie";

ALTER TABLE "sturio"."public"."sperme" DROP COLUMN "tx_survie_60";

ALTER TABLE "sturio"."public"."sperme" DROP COLUMN "tx_survie_initial";

CREATE SEQUENCE "sturio"."public"."sperme_aspect_sperme_aspect_id_seq";

CREATE TABLE "sturio"."public"."sperme_aspect" (
                "sperme_aspect_id" INTEGER NOT NULL DEFAULT nextval('"sturio"."public"."sperme_aspect_sperme_aspect_id_seq"'),
                "sperme_aspect_libelle" VARCHAR NOT NULL,
                CONSTRAINT "sperme_aspect_pk" PRIMARY KEY ("sperme_aspect_id")
);
COMMENT ON TABLE "sturio"."public"."sperme_aspect" IS 'Aspect visuel du sperme';


ALTER SEQUENCE "sturio"."public"."sperme_aspect_sperme_aspect_id_seq" OWNED BY "sturio"."public"."sperme_aspect"."sperme_aspect_id";

CREATE TABLE "sturio"."public"."sperme_caract" (
                "sperme_id" INTEGER NOT NULL,
                "sperme_caracteristique_id" INTEGER NOT NULL,
                CONSTRAINT "sperme_caract_pk" PRIMARY KEY ("sperme_id", "sperme_caracteristique_id")
);
COMMENT ON TABLE "sturio"."public"."sperme_caract" IS 'Table de relation entre sperme et sperme_caracteristique';


CREATE SEQUENCE "sturio"."public"."sperme_caracteristique_sperme_caracteristique_id_seq";

CREATE TABLE "sturio"."public"."sperme_caracteristique" (
                "sperme_caracteristique_id" INTEGER NOT NULL DEFAULT nextval('"sturio"."public"."sperme_caracteristique_sperme_caracteristique_id_seq"'),
                "sperme_caracteristique_libelle" VARCHAR NOT NULL,
                CONSTRAINT "sperme_caracteristique_pk" PRIMARY KEY ("sperme_caracteristique_id")
);
COMMENT ON TABLE "sturio"."public"."sperme_caracteristique" IS 'Table des caractéristiques complémentaires du sperme';


ALTER SEQUENCE "sturio"."public"."sperme_caracteristique_sperme_caracteristique_id_seq" OWNED BY "sturio"."public"."sperme_caracteristique"."sperme_caracteristique_id";

CREATE SEQUENCE "sturio"."public"."sperme_dilueur_sperme_dilueur_id_seq";

CREATE TABLE "sturio"."public"."sperme_dilueur" (
                "sperme_dilueur_id" INTEGER NOT NULL DEFAULT nextval('"sturio"."public"."sperme_dilueur_sperme_dilueur_id_seq"'),
                "sperme_dilueur_libelle" VARCHAR NOT NULL,
                CONSTRAINT "sperme_dilueur_pk" PRIMARY KEY ("sperme_dilueur_id")
);
COMMENT ON TABLE "sturio"."public"."sperme_dilueur" IS 'Produit dilueur utilisé pour la congélation du sperme';


ALTER SEQUENCE "sturio"."public"."sperme_dilueur_sperme_dilueur_id_seq" OWNED BY "sturio"."public"."sperme_dilueur"."sperme_dilueur_id";

CREATE SEQUENCE "sturio"."public"."sperme_mesure_sperme_mesure_id_seq";

CREATE TABLE "sturio"."public"."sperme_mesure" (
                "sperme_mesure_id" INTEGER NOT NULL DEFAULT nextval('"sturio"."public"."sperme_mesure_sperme_mesure_id_seq"'),
                "sperme_id" INTEGER NOT NULL,
                "sperme_qualite_id" INTEGER NOT NULL,
                "sperme_mesure_date" TIMESTAMP NOT NULL,
                "motilite_initiale" REAL,
                "tx_survie_initial" REAL,
                "motilite_60" REAL,
                "tx_survie_60" REAL,
                "temps_survie" INTEGER,
                "sperme_ph" REAL,
                "nb_paillette" INTEGER,
                CONSTRAINT "sperme_mesure_pk" PRIMARY KEY ("sperme_mesure_id")
);
COMMENT ON TABLE "sturio"."public"."sperme_mesure" IS 'Table des mesures de qualité du sperme';
COMMENT ON COLUMN "sturio"."public"."sperme_mesure"."sperme_mesure_date" IS 'Date/heure de la réalisation de la mesure';
COMMENT ON COLUMN "sturio"."public"."sperme_mesure"."motilite_initiale" IS 'Motilité initiale, notée de 0 à 5';
COMMENT ON COLUMN "sturio"."public"."sperme_mesure"."tx_survie_initial" IS 'Taux de survie initial, en pourcentage';
COMMENT ON COLUMN "sturio"."public"."sperme_mesure"."motilite_60" IS 'Motilité à 60 secondes, notée de 0 à 5';
COMMENT ON COLUMN "sturio"."public"."sperme_mesure"."tx_survie_60" IS 'Taux de survie à 60 secondes, en pourcentage';
COMMENT ON COLUMN "sturio"."public"."sperme_mesure"."temps_survie" IS 'Temps nécessaire pour atteindre 5% de survie, en secondes';
COMMENT ON COLUMN "sturio"."public"."sperme_mesure"."sperme_ph" IS 'Valeur mesurée du pH du sperme';
COMMENT ON COLUMN "sturio"."public"."sperme_mesure"."nb_paillette" IS 'Nombre de paillettes utilisées pour réaliser l''analyse';


ALTER SEQUENCE "sturio"."public"."sperme_mesure_sperme_mesure_id_seq" OWNED BY "sturio"."public"."sperme_mesure"."sperme_mesure_id";
COMMENT ON TABLE "sturio"."public"."sperme_qualite" IS 'Table de notation de la qualité globale du sperme
1 : mauvaise à très mauvaise
2 : moyenne
3 : bonne
4 : très bonne';

CREATE SEQUENCE "sturio"."public"."sperme_utilise_sperme_utilise_id_seq";

CREATE TABLE "sturio"."public"."sperme_utilise" (
                "sperme_utilise_id" INTEGER NOT NULL DEFAULT nextval('"sturio"."public"."sperme_utilise_sperme_utilise_id_seq"'),
                "croisement_id" INTEGER NOT NULL,
                "sperme_id" INTEGER NOT NULL,
                "volume_utilise" REAL,
                "nb_paillette" INTEGER,
                CONSTRAINT "sperme_utilise_pk" PRIMARY KEY ("sperme_utilise_id")
);
COMMENT ON TABLE "sturio"."public"."sperme_utilise" IS 'Description détaillée du sperme utilisé dans un croisement';
COMMENT ON COLUMN "sturio"."public"."sperme_utilise"."volume_utilise" IS 'Volume utilisé, en ml';
COMMENT ON COLUMN "sturio"."public"."sperme_utilise"."nb_paillette" IS 'Nombre de paillettes utilisées (congélation)';


ALTER SEQUENCE "sturio"."public"."sperme_utilise_sperme_utilise_id_seq" OWNED BY "sturio"."public"."sperme_utilise"."sperme_utilise_id";


ALTER TABLE "sturio"."public"."sperme_utilise" ADD CONSTRAINT "croisement_sperme_utilise_fk"
FOREIGN KEY ("croisement_id")
REFERENCES "sturio"."public"."croisement" ("croisement_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "sturio"."public"."sperme_caract" ADD CONSTRAINT "sperme_sperme_caract_fk"
FOREIGN KEY ("sperme_id")
REFERENCES "sturio"."public"."sperme" ("sperme_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "sturio"."public"."sperme_mesure" ADD CONSTRAINT "sperme_sperme_mesure_fk"
FOREIGN KEY ("sperme_id")
REFERENCES "sturio"."public"."sperme" ("sperme_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "sturio"."public"."sperme_utilise" ADD CONSTRAINT "sperme_sperme_utilise_fk"
FOREIGN KEY ("sperme_id")
REFERENCES "sturio"."public"."sperme" ("sperme_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "sturio"."public"."sperme" ADD CONSTRAINT "sperme_aspect_sperme_fk"
FOREIGN KEY ("sperme_aspect_id")
REFERENCES "sturio"."public"."sperme_aspect" ("sperme_aspect_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "sturio"."public"."sperme_caract" ADD CONSTRAINT "sperme_caracteristique_sperme_caract_fk"
FOREIGN KEY ("sperme_caracteristique_id")
REFERENCES "sturio"."public"."sperme_caracteristique" ("sperme_caracteristique_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "sturio"."public"."sperme" ADD CONSTRAINT "sperme_dilueur_sperme_fk"
FOREIGN KEY ("sperme_dilueur_id")
REFERENCES "sturio"."public"."sperme_dilueur" ("sperme_dilueur_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "sturio"."public"."sperme_mesure" ADD CONSTRAINT "sperme_qualite_sperme_mesure_fk"
FOREIGN KEY ("sperme_qualite_id")
REFERENCES "sturio"."public"."sperme_qualite" ("sperme_qualite_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

insert into sperme_caracteristique (sperme_caracteristique_libelle) 
values
('jaunâtre'),
('tâches de sang');

insert into sperme_aspect (sperme_aspect_id, sperme_aspect_libelle) 
values
(1, 'très clair'),
(2, 'clair'),
(3, 'concentré'),
(4, 'très concentré');
select setval('sperme_aspect_sperme_aspect_id_seq', (select max(sperme_aspect_id) from sperme_aspect));

alter table sperme_mesure alter column sperme_qualite_id drop not null;
alter table sperme_mesure rename column nb_paillette to nb_paillette_utilise;
alter table sperme_utilise rename column nb_paillette to nb_paillette_croisement;
