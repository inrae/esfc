
/* Code generated for Postgre_8_2_4 */


 

	
CREATE TABLE public.LoginGestion(
id integer NOT NULL,
login varchar(32) NOT NULL,
password varchar(255),
nom varchar(32),
prenom varchar(32),
mail varchar(255),
datemodif date
) ;


CREATE SEQUENCE public.SEQ_LoginGestion_id
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 999999
	START WITH 1
	NO CYCLE
	OWNED BY public.LoginGestion.id	
;
ALTER TABLE public.LoginGestion ALTER COLUMN id SET DEFAULT nextval('public.SEQ_LoginGestion_id');




ALTER TABLE public.LoginGestion ADD CONSTRAINT PK_LoginGestion PRIMARY KEY (id);


	
CREATE TABLE public.gaclacl(
id integer NOT NULL DEFAULT 0,
section_value varchar(230) NOT NULL,
allow integer NOT NULL DEFAULT 0,
enabled integer NOT NULL DEFAULT 0,
return_value text,
note text,
updated_date integer NOT NULL DEFAULT 0
) ;


ALTER TABLE public.gaclacl ADD CONSTRAINT PK_gaclacl PRIMARY KEY (id);

	
	
 

	
CREATE TABLE public.gaclacl_sections(
id integer NOT NULL DEFAULT 0,
value varchar(230) NOT NULL,
order_value integer NOT NULL DEFAULT 0,
name varchar(230) NOT NULL,
hidden integer NOT NULL DEFAULT 0
) ;


ALTER TABLE public.gaclacl_sections ADD CONSTRAINT PK_gaclacl_sections PRIMARY KEY (id);

ALTER TABLE  public.gaclacl_sections ADD CONSTRAINT gaclvalue_acl_sections UNIQUE (value);


	
CREATE TABLE public.gaclacl_seq(
id integer NOT NULL
) ;

	
CREATE TABLE public.gaclaco(
id integer NOT NULL DEFAULT 0,
section_value varchar(240) NOT NULL DEFAULT 0,
value varchar(240) NOT NULL,
order_value integer NOT NULL DEFAULT 0,
name varchar(255) NOT NULL,
hidden integer NOT NULL DEFAULT 0
) ;


ALTER TABLE public.gaclaco ADD CONSTRAINT PK_gaclaco PRIMARY KEY (id);

ALTER TABLE  public.gaclaco ADD CONSTRAINT gaclsection_value_value_aco UNIQUE (section_value,value);

	
CREATE TABLE public.gaclaco_map(
acl_id integer NOT NULL DEFAULT 0,
section_value varchar(230) NOT NULL DEFAULT 0,
value varchar(230) NOT NULL
) ;


ALTER TABLE public.gaclaco_map ADD CONSTRAINT pk_gaclaco_map PRIMARY KEY (acl_id,section_value,value);


	
CREATE TABLE public.gaclaco_sections(
id integer NOT NULL DEFAULT 0,
value varchar(230) NOT NULL,
order_value integer NOT NULL DEFAULT 0,
name varchar(230) NOT NULL,
hidden integer NOT NULL DEFAULT 0
) ;


ALTER TABLE public.gaclaco_sections ADD CONSTRAINT pk_gaclaco_sections PRIMARY KEY (id);

ALTER TABLE  public.gaclaco_sections ADD CONSTRAINT gaclvalue_aco_sections UNIQUE (value);


	
CREATE TABLE public.gaclaco_sections_seq(
id integer NOT NULL
) ;

	
CREATE TABLE public.gaclaco_seq(
id integer NOT NULL
) ;


	
CREATE TABLE public.gaclaro(
id integer NOT NULL DEFAULT 0,
section_value varchar(240) NOT NULL DEFAULT 0,
value varchar(240) NOT NULL,
order_value integer NOT NULL DEFAULT 0,
name varchar(255) NOT NULL,
hidden integer NOT NULL DEFAULT 0
) ;


ALTER TABLE public.gaclaro ADD CONSTRAINT pk_gaclaro PRIMARY KEY (id);

ALTER TABLE  public.gaclaro ADD CONSTRAINT gaclsection_value_value_aro UNIQUE (section_value,value);


	
CREATE TABLE public.gaclaro_groups(
id integer NOT NULL DEFAULT 0,
parent_id integer NOT NULL DEFAULT 0,
lft integer NOT NULL DEFAULT 0,
rgt integer NOT NULL DEFAULT 0,
name varchar(255) NOT NULL,
value varchar(255) NOT NULL
) ;


ALTER TABLE public.gaclaro_groups ADD CONSTRAINT pk_gaclaro_groups PRIMARY KEY (id,value);

ALTER TABLE  public.gaclaro_groups ADD CONSTRAINT gaclvalue_aro_groups UNIQUE (value);


	
CREATE TABLE public.gaclaro_groups_id_seq(
id integer NOT NULL
) ;


	
	
 

	
CREATE TABLE public.gaclaro_groups_map(
acl_id integer NOT NULL DEFAULT 0,
group_id integer NOT NULL DEFAULT 0
) ;


