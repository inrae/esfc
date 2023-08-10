-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 1.0.5
-- PostgreSQL version: 15.0
-- Project Site: pgmodeler.io
-- Model Author: ---
-- object: collec | type: ROLE --
-- DROP ROLE IF EXISTS collec;



-- object: gacl | type: SCHEMA --
-- DROP SCHEMA IF EXISTS gacl CASCADE;
CREATE SCHEMA gacl;
-- ddl-end --
ALTER SCHEMA gacl OWNER TO esfc;
-- ddl-end --
COMMENT ON SCHEMA gacl IS E'Rights management';
-- ddl-end --

SET search_path TO pg_catalog,public,gacl;
-- ddl-end --

-- object: gacl.aclacl | type: TABLE --
-- DROP TABLE IF EXISTS gacl.aclacl CASCADE;
CREATE TABLE gacl.aclacl (
	aclaco_id integer NOT NULL,
	aclgroup_id integer NOT NULL,
	CONSTRAINT aclacl_pk PRIMARY KEY (aclaco_id,aclgroup_id)
);
-- ddl-end --
COMMENT ON TABLE gacl.aclacl IS E'Table des droits attribués';
-- ddl-end --
ALTER TABLE gacl.aclacl OWNER TO esfc;
-- ddl-end --

-- object: gacl.aclaco_aclaco_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS gacl.aclaco_aclaco_id_seq CASCADE;
CREATE SEQUENCE gacl.aclaco_aclaco_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE gacl.aclaco_aclaco_id_seq OWNER TO esfc;
-- ddl-end --

-- object: gacl.aclaco | type: TABLE --
-- DROP TABLE IF EXISTS gacl.aclaco CASCADE;
CREATE TABLE gacl.aclaco (
	aclaco_id integer NOT NULL DEFAULT nextval('gacl.aclaco_aclaco_id_seq'::regclass),
	aclappli_id integer NOT NULL,
	aco character varying NOT NULL,
	CONSTRAINT aclaco_pk PRIMARY KEY (aclaco_id)
);
-- ddl-end --
COMMENT ON TABLE gacl.aclaco IS E'Table des droits gérés';
-- ddl-end --
ALTER TABLE gacl.aclaco OWNER TO esfc;
-- ddl-end --

-- object: gacl.aclappli_aclappli_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS gacl.aclappli_aclappli_id_seq CASCADE;
CREATE SEQUENCE gacl.aclappli_aclappli_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE gacl.aclappli_aclappli_id_seq OWNER TO esfc;
-- ddl-end --

-- object: gacl.aclappli | type: TABLE --
-- DROP TABLE IF EXISTS gacl.aclappli CASCADE;
CREATE TABLE gacl.aclappli (
	aclappli_id integer NOT NULL DEFAULT nextval('gacl.aclappli_aclappli_id_seq'::regclass),
	appli character varying NOT NULL,
	applidetail character varying,
	CONSTRAINT aclappli_pk PRIMARY KEY (aclappli_id)
);
-- ddl-end --
COMMENT ON TABLE gacl.aclappli IS E'Table des applications gérées';
-- ddl-end --
COMMENT ON COLUMN gacl.aclappli.appli IS E'Nom de l''application pour la gestion des droits';
-- ddl-end --
COMMENT ON COLUMN gacl.aclappli.applidetail IS E'Description de l''application';
-- ddl-end --
ALTER TABLE gacl.aclappli OWNER TO esfc;
-- ddl-end --

-- object: gacl.aclgroup_aclgroup_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS gacl.aclgroup_aclgroup_id_seq CASCADE;
CREATE SEQUENCE gacl.aclgroup_aclgroup_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE gacl.aclgroup_aclgroup_id_seq OWNER TO esfc;
-- ddl-end --

-- object: gacl.aclgroup | type: TABLE --
-- DROP TABLE IF EXISTS gacl.aclgroup CASCADE;
CREATE TABLE gacl.aclgroup (
	aclgroup_id integer NOT NULL DEFAULT nextval('gacl.aclgroup_aclgroup_id_seq'::regclass),
	groupe character varying NOT NULL,
	aclgroup_id_parent integer,
	CONSTRAINT aclgroup_pk PRIMARY KEY (aclgroup_id)
);
-- ddl-end --
COMMENT ON TABLE gacl.aclgroup IS E'Groupes des logins';
-- ddl-end --
ALTER TABLE gacl.aclgroup OWNER TO esfc;
-- ddl-end --

