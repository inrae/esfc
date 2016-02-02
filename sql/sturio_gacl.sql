-- BEGIN TABLE aclacl
CREATE TABLE gacl.aclacl
(
   aclaco_id    integer    NOT NULL,
   aclgroup_id  integer    NOT NULL
);

ALTER TABLE gacl.aclacl
   ADD CONSTRAINT aclacl_pk
   PRIMARY KEY (aclaco_id, aclgroup_id);

COMMENT ON TABLE aclacl IS 'Table des droits attribués';
GRANT DELETE, REFERENCES, INSERT, TRUNCATE, TRIGGER, UPDATE, SELECT ON gacl.aclacl TO sturio_gacl_g;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON gacl.aclacl TO \"eric.quinton\";
-- END TABLE aclacl

-- BEGIN TABLE aclaco
CREATE TABLE gacl.aclaco
(
   aclaco_id    serial    NOT NULL,
   aclappli_id  integer    NOT NULL,
   aco          varchar    NOT NULL
);

-- Column aclaco_id is associated with sequence gacl.aclaco_aclaco_id_seq

ALTER TABLE gacl.aclaco
   ADD CONSTRAINT aclaco_pk
   PRIMARY KEY (aclaco_id);

COMMENT ON TABLE aclaco IS 'Table des droits gérés';
GRANT DELETE, REFERENCES, INSERT, TRUNCATE, TRIGGER, UPDATE, SELECT ON gacl.aclaco TO sturio_gacl_g;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON gacl.aclaco TO \"eric.quinton\";
-- END TABLE aclaco

-- BEGIN TABLE aclappli
CREATE TABLE gacl.aclappli
(
   aclappli_id  serial    NOT NULL,
   appli        varchar    NOT NULL,
   applidetail  varchar
);

-- Column aclappli_id is associated with sequence gacl.aclappli_aclappli_id_seq

ALTER TABLE gacl.aclappli
   ADD CONSTRAINT aclappli_pk
   PRIMARY KEY (aclappli_id);

COMMENT ON TABLE aclappli IS 'Table des applications gérées';
COMMENT ON COLUMN aclappli.appli IS 'Nom de l''application pour la gestion des droits';
COMMENT ON COLUMN aclappli.applidetail IS 'Description de l''application';

GRANT DELETE, REFERENCES, INSERT, TRUNCATE, TRIGGER, UPDATE, SELECT ON gacl.aclappli TO sturio_gacl_g;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON gacl.aclappli TO \"eric.quinton\";
-- END TABLE aclappli

-- BEGIN TABLE aclgroup
CREATE TABLE gacl.aclgroup
(
   aclgroup_id         serial    NOT NULL,
   groupe              varchar    NOT NULL,
   aclgroup_id_parent  integer
);

-- Column aclgroup_id is associated with sequence gacl.aclgroup_aclgroup_id_seq

ALTER TABLE gacl.aclgroup
   ADD CONSTRAINT aclgroup_pk
   PRIMARY KEY (aclgroup_id);

COMMENT ON TABLE aclgroup IS 'Groupes des logins';
GRANT DELETE, REFERENCES, INSERT, TRUNCATE, TRIGGER, UPDATE, SELECT ON gacl.aclgroup TO sturio_gacl_g;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON gacl.aclgroup TO \"eric.quinton\";
-- END TABLE aclgroup

-- BEGIN TABLE acllogin
CREATE TABLE gacl.acllogin
(
   acllogin_id  serial    NOT NULL,
   login        varchar    NOT NULL,
   logindetail  varchar    NOT NULL
);

-- Column acllogin_id is associated with sequence gacl.acllogin_acllogin_id_seq

ALTER TABLE gacl.acllogin
   ADD CONSTRAINT acllogin_pk
   PRIMARY KEY (acllogin_id);

COMMENT ON TABLE acllogin IS 'Table des logins des utilisateurs autorisés';
COMMENT ON COLUMN acllogin.logindetail IS 'Nom affiché';

GRANT DELETE, REFERENCES, INSERT, TRUNCATE, TRIGGER, UPDATE, SELECT ON gacl.acllogin TO sturio_gacl_g;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON gacl.acllogin TO \"eric.quinton\";
-- END TABLE acllogin

-- BEGIN TABLE acllogingroup
CREATE TABLE gacl.acllogingroup
(
   acllogin_id  integer    NOT NULL,
   aclgroup_id  integer    NOT NULL
);

ALTER TABLE gacl.acllogingroup
   ADD CONSTRAINT acllogingroup_pk
   PRIMARY KEY (acllogin_id, aclgroup_id);

COMMENT ON TABLE acllogingroup IS 'Table des relations entre les logins et les groupes';
GRANT DELETE, REFERENCES, INSERT, TRUNCATE, TRIGGER, UPDATE, SELECT ON gacl.acllogingroup TO sturio_gacl_g;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON gacl.acllogingroup TO \"eric.quinton\";
-- END TABLE acllogingroup

