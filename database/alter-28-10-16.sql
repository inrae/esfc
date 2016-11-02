

ALTER TABLE "sturio"."public"."sperme" DROP COLUMN "congelation_date";

ALTER TABLE "sturio"."public"."sperme" DROP COLUMN "congelation_volume";

ALTER TABLE "sturio"."public"."sperme" DROP COLUMN "nb_paillette";

ALTER TABLE "sturio"."public"."sperme" DROP COLUMN "numero_canister";

ALTER TABLE "sturio"."public"."sperme" DROP COLUMN "position_canister";

CREATE SEQUENCE "sturio"."public"."sperme_congelation_sperme_congelation_id_seq";

CREATE TABLE "sturio"."public"."sperme_congelation" (
                "sperme_congelation_id" INTEGER NOT NULL DEFAULT nextval('"sturio"."public"."sperme_congelation_sperme_congelation_id_seq"'),
                "sperme_id" INTEGER NOT NULL,
                "sperme_dilueur_id" INTEGER,
                "congelation_date" TIMESTAMP NOT NULL,
                "congelation_volume" REAL,
                "nb_paillette" INTEGER,
                "numero_canister" VARCHAR,
                "position_canister" SMALLINT,
                "nb_visiotube" INTEGER,
                "sperme_congelation_commentaire" VARCHAR,
                CONSTRAINT "sperme_congelation_pk" PRIMARY KEY ("sperme_congelation_id")
);
COMMENT ON TABLE "sturio"."public"."sperme_congelation" IS 'Table des congélations de sperme';
COMMENT ON COLUMN "sturio"."public"."sperme_congelation"."sperme_dilueur_id" IS 'Dilueur de sperme utilisé';
COMMENT ON COLUMN "sturio"."public"."sperme_congelation"."congelation_date" IS 'Date de congélation de la semence';
COMMENT ON COLUMN "sturio"."public"."sperme_congelation"."congelation_volume" IS 'Volume congelé, en ml';
COMMENT ON COLUMN "sturio"."public"."sperme_congelation"."nb_paillette" IS 'Nombre de paillettes préparées';
COMMENT ON COLUMN "sturio"."public"."sperme_congelation"."numero_canister" IS 'Numéro du canister';
COMMENT ON COLUMN "sturio"."public"."sperme_congelation"."position_canister" IS 'Emplacement du canister dans la bouteille
1 : bas
2 : haut';
COMMENT ON COLUMN "sturio"."public"."sperme_congelation"."nb_visiotube" IS 'Nombre de visiotubes utilisés';


ALTER SEQUENCE "sturio"."public"."sperme_congelation_sperme_congelation_id_seq" OWNED BY "sturio"."public"."sperme_congelation"."sperme_congelation_id";

ALTER TABLE "sturio"."public"."sperme_congelation" ADD CONSTRAINT "sperme_sperme_congelation_fk"
FOREIGN KEY ("sperme_id")
REFERENCES "sturio"."public"."sperme" ("sperme_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "sturio"."public"."sperme_congelation" ADD CONSTRAINT "sperme_dilueur_sperme_congelation_fk"
FOREIGN KEY ("sperme_dilueur_id")
REFERENCES "sturio"."public"."sperme_dilueur" ("sperme_dilueur_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

create or replace view v_sperme_congelation_date as (
select sperme_id, array_to_string (array_agg(to_char(congelation_date, 'DD/MM/YYYY') order by congelation_date), ', ') as congelation_dates
from sperme_congelation
group by sperme_id)
;

ALTER TABLE "sturio"."public"."sperme_utilise" ADD COLUMN "sperme_congelation_id" INTEGER;

ALTER TABLE "sturio"."public"."sperme_utilise" ADD CONSTRAINT "sperme_congelation_sperme_utilise_fk"
FOREIGN KEY ("sperme_congelation_id")
REFERENCES "sturio"."public"."sperme_congelation" ("sperme_congelation_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