-- object: gacl.acllogin_acllogin_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS gacl.acllogin_acllogin_id_seq CASCADE;
CREATE SEQUENCE gacl.acllogin_acllogin_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE gacl.acllogin_acllogin_id_seq OWNER TO esfc;
-- ddl-end --

-- object: gacl.acllogin | type: TABLE --
-- DROP TABLE IF EXISTS gacl.acllogin CASCADE;
CREATE TABLE gacl.acllogin (
	acllogin_id integer NOT NULL DEFAULT nextval('gacl.acllogin_acllogin_id_seq'::regclass),
	login character varying NOT NULL,
	logindetail character varying NOT NULL,
	totp_key character varying,
	CONSTRAINT acllogin_pk PRIMARY KEY (acllogin_id)
);
-- ddl-end --
COMMENT ON TABLE gacl.acllogin IS E'Table des logins des utilisateurs autorisés';
-- ddl-end --
COMMENT ON COLUMN gacl.acllogin.logindetail IS E'Nom affiché';
-- ddl-end --
COMMENT ON COLUMN gacl.acllogin.totp_key IS E'TOTP secret key for the user';
-- ddl-end --
ALTER TABLE gacl.acllogin OWNER TO esfc;
-- ddl-end --

-- object: gacl.acllogingroup | type: TABLE --
-- DROP TABLE IF EXISTS gacl.acllogingroup CASCADE;
CREATE TABLE gacl.acllogingroup (
	acllogin_id integer NOT NULL,
	aclgroup_id integer NOT NULL,
	CONSTRAINT acllogingroup_pk PRIMARY KEY (acllogin_id,aclgroup_id)
);
-- ddl-end --
COMMENT ON TABLE gacl.acllogingroup IS E'Table des relations entre les logins et les groupes';
-- ddl-end --
ALTER TABLE gacl.acllogingroup OWNER TO esfc;
-- ddl-end --

-- object: gacl.gaclacl_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS gacl.gaclacl_seq CASCADE;
CREATE SEQUENCE gacl.gaclacl_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 10
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE gacl.gaclacl_seq OWNER TO esfc;
-- ddl-end --

-- object: gacl.gaclaco_sections_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS gacl.gaclaco_sections_seq CASCADE;
CREATE SEQUENCE gacl.gaclaco_sections_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 10
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE gacl.gaclaco_sections_seq OWNER TO esfc;
-- ddl-end --

-- object: gacl.gaclaco_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS gacl.gaclaco_seq CASCADE;
CREATE SEQUENCE gacl.gaclaco_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 10
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE gacl.gaclaco_seq OWNER TO esfc;
-- ddl-end --

-- object: gacl.gaclaro_groups_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS gacl.gaclaro_groups_id_seq CASCADE;
CREATE SEQUENCE gacl.gaclaro_groups_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 10
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE gacl.gaclaro_groups_id_seq OWNER TO esfc;
-- ddl-end --

-- object: gacl.gaclaro_sections_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS gacl.gaclaro_sections_seq CASCADE;
CREATE SEQUENCE gacl.gaclaro_sections_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 10
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE gacl.gaclaro_sections_seq OWNER TO esfc;
-- ddl-end --

-- object: gacl.gaclaro_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS gacl.gaclaro_seq CASCADE;
CREATE SEQUENCE gacl.gaclaro_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 10
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE gacl.gaclaro_seq OWNER TO esfc;
-- ddl-end --

-- object: gacl.log_log_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS gacl.log_log_id_seq CASCADE;
CREATE SEQUENCE gacl.log_log_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE gacl.log_log_id_seq OWNER TO esfc;
-- ddl-end --

-- object: gacl.log | type: TABLE --
-- DROP TABLE IF EXISTS gacl.log CASCADE;
CREATE TABLE gacl.log (
	log_id integer NOT NULL DEFAULT nextval('gacl.log_log_id_seq'::regclass),
	login character varying(32) NOT NULL,
	nom_module character varying,
	log_date timestamp NOT NULL,
	commentaire character varying,
	ipaddress character varying,
	CONSTRAINT log_pk PRIMARY KEY (log_id)
);
-- ddl-end --
COMMENT ON TABLE gacl.log IS E'Liste des connexions ou des actions enregistrées';
-- ddl-end --
COMMENT ON COLUMN gacl.log.log_date IS E'Heure de connexion';
-- ddl-end --
COMMENT ON COLUMN gacl.log.commentaire IS E'Donnees complementaires enregistrees';
-- ddl-end --
ALTER TABLE gacl.log OWNER TO esfc;
-- ddl-end --

