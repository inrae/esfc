-- Diff code generated with pgModeler (PostgreSQL Database Modeler)
-- pgModeler version: 0.9.2-alpha1
-- Diff date: 2019-02-08 17:04:44
-- Source model: sturio
-- Database: sturio
-- PostgreSQL version: 9.6


-- [ Created objects ] --
-- object: public.site_site_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.site_site_id_seq CASCADE;
CREATE SEQUENCE public.site_site_id_seq
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE public.site_site_id_seq OWNER TO postgres;
-- ddl-end --

-- object: public.site | type: TABLE --
-- DROP TABLE IF EXISTS public.site CASCADE;
CREATE TABLE public.site (
	site_id integer NOT NULL DEFAULT nextval('public.site_site_id_seq'::regclass),
	site_name varchar NOT NULL,
	CONSTRAINT site_id_pk PRIMARY KEY (site_id)

);
-- ddl-end --
COMMENT ON TABLE public.site IS 'Liste des sites gérés';
-- ddl-end --
COMMENT ON COLUMN public.site.site_name IS 'Nom du site';
-- ddl-end --
ALTER TABLE public.site OWNER TO postgres;
-- ddl-end --



-- object: site_id | type: COLUMN --
-- ALTER TABLE public.bassin DROP COLUMN IF EXISTS site_id CASCADE;
ALTER TABLE public.bassin ADD COLUMN site_id integer;
-- ddl-end --


-- object: site_id | type: COLUMN --
-- ALTER TABLE public.circuit_eau DROP COLUMN IF EXISTS site_id CASCADE;
ALTER TABLE public.circuit_eau ADD COLUMN site_id integer;
-- ddl-end --




-- [ Created foreign keys ] --
-- object: site_site_id_fk | type: CONSTRAINT --
-- ALTER TABLE public.bassin DROP CONSTRAINT IF EXISTS site_site_id_fk CASCADE;
ALTER TABLE public.bassin ADD CONSTRAINT site_site_id_fk FOREIGN KEY (site_id)
REFERENCES public.site (site_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: site_site_id_fk | type: CONSTRAINT --
-- ALTER TABLE public.circuit_eau DROP CONSTRAINT IF EXISTS site_site_id_fk CASCADE;
ALTER TABLE public.circuit_eau ADD CONSTRAINT site_site_id_fk FOREIGN KEY (site_id)
REFERENCES public.site (site_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

DROP VIEW IF EXISTS v_poisson_last_bassin CASCADE;

CREATE OR REPLACE VIEW v_poisson_last_bassin
(
  poisson_id,
  bassin_id,
  bassin_nom,
  site_id,
  transfert_date,
  transfert_id,
  evenement_id
)
AS 
 SELECT t.poisson_id,
    bassin.bassin_id,
    bassin.bassin_nom,
    bassin.site_id,
    t.transfert_date,
    t.transfert_id,
    t.evenement_id
   FROM transfert t
     JOIN bassin ON t.bassin_destination = bassin.bassin_id
  WHERE t.transfert_date = (( SELECT max(t1.transfert_date) AS max
           FROM transfert t1
          WHERE t.poisson_id = t1.poisson_id AND t1.bassin_destination > 0));

alter table repartition add column site_id integer,
add constraint site_site_id_fk foreign key (site_id) references site (site_id)
match full on delete no action on update no action;

alter table sequence add column site_id integer,
add constraint site_site_id_fk foreign key (site_id) references site (site_id)
match full on delete no action on update no action;

CREATE SEQUENCE public.sonde_sonde_id_seq
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
	
	
CREATE TABLE public.sonde (
	sonde_id integer NOT NULL DEFAULT nextval('public.sonde_sonde_id_seq'::regclass),
	sonde_name varchar NOT NULL,
	sonde_param json,
	CONSTRAINT sonde_id_pk PRIMARY KEY (sonde_id)

);
-- ddl-end --
COMMENT ON TABLE public.sonde IS 'Table décrivant les procédures d''importation des données de sonde';
-- ddl-end --
COMMENT ON COLUMN public.sonde.sonde_name IS 'Nom du modèle d''intégration des données de la sonde';
-- ddl-end --
COMMENT ON COLUMN public.sonde.sonde_param IS 'Paramètres nécessaires pour gérer l''importation';
-- ddl-end --

insert into sonde (sonde_id, sonde_name, sonde_param) values (1, 'pcwin (xlsx)',
'{"filetype":"xslx","sheetname":"DATA",
"abnormalvalues":[200,14,70,60,0],
"fieldSeparator":" - ",
"circuits":{"BC 1":"BC1", "BC 2":"BC2", "BC 3":"BC3", "BC 4":"BC4", "BR1":"BR1", "BR2":"BR2","BR3":"BR3", "BR4":"BR4", "BR5":"BR5","BS 1":"BS1", "BS 2":"BS2"},
"attributs":{"O":"o2_pc","p":"ph", "S":"salinite", "T":"temperature", "C":"salinite"}
}'
);
select setval('sonde_sonde_id_seq', 1);


/*
 * Cas particulier pour Saint-Seurin : initialisation du site
 */
 insert into site(site_id, site_name) values (1, 'Saint-Seurin');
 select setval('site_site_id_seq', 1);
 update repartition set site_id = 1;
 update circuit_eau set site_id = 1;
 update bassin set site_id = 1;
 update sequence set site_id = 1;
 
