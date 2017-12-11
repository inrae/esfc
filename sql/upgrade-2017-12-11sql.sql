CREATE SEQUENCE "sturio"."public"."requete_requete_id_seq";

CREATE TABLE "sturio"."public"."requete" (
                "requete_id" INTEGER NOT NULL DEFAULT nextval('"sturio"."public"."requete_requete_id_seq"'),
                "creation_date" TIMESTAMP NOT NULL,
                "last_exec" TIMESTAMP,
                "title" VARCHAR NOT NULL,
                "body" VARCHAR NOT NULL,
                "login" VARCHAR NOT NULL,
                CONSTRAINT "requete_pk" PRIMARY KEY ("requete_id")
);
alter table requete add column datefields varchar;
COMMENT ON TABLE "sturio"."public"."requete" IS 'Table des requêtes dans la base de données';
COMMENT ON COLUMN "sturio"."public"."requete"."creation_date" IS 'Date de création de la requête';
COMMENT ON COLUMN "sturio"."public"."requete"."last_exec" IS 'Date de dernière exécution';
COMMENT ON COLUMN "sturio"."public"."requete"."title" IS 'Titre de la requête';
COMMENT ON COLUMN "sturio"."public"."requete"."body" IS 'Corps de la requête. Ne pas indiquer SELECT, qui sera rajouté automatiquement.';
COMMENT ON COLUMN "sturio"."public"."requete"."login" IS 'Login du créateur de la requête';
COMMENT ON COLUMN "sturio"."public"."requete"."datefields" IS 'Liste des champs de type date utilisés dans la requête, séparés par une virgule, pour formatage en sortie';

ALTER SEQUENCE "sturio"."public"."requete_requete_id_seq" OWNED BY "sturio"."public"."requete"."requete_id";
