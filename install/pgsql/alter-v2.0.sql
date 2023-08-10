/**
 * Script of upgrade to ESFC v2.0
 */

alter table gacl.logingestion add column nbattempts smallint DEFAULT 0,
	add column lastattempt timestamp;
COMMENT ON COLUMN gacl.logingestion.nbattempts IS E'Number of connection attemps';
-- ddl-end --
COMMENT ON COLUMN gacl.logingestion.lastattempt IS E'last attemp of connection';

alter table gacl.acllogin add column totp_key varchar;
COMMENT ON COLUMN gacl.acllogin.totp_key IS E'TOTP secret key for the user';

alter TABLE gacl.log add column ipaddress character varying;

CREATE TABLE "dbparam" (
                "dbparam_id" serial NOT NULL,
                "dbparam_name" VARCHAR NOT NULL,
                "dbparam_value" VARCHAR,
                CONSTRAINT "dbparam_pk" PRIMARY KEY ("dbparam_id")
);
COMMENT ON TABLE "dbparam" IS 'Table of parameters used by the instance';
COMMENT ON COLUMN "dbparam"."dbparam_name" IS 'Parameter name';
COMMENT ON COLUMN "dbparam"."dbparam_value" IS 'Parameter value';

insert into public.dbparam (dbparam_name, dbparam_value) values 
('APPLI_title', 'Ex-Situ Fish Conservation'),
('otp_issuer', 'esfc');

ALTER TABLE gacl.logingestion ADD is_expired bool NULL DEFAULT false;
COMMENT ON COLUMN gacl.logingestion.is_expired IS 'If true, the account is expired (password older)';



CREATE SEQUENCE "dbversion_dbversion_id_seq";

CREATE TABLE "dbversion" (
                "dbversion_id" INTEGER NOT NULL DEFAULT nextval('"dbversion_dbversion_id_seq"'),
                "dbversion_number" VARCHAR NOT NULL,
                "dbversion_date" TIMESTAMP NOT NULL,
                CONSTRAINT "dbversion_pk" PRIMARY KEY ("dbversion_id")
);
COMMENT ON TABLE "dbversion" IS 'Table of database versions';
COMMENT ON COLUMN "dbversion"."dbversion_number" IS 'Version number';
COMMENT ON COLUMN "dbversion"."dbversion_date" IS 'Version date';

alter table requete rename to request;
alter table request rename column requete_id to request_id;
alter table request rename column creation_date to create_date;
update request set body = 'select ' || body;

alter table bassin add column mode_calcul_masse smallint DEFAULT 0;
COMMENT ON COLUMN public.bassin.mode_calcul_masse IS E'0: masse globale connue\n1: par échantillonnage par rapport à la dernière date de mesure';


ALTER SEQUENCE "dbversion_dbversion_id_seq" OWNED BY "dbversion"."dbversion_id";

insert into dbversion(dbversion_number, dbversion_date) values ('2.0', '2023-08-10');