-- BEGIN TABLE log
CREATE TABLE gacl.log
(
   log_id       serial        NOT NULL,
   login        varchar(32)    NOT NULL,
   nom_module   varchar,
   log_date     timestamp      NOT NULL,
   commentaire  varchar
);

-- Column log_id is associated with sequence gacl.log_log_id_seq
ALTER TABLE gacl.log SET OWNER TO sturio_owner;

ALTER TABLE gacl.log
   ADD CONSTRAINT log_pk
   PRIMARY KEY (log_id);

CREATE INDEX log_login_idx ON gacl.log USING btree (login);
CREATE INDEX log_date_idx ON gacl.log USING btree (log_date);


COMMENT ON TABLE log IS 'Liste des connexions ou des actions enregistrées';
COMMENT ON COLUMN log.log_date IS 'Heure de connexion';
COMMENT ON COLUMN log.commentaire IS 'Donnees complementaires enregistrees';

GRANT DELETE, REFERENCES, INSERT, TRUNCATE, TRIGGER, UPDATE, SELECT ON gacl.log TO sturio_gacl_g;
GRANT UPDATE, TRIGGER, SELECT, DELETE, INSERT, TRUNCATE, REFERENCES ON gacl.log TO sturio_owner;
-- END TABLE log

-- BEGIN TABLE login_oldpassword
CREATE TABLE gacl.login_oldpassword
(
   login_oldpassword_id  serial         NOT NULL,
   id                    integer        DEFAULT nextval('gacl.seq_logingestion_id'::regclass) NOT NULL,
   password              varchar(255)
);

-- Column login_oldpassword_id is associated with sequence gacl.login_oldpassword_login_oldpassword_id_seq
ALTER TABLE gacl.login_oldpassword SET OWNER TO sturio_owner;

ALTER TABLE gacl.login_oldpassword
   ADD CONSTRAINT login_oldpassword_pk
   PRIMARY KEY (login_oldpassword_id);

COMMENT ON TABLE login_oldpassword IS 'Table contenant les anciens mots de passe';
GRANT DELETE, REFERENCES, INSERT, TRUNCATE, TRIGGER, UPDATE, SELECT ON gacl.login_oldpassword TO sturio_gacl_g;
GRANT UPDATE, TRIGGER, SELECT, DELETE, INSERT, TRUNCATE, REFERENCES ON gacl.login_oldpassword TO sturio_owner;
-- END TABLE login_oldpassword

-- BEGIN TABLE logingestion
CREATE TABLE gacl.logingestion
(
   id         integer        DEFAULT nextval('gacl.seq_logingestion_id'::regclass) NOT NULL,
   login      varchar(32)     NOT NULL,
   password   varchar(255),
   nom        varchar(32),
   prenom     varchar(32),
   mail       varchar(255),
   datemodif  date,
   actif      smallint        DEFAULT 1
);

ALTER TABLE gacl.logingestion SET OWNER TO sturio_owner;

ALTER TABLE gacl.logingestion
   ADD CONSTRAINT pk_logingestion
   PRIMARY KEY (id);

GRANT DELETE, REFERENCES, INSERT, TRUNCATE, TRIGGER, UPDATE, SELECT ON gacl.logingestion TO sturio_gacl_g;
GRANT UPDATE, TRIGGER, SELECT, DELETE, INSERT, TRUNCATE, REFERENCES ON gacl.logingestion TO sturio_owner;
-- END TABLE logingestion

-- BEGIN FOREIGN KEYS --
ALTER TABLE gacl.aclacl
  ADD CONSTRAINT aclaco_aclacl_fk FOREIGN KEY (aclaco_id)
  REFERENCES gacl.aclaco (aclaco_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE gacl.aclacl
  ADD CONSTRAINT aclgroup_aclacl_fk FOREIGN KEY (aclgroup_id)
  REFERENCES gacl.aclgroup (aclgroup_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE gacl.aclaco
  ADD CONSTRAINT aclappli_aclaco_fk FOREIGN KEY (aclappli_id)
  REFERENCES gacl.aclappli (aclappli_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE gacl.aclgroup
  ADD CONSTRAINT aclgroup_aclgroup_fk FOREIGN KEY (aclgroup_id_parent)
  REFERENCES gacl.aclgroup (aclgroup_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE gacl.acllogingroup
  ADD CONSTRAINT aclgroup_acllogingroup_fk FOREIGN KEY (aclgroup_id)
  REFERENCES gacl.aclgroup (aclgroup_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE gacl.acllogingroup
  ADD CONSTRAINT acllogin_acllogingroup_fk FOREIGN KEY (acllogin_id)
  REFERENCES gacl.acllogin (acllogin_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE gacl.login_oldpassword
  ADD CONSTRAINT logingestion_login_oldpassword_fk FOREIGN KEY (id)
  REFERENCES gacl.logingestion (id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;
-- END FOREIGN KEYS --


COMMIT;
