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