-- object: gacl.seq_logingestion_id | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS gacl.seq_logingestion_id CASCADE;
CREATE SEQUENCE gacl.seq_logingestion_id
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 999999
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE gacl.seq_logingestion_id OWNER TO esfc;
-- ddl-end --

-- object: gacl.login_oldpassword_login_oldpassword_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS gacl.login_oldpassword_login_oldpassword_id_seq CASCADE;
CREATE SEQUENCE gacl.login_oldpassword_login_oldpassword_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE gacl.login_oldpassword_login_oldpassword_id_seq OWNER TO esfc;
-- ddl-end --

-- object: gacl.login_oldpassword | type: TABLE --
-- DROP TABLE IF EXISTS gacl.login_oldpassword CASCADE;
CREATE TABLE gacl.login_oldpassword (
	login_oldpassword_id integer NOT NULL DEFAULT nextval('gacl.login_oldpassword_login_oldpassword_id_seq'::regclass),
	id integer NOT NULL DEFAULT nextval('gacl.seq_logingestion_id'::regclass),
	password character varying(255),
	CONSTRAINT login_oldpassword_pk PRIMARY KEY (login_oldpassword_id)
);
-- ddl-end --
COMMENT ON TABLE gacl.login_oldpassword IS E'Table contenant les anciens mots de passe';
-- ddl-end --
ALTER TABLE gacl.login_oldpassword OWNER TO esfc;
-- ddl-end --

-- object: gacl.logingestion | type: TABLE --
-- DROP TABLE IF EXISTS gacl.logingestion CASCADE;
CREATE TABLE gacl.logingestion (
	id integer NOT NULL DEFAULT nextval('gacl.seq_logingestion_id'::regclass),
	login character varying(32) NOT NULL,
	password character varying(255),
	nom character varying(255),
	prenom character varying(32),
	mail character varying(255),
	datemodif date,
	actif smallint DEFAULT 1,
	nbattempts smallint DEFAULT 0,
	lastattempt timestamp,
	is_expired boolean DEFAULT false,
	CONSTRAINT pk_logingestion PRIMARY KEY (id)
);
-- ddl-end --
COMMENT ON COLUMN gacl.logingestion.nbattempts IS E'Number of connection attemps';
-- ddl-end --
COMMENT ON COLUMN gacl.logingestion.lastattempt IS E'last attemp of connection';
-- ddl-end --
COMMENT ON COLUMN gacl.logingestion.is_expired IS E'If true, the account is expired (password older)';
-- ddl-end --
ALTER TABLE gacl.logingestion OWNER TO esfc;
-- ddl-end --