ALTER TABLE public.gaclaro_groups_map ADD CONSTRAINT pk_gaclaro_groups_map PRIMARY KEY (acl_id,group_id);

	
	
 

	
CREATE TABLE public.gaclaro_map(
acl_id integer NOT NULL DEFAULT 0,
section_value varchar(230) NOT NULL DEFAULT 0,
value varchar(230) NOT NULL
) ;


ALTER TABLE public.gaclaro_map ADD CONSTRAINT pk_gaclaro_map PRIMARY KEY (acl_id,section_value,value);

	
	
 

	
CREATE TABLE public.gaclaro_sections(
id integer NOT NULL DEFAULT 0,
value varchar(230) NOT NULL,
order_value integer NOT NULL DEFAULT 0,
name varchar(230) NOT NULL,
hidden integer NOT NULL DEFAULT 0
) ;


ALTER TABLE public.gaclaro_sections ADD CONSTRAINT pk_gaclaro_sections PRIMARY KEY (id);

ALTER TABLE  public.gaclaro_sections ADD CONSTRAINT gaclvalue_aro_sections UNIQUE (value);


	
CREATE TABLE public.gaclaro_sections_seq(
id integer NOT NULL
) ;


	
CREATE TABLE public.gaclaro_seq(
id integer NOT NULL
) ;


	
CREATE TABLE public.gaclaxo(
id integer NOT NULL DEFAULT 0,
section_value varchar(240) NOT NULL DEFAULT 0,
value varchar(240) NOT NULL,
order_value integer NOT NULL DEFAULT 0,
name varchar(255) NOT NULL,
hidden integer NOT NULL DEFAULT 0
) ;


ALTER TABLE public.gaclaxo ADD CONSTRAINT pk_gaclaxo PRIMARY KEY (id);

ALTER TABLE  public.gaclaxo ADD CONSTRAINT gaclsection_value_value_axo UNIQUE (section_value,value);


	
CREATE TABLE public.gaclaxo_groups(
id integer NOT NULL DEFAULT 0,
parent_id integer NOT NULL DEFAULT 0,
lft integer NOT NULL DEFAULT 0,
rgt integer NOT NULL DEFAULT 0,
name varchar(255) NOT NULL,
value varchar(255) NOT NULL
) ;


ALTER TABLE public.gaclaxo_groups ADD CONSTRAINT pk_gaclaxo_groups PRIMARY KEY (id,value);

ALTER TABLE  public.gaclaxo_groups ADD CONSTRAINT gaclvalue_axo_groups UNIQUE (value);


	
CREATE TABLE public.gaclaxo_groups_map(
acl_id integer NOT NULL DEFAULT 0,
group_id integer NOT NULL DEFAULT 0
) ;


ALTER TABLE public.gaclaxo_groups_map ADD CONSTRAINT pk_gaclaxo_groups_map PRIMARY KEY (acl_id,group_id);

	
	
 

	
CREATE TABLE public.gaclaxo_map(
acl_id integer NOT NULL DEFAULT 0,
section_value varchar(230) NOT NULL DEFAULT 0,
value varchar(230) NOT NULL
) ;


ALTER TABLE public.gaclaxo_map ADD CONSTRAINT pk_gaclaxo_map PRIMARY KEY (acl_id,section_value,value);

	
CREATE TABLE public.gaclaxo_sections(
id integer NOT NULL DEFAULT 0,
value varchar(230) NOT NULL,
order_value integer NOT NULL DEFAULT 0,
name varchar(230) NOT NULL,
hidden integer NOT NULL DEFAULT 0
) ;


ALTER TABLE public.gaclaxo_sections ADD CONSTRAINT pk_gaclaxo_sections PRIMARY KEY (id);

ALTER TABLE  public.gaclaxo_sections ADD CONSTRAINT gaclvalue_axo_sections UNIQUE (value);

	
CREATE TABLE public.gaclgroups_aro_map(
group_id integer NOT NULL DEFAULT 0,
aro_id integer NOT NULL DEFAULT 0
) ;


ALTER TABLE public.gaclgroups_aro_map ADD CONSTRAINT pk_gaclgroups_aro_map PRIMARY KEY (group_id,aro_id);

	
CREATE TABLE public.gaclgroups_axo_map(
group_id integer NOT NULL DEFAULT 0,
axo_id integer NOT NULL DEFAULT 0
) ;


ALTER TABLE public.gaclgroups_axo_map ADD CONSTRAINT pk_gaclgroups_axo_map PRIMARY KEY (group_id,axo_id);
	
CREATE TABLE public.gaclphpgacl(
name varchar(230) NOT NULL,
value varchar(230) NOT NULL
) ;


