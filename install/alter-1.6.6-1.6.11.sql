
CREATE SEQUENCE "sturio"."public"."determination_parente_determination_parente_id_seq";

CREATE TABLE "sturio"."public"."determination_parente" (
                "determination_parente_id" INTEGER NOT NULL DEFAULT nextval('"sturio"."public"."determination_parente_determination_parente_id_seq"'),
                "determination_parente_libelle" VARCHAR NOT NULL,
                CONSTRAINT "determination_parente_pk" PRIMARY KEY ("determination_parente_id")
);
COMMENT ON TABLE "sturio"."public"."determination_parente" IS 'Méthodes de détermination de la parentéle d''un poisson
1 : données de reproduction
2 : génétique
3 : non réalisable';


ALTER SEQUENCE "sturio"."public"."determination_parente_determination_parente_id_seq" OWNED BY "sturio"."public"."determination_parente"."determination_parente_id";

CREATE SEQUENCE "sturio"."public"."parente_parente_id_seq";

CREATE TABLE "sturio"."public"."parente" (
                "parente_id" INTEGER NOT NULL DEFAULT nextval('"sturio"."public"."parente_parente_id_seq"'),
                "poisson_id" integer not null,
                "evenement_id" INTEGER NOT NULL,
                "determination_parente_id" INTEGER NOT NULL,
                "parente_date" TIMESTAMP NOT NULL,
                "parente_commentaire" VARCHAR,
                CONSTRAINT "parente_pk" PRIMARY KEY ("parente_id")
);
COMMENT ON TABLE "sturio"."public"."parente" IS 'événement de détermination de la parenté';


ALTER SEQUENCE "sturio"."public"."parente_parente_id_seq" OWNED BY "sturio"."public"."parente"."parente_id";

ALTER TABLE "sturio"."public"."parente" ADD CONSTRAINT "determination_parente_parente_fk"
FOREIGN KEY ("determination_parente_id")
REFERENCES "sturio"."public"."determination_parente" ("determination_parente_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "sturio"."public"."parente" ADD CONSTRAINT "evenement_parente_fk"
FOREIGN KEY ("evenement_id")
REFERENCES "sturio"."public"."evenement" ("evenement_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/*alter table parente add column poisson_id int;*/

ALTER TABLE "sturio"."public"."parente" ADD CONSTRAINT "poisson_parente_fk"
FOREIGN KEY ("poisson_id")
REFERENCES "sturio"."public"."poisson" ("poisson_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

insert into determination_parente (determination_parente_id, determination_parente_libelle)
values
(1, 'Données de reproduction'),
(2, 'Détermination génétique'),
(3, 'non réalisable');

select setval('determination_parente_determination_parente_id_seq', 3);
