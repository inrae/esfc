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
