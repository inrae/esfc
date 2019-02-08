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