-- object: acllogin_login_idx | type: INDEX --
-- DROP INDEX IF EXISTS gacl.acllogin_login_idx CASCADE;
CREATE UNIQUE INDEX acllogin_login_idx ON gacl.acllogin
USING btree
(
	login
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: log_date_idx | type: INDEX --
-- DROP INDEX IF EXISTS gacl.log_date_idx CASCADE;
CREATE INDEX log_date_idx ON gacl.log
USING btree
(
	log_date
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: log_login_idx | type: INDEX --
-- DROP INDEX IF EXISTS gacl.log_login_idx CASCADE;
CREATE INDEX log_login_idx ON gacl.log
USING btree
(
	login
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: tablefunc | type: EXTENSION --
-- DROP EXTENSION IF EXISTS tablefunc CASCADE;
CREATE EXTENSION tablefunc
WITH SCHEMA public
VERSION '1.0';
-- ddl-end --
COMMENT ON EXTENSION tablefunc IS E'functions that manipulate whole tables, including crosstab';
-- ddl-end --

-- object: postgis | type: EXTENSION --
-- DROP EXTENSION IF EXISTS postgis CASCADE;
CREATE EXTENSION postgis
WITH SCHEMA public
VERSION '3.3.2';
-- ddl-end --
COMMENT ON EXTENSION postgis IS E'PostGIS geometry and geography spatial types and functions';
-- ddl-end --

-- object: aclaco_aclacl_fk | type: CONSTRAINT --
-- ALTER TABLE gacl.aclacl DROP CONSTRAINT IF EXISTS aclaco_aclacl_fk CASCADE;
ALTER TABLE gacl.aclacl ADD CONSTRAINT aclaco_aclacl_fk FOREIGN KEY (aclaco_id)
REFERENCES gacl.aclaco (aclaco_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: aclgroup_aclacl_fk | type: CONSTRAINT --
-- ALTER TABLE gacl.aclacl DROP CONSTRAINT IF EXISTS aclgroup_aclacl_fk CASCADE;
ALTER TABLE gacl.aclacl ADD CONSTRAINT aclgroup_aclacl_fk FOREIGN KEY (aclgroup_id)
REFERENCES gacl.aclgroup (aclgroup_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: aclappli_aclaco_fk | type: CONSTRAINT --
-- ALTER TABLE gacl.aclaco DROP CONSTRAINT IF EXISTS aclappli_aclaco_fk CASCADE;
ALTER TABLE gacl.aclaco ADD CONSTRAINT aclappli_aclaco_fk FOREIGN KEY (aclappli_id)
REFERENCES gacl.aclappli (aclappli_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: aclgroup_aclgroup_fk | type: CONSTRAINT --
-- ALTER TABLE gacl.aclgroup DROP CONSTRAINT IF EXISTS aclgroup_aclgroup_fk CASCADE;
ALTER TABLE gacl.aclgroup ADD CONSTRAINT aclgroup_aclgroup_fk FOREIGN KEY (aclgroup_id_parent)
REFERENCES gacl.aclgroup (aclgroup_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: aclgroup_acllogingroup_fk | type: CONSTRAINT --
-- ALTER TABLE gacl.acllogingroup DROP CONSTRAINT IF EXISTS aclgroup_acllogingroup_fk CASCADE;
ALTER TABLE gacl.acllogingroup ADD CONSTRAINT aclgroup_acllogingroup_fk FOREIGN KEY (aclgroup_id)
REFERENCES gacl.aclgroup (aclgroup_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: acllogin_acllogingroup_fk | type: CONSTRAINT --
-- ALTER TABLE gacl.acllogingroup DROP CONSTRAINT IF EXISTS acllogin_acllogingroup_fk CASCADE;
ALTER TABLE gacl.acllogingroup ADD CONSTRAINT acllogin_acllogingroup_fk FOREIGN KEY (acllogin_id)
REFERENCES gacl.acllogin (acllogin_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: logingestion_login_oldpassword_fk | type: CONSTRAINT --
-- ALTER TABLE gacl.login_oldpassword DROP CONSTRAINT IF EXISTS logingestion_login_oldpassword_fk CASCADE;
ALTER TABLE gacl.login_oldpassword ADD CONSTRAINT logingestion_login_oldpassword_fk FOREIGN KEY (id)
REFERENCES gacl.logingestion (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


INSERT INTO gacl.logingestion (login,"password",nom,prenom,mail,datemodif,actif,nbattempts,lastattempt,is_expired) VALUES
	 ('admin','$2y$13$evOzF08OtKIzqZlIlTQ.i.8JeVT9940H28VdR7ZWOkB.BlPn.4D6u','Default administrator account - must be deleted in production',NULL,NULL,NULL,1,0,NULL,false);

INSERT INTO gacl.acllogin (login,logindetail,totp_key) VALUES
	 ('admin','Admin',NULL);

INSERT INTO gacl.aclappli (appli,applidetail) VALUES
	 ('esfc',NULL);

INSERT INTO gacl.aclaco (aclappli_id,aco) VALUES
	 (1,'admin'),
	 (1,'bassinGestion'),
	 (1,'gestion'),
	 (1,'paramAdmin'),
	 (1,'poissonAdmin'),
	 (1,'poissonGestion'),
	 (1,'reproAdmin'),
	 (1,'reproGestion'),
	 (1,'bassinAdmin'),
	 (1,'consult');
INSERT INTO gacl.aclaco (aclappli_id,aco) VALUES
	 (1,'reproConsult'),
	 (1,'requete'),
	 (1,'requeteAdmin');
INSERT INTO gacl.aclgroup (groupe,aclgroup_id_parent) VALUES
	 ('migado_resp',2),
	 ('super admin',1),
	 ('admin',NULL),
	 ('consult',NULL),
	 ('repro',NULL),
	 ('requete',NULL),
	 ('requeteAdmin',10),
	 ('Repro admin',7),
	 ('migado',NULL),
	 ('repro gestion',6);
INSERT INTO gacl.aclgroup (groupe,aclgroup_id_parent) VALUES
	 ('station',NULL);
INSERT INTO gacl.aclacl (aclaco_id,aclgroup_id) VALUES
	 (1,1);
INSERT INTO gacl.acllogingroup (acllogin_id,aclgroup_id) VALUES
	 (1,1),
	 (1,4);
