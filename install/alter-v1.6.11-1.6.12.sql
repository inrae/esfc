

ALTER TABLE "sturio"."public"."sperme_congelation" ADD COLUMN "nb_paillettes_utilisees" INTEGER;


ALTER TABLE "sturio"."public"."sperme_congelation" ADD COLUMN "sperme_conservateur_id" INTEGER DEFAULT 1;

ALTER TABLE "sturio"."public"."sperme_congelation" ADD COLUMN "volume_conservateur" REAL;

ALTER TABLE "sturio"."public"."sperme_congelation" ADD COLUMN "volume_dilueur" REAL;

ALTER TABLE "sturio"."public"."sperme_congelation" ADD COLUMN "volume_sperme" REAL;

CREATE SEQUENCE "sturio"."public"."sperme_conservateur_sperme_conservateur_id_seq";

CREATE TABLE "sturio"."public"."sperme_conservateur" (
                "sperme_conservateur_id" INTEGER NOT NULL DEFAULT nextval('"sturio"."public"."sperme_conservateur_sperme_conservateur_id_seq"'),
                "sperme_conservateur_libelle" VARCHAR NOT NULL,
                CONSTRAINT "sperme_conservateur_pk" PRIMARY KEY ("sperme_conservateur_id")
);
COMMENT ON TABLE "sturio"."public"."sperme_conservateur" IS 'Table des produits de conservation utilis?s pour la cong?lation des spermes';


ALTER SEQUENCE "sturio"."public"."sperme_conservateur_sperme_conservateur_id_seq" OWNED BY "sturio"."public"."sperme_conservateur"."sperme_conservateur_id";

insert into sperme_conservateur (sperme_conservateur_id, sperme_conservateur_libelle) values 
(1, 'Methanol');

select setval('sperme_conservateur_sperme_conservateur_id_seq', 1);

CREATE SEQUENCE "sturio"."public"."sperme_freezing_measure_sperme_freezing_measure_id_seq";

CREATE TABLE "sturio"."public"."sperme_freezing_measure" (
                "sperme_freezing_measure_id" INTEGER NOT NULL DEFAULT nextval('"sturio"."public"."sperme_freezing_measure_sperme_freezing_measure_id_seq"'),
                "sperme_congelation_id" INTEGER NOT NULL,
                "measure_date" TIMESTAMP NOT NULL,
                "measure_temp" REAL NOT NULL,
                CONSTRAINT "sperme_freezing_measure_pk" PRIMARY KEY ("sperme_freezing_measure_id")
);
COMMENT ON TABLE "sturio"."public"."sperme_freezing_measure" IS 'Table des mesures de vitesse de cong?lation';
COMMENT ON COLUMN "sturio"."public"."sperme_freezing_measure"."measure_date" IS 'Heure exacte de la mesure';
COMMENT ON COLUMN "sturio"."public"."sperme_freezing_measure"."measure_temp" IS 'Mesure de la temp?rature';


ALTER SEQUENCE "sturio"."public"."sperme_freezing_measure_sperme_freezing_measure_id_seq" OWNED BY "sturio"."public"."sperme_freezing_measure"."sperme_freezing_measure_id";

CREATE SEQUENCE "sturio"."public"."sperme_freezing_place_sperme_freezing_place_id_seq";

CREATE TABLE "sturio"."public"."sperme_freezing_place" (
                "sperme_freezing_place_id" INTEGER NOT NULL DEFAULT nextval('"sturio"."public"."sperme_freezing_place_sperme_freezing_place_id_seq"'),
                "sperme_congelation_id" INTEGER NOT NULL,
                "cuve_libelle" VARCHAR,
                "canister_numero" VARCHAR ,
                "position_canister" SMALLINT,
                "nb_visiotube" INTEGER,
                CONSTRAINT "sperme_freezing_place_pk" PRIMARY KEY ("sperme_freezing_place_id")
);
COMMENT ON TABLE "sturio"."public"."sperme_freezing_place" IS 'Emplacement des paillettes';
COMMENT ON COLUMN "sturio"."public"."sperme_freezing_place"."cuve_libelle" IS 'Nom ou code de la cuve';
COMMENT ON COLUMN "sturio"."public"."sperme_freezing_place"."canister_numero" IS 'N¢X du canister';
COMMENT ON COLUMN "sturio"."public"."sperme_freezing_place"."position_canister" IS 'Emplacement du canister dans la bouteille
1 : bas
2 : haut';
COMMENT ON COLUMN "sturio"."public"."sperme_freezing_place"."nb_visiotube" IS 'Nombre de visiotubes utilis?s';


ALTER SEQUENCE "sturio"."public"."sperme_freezing_place_sperme_freezing_place_id_seq" OWNED BY "sturio"."public"."sperme_freezing_place"."sperme_freezing_place_id";


COMMENT ON TABLE "sturio"."public"."sperme_qualite" IS 'Table de notation de la qualit? globale du sperme
1 : mauvaise ? tr?s mauvaise
2 : moyenne
3 : bonne
4 : tr?s bonne';




ALTER TABLE "sturio"."public"."sperme_freezing_measure" ADD CONSTRAINT "sperme_congelation_sperme_freezing_measure_fk"
FOREIGN KEY ("sperme_congelation_id")
REFERENCES "sturio"."public"."sperme_congelation" ("sperme_congelation_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "sturio"."public"."sperme_freezing_place" ADD CONSTRAINT "sperme_congelation_sperme_freezing_place_fk"
FOREIGN KEY ("sperme_congelation_id")
REFERENCES "sturio"."public"."sperme_congelation" ("sperme_congelation_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "sturio"."public"."sperme_congelation" ADD CONSTRAINT "sperme_conservateur_sperme_congelation_fk"
FOREIGN KEY ("sperme_conservateur_id")
REFERENCES "sturio"."public"."sperme_conservateur" ("sperme_conservateur_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/*alter table sperme_freezing_place alter column cuve_libelle drop not null;
alter table sperme_freezing_place alter column canister_numero drop not null;*/

insert into sperme_freezing_place (sperme_congelation_id, cuve_libelle, canister_numero, position_canister, nb_visiotube)
(
select sperme_congelation_id, sperme_congelation_commentaire, numero_canister, position_canister, nb_visiotube from sperme_congelation)
;
alter table sperme_congelation drop column numero_canister;

alter table sperme_congelation drop column position_canister;

update sperme_congelation set sperme_congelation_commentaire = null;

select * from sperme_congelation;
select * from sperme_freezing_place;
