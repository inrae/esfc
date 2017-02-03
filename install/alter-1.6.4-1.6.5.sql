
ALTER TABLE "sturio"."public"."echographie" ADD COLUMN "stade_gonade_id" INTEGER;

ALTER TABLE "sturio"."public"."echographie" ADD COLUMN "stade_oeuf_id" INTEGER;

CREATE SEQUENCE "sturio"."public"."stade_gonade_stade_gonade_id_seq";

CREATE TABLE "sturio"."public"."stade_gonade" (
                "stade_gonade_id" INTEGER NOT NULL DEFAULT nextval('"sturio"."public"."stade_gonade_stade_gonade_id_seq"'),
                "stade_gonade_libelle" VARCHAR NOT NULL,
                CONSTRAINT "stade_gonade_pk" PRIMARY KEY ("stade_gonade_id")
);
COMMENT ON TABLE "sturio"."public"."stade_gonade" IS 'Table des stades de gonades';


ALTER SEQUENCE "sturio"."public"."stade_gonade_stade_gonade_id_seq" OWNED BY "sturio"."public"."stade_gonade"."stade_gonade_id";

CREATE SEQUENCE "sturio"."public"."stade_oeuf_stade_oeuf_id_seq";

CREATE TABLE "sturio"."public"."stade_oeuf" (
                "stade_oeuf_id" INTEGER NOT NULL DEFAULT nextval('"sturio"."public"."stade_oeuf_stade_oeuf_id_seq"'),
                "stade_oeuf_libelle" VARCHAR NOT NULL,
                CONSTRAINT "stade_oeuf_pk" PRIMARY KEY ("stade_oeuf_id")
);
COMMENT ON TABLE "sturio"."public"."stade_oeuf" IS 'Table des stades de maturation des oeufs';


ALTER SEQUENCE "sturio"."public"."stade_oeuf_stade_oeuf_id_seq" OWNED BY "sturio"."public"."stade_oeuf"."stade_oeuf_id";

ALTER TABLE "sturio"."public"."echographie" ADD CONSTRAINT "stade_gonade_echographie_fk"
FOREIGN KEY ("stade_gonade_id")
REFERENCES "sturio"."public"."stade_gonade" ("stade_gonade_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "sturio"."public"."echographie" ADD CONSTRAINT "stade_oeuf_echographie_fk"
FOREIGN KEY ("stade_oeuf_id")
REFERENCES "sturio"."public"."stade_oeuf" ("stade_oeuf_id")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