ALTER TABLE public.gaclphpgacl ADD CONSTRAINT pk_gaclphpgacl PRIMARY KEY (name);

 
CREATE INDEX login ON public.LoginGestion (login);

 
CREATE INDEX gaclenabled_acl ON public.gaclacl (enabled);

 
CREATE INDEX gaclsection_value_acl ON public.gaclacl (section_value);

 
CREATE INDEX gaclupdated_date_acl ON public.gaclacl (updated_date);

 
CREATE INDEX gaclhidden_acl_sections ON public.gaclacl_sections (hidden);

 
CREATE INDEX gaclhidden_aco ON public.gaclaco (hidden);

 
CREATE INDEX gaclhidden_aco_sections ON public.gaclaco_sections (hidden);

 
CREATE INDEX gaclhidden_aro ON public.gaclaro (hidden);

 
CREATE INDEX gacllft_rgt_aro_groups ON public.gaclaro_groups (lft);

 
CREATE INDEX gaclparent_id_aro_groups ON public.gaclaro_groups (parent_id);

 
CREATE INDEX gaclhidden_aro_sections ON public.gaclaro_sections (hidden);

 
CREATE INDEX gaclhidden_axo ON public.gaclaxo (hidden);

 
CREATE INDEX gacllft_rgt_axo_groups ON public.gaclaxo_groups (lft);

 
CREATE INDEX gaclparent_id_axo_groups ON public.gaclaxo_groups (parent_id);

 
CREATE INDEX gaclhidden_axo_sections ON public.gaclaxo_sections (hidden);

 
CREATE INDEX gaclaro_id ON public.gaclgroups_aro_map (aro_id);

 
CREATE INDEX gaclaxo_id ON public.gaclgroups_axo_map (axo_id);

INSERT INTO gaclacl (id, section_value, allow, enabled, return_value, note, updated_date) VALUES
(12, 'user', 1, 1, '', '', 1178872734),
(13, 'user', 1, 1, '', '', 1178872750),
(15, 'user', 1, 1, '', '', 1178889703),
(16, 'user', 1, 1, '', '', 1178889776);

INSERT INTO gaclacl_sections (id, value, order_value, name, hidden) VALUES
(1, 'system', 1, 'System', 0),
(2, 'user', 2, 'User', 0);

INSERT INTO gaclacl_seq (id) VALUES
(16);
INSERT INTO gaclaco (id, section_value, value, order_value, name, hidden) VALUES
(14, 'proto', 'gestion', 1, 'gestion', 0),
(13, 'proto', 'admin', 1, 'admin', 0),
(16, 'proto', 'gestionValid', 2, 'gestionValid', 0),
(17, 'proto', 'gestionAdmin', 2, 'gestionAdmin', 0);

INSERT INTO gaclaco_map (acl_id, section_value, value) VALUES
(12, 'proto', 'admin'),
(13, 'proto', 'gestion'),
(15, 'proto', 'gestionAdmin'),
(16, 'proto', 'gestionValid');

INSERT INTO gaclaco_sections (id, value, order_value, name, hidden) VALUES
(14, 'proto', 1, 'proto', 0);
INSERT INTO gaclaco_sections_seq (id) VALUES
(14);
INSERT INTO gaclaco_seq (id) VALUES
(17);
INSERT INTO gaclaro (id, section_value, value, order_value, name, hidden) VALUES
(11, 'login', 'admin', 1, 'admin', 0),
(12, 'login', 'gestion', 1, 'gestion', 0);
INSERT INTO gaclaro_groups (id, parent_id, lft, rgt, name, value) VALUES
(11, 0, 1, 14, 'application', 'application'),
(12, 11, 2, 3, 'administration', 'admin'),
(13, 11, 4, 13, 'gestion', 'gestion'),
(18, 15, 10, 11, 'gestionadmin', 'gestionadmin'),
(15, 13, 5, 12, 'gestionvalid', 'gestionvalid');

INSERT INTO gaclaro_groups_id_seq (id) VALUES
(18);
INSERT INTO gaclaro_groups_map (acl_id, group_id) VALUES
(12, 12),
(13, 13),
(15, 18),
(16, 15);
INSERT INTO gaclaro_sections (id, value, order_value, name, hidden) VALUES
(11, 'login', 1, 'login', 0);
INSERT INTO gaclaro_sections_seq (id) VALUES
(11);
INSERT INTO gaclaro_seq (id) VALUES
(12);
INSERT INTO gaclgroups_aro_map (group_id, aro_id) VALUES
(12, 11),
(15, 12),
(18, 11);


INSERT INTO gaclphpgacl (name, value) VALUES
('version', '3.3.7'),
('schema_version', '2.1');


INSERT INTO LoginGestion (id, login, password, nom, prenom, mail, datemodif) VALUES
(1, 'admin', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 'Administrateur', NULL, NULL, NULL),
(5, 'gestion', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 'Gestionnaire', NULL, NULL, NULL);	
 
	

