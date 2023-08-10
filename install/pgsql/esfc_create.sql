-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 1.0.5
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: Eric esfc
-- object: esfc | type: ROLE --
-- DROP ROLE IF EXISTS esfc;


SET check_function_bodies = false;
-- ddl-end --

-- object: public.alim_populate | type: FUNCTION --
-- DROP FUNCTION IF EXISTS public.alim_populate(date,date,integer,double precision,double precision,double precision,double precision,double precision,double precision,double precision,double precision) CASCADE;
CREATE FUNCTION public.alim_populate (date_debut date, date_fin date, bassin_id integer, larve double precision, terreau double precision, nrd2000 double precision, coppens double precision, biomar double precision, chiro double precision, krill double precision, crevette double precision)
	RETURNS text
	LANGUAGE plpgsql
	VOLATILE 
	CALLED ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 100
	AS $$

DECLARE 
d1 date := date_debut;
retour text := '';
total_distrib float;
id bigint;
BEGIN
LOOP
/*retour := retour ||' '||d1||'@'||bassin_id;*/
total_distrib := larve + terreau + nrd2000 + coppens + biomar + chiro + krill + crevette;
insert into distrib_quotidien (bassin_id, distrib_quotidien_date, total_distribue)
values (bassin_id, d1, total_distrib);
id = currval('distrib_quotidien_distrib_quotidien_id_seq');
if larve > 0 then 
insert into aliment_quotidien (aliment_id, distrib_quotidien_id, quantite)
values (18, id, larve);
end if;

if terreau > 0 then 
insert into aliment_quotidien (aliment_id, distrib_quotidien_id, quantite)
values (12, id, terreau);
end if;

if nrd2000 > 0 then 
insert into aliment_quotidien (aliment_id, distrib_quotidien_id, quantite)
values (19, id, nrd2000);
end if;

if coppens > 0 then 
insert into aliment_quotidien (aliment_id, distrib_quotidien_id, quantite)
values (13, id, coppens);
end if;

if biomar > 0 then 
insert into aliment_quotidien (aliment_id, distrib_quotidien_id, quantite)
values (20, id, biomar);
end if;

if chiro > 0 then 
insert into aliment_quotidien (aliment_id, distrib_quotidien_id, quantite)
values (1, id, chiro);
end if;

if krill > 0 then 
insert into aliment_quotidien (aliment_id, distrib_quotidien_id, quantite)
values (8, id, krill);
end if;

if crevette > 0 then 
insert into aliment_quotidien (aliment_id, distrib_quotidien_id, quantite)
values (17, id, crevette);
end if;


d1 := d1 + 1;
EXIT WHEN d1 = date_fin;
END LOOP;
RETURN retour;
END;

$$;
-- ddl-end --
ALTER FUNCTION public.alim_populate(date,date,integer,double precision,double precision,double precision,double precision,double precision,double precision,double precision,double precision) OWNER TO esfc;
-- ddl-end --

-- object: public.exec | type: FUNCTION --
-- DROP FUNCTION IF EXISTS public.exec(text) CASCADE;
CREATE FUNCTION public.exec (_param1 text)
	RETURNS void
	LANGUAGE plpgsql
	VOLATILE 
	CALLED ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 100
	AS $$

begin
execute $1;  
end   
$$;
-- ddl-end --
ALTER FUNCTION public.exec(text) OWNER TO esfc;
-- ddl-end --

-- object: public.f_bassin_masse_at_date | type: FUNCTION --
-- DROP FUNCTION IF EXISTS public.f_bassin_masse_at_date(integer,timestamp) CASCADE;
CREATE FUNCTION public.f_bassin_masse_at_date (_param1 integer, _param2 timestamp)
	RETURNS real
	LANGUAGE sql
	VOLATILE 
	CALLED ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 100
	AS $$

select sum(f_poisson_masse_at_date(poisson_id, $2))
from transfert t
where  t.transfert_id in 
(select t2.transfert_id from transfert t2 
join poisson using (poisson_id)
left outer join mortalite using (poisson_id)
left outer join sortie using (poisson_id)
where t.poisson_id = t2.poisson_id
and (mortalite_date is null or mortalite_date > $2)
and (sortie_date is null or sortie_date > $2)
and t2.transfert_date <= $2 order by t2.transfert_date desc limit 1)
and t.bassin_destination = $1


$$;
-- ddl-end --
ALTER FUNCTION public.f_bassin_masse_at_date(integer,timestamp) OWNER TO esfc;
-- ddl-end --

-- object: public.f_poisson_masse_at_date | type: FUNCTION --
-- DROP FUNCTION IF EXISTS public.f_poisson_masse_at_date(integer,timestamp) CASCADE;
CREATE FUNCTION public.f_poisson_masse_at_date (_param1 integer, _param2 timestamp)
	RETURNS real
	LANGUAGE sql
	VOLATILE 
	CALLED ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 100
	AS $$

select masse from morphologie
where poisson_id = $1
and morphologie_date <= $2
order by morphologie_date desc
limit 1

$$;
-- ddl-end --
ALTER FUNCTION public.f_poisson_masse_at_date(integer,timestamp) OWNER TO esfc;
-- ddl-end --
COMMENT ON FUNCTION public.f_poisson_masse_at_date(integer,timestamp) IS E'Masse des poissons présents dans un bassin à une date';
-- ddl-end --

-- object: public.masse_bassin_date | type: FUNCTION --
-- DROP FUNCTION IF EXISTS public.masse_bassin_date(integer,date) CASCADE;
CREATE FUNCTION public.masse_bassin_date (bassin integer, madate date)
	RETURNS real
	LANGUAGE plpgsql
	VOLATILE 
	CALLED ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 100
	AS $$

declare masse real;
begin
select sum(poisson_masse_date(poisson_id, madate)) into masse
from transfert
where bassin_destination = poisson_bassin_date(poisson_id, madate)
and bassin_destination = bassin;
return masse;
end

$$;
-- ddl-end --
ALTER FUNCTION public.masse_bassin_date(integer,date) OWNER TO esfc;
-- ddl-end --

-- object: public.poisson_bassin_date | type: FUNCTION --
-- DROP FUNCTION IF EXISTS public.poisson_bassin_date(integer,date) CASCADE;
CREATE FUNCTION public.poisson_bassin_date (id integer, madate date)
	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE 
	CALLED ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 100
	AS $$

declare mortdate date;
declare sortiedate date;
declare bassin int;
begin
select mortalite_date into mortdate from mortalite where poisson_id = id order by mortalite_date desc limit 1;
select sortie_date into sortiedate from sortie where poisson_id = id order by sortie_date desc limit 1;
if (mortdate is null or mortdate > madate) and (sortiedate is null or sortiedate > madate) then
select bassin_destination into bassin
from transfert
where poisson_id = id
and transfert_date <= madate
order by transfert_date desc limit 1;
return bassin;
else
return null;
end if;

end

$$;
-- ddl-end --
ALTER FUNCTION public.poisson_bassin_date(integer,date) OWNER TO esfc;
-- ddl-end --

-- object: public.poisson_masse_date | type: FUNCTION --
-- DROP FUNCTION IF EXISTS public.poisson_masse_date(integer,date) CASCADE;
CREATE FUNCTION public.poisson_masse_date (id integer, madate date)
	RETURNS real
	LANGUAGE sql
	VOLATILE 
	CALLED ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 100
	AS $$

select masse from morphologie
where poisson_id = id
and morphologie_date <= madate
order by morphologie_date desc
limit 1


$$;
-- ddl-end --
ALTER FUNCTION public.poisson_masse_date(integer,date) OWNER TO esfc;
-- ddl-end --
COMMENT ON FUNCTION public.poisson_masse_date(integer,date) IS E'Masse poisson a une date donnee';
-- ddl-end --

-- object: public.update_sturat_geom | type: FUNCTION --
-- DROP FUNCTION IF EXISTS public.update_sturat_geom() CASCADE;
CREATE FUNCTION public.update_sturat_geom ()
	RETURNS void
	LANGUAGE sql
	VOLATILE 
	CALLED ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 100
	AS $$

update sturat.trait_geom set geom_segment = st_setsrid(st_makeline (st_makepoint(longitude_start, latitude_start), st_makepoint(longitude_end, latitude_end)),4326)
where longitude_end is not null and latitude_end is not null;
update sturat.trait_geom set geom_point = st_setsrid (st_makepoint(longitude_start, latitude_start), 4326)
where longitude_start is not null and latitude_start is not null and geom_point is null;

$$;
-- ddl-end --
ALTER FUNCTION public.update_sturat_geom() OWNER TO esfc;
-- ddl-end --

-- object: public.aliment_aliment_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.aliment_aliment_id_seq CASCADE;
CREATE SEQUENCE public.aliment_aliment_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.aliment_aliment_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.aliment | type: TABLE --
-- DROP TABLE IF EXISTS public.aliment CASCADE;
CREATE TABLE public.aliment (
	aliment_id integer NOT NULL DEFAULT nextval('public.aliment_aliment_id_seq'::regclass),
	aliment_type_id integer NOT NULL,
	aliment_libelle character varying NOT NULL,
	actif smallint NOT NULL DEFAULT 1,
	aliment_libelle_court character varying(8) NOT NULL,
	CONSTRAINT aliment_pk PRIMARY KEY (aliment_id)
);
-- ddl-end --
COMMENT ON COLUMN public.aliment.actif IS E'0 : aliment non utilisé\n1 : aliment en cours d''utilisation';
-- ddl-end --
COMMENT ON COLUMN public.aliment.aliment_libelle_court IS E'Nom de l''aliment - 8 caractères';
-- ddl-end --
ALTER TABLE public.aliment OWNER TO esfc;
-- ddl-end --

-- object: public.aliment_categorie | type: TABLE --
-- DROP TABLE IF EXISTS public.aliment_categorie CASCADE;
CREATE TABLE public.aliment_categorie (
	aliment_id integer NOT NULL,
	categorie_id integer NOT NULL,
	CONSTRAINT aliment_categorie_pk PRIMARY KEY (aliment_id,categorie_id)
);
-- ddl-end --
COMMENT ON TABLE public.aliment_categorie IS E'Caractérisation de l''aliment par rapport à la catégorie de poisson nourri (adulte, juvénile, repro)';
-- ddl-end --
ALTER TABLE public.aliment_categorie OWNER TO esfc;
-- ddl-end --

-- object: public.aliment_quotidien_aliment_quotidien_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.aliment_quotidien_aliment_quotidien_id_seq CASCADE;
CREATE SEQUENCE public.aliment_quotidien_aliment_quotidien_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.aliment_quotidien_aliment_quotidien_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.aliment_quotidien | type: TABLE --
-- DROP TABLE IF EXISTS public.aliment_quotidien CASCADE;
CREATE TABLE public.aliment_quotidien (
	aliment_quotidien_id integer NOT NULL DEFAULT nextval('public.aliment_quotidien_aliment_quotidien_id_seq'::regclass),
	aliment_id integer NOT NULL,
	quantite real,
	distrib_quotidien_id integer NOT NULL,
	CONSTRAINT aliment_quotidien_pk PRIMARY KEY (aliment_quotidien_id)
);
-- ddl-end --
COMMENT ON TABLE public.aliment_quotidien IS E'Table des répartitions quotidiennes d''aliments';
-- ddl-end --
COMMENT ON COLUMN public.aliment_quotidien.quantite IS E'Quantité quotidienne distribuée, en grammes';
-- ddl-end --
ALTER TABLE public.aliment_quotidien OWNER TO esfc;
-- ddl-end --

-- object: public.aliment_type_aliment_type_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.aliment_type_aliment_type_id_seq CASCADE;
CREATE SEQUENCE public.aliment_type_aliment_type_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.aliment_type_aliment_type_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.aliment_type | type: TABLE --
-- DROP TABLE IF EXISTS public.aliment_type CASCADE;
CREATE TABLE public.aliment_type (
	aliment_type_id integer NOT NULL DEFAULT nextval('public.aliment_type_aliment_type_id_seq'::regclass),
	aliment_type_libelle character varying NOT NULL,
	CONSTRAINT aliment_type_pk PRIMARY KEY (aliment_type_id)
);
-- ddl-end --
COMMENT ON TABLE public.aliment_type IS E'Type d''aliment (naturel, artificiel, etc.)';
-- ddl-end --
ALTER TABLE public.aliment_type OWNER TO esfc;
-- ddl-end --

-- object: public.analyse_eau_analyse_eau_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.analyse_eau_analyse_eau_id_seq CASCADE;
CREATE SEQUENCE public.analyse_eau_analyse_eau_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.analyse_eau_analyse_eau_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.analyse_eau | type: TABLE --
-- DROP TABLE IF EXISTS public.analyse_eau CASCADE;
CREATE TABLE public.analyse_eau (
	analyse_eau_id integer NOT NULL DEFAULT nextval('public.analyse_eau_analyse_eau_id_seq'::regclass),
	circuit_eau_id integer NOT NULL,
	analyse_eau_date timestamp NOT NULL,
	temperature real,
	oxygene real,
	salinite real,
	ph real,
	nh4 real,
	n_nh4 real,
	no2 real,
	no2_seuil character varying,
	n_no2 real,
	no3 real,
	no3_seuil character varying,
	n_no3 real,
	backwash_mecanique smallint DEFAULT 0,
	backwash_biologique_commentaire character varying,
	debit_eau_riviere real,
	debit_eau_forage real,
	observations character varying,
	nh4_seuil character varying,
	backwash_biologique smallint NOT NULL DEFAULT 0,
	laboratoire_analyse_id integer,
	debit_eau_mer double precision,
	o2_pc double precision,
	CONSTRAINT analyse_eau_pk PRIMARY KEY (analyse_eau_id)
);
-- ddl-end --
COMMENT ON TABLE public.analyse_eau IS E'Liste des analyses d''eau réalisées dans les circuits d''eau';
-- ddl-end --
COMMENT ON COLUMN public.analyse_eau.analyse_eau_date IS E'Date - heure de l''analyse';
-- ddl-end --
COMMENT ON COLUMN public.analyse_eau.temperature IS E'Temperature en degrés centigrades';
-- ddl-end --
COMMENT ON COLUMN public.analyse_eau.oxygene IS E'O2 dissous';
-- ddl-end --
COMMENT ON COLUMN public.analyse_eau.salinite IS E'Salinité en o/oo';
-- ddl-end --
COMMENT ON COLUMN public.analyse_eau.ph IS E'pH - potentiel hydrogène';
-- ddl-end --
COMMENT ON COLUMN public.analyse_eau.nh4 IS E'Oxyde d''ammoniac - NH4+ (n-nh4 x 1.288)';
-- ddl-end --
COMMENT ON COLUMN public.analyse_eau.n_nh4 IS E'Azote ammoniacal (nh4 x 0.776)';
-- ddl-end --
COMMENT ON COLUMN public.analyse_eau.no2 IS E'NO2 - oxyde nitrique';
-- ddl-end --
COMMENT ON COLUMN public.analyse_eau.no2_seuil IS E'NO2 exprimé par rapport à un seuil de référence';
-- ddl-end --
COMMENT ON COLUMN public.analyse_eau.n_no2 IS E'ion nitrite';
-- ddl-end --
COMMENT ON COLUMN public.analyse_eau.no3 IS E'Oxyde nitrate - NO3 - valeur réellement mesurée (n-no3 x 4.427)';
-- ddl-end --
COMMENT ON COLUMN public.analyse_eau.no3_seuil IS E'NO3 - valeur exprimée par rapport à un seuil de référence';
-- ddl-end --
COMMENT ON COLUMN public.analyse_eau.n_no3 IS E'Ion nitrate N-NO3 (NO3 x 0.226)';
-- ddl-end --
COMMENT ON COLUMN public.analyse_eau.backwash_mecanique IS E'0 : non - 1 : oui';
-- ddl-end --
COMMENT ON COLUMN public.analyse_eau.backwash_biologique_commentaire IS E'commentaires lors du backwash biologique';
-- ddl-end --
COMMENT ON COLUMN public.analyse_eau.debit_eau_riviere IS E'Débit d''eau de rivière utilisé (l/mn)';
-- ddl-end --
COMMENT ON COLUMN public.analyse_eau.debit_eau_forage IS E'Débit d''eau de forage utilisé (l/mn)';
-- ddl-end --
COMMENT ON COLUMN public.analyse_eau.observations IS E'Observations lors du prélèvement d''eau';
-- ddl-end --
COMMENT ON COLUMN public.analyse_eau.nh4_seuil IS E'Taux de NH4, exprimé sous forme de seuil ou de fourchette de valeurs';
-- ddl-end --
COMMENT ON COLUMN public.analyse_eau.backwash_biologique IS E'0 : non effectué\n1 : effectué';
-- ddl-end --
COMMENT ON COLUMN public.analyse_eau.debit_eau_mer IS E'En litre/mn';
-- ddl-end --
COMMENT ON COLUMN public.analyse_eau.o2_pc IS E'Oxygène dissous, en pourcentage de saturation';
-- ddl-end --
ALTER TABLE public.analyse_eau OWNER TO esfc;
-- ddl-end --

-- object: public.analyse_metal_analyse_metal_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.analyse_metal_analyse_metal_id_seq CASCADE;
CREATE SEQUENCE public.analyse_metal_analyse_metal_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.analyse_metal_analyse_metal_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.analyse_metal | type: TABLE --
-- DROP TABLE IF EXISTS public.analyse_metal CASCADE;
CREATE TABLE public.analyse_metal (
	analyse_metal_id integer NOT NULL DEFAULT nextval('public.analyse_metal_analyse_metal_id_seq'::regclass),
	analyse_eau_id integer NOT NULL,
	metal_id integer NOT NULL,
	mesure real,
	mesure_seuil character varying,
	CONSTRAINT analyse_metal_pk PRIMARY KEY (analyse_metal_id)
);
-- ddl-end --
COMMENT ON TABLE public.analyse_metal IS E'Table des analyses des métaux';
-- ddl-end --
COMMENT ON COLUMN public.analyse_metal.mesure IS E'Mesure réelle effectuée';
-- ddl-end --
COMMENT ON COLUMN public.analyse_metal.mesure_seuil IS E'Mesure exprimée sous forme de seuil';
-- ddl-end --
ALTER TABLE public.analyse_metal OWNER TO esfc;
-- ddl-end --

-- object: public.anesthesie_anesthesie_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.anesthesie_anesthesie_id_seq CASCADE;
CREATE SEQUENCE public.anesthesie_anesthesie_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.anesthesie_anesthesie_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.anesthesie | type: TABLE --
-- DROP TABLE IF EXISTS public.anesthesie CASCADE;
CREATE TABLE public.anesthesie (
	anesthesie_id integer NOT NULL DEFAULT nextval('public.anesthesie_anesthesie_id_seq'::regclass),
	poisson_id integer NOT NULL,
	evenement_id integer NOT NULL,
	anesthesie_produit_id integer NOT NULL,
	anesthesie_commentaire character varying,
	anesthesie_date timestamp NOT NULL,
	anesthesie_dosage double precision,
	CONSTRAINT anesthesie_pk PRIMARY KEY (anesthesie_id)
);
-- ddl-end --
COMMENT ON TABLE public.anesthesie IS E'Tables des anesthésies pratiquées';
-- ddl-end --
COMMENT ON COLUMN public.anesthesie.anesthesie_date IS E'Date de l''anesthésie';
-- ddl-end --
COMMENT ON COLUMN public.anesthesie.anesthesie_dosage IS E'Dosage du produit, en mg/l';
-- ddl-end --
ALTER TABLE public.anesthesie OWNER TO esfc;
-- ddl-end --

-- object: public.anesthesie_produit_anesthesie_produit_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.anesthesie_produit_anesthesie_produit_id_seq CASCADE;
CREATE SEQUENCE public.anesthesie_produit_anesthesie_produit_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.anesthesie_produit_anesthesie_produit_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.anesthesie_produit | type: TABLE --
-- DROP TABLE IF EXISTS public.anesthesie_produit CASCADE;
CREATE TABLE public.anesthesie_produit (
	anesthesie_produit_id integer NOT NULL DEFAULT nextval('public.anesthesie_produit_anesthesie_produit_id_seq'::regclass),
	anesthesie_produit_libelle character varying NOT NULL,
	anesthesie_produit_actif smallint NOT NULL DEFAULT 1,
	CONSTRAINT anesthesie_produit_pk PRIMARY KEY (anesthesie_produit_id)
);
-- ddl-end --
COMMENT ON TABLE public.anesthesie_produit IS E'Tables des produits utilisés pour l''anesthésie';
-- ddl-end --
COMMENT ON COLUMN public.anesthesie_produit.anesthesie_produit_actif IS E'Le produit est utilisé : 1';
-- ddl-end --
ALTER TABLE public.anesthesie_produit OWNER TO esfc;
-- ddl-end --

-- object: public.anomalie_db_anomalie_db_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.anomalie_db_anomalie_db_id_seq CASCADE;
CREATE SEQUENCE public.anomalie_db_anomalie_db_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.anomalie_db_anomalie_db_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.anomalie_db | type: TABLE --
-- DROP TABLE IF EXISTS public.anomalie_db CASCADE;
CREATE TABLE public.anomalie_db (
	anomalie_db_id integer NOT NULL DEFAULT nextval('public.anomalie_db_anomalie_db_id_seq'::regclass),
	anomalie_db_date date NOT NULL,
	anomalie_db_type_id integer NOT NULL,
	poisson_id integer,
	evenement_id integer,
	anomalie_db_commentaire character varying,
	anomalie_db_statut smallint NOT NULL DEFAULT 1,
	anomalie_db_date_traitement date,
	CONSTRAINT anomalie_db_pk PRIMARY KEY (anomalie_db_id)
);
-- ddl-end --
COMMENT ON TABLE public.anomalie_db IS E'Table des anomalies détectées dans la base de données';
-- ddl-end --
COMMENT ON COLUMN public.anomalie_db.anomalie_db_date IS E'Date de détection de l''anomalie';
-- ddl-end --
COMMENT ON COLUMN public.anomalie_db.anomalie_db_statut IS E'1 : anomalie non traitée\n0 : anomalie levée';
-- ddl-end --
COMMENT ON COLUMN public.anomalie_db.anomalie_db_date_traitement IS E'Date de levée de l''anomalie';
-- ddl-end --
ALTER TABLE public.anomalie_db OWNER TO esfc;
-- ddl-end --

-- object: public.anomalie_db_type_anomalie_db_type_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.anomalie_db_type_anomalie_db_type_id_seq CASCADE;
CREATE SEQUENCE public.anomalie_db_type_anomalie_db_type_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.anomalie_db_type_anomalie_db_type_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.anomalie_db_type | type: TABLE --
-- DROP TABLE IF EXISTS public.anomalie_db_type CASCADE;
CREATE TABLE public.anomalie_db_type (
	anomalie_db_type_id integer NOT NULL DEFAULT nextval('public.anomalie_db_type_anomalie_db_type_id_seq'::regclass),
	anomalie_db_type_libelle character varying NOT NULL,
	CONSTRAINT anomalie_db_type_pk PRIMARY KEY (anomalie_db_type_id)
);
-- ddl-end --
COMMENT ON TABLE public.anomalie_db_type IS E'Types des anomalies détectées dans la base de données';
-- ddl-end --
ALTER TABLE public.anomalie_db_type OWNER TO esfc;
-- ddl-end --

-- object: public.bassin_bassin_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.bassin_bassin_id_seq CASCADE;
CREATE SEQUENCE public.bassin_bassin_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.bassin_bassin_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.bassin | type: TABLE --
-- DROP TABLE IF EXISTS public.bassin CASCADE;
CREATE TABLE public.bassin (
	bassin_id integer NOT NULL DEFAULT nextval('public.bassin_bassin_id_seq'::regclass),
	bassin_zone_id integer,
	bassin_type_id integer,
	circuit_eau_id integer,
	bassin_usage_id integer,
	bassin_nom character varying NOT NULL,
	bassin_description character varying,
	longueur integer,
	largeur_diametre integer,
	surface integer,
	hauteur_eau integer,
	volume integer,
	actif smallint DEFAULT 1,
	site_id integer,
	mode_calcul_masse smallint DEFAULT 0,
	CONSTRAINT bassin_pk PRIMARY KEY (bassin_id)
);
-- ddl-end --
COMMENT ON TABLE public.bassin IS E'Description des bassins';
-- ddl-end --
COMMENT ON COLUMN public.bassin.bassin_nom IS E'Nom du bassin';
-- ddl-end --
COMMENT ON COLUMN public.bassin.bassin_description IS E'Description du bassin';
-- ddl-end --
COMMENT ON COLUMN public.bassin.longueur IS E'En cm';
-- ddl-end --
COMMENT ON COLUMN public.bassin.largeur_diametre IS E'Largeur ou diametre, en cm';
-- ddl-end --
COMMENT ON COLUMN public.bassin.surface IS E'Surface en cm2';
-- ddl-end --
COMMENT ON COLUMN public.bassin.hauteur_eau IS E'Hauteur d''eau, en cm';
-- ddl-end --
COMMENT ON COLUMN public.bassin.volume IS E'Volume, en litre - dm3';
-- ddl-end --
COMMENT ON COLUMN public.bassin.actif IS E'Indique si le bassin est toujours utilisé ou non';
-- ddl-end --
COMMENT ON COLUMN public.bassin.mode_calcul_masse IS E'0: masse globale connue\n1: par échantillonnage par rapport à la dernière date de mesure';
-- ddl-end --
ALTER TABLE public.bassin OWNER TO esfc;
-- ddl-end --

-- object: public.bassin_campagne_bassin_campagne_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.bassin_campagne_bassin_campagne_id_seq CASCADE;
CREATE SEQUENCE public.bassin_campagne_bassin_campagne_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.bassin_campagne_bassin_campagne_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.bassin_campagne | type: TABLE --
-- DROP TABLE IF EXISTS public.bassin_campagne CASCADE;
CREATE TABLE public.bassin_campagne (
	bassin_campagne_id integer NOT NULL DEFAULT nextval('public.bassin_campagne_bassin_campagne_id_seq'::regclass),
	bassin_id integer NOT NULL,
	annee integer NOT NULL,
	bassin_utilisation character varying,
	CONSTRAINT bassin_campagne_pk PRIMARY KEY (bassin_campagne_id)
);
-- ddl-end --
COMMENT ON COLUMN public.bassin_campagne.bassin_utilisation IS E'Utilisation du bassin dans le cadre de la reproduction';
-- ddl-end --
ALTER TABLE public.bassin_campagne OWNER TO esfc;
-- ddl-end --

-- object: public.bassin_document | type: TABLE --
-- DROP TABLE IF EXISTS public.bassin_document CASCADE;
CREATE TABLE public.bassin_document (
	bassin_id integer NOT NULL,
	document_id integer NOT NULL,
	CONSTRAINT bassin_document_pk PRIMARY KEY (bassin_id,document_id)
);
-- ddl-end --
COMMENT ON TABLE public.bassin_document IS E'Table de liaison des bassins avec les documents';
-- ddl-end --
ALTER TABLE public.bassin_document OWNER TO esfc;
-- ddl-end --

-- object: public.bassin_evenement_bassin_evenement_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.bassin_evenement_bassin_evenement_id_seq CASCADE;
CREATE SEQUENCE public.bassin_evenement_bassin_evenement_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.bassin_evenement_bassin_evenement_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.bassin_evenement | type: TABLE --
-- DROP TABLE IF EXISTS public.bassin_evenement CASCADE;
CREATE TABLE public.bassin_evenement (
	bassin_evenement_id integer NOT NULL DEFAULT nextval('public.bassin_evenement_bassin_evenement_id_seq'::regclass),
	bassin_id integer NOT NULL,
	bassin_evenement_type_id integer NOT NULL,
	bassin_evenement_date date NOT NULL,
	bassin_evenement_commentaire character varying,
	CONSTRAINT bassin_evenement_pk PRIMARY KEY (bassin_evenement_id)
);
-- ddl-end --
COMMENT ON TABLE public.bassin_evenement IS E'Table des événements survenant dans les bassins';
-- ddl-end --
COMMENT ON COLUMN public.bassin_evenement.bassin_evenement_date IS E'Date de survenue de l''événement dans le bassin';
-- ddl-end --
COMMENT ON COLUMN public.bassin_evenement.bassin_evenement_commentaire IS E'Commentaire concernant l''événement';
-- ddl-end --
ALTER TABLE public.bassin_evenement OWNER TO esfc;
-- ddl-end --

-- object: public.bassin_evenement_type_bassin_evenement_type_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.bassin_evenement_type_bassin_evenement_type_id_seq CASCADE;
CREATE SEQUENCE public.bassin_evenement_type_bassin_evenement_type_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.bassin_evenement_type_bassin_evenement_type_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.bassin_evenement_type | type: TABLE --
-- DROP TABLE IF EXISTS public.bassin_evenement_type CASCADE;
CREATE TABLE public.bassin_evenement_type (
	bassin_evenement_type_id integer NOT NULL DEFAULT nextval('public.bassin_evenement_type_bassin_evenement_type_id_seq'::regclass),
	bassin_evenement_type_libelle character varying NOT NULL,
	CONSTRAINT bassin_evenement_type_pk PRIMARY KEY (bassin_evenement_type_id)
);
-- ddl-end --
COMMENT ON TABLE public.bassin_evenement_type IS E'Table des types d''événements dans les bassins';
-- ddl-end --
ALTER TABLE public.bassin_evenement_type OWNER TO esfc;
-- ddl-end --

-- object: public.bassin_lot_bassin_lot_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.bassin_lot_bassin_lot_id_seq CASCADE;
CREATE SEQUENCE public.bassin_lot_bassin_lot_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.bassin_lot_bassin_lot_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.bassin_lot | type: TABLE --
-- DROP TABLE IF EXISTS public.bassin_lot CASCADE;
CREATE TABLE public.bassin_lot (
	bassin_lot_id integer NOT NULL DEFAULT nextval('public.bassin_lot_bassin_lot_id_seq'::regclass),
	bassin_id integer NOT NULL,
	lot_id integer NOT NULL,
	bl_date_arrivee timestamp NOT NULL,
	bl_date_depart timestamp,
	CONSTRAINT bassin_lot_pk PRIMARY KEY (bassin_lot_id)
);
-- ddl-end --
COMMENT ON TABLE public.bassin_lot IS E'Suivi des lots dans les bassins';
-- ddl-end --
COMMENT ON COLUMN public.bassin_lot.bl_date_arrivee IS E'Date d''arrivée dans le bassin';
-- ddl-end --
COMMENT ON COLUMN public.bassin_lot.bl_date_depart IS E'Date de départ du bassin';
-- ddl-end --
ALTER TABLE public.bassin_lot OWNER TO esfc;
-- ddl-end --

-- object: public.bassin_type_bassin_type_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.bassin_type_bassin_type_id_seq CASCADE;
CREATE SEQUENCE public.bassin_type_bassin_type_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.bassin_type_bassin_type_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.bassin_type | type: TABLE --
-- DROP TABLE IF EXISTS public.bassin_type CASCADE;
CREATE TABLE public.bassin_type (
	bassin_type_id integer NOT NULL DEFAULT nextval('public.bassin_type_bassin_type_id_seq'::regclass),
	bassin_type_libelle character varying NOT NULL,
	CONSTRAINT bassin_type_pk PRIMARY KEY (bassin_type_id)
);
-- ddl-end --
COMMENT ON TABLE public.bassin_type IS E'Type de bassin';
-- ddl-end --
ALTER TABLE public.bassin_type OWNER TO esfc;
-- ddl-end --

-- object: public.bassin_usage_bassin_usage_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.bassin_usage_bassin_usage_id_seq CASCADE;
CREATE SEQUENCE public.bassin_usage_bassin_usage_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.bassin_usage_bassin_usage_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.bassin_usage | type: TABLE --
-- DROP TABLE IF EXISTS public.bassin_usage CASCADE;
CREATE TABLE public.bassin_usage (
	bassin_usage_id integer NOT NULL DEFAULT nextval('public.bassin_usage_bassin_usage_id_seq'::regclass),
	bassin_usage_libelle character varying NOT NULL,
	categorie_id integer,
	CONSTRAINT bassin_usage_pk PRIMARY KEY (bassin_usage_id)
);
-- ddl-end --
COMMENT ON TABLE public.bassin_usage IS E'Élevage des adultes, des juvéniles, infirmerie, etc.';
-- ddl-end --
ALTER TABLE public.bassin_usage OWNER TO esfc;
-- ddl-end --

-- object: public.bassin_zone_bassin_zone_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.bassin_zone_bassin_zone_id_seq CASCADE;
CREATE SEQUENCE public.bassin_zone_bassin_zone_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.bassin_zone_bassin_zone_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.bassin_zone | type: TABLE --
-- DROP TABLE IF EXISTS public.bassin_zone CASCADE;
CREATE TABLE public.bassin_zone (
	bassin_zone_id integer NOT NULL DEFAULT nextval('public.bassin_zone_bassin_zone_id_seq'::regclass),
	bassin_zone_libelle character varying NOT NULL,
	CONSTRAINT bassin_zone_pk PRIMARY KEY (bassin_zone_id)
);
-- ddl-end --
COMMENT ON TABLE public.bassin_zone IS E'Zones d''implantation des bassins';
-- ddl-end --
ALTER TABLE public.bassin_zone OWNER TO esfc;
-- ddl-end --

-- object: public.biopsie_biopsie_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.biopsie_biopsie_id_seq CASCADE;
CREATE SEQUENCE public.biopsie_biopsie_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.biopsie_biopsie_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.biopsie | type: TABLE --
-- DROP TABLE IF EXISTS public.biopsie CASCADE;
CREATE TABLE public.biopsie (
	biopsie_id integer NOT NULL DEFAULT nextval('public.biopsie_biopsie_id_seq'::regclass),
	poisson_campagne_id integer NOT NULL,
	biopsie_technique_calcul_id integer,
	biopsie_date timestamp,
	diam_moyen real,
	diametre_ecart_type real,
	tx_opi real,
	tx_coloration_normal real,
	ringer_t50 character varying,
	ringer_tx_max real,
	ringer_duree character varying,
	ringer_commentaire character varying,
	tx_eclatement real,
	leibovitz_t50 character varying,
	leibovitz_tx_max real,
	leibovitz_duree character varying,
	leibovitz_commentaire character varying,
	biopsie_commentaire character varying,
	CONSTRAINT biopsie_pk PRIMARY KEY (biopsie_id)
);
-- ddl-end --
COMMENT ON TABLE public.biopsie IS E'Biopsies pratiquées et relevés biométriques correspondants';
-- ddl-end --
COMMENT ON COLUMN public.biopsie.biopsie_date IS E'Date/heure de la biopsie';
-- ddl-end --
COMMENT ON COLUMN public.biopsie.diam_moyen IS E'Diamètre moyen des ovocytes, en mm';
-- ddl-end --
COMMENT ON COLUMN public.biopsie.diametre_ecart_type IS E'Écart type du calcul du diamètre moyen des ovocytes';
-- ddl-end --
COMMENT ON COLUMN public.biopsie.tx_opi IS E'Pourcentage d''ovocytes de forme ovoide';
-- ddl-end --
COMMENT ON COLUMN public.biopsie.tx_coloration_normal IS E'Pourcentage d''ovocytes de coloration normale';
-- ddl-end --
COMMENT ON COLUMN public.biopsie.ringer_t50 IS E'Test Ringer, T50 h ref 12-15 h';
-- ddl-end --
COMMENT ON COLUMN public.biopsie.ringer_tx_max IS E'Test Ringer - Taux max';
-- ddl-end --
COMMENT ON COLUMN public.biopsie.ringer_duree IS E'Test Ringer - durée maxi 17 heures';
-- ddl-end --
COMMENT ON COLUMN public.biopsie.ringer_commentaire IS E'Commentaires concernant le test Ringer';
-- ddl-end --
COMMENT ON COLUMN public.biopsie.tx_eclatement IS E'Taux d''éclatement des ovocytes. Test Ringer/Lelb';
-- ddl-end --
COMMENT ON COLUMN public.biopsie.leibovitz_t50 IS E'T50 - test leibovitz';
-- ddl-end --
COMMENT ON COLUMN public.biopsie.leibovitz_tx_max IS E'Test Leibovitz - taux max';
-- ddl-end --
COMMENT ON COLUMN public.biopsie.leibovitz_duree IS E'Test Leibovitz - durée';
-- ddl-end --
ALTER TABLE public.biopsie OWNER TO esfc;
-- ddl-end --

-- object: public.biopsie_document | type: TABLE --
-- DROP TABLE IF EXISTS public.biopsie_document CASCADE;
CREATE TABLE public.biopsie_document (
	document_id integer NOT NULL,
	biopsie_id integer NOT NULL,
	CONSTRAINT biopsie_document_pk PRIMARY KEY (document_id,biopsie_id)
);
-- ddl-end --
COMMENT ON TABLE public.biopsie_document IS E'Table des documents associés avec la biopsie';
-- ddl-end --
ALTER TABLE public.biopsie_document OWNER TO esfc;
-- ddl-end --

-- object: public.biopsie_technique_calcul_biopsie_technique_calcul_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.biopsie_technique_calcul_biopsie_technique_calcul_id_seq CASCADE;
CREATE SEQUENCE public.biopsie_technique_calcul_biopsie_technique_calcul_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.biopsie_technique_calcul_biopsie_technique_calcul_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.biopsie_technique_calcul | type: TABLE --
-- DROP TABLE IF EXISTS public.biopsie_technique_calcul CASCADE;
CREATE TABLE public.biopsie_technique_calcul (
	biopsie_technique_calcul_id integer NOT NULL DEFAULT nextval('public.biopsie_technique_calcul_biopsie_technique_calcul_id_seq'::regclass),
	biopsie_technique_calcul_libelle character varying NOT NULL,
	CONSTRAINT biopsie_technique_calcul_pk PRIMARY KEY (biopsie_technique_calcul_id)
);
-- ddl-end --
COMMENT ON TABLE public.biopsie_technique_calcul IS E'Table des techniques utilisées pour le calcul du diamètre moyen des ovocytes\n1 : ImageJ\n2 : logiciel Boris';
-- ddl-end --
ALTER TABLE public.biopsie_technique_calcul OWNER TO esfc;
-- ddl-end --

-- object: public.categorie_categorie_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.categorie_categorie_id_seq CASCADE;
CREATE SEQUENCE public.categorie_categorie_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.categorie_categorie_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.categorie | type: TABLE --
-- DROP TABLE IF EXISTS public.categorie CASCADE;
CREATE TABLE public.categorie (
	categorie_id integer NOT NULL DEFAULT nextval('public.categorie_categorie_id_seq'::regclass),
	categorie_libelle character varying NOT NULL,
	CONSTRAINT categorie_pk PRIMARY KEY (categorie_id)
);
-- ddl-end --
COMMENT ON TABLE public.categorie IS E'Catégorie ou destination de l''aliment (juvénile, adulte, reproduction...)';
-- ddl-end --
COMMENT ON COLUMN public.categorie.categorie_libelle IS E'Adulte, juvénile, reproduction...';
-- ddl-end --
ALTER TABLE public.categorie OWNER TO esfc;
-- ddl-end --

-- object: public.circuit_eau_circuit_eau_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.circuit_eau_circuit_eau_id_seq CASCADE;
CREATE SEQUENCE public.circuit_eau_circuit_eau_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.circuit_eau_circuit_eau_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.circuit_eau | type: TABLE --
-- DROP TABLE IF EXISTS public.circuit_eau CASCADE;
CREATE TABLE public.circuit_eau (
	circuit_eau_id integer NOT NULL DEFAULT nextval('public.circuit_eau_circuit_eau_id_seq'::regclass),
	circuit_eau_libelle character varying NOT NULL,
	circuit_eau_actif smallint,
	site_id integer,
	CONSTRAINT circuit_eau_pk PRIMARY KEY (circuit_eau_id)
);
-- ddl-end --
COMMENT ON TABLE public.circuit_eau IS E'Circuit d''eau utilisé par le ou les bassins';
-- ddl-end --
COMMENT ON COLUMN public.circuit_eau.circuit_eau_actif IS E'0 : circuit d''eau non utilisé\n1 : circuit d''eau en service';
-- ddl-end --
ALTER TABLE public.circuit_eau OWNER TO esfc;
-- ddl-end --

-- object: public.circuit_evenement_circuit_evenement_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.circuit_evenement_circuit_evenement_id_seq CASCADE;
CREATE SEQUENCE public.circuit_evenement_circuit_evenement_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.circuit_evenement_circuit_evenement_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.circuit_evenement | type: TABLE --
-- DROP TABLE IF EXISTS public.circuit_evenement CASCADE;
CREATE TABLE public.circuit_evenement (
	circuit_evenement_id integer NOT NULL DEFAULT nextval('public.circuit_evenement_circuit_evenement_id_seq'::regclass),
	circuit_eau_id integer NOT NULL,
	circuit_evenement_type_id integer NOT NULL,
	circuit_evenement_date timestamp NOT NULL,
	circuit_evenement_commentaire character varying,
	CONSTRAINT circuit_evenement_pk PRIMARY KEY (circuit_evenement_id)
);
-- ddl-end --
COMMENT ON TABLE public.circuit_evenement IS E'Table des événements sur les circuits d''eau';
-- ddl-end --
ALTER TABLE public.circuit_evenement OWNER TO esfc;
-- ddl-end --

-- object: public.circuit_evenement_type_circuit_evenement_type_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.circuit_evenement_type_circuit_evenement_type_id_seq CASCADE;
CREATE SEQUENCE public.circuit_evenement_type_circuit_evenement_type_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.circuit_evenement_type_circuit_evenement_type_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.circuit_evenement_type | type: TABLE --
-- DROP TABLE IF EXISTS public.circuit_evenement_type CASCADE;
CREATE TABLE public.circuit_evenement_type (
	circuit_evenement_type_id integer NOT NULL DEFAULT nextval('public.circuit_evenement_type_circuit_evenement_type_id_seq'::regclass),
	circuit_evenement_type_libelle character varying NOT NULL,
	CONSTRAINT circuit_evenement_type_pk PRIMARY KEY (circuit_evenement_type_id)
);
-- ddl-end --
COMMENT ON TABLE public.circuit_evenement_type IS E'Table des types d''événement pour les circuits d''eau';
-- ddl-end --
ALTER TABLE public.circuit_evenement_type OWNER TO esfc;
-- ddl-end --

-- object: public.cohorte_cohorte_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.cohorte_cohorte_id_seq CASCADE;
CREATE SEQUENCE public.cohorte_cohorte_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.cohorte_cohorte_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.cohorte | type: TABLE --
-- DROP TABLE IF EXISTS public.cohorte CASCADE;
CREATE TABLE public.cohorte (
	cohorte_id integer NOT NULL DEFAULT nextval('public.cohorte_cohorte_id_seq'::regclass),
	poisson_id integer NOT NULL,
	evenement_id integer NOT NULL,
	cohorte_determination character varying,
	cohorte_commentaire character varying,
	cohorte_date date,
	cohorte_type_id integer,
	CONSTRAINT cohorte_pk PRIMARY KEY (cohorte_id)
);
-- ddl-end --
COMMENT ON TABLE public.cohorte IS E'Table des déterminations de cohortes';
-- ddl-end --
COMMENT ON COLUMN public.cohorte.cohorte_determination IS E'Valeur déterminée';
-- ddl-end --
COMMENT ON COLUMN public.cohorte.cohorte_date IS E'Date de détermination de la cohorte';
-- ddl-end --
ALTER TABLE public.cohorte OWNER TO esfc;
-- ddl-end --

-- object: public.cohorte_type_cohorte_type_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.cohorte_type_cohorte_type_id_seq CASCADE;
CREATE SEQUENCE public.cohorte_type_cohorte_type_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.cohorte_type_cohorte_type_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.cohorte_type | type: TABLE --
-- DROP TABLE IF EXISTS public.cohorte_type CASCADE;
CREATE TABLE public.cohorte_type (
	cohorte_type_id integer NOT NULL DEFAULT nextval('public.cohorte_type_cohorte_type_id_seq'::regclass),
	cohorte_type_libelle character varying NOT NULL,
	CONSTRAINT cohorte_type_pk PRIMARY KEY (cohorte_type_id)
);
-- ddl-end --
COMMENT ON TABLE public.cohorte_type IS E'Type de détermination des cohortes';
-- ddl-end --
ALTER TABLE public.cohorte_type OWNER TO esfc;
-- ddl-end --

-- object: public.croisement_croisement_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.croisement_croisement_id_seq CASCADE;
CREATE SEQUENCE public.croisement_croisement_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.croisement_croisement_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.croisement | type: TABLE --
-- DROP TABLE IF EXISTS public.croisement CASCADE;
CREATE TABLE public.croisement (
	croisement_id integer NOT NULL DEFAULT nextval('public.croisement_croisement_id_seq'::regclass),
	sequence_id integer NOT NULL,
	croisement_qualite_id integer,
	croisement_nom character varying NOT NULL,
	croisement_date timestamp,
	ovocyte_masse real,
	ovocyte_densite real,
	tx_fecondation real,
	tx_survie_estime real,
	croisement_parents character varying,
	CONSTRAINT croisement_pk PRIMARY KEY (croisement_id)
);
-- ddl-end --
COMMENT ON TABLE public.croisement IS E'Table des croisements réalisés';
-- ddl-end --
COMMENT ON COLUMN public.croisement.croisement_nom IS E'Nom du croisement';
-- ddl-end --
COMMENT ON COLUMN public.croisement.croisement_date IS E'Date/heure de la fécondation';
-- ddl-end --
COMMENT ON COLUMN public.croisement.ovocyte_masse IS E'Masse des ovocytes utilisés dans le croisement, en grammes';
-- ddl-end --
COMMENT ON COLUMN public.croisement.ovocyte_densite IS E'Nbre d''ovocytes par gramme';
-- ddl-end --
COMMENT ON COLUMN public.croisement.tx_fecondation IS E'Taux de fécondation';
-- ddl-end --
COMMENT ON COLUMN public.croisement.tx_survie_estime IS E'Taux de survie estimé';
-- ddl-end --
COMMENT ON COLUMN public.croisement.croisement_parents IS E'Parents du croisement, sous forme textuelle';
-- ddl-end --
ALTER TABLE public.croisement OWNER TO esfc;
-- ddl-end --

-- object: public.croisement_qualite | type: TABLE --
-- DROP TABLE IF EXISTS public.croisement_qualite CASCADE;
CREATE TABLE public.croisement_qualite (
	croisement_qualite_id integer NOT NULL,
	croisement_qualite_libelle character varying NOT NULL,
	CONSTRAINT croisement_qualite_pk PRIMARY KEY (croisement_qualite_id)
);
-- ddl-end --
COMMENT ON TABLE public.croisement_qualite IS E'Qualité des croisements (1 : très bon, 2 : bon, 3 : moyen, 4 : mauvais)';
-- ddl-end --
ALTER TABLE public.croisement_qualite OWNER TO esfc;
-- ddl-end --

-- object: public.determination_parente_determination_parente_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.determination_parente_determination_parente_id_seq CASCADE;
CREATE SEQUENCE public.determination_parente_determination_parente_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.determination_parente_determination_parente_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.determination_parente | type: TABLE --
-- DROP TABLE IF EXISTS public.determination_parente CASCADE;
CREATE TABLE public.determination_parente (
	determination_parente_id integer NOT NULL DEFAULT nextval('public.determination_parente_determination_parente_id_seq'::regclass),
	determination_parente_libelle character varying NOT NULL,
	CONSTRAINT determination_parente_pk PRIMARY KEY (determination_parente_id)
);
-- ddl-end --
COMMENT ON TABLE public.determination_parente IS E'Méthodes de détermination de la parentèle d''un poisson\n1 : données de reproduction\n2 : génétique\n3 : non réalisable';
-- ddl-end --
ALTER TABLE public.determination_parente OWNER TO esfc;
-- ddl-end --

-- object: public.devenir_devenir_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.devenir_devenir_id_seq CASCADE;
CREATE SEQUENCE public.devenir_devenir_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.devenir_devenir_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.devenir | type: TABLE --
-- DROP TABLE IF EXISTS public.devenir CASCADE;
CREATE TABLE public.devenir (
	devenir_id integer NOT NULL DEFAULT nextval('public.devenir_devenir_id_seq'::regclass),
	devenir_type_id integer NOT NULL,
	lot_id integer,
	sortie_lieu_id integer,
	categorie_id integer NOT NULL,
	devenir_date timestamp NOT NULL,
	poisson_nombre integer,
	parent_devenir_id integer,
	CONSTRAINT devenir_pk PRIMARY KEY (devenir_id)
);
-- ddl-end --
COMMENT ON TABLE public.devenir IS E'Table des devenirs des lots, et des lachers non rattachables';
-- ddl-end --
COMMENT ON COLUMN public.devenir.devenir_date IS E'Date de lâcher ou d''intégration dans le stock';
-- ddl-end --
COMMENT ON COLUMN public.devenir.poisson_nombre IS E'Nombre de poissons concernés';
-- ddl-end --
COMMENT ON COLUMN public.devenir.parent_devenir_id IS E'Pour un lot, permet de suivre les différentes destinations successives';
-- ddl-end --
ALTER TABLE public.devenir OWNER TO esfc;
-- ddl-end --

-- object: public.devenir_type | type: TABLE --
-- DROP TABLE IF EXISTS public.devenir_type CASCADE;
CREATE TABLE public.devenir_type (
	devenir_type_id integer NOT NULL,
	devenir_type_libelle character varying NOT NULL,
	CONSTRAINT devenir_type_pk PRIMARY KEY (devenir_type_id)
);
-- ddl-end --
COMMENT ON TABLE public.devenir_type IS E'Table des types de devenir :\n1 : lâcher\n2 : stock captif';
-- ddl-end --
ALTER TABLE public.devenir_type OWNER TO esfc;
-- ddl-end --

-- object: public.distrib_quotidien_distrib_quotidien_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.distrib_quotidien_distrib_quotidien_id_seq CASCADE;
CREATE SEQUENCE public.distrib_quotidien_distrib_quotidien_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.distrib_quotidien_distrib_quotidien_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.distrib_quotidien | type: TABLE --
-- DROP TABLE IF EXISTS public.distrib_quotidien CASCADE;
CREATE TABLE public.distrib_quotidien (
	distrib_quotidien_id integer NOT NULL DEFAULT nextval('public.distrib_quotidien_distrib_quotidien_id_seq'::regclass),
	bassin_id integer NOT NULL,
	distrib_quotidien_date date NOT NULL,
	total_distribue real,
	reste real,
	CONSTRAINT distrib_quotidien_pk PRIMARY KEY (distrib_quotidien_id)
);
-- ddl-end --
COMMENT ON TABLE public.distrib_quotidien IS E'Table générale récapitulant les distributions quotidiennes';
-- ddl-end --
COMMENT ON COLUMN public.distrib_quotidien.total_distribue IS E'Quantité totale distribuée, en grammes';
-- ddl-end --
COMMENT ON COLUMN public.distrib_quotidien.reste IS E'Reste estimé, en grammes';
-- ddl-end --
ALTER TABLE public.distrib_quotidien OWNER TO esfc;
-- ddl-end --

-- object: public.distribution_distribution_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.distribution_distribution_id_seq CASCADE;
CREATE SEQUENCE public.distribution_distribution_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.distribution_distribution_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.distribution | type: TABLE --
-- DROP TABLE IF EXISTS public.distribution CASCADE;
CREATE TABLE public.distribution (
	distribution_id integer NOT NULL DEFAULT nextval('public.distribution_distribution_id_seq'::regclass),
	repartition_id integer NOT NULL,
	bassin_id integer NOT NULL,
	evol_taux_nourrissage real,
	taux_nourrissage real,
	total_distribue real,
	ration_commentaire character varying,
	distribution_consigne character varying,
	repart_template_id integer NOT NULL,
	distribution_masse real,
	reste_zone_calcul character varying,
	reste_total real,
	taux_reste real,
	distribution_id_prec integer,
	distribution_jour character varying,
	distribution_jour_soir character varying,
	CONSTRAINT distribution_pk PRIMARY KEY (distribution_id)
);
-- ddl-end --
COMMENT ON TABLE public.distribution IS E'Table de distribution des aliments pour une période donnée';
-- ddl-end --
COMMENT ON COLUMN public.distribution.evol_taux_nourrissage IS E'Evolution du taux de nourrissage par rapport à la semaine précédente, (pourcentage de la biomasse * 100)';
-- ddl-end --
COMMENT ON COLUMN public.distribution.taux_nourrissage IS E'Taux quotidien de nourrissage (pourcentage de la biomasse  * 100)';
-- ddl-end --
COMMENT ON COLUMN public.distribution.total_distribue IS E'Ration totale distribuee, en grammes';
-- ddl-end --
COMMENT ON COLUMN public.distribution.ration_commentaire IS E'Commentaires sur la manière dont la ration a été consommée';
-- ddl-end --
COMMENT ON COLUMN public.distribution.distribution_consigne IS E'Consignes de distribution';
-- ddl-end --
COMMENT ON COLUMN public.distribution.distribution_masse IS E'Masse (poids) des poissons dans le bassin';
-- ddl-end --
COMMENT ON COLUMN public.distribution.reste_zone_calcul IS E'Zone permettant de saisir les différents restes quotidiens, pour totalisation.\nAccepte uniquement des chiffres et le signe +';
-- ddl-end --
COMMENT ON COLUMN public.distribution.reste_total IS E'Quantité de nourriture restante totale pour la période';
-- ddl-end --
COMMENT ON COLUMN public.distribution.taux_reste IS E'Taux de reste : reste / quantité distribuée * 100';
-- ddl-end --
COMMENT ON COLUMN public.distribution.distribution_id_prec IS E'Identifiant de la distribution precedente';
-- ddl-end --
COMMENT ON COLUMN public.distribution.distribution_jour IS E'Jour de distribution, selon la forme :\n1,1,1,1,1,1,1\nLe premier chiffre correspond au lundi';
-- ddl-end --
COMMENT ON COLUMN public.distribution.distribution_jour_soir IS E'Distribution exclusivement le soir d''une demi-ration';
-- ddl-end --
ALTER TABLE public.distribution OWNER TO esfc;
-- ddl-end --

-- object: public.document_document_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.document_document_id_seq CASCADE;
CREATE SEQUENCE public.document_document_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.document_document_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.document | type: TABLE --
-- DROP TABLE IF EXISTS public.document CASCADE;
CREATE TABLE public.document (
	document_id integer NOT NULL DEFAULT nextval('public.document_document_id_seq'::regclass),
	mime_type_id integer NOT NULL,
	document_date_import date NOT NULL,
	document_nom character varying NOT NULL,
	document_description character varying,
	data bytea,
	size integer,
	thumbnail bytea,
	document_date_creation timestamp,
	CONSTRAINT document_pk PRIMARY KEY (document_id)
);
-- ddl-end --
COMMENT ON TABLE public.document IS E'Documents numériques rattachés à un poisson ou à un événement';
-- ddl-end --
COMMENT ON COLUMN public.document.document_nom IS E'Nom d''origine du document';
-- ddl-end --
COMMENT ON COLUMN public.document.document_description IS E'Description libre du document';
-- ddl-end --
COMMENT ON COLUMN public.document.document_date_creation IS E'Date de création du document (date de prise de vue de la photo)';
-- ddl-end --
ALTER TABLE public.document OWNER TO esfc;
-- ddl-end --

-- object: public.dosage_sanguin_dosage_sanguin_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.dosage_sanguin_dosage_sanguin_id_seq CASCADE;
CREATE SEQUENCE public.dosage_sanguin_dosage_sanguin_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.dosage_sanguin_dosage_sanguin_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.dosage_sanguin | type: TABLE --
-- DROP TABLE IF EXISTS public.dosage_sanguin CASCADE;
CREATE TABLE public.dosage_sanguin (
	dosage_sanguin_id integer NOT NULL DEFAULT nextval('public.dosage_sanguin_dosage_sanguin_id_seq'::regclass),
	poisson_campagne_id integer,
	dosage_sanguin_date timestamp,
	tx_e2 real,
	tx_e2_texte character varying,
	tx_calcium real,
	tx_hematocrite real,
	dosage_sanguin_commentaire character varying,
	evenement_id integer,
	poisson_id integer,
	CONSTRAINT dosage_sanguin_pk PRIMARY KEY (dosage_sanguin_id)
);
-- ddl-end --
COMMENT ON TABLE public.dosage_sanguin IS E'Table des dosages sanguins';
-- ddl-end --
COMMENT ON COLUMN public.dosage_sanguin.tx_e2 IS E'Tx E2, en pg/ml';
-- ddl-end --
COMMENT ON COLUMN public.dosage_sanguin.tx_e2_texte IS E'Taux E2 en pg/ml, sous forme textuelle';
-- ddl-end --
COMMENT ON COLUMN public.dosage_sanguin.tx_calcium IS E'Taux de calcium, en mg/l';
-- ddl-end --
COMMENT ON COLUMN public.dosage_sanguin.tx_hematocrite IS E'Taux d''hématocrite';
-- ddl-end --
ALTER TABLE public.dosage_sanguin OWNER TO esfc;
-- ddl-end --

-- object: public.echographie_echographie_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.echographie_echographie_id_seq CASCADE;
CREATE SEQUENCE public.echographie_echographie_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.echographie_echographie_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.echographie | type: TABLE --
-- DROP TABLE IF EXISTS public.echographie CASCADE;
CREATE TABLE public.echographie (
	echographie_id integer NOT NULL DEFAULT nextval('public.echographie_echographie_id_seq'::regclass),
	evenement_id integer NOT NULL,
	poisson_id integer NOT NULL,
	echographie_date timestamp,
	echographie_commentaire character varying,
	cliche_nb integer,
	cliche_ref character varying,
	stade_gonade_id integer,
	stade_oeuf_id integer,
	CONSTRAINT echographie_pk PRIMARY KEY (echographie_id)
);
-- ddl-end --
COMMENT ON TABLE public.echographie IS E'Echographies réalisées';
-- ddl-end --
COMMENT ON COLUMN public.echographie.echographie_date IS E'Date de l''échographie';
-- ddl-end --
COMMENT ON COLUMN public.echographie.echographie_commentaire IS E'Commentaires de l''échographie';
-- ddl-end --
COMMENT ON COLUMN public.echographie.cliche_nb IS E'Nombre de clichés pris';
-- ddl-end --
COMMENT ON COLUMN public.echographie.cliche_ref IS E'Référence des clichés pris';
-- ddl-end --
ALTER TABLE public.echographie OWNER TO esfc;
-- ddl-end --

-- object: public.evenement_evenement_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.evenement_evenement_id_seq CASCADE;
CREATE SEQUENCE public.evenement_evenement_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.evenement_evenement_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.evenement_document | type: TABLE --
-- DROP TABLE IF EXISTS public.evenement_document CASCADE;
CREATE TABLE public.evenement_document (
	evenement_id integer NOT NULL,
	document_id integer NOT NULL,
	CONSTRAINT evenement_document_pk PRIMARY KEY (evenement_id,document_id)
);
-- ddl-end --
COMMENT ON TABLE public.evenement_document IS E'Table de liaison des événements avec des documents';
-- ddl-end --
ALTER TABLE public.evenement_document OWNER TO esfc;
-- ddl-end --

-- object: public.evenement | type: TABLE --
-- DROP TABLE IF EXISTS public.evenement CASCADE;
CREATE TABLE public.evenement (
	evenement_id integer NOT NULL DEFAULT nextval('public.evenement_evenement_id_seq'::regclass),
	evenement_type_id integer NOT NULL,
	evenement_date timestamp,
	poisson_id integer NOT NULL,
	evenement_commentaire character varying,
	CONSTRAINT evenement_pk PRIMARY KEY (evenement_id)
);
-- ddl-end --
COMMENT ON TABLE public.evenement IS E'Table des événements ou des opérations particulières réalisées';
-- ddl-end --
COMMENT ON COLUMN public.evenement.evenement_commentaire IS E'Commentaire général de l''événement';
-- ddl-end --
ALTER TABLE public.evenement OWNER TO esfc;
-- ddl-end --

-- object: public.evenement_type_evenement_type_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.evenement_type_evenement_type_id_seq CASCADE;
CREATE SEQUENCE public.evenement_type_evenement_type_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.evenement_type_evenement_type_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.evenement_type | type: TABLE --
-- DROP TABLE IF EXISTS public.evenement_type CASCADE;
CREATE TABLE public.evenement_type (
	evenement_type_id integer NOT NULL DEFAULT nextval('public.evenement_type_evenement_type_id_seq'::regclass),
	evenement_type_libelle character varying NOT NULL,
	evenement_type_actif smallint NOT NULL DEFAULT 1,
	CONSTRAINT evenement_type_pk PRIMARY KEY (evenement_type_id)
);
-- ddl-end --
COMMENT ON TABLE public.evenement_type IS E'Table des types d''événements';
-- ddl-end --
COMMENT ON COLUMN public.evenement_type.evenement_type_actif IS E'0 : non, 1 : oui';
-- ddl-end --
ALTER TABLE public.evenement_type OWNER TO esfc;
-- ddl-end --

-- object: public.gender_methode_gender_methode_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.gender_methode_gender_methode_id_seq CASCADE;
CREATE SEQUENCE public.gender_methode_gender_methode_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.gender_methode_gender_methode_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.gender_methode | type: TABLE --
-- DROP TABLE IF EXISTS public.gender_methode CASCADE;
CREATE TABLE public.gender_methode (
	gender_methode_id integer NOT NULL DEFAULT nextval('public.gender_methode_gender_methode_id_seq'::regclass),
	gender_methode_libelle character varying NOT NULL,
	CONSTRAINT gender_methode_pk PRIMARY KEY (gender_methode_id)
);
-- ddl-end --
COMMENT ON TABLE public.gender_methode IS E'Méthodes de détermination du sexe';
-- ddl-end --
ALTER TABLE public.gender_methode OWNER TO esfc;
-- ddl-end --

-- object: public.gender_selection_gender_selection_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.gender_selection_gender_selection_id_seq CASCADE;
CREATE SEQUENCE public.gender_selection_gender_selection_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.gender_selection_gender_selection_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.gender_selection | type: TABLE --
-- DROP TABLE IF EXISTS public.gender_selection CASCADE;
CREATE TABLE public.gender_selection (
	gender_selection_id integer NOT NULL DEFAULT nextval('public.gender_selection_gender_selection_id_seq'::regclass),
	poisson_id integer NOT NULL,
	gender_methode_id integer,
	sexe_id integer,
	gender_selection_date timestamp,
	evenement_id integer,
	gender_selection_commentaire character varying,
	CONSTRAINT gender_selection_pk PRIMARY KEY (gender_selection_id)
);
-- ddl-end --
COMMENT ON TABLE public.gender_selection IS E'Opérations de détermination du sexe';
-- ddl-end --
COMMENT ON COLUMN public.gender_selection.gender_selection_date IS E'Date de détermination';
-- ddl-end --
ALTER TABLE public.gender_selection OWNER TO esfc;
-- ddl-end --

-- object: public.genetique_genetique_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.genetique_genetique_id_seq CASCADE;
CREATE SEQUENCE public.genetique_genetique_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.genetique_genetique_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.genetique | type: TABLE --
-- DROP TABLE IF EXISTS public.genetique CASCADE;
CREATE TABLE public.genetique (
	genetique_id integer NOT NULL DEFAULT nextval('public.genetique_genetique_id_seq'::regclass),
	poisson_id integer NOT NULL,
	evenement_id integer NOT NULL,
	nageoire_id integer,
	genetique_date timestamp NOT NULL,
	genetique_commentaire character varying,
	genetique_reference character varying NOT NULL,
	CONSTRAINT genetique_pk PRIMARY KEY (genetique_id)
);
-- ddl-end --
COMMENT ON TABLE public.genetique IS E'Table des prélèvements réalisés pour des tests génétiques';
-- ddl-end --
COMMENT ON COLUMN public.genetique.genetique_reference IS E'Référence du prélèvement';
-- ddl-end --
ALTER TABLE public.genetique OWNER TO esfc;
-- ddl-end --

-- object: public.hormone_hormone_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.hormone_hormone_id_seq CASCADE;
CREATE SEQUENCE public.hormone_hormone_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.hormone_hormone_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.hormone | type: TABLE --
-- DROP TABLE IF EXISTS public.hormone CASCADE;
CREATE TABLE public.hormone (
	hormone_id integer NOT NULL DEFAULT nextval('public.hormone_hormone_id_seq'::regclass),
	hormone_nom character varying NOT NULL,
	hormone_unite character varying,
	CONSTRAINT hormone_pk PRIMARY KEY (hormone_id)
);
-- ddl-end --
COMMENT ON TABLE public.hormone IS E'Table des hormones injectées lors des reproductions';
-- ddl-end --
COMMENT ON COLUMN public.hormone.hormone_nom IS E'Nom de l''hormone';
-- ddl-end --
COMMENT ON COLUMN public.hormone.hormone_unite IS E'Unité utilisée pour le dosage de l''hormone';
-- ddl-end --
ALTER TABLE public.hormone OWNER TO esfc;
-- ddl-end --

-- object: public.import_alim_import_alim_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.import_alim_import_alim_id_seq CASCADE;
CREATE SEQUENCE public.import_alim_import_alim_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.import_alim_import_alim_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.import_alim | type: TABLE --
-- DROP TABLE IF EXISTS public.import_alim CASCADE;
CREATE TABLE public.import_alim (
	import_alim_id integer NOT NULL DEFAULT nextval('public.import_alim_import_alim_id_seq'::regclass),
	date_debut date NOT NULL,
	date_fin date NOT NULL,
	bassin_id integer NOT NULL,
	larve real,
	terreau real,
	nrd2000 real,
	coppens real,
	biomar real,
	chiro real,
	krill real,
	crevette real,
	CONSTRAINT import_alim_pk PRIMARY KEY (import_alim_id)
);
-- ddl-end --
COMMENT ON TABLE public.import_alim IS E'Table temporaire pour importer les aliments, entre deux dates';
-- ddl-end --
ALTER TABLE public.import_alim OWNER TO esfc;
-- ddl-end --

-- object: public.injection_injection_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.injection_injection_id_seq CASCADE;
CREATE SEQUENCE public.injection_injection_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.injection_injection_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.injection | type: TABLE --
-- DROP TABLE IF EXISTS public.injection CASCADE;
CREATE TABLE public.injection (
	injection_id integer NOT NULL DEFAULT nextval('public.injection_injection_id_seq'::regclass),
	poisson_campagne_id integer NOT NULL,
	sequence_id integer NOT NULL,
	hormone_id integer,
	injection_date timestamp NOT NULL,
	injection_dose real,
	injection_commentaire character varying,
	CONSTRAINT injection_pk PRIMARY KEY (injection_id)
);
-- ddl-end --
COMMENT ON TABLE public.injection IS E'Table des injections d''hormones';
-- ddl-end --
COMMENT ON COLUMN public.injection.injection_date IS E'Date/heure de l''injection réalisée';
-- ddl-end --
COMMENT ON COLUMN public.injection.injection_dose IS E'Dose injectée';
-- ddl-end --
ALTER TABLE public.injection OWNER TO esfc;
-- ddl-end --

-- object: public.laboratoire_analyse_laboratoire_analyse_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.laboratoire_analyse_laboratoire_analyse_id_seq CASCADE;
CREATE SEQUENCE public.laboratoire_analyse_laboratoire_analyse_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.laboratoire_analyse_laboratoire_analyse_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.laboratoire_analyse | type: TABLE --
-- DROP TABLE IF EXISTS public.laboratoire_analyse CASCADE;
CREATE TABLE public.laboratoire_analyse (
	laboratoire_analyse_id integer NOT NULL DEFAULT nextval('public.laboratoire_analyse_laboratoire_analyse_id_seq'::regclass),
	laboratoire_analyse_libelle character varying NOT NULL,
	laboratoire_analyse_actif smallint NOT NULL DEFAULT 1,
	CONSTRAINT laboratoire_analyse_pk PRIMARY KEY (laboratoire_analyse_id)
);
-- ddl-end --
COMMENT ON TABLE public.laboratoire_analyse IS E'Table des laboratoires d''analyse de l''eau';
-- ddl-end --
COMMENT ON COLUMN public.laboratoire_analyse.laboratoire_analyse_libelle IS E'Nom du laboratoire';
-- ddl-end --
COMMENT ON COLUMN public.laboratoire_analyse.laboratoire_analyse_actif IS E'0 : non sollicité actuellement\n1 : laboratoire sollicité actuellement';
-- ddl-end --
ALTER TABLE public.laboratoire_analyse OWNER TO esfc;
-- ddl-end --

-- object: public.lot_lot_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.lot_lot_id_seq CASCADE;
CREATE SEQUENCE public.lot_lot_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.lot_lot_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.lot | type: TABLE --
-- DROP TABLE IF EXISTS public.lot CASCADE;
CREATE TABLE public.lot (
	lot_id integer NOT NULL DEFAULT nextval('public.lot_lot_id_seq'::regclass),
	croisement_id integer NOT NULL,
	lot_nom character varying NOT NULL,
	eclosion_date timestamp,
	nb_larve_initial real,
	nb_larve_compte real,
	vie_date_marquage timestamp,
	vie_modele_id integer,
	CONSTRAINT lot_pk PRIMARY KEY (lot_id),
	CONSTRAINT lot_vie_modele_id UNIQUE (vie_modele_id)
);
-- ddl-end --
COMMENT ON TABLE public.lot IS E'Lots issus des croisements (au moins un lot par croisement réussi)';
-- ddl-end --
COMMENT ON COLUMN public.lot.lot_nom IS E'Nom du lot';
-- ddl-end --
COMMENT ON COLUMN public.lot.eclosion_date IS E'Date d''éclosion';
-- ddl-end --
COMMENT ON COLUMN public.lot.nb_larve_initial IS E'Nombre de larves estimées';
-- ddl-end --
COMMENT ON COLUMN public.lot.nb_larve_compte IS E'Nombre de larves final';
-- ddl-end --
COMMENT ON COLUMN public.lot.vie_date_marquage IS E'Date de marquage du lot avec une marque VIE';
-- ddl-end --
ALTER TABLE public.lot OWNER TO esfc;
-- ddl-end --

-- object: public.lot_mesure_lot_mesure_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.lot_mesure_lot_mesure_id_seq CASCADE;
CREATE SEQUENCE public.lot_mesure_lot_mesure_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.lot_mesure_lot_mesure_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.lot_mesure | type: TABLE --
-- DROP TABLE IF EXISTS public.lot_mesure CASCADE;
CREATE TABLE public.lot_mesure (
	lot_mesure_id integer NOT NULL DEFAULT nextval('public.lot_mesure_lot_mesure_id_seq'::regclass),
	lot_id integer NOT NULL,
	lot_mesure_date timestamp NOT NULL,
	nb_jour integer,
	lot_mortalite integer,
	lot_mesure_masse real,
	lot_mesure_masse_indiv real,
	CONSTRAINT lot_mesure_pk PRIMARY KEY (lot_mesure_id)
);
-- ddl-end --
COMMENT ON TABLE public.lot_mesure IS E'Mesures effectuées sur un lot';
-- ddl-end --
COMMENT ON COLUMN public.lot_mesure.nb_jour IS E'Nbre de jours depuis l''éclosion';
-- ddl-end --
COMMENT ON COLUMN public.lot_mesure.lot_mortalite IS E'Mortalité recensée, en nombre d''individus';
-- ddl-end --
COMMENT ON COLUMN public.lot_mesure.lot_mesure_masse IS E'Masse totale des poissons du lot';
-- ddl-end --
COMMENT ON COLUMN public.lot_mesure.lot_mesure_masse_indiv IS E'Masse moyenne individuelle du lot';
-- ddl-end --
ALTER TABLE public.lot_mesure OWNER TO esfc;
-- ddl-end --

-- object: public.lot_repart_template_lot_repart_template_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.lot_repart_template_lot_repart_template_id_seq CASCADE;
CREATE SEQUENCE public.lot_repart_template_lot_repart_template_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.lot_repart_template_lot_repart_template_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.lot_repart_template | type: TABLE --
-- DROP TABLE IF EXISTS public.lot_repart_template CASCADE;
CREATE TABLE public.lot_repart_template (
	lot_repart_template_id integer NOT NULL DEFAULT nextval('public.lot_repart_template_lot_repart_template_id_seq'::regclass),
	age integer NOT NULL,
	artemia integer,
	chironome real,
	CONSTRAINT lot_repart_template_pk PRIMARY KEY (lot_repart_template_id)
);
-- ddl-end --
COMMENT ON TABLE public.lot_repart_template IS E'Modèle de répartition des aliments pour les lots';
-- ddl-end --
COMMENT ON COLUMN public.lot_repart_template.age IS E'Age, en  jours, du lot (depuis la naissance)';
-- ddl-end --
COMMENT ON COLUMN public.lot_repart_template.artemia IS E'Nombre d''artémia par poisson';
-- ddl-end --
COMMENT ON COLUMN public.lot_repart_template.chironome IS E'Masse de chironomes à distribuer, en pourcentage  de la masse des poissons du lot';
-- ddl-end --
ALTER TABLE public.lot_repart_template OWNER TO esfc;
-- ddl-end --

-- object: public.metal_metal_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.metal_metal_id_seq CASCADE;
CREATE SEQUENCE public.metal_metal_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.metal_metal_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.metal | type: TABLE --
-- DROP TABLE IF EXISTS public.metal CASCADE;
CREATE TABLE public.metal (
	metal_id integer NOT NULL DEFAULT nextval('public.metal_metal_id_seq'::regclass),
	metal_nom character varying NOT NULL,
	metal_unite character varying,
	metal_actif smallint NOT NULL DEFAULT 1,
	CONSTRAINT metal_pk PRIMARY KEY (metal_id)
);
-- ddl-end --
COMMENT ON TABLE public.metal IS E'Table des métaux analysés';
-- ddl-end --
COMMENT ON COLUMN public.metal.metal_nom IS E'Nom du métal analysé';
-- ddl-end --
COMMENT ON COLUMN public.metal.metal_unite IS E'Unité de mesure';
-- ddl-end --
COMMENT ON COLUMN public.metal.metal_actif IS E'1 si le métal est analysé';
-- ddl-end --
ALTER TABLE public.metal OWNER TO esfc;
-- ddl-end --

-- object: public.mime_type_mime_type_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.mime_type_mime_type_id_seq CASCADE;
CREATE SEQUENCE public.mime_type_mime_type_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.mime_type_mime_type_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.mime_type | type: TABLE --
-- DROP TABLE IF EXISTS public.mime_type CASCADE;
CREATE TABLE public.mime_type (
	mime_type_id integer NOT NULL DEFAULT nextval('public.mime_type_mime_type_id_seq'::regclass),
	content_type character varying NOT NULL,
	extension character varying NOT NULL,
	CONSTRAINT mime_type_pk PRIMARY KEY (mime_type_id)
);
-- ddl-end --
COMMENT ON TABLE public.mime_type IS E'Table des types mime, pour les documents associés';
-- ddl-end --
COMMENT ON COLUMN public.mime_type.content_type IS E'type mime officiel';
-- ddl-end --
COMMENT ON COLUMN public.mime_type.extension IS E'Extension du fichier correspondant';
-- ddl-end --
ALTER TABLE public.mime_type OWNER TO esfc;
-- ddl-end --

-- object: public.morphologie_morphologie_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.morphologie_morphologie_id_seq CASCADE;
CREATE SEQUENCE public.morphologie_morphologie_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.morphologie_morphologie_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.morphologie | type: TABLE --
-- DROP TABLE IF EXISTS public.morphologie CASCADE;
CREATE TABLE public.morphologie (
	morphologie_id integer NOT NULL DEFAULT nextval('public.morphologie_morphologie_id_seq'::regclass),
	poisson_id integer NOT NULL,
	longueur_fourche real,
	longueur_totale real,
	morphologie_date timestamp,
	evenement_id integer,
	morphologie_commentaire character varying,
	masse real,
	circonference double precision,
	CONSTRAINT morphologie_pk PRIMARY KEY (morphologie_id)
);
-- ddl-end --
COMMENT ON TABLE public.morphologie IS E'Données morphologiques';
-- ddl-end --
COMMENT ON COLUMN public.morphologie.longueur_fourche IS E'Longueur à la fourche, en cm';
-- ddl-end --
COMMENT ON COLUMN public.morphologie.longueur_totale IS E'longueur totale, en cm';
-- ddl-end --
COMMENT ON COLUMN public.morphologie.masse IS E'Masse de l''animal, en grammes';
-- ddl-end --
COMMENT ON COLUMN public.morphologie.circonference IS E'Circonférence du poisson, en cm';
-- ddl-end --
ALTER TABLE public.morphologie OWNER TO esfc;
-- ddl-end --

-- object: public.mortalite_mortalite_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.mortalite_mortalite_id_seq CASCADE;
CREATE SEQUENCE public.mortalite_mortalite_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.mortalite_mortalite_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.mortalite | type: TABLE --
-- DROP TABLE IF EXISTS public.mortalite CASCADE;
CREATE TABLE public.mortalite (
	mortalite_id integer NOT NULL DEFAULT nextval('public.mortalite_mortalite_id_seq'::regclass),
	poisson_id integer NOT NULL,
	mortalite_type_id integer NOT NULL,
	mortalite_date date,
	mortalite_commentaire character varying,
	evenement_id integer NOT NULL,
	CONSTRAINT mortalite_pk PRIMARY KEY (mortalite_id)
);
-- ddl-end --
COMMENT ON TABLE public.mortalite IS E'Informations concernant la mortalité du poisson';
-- ddl-end --
COMMENT ON COLUMN public.mortalite.mortalite_date IS E'Date de la mortalité';
-- ddl-end --
ALTER TABLE public.mortalite OWNER TO esfc;
-- ddl-end --

-- object: public.mortalite_type_mortalite_type_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.mortalite_type_mortalite_type_id_seq CASCADE;
CREATE SEQUENCE public.mortalite_type_mortalite_type_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.mortalite_type_mortalite_type_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.mortalite_type | type: TABLE --
-- DROP TABLE IF EXISTS public.mortalite_type CASCADE;
CREATE TABLE public.mortalite_type (
	mortalite_type_id integer NOT NULL DEFAULT nextval('public.mortalite_type_mortalite_type_id_seq'::regclass),
	mortalite_type_libelle character varying NOT NULL,
	CONSTRAINT mortalite_type_pk PRIMARY KEY (mortalite_type_id)
);
-- ddl-end --
COMMENT ON TABLE public.mortalite_type IS E'Types de mortalité';
-- ddl-end --
ALTER TABLE public.mortalite_type OWNER TO esfc;
-- ddl-end --

-- object: public.nageoire_nageoire_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.nageoire_nageoire_id_seq CASCADE;
CREATE SEQUENCE public.nageoire_nageoire_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.nageoire_nageoire_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.nageoire | type: TABLE --
-- DROP TABLE IF EXISTS public.nageoire CASCADE;
CREATE TABLE public.nageoire (
	nageoire_id integer NOT NULL DEFAULT nextval('public.nageoire_nageoire_id_seq'::regclass),
	nageoire_libelle character varying NOT NULL,
	CONSTRAINT nageoire_pk PRIMARY KEY (nageoire_id)
);
-- ddl-end --
COMMENT ON TABLE public.nageoire IS E'Nom des nageoires';
-- ddl-end --
ALTER TABLE public.nageoire OWNER TO esfc;
-- ddl-end --

-- object: public.parent_poisson_parent_poisson_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.parent_poisson_parent_poisson_id_seq CASCADE;
CREATE SEQUENCE public.parent_poisson_parent_poisson_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.parent_poisson_parent_poisson_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.parent_poisson | type: TABLE --
-- DROP TABLE IF EXISTS public.parent_poisson CASCADE;
CREATE TABLE public.parent_poisson (
	parent_poisson_id integer NOT NULL DEFAULT nextval('public.parent_poisson_parent_poisson_id_seq'::regclass),
	poisson_id integer NOT NULL,
	parent_id integer NOT NULL,
	CONSTRAINT parent_poisson_pkey PRIMARY KEY (parent_poisson_id)
);
-- ddl-end --
COMMENT ON TABLE public.parent_poisson IS E'Table contenant les parents d''un poisson';
-- ddl-end --
ALTER TABLE public.parent_poisson OWNER TO esfc;
-- ddl-end --

-- object: public.parente_parente_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.parente_parente_id_seq CASCADE;
CREATE SEQUENCE public.parente_parente_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.parente_parente_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.parente | type: TABLE --
-- DROP TABLE IF EXISTS public.parente CASCADE;
CREATE TABLE public.parente (
	parente_id integer NOT NULL DEFAULT nextval('public.parente_parente_id_seq'::regclass),
	evenement_id integer NOT NULL,
	determination_parente_id integer NOT NULL,
	parente_date timestamp NOT NULL,
	parente_commentaire character varying,
	poisson_id integer,
	CONSTRAINT parente_pk PRIMARY KEY (parente_id)
);
-- ddl-end --
COMMENT ON TABLE public.parente IS E'Événement de détermination de la parenté';
-- ddl-end --
ALTER TABLE public.parente OWNER TO esfc;
-- ddl-end --

-- object: public.pathologie_pathologie_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.pathologie_pathologie_id_seq CASCADE;
CREATE SEQUENCE public.pathologie_pathologie_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.pathologie_pathologie_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.pathologie | type: TABLE --
-- DROP TABLE IF EXISTS public.pathologie CASCADE;
CREATE TABLE public.pathologie (
	pathologie_id integer NOT NULL DEFAULT nextval('public.pathologie_pathologie_id_seq'::regclass),
	poisson_id integer NOT NULL,
	pathologie_type_id integer NOT NULL,
	pathologie_date timestamp,
	pathologie_commentaire character varying,
	evenement_id integer,
	pathologie_valeur real,
	CONSTRAINT pathologie_pk PRIMARY KEY (pathologie_id)
);
-- ddl-end --
COMMENT ON TABLE public.pathologie IS E'Liste des pathologies subies par les poissons';
-- ddl-end --
COMMENT ON COLUMN public.pathologie.pathologie_valeur IS E'Valeur numérique associée à la pathologie';
-- ddl-end --
ALTER TABLE public.pathologie OWNER TO esfc;
-- ddl-end --

-- object: public.pathologie_type_pathologie_type_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.pathologie_type_pathologie_type_id_seq CASCADE;
CREATE SEQUENCE public.pathologie_type_pathologie_type_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.pathologie_type_pathologie_type_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.pathologie_type | type: TABLE --
-- DROP TABLE IF EXISTS public.pathologie_type CASCADE;
CREATE TABLE public.pathologie_type (
	pathologie_type_id integer NOT NULL DEFAULT nextval('public.pathologie_type_pathologie_type_id_seq'::regclass),
	pathologie_type_libelle character varying NOT NULL,
	pathologie_type_libelle_court character varying,
	CONSTRAINT pathologie_type_pk PRIMARY KEY (pathologie_type_id)
);
-- ddl-end --
COMMENT ON TABLE public.pathologie_type IS E'Types de pathologie rencontrés';
-- ddl-end --
ALTER TABLE public.pathologie_type OWNER TO esfc;
-- ddl-end --

-- object: public.pittag_pittag_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.pittag_pittag_id_seq CASCADE;
CREATE SEQUENCE public.pittag_pittag_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.pittag_pittag_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.pittag | type: TABLE --
-- DROP TABLE IF EXISTS public.pittag CASCADE;
CREATE TABLE public.pittag (
	pittag_id integer NOT NULL DEFAULT nextval('public.pittag_pittag_id_seq'::regclass),
	poisson_id integer NOT NULL,
	pittag_type_id integer,
	pittag_valeur character varying NOT NULL,
	pittag_date_pose timestamp,
	pittag_commentaire character varying,
	CONSTRAINT pittag_pk PRIMARY KEY (pittag_id)
);
-- ddl-end --
COMMENT ON TABLE public.pittag IS E'Table des marques utilisées pour suivre les poissons';
-- ddl-end --
COMMENT ON COLUMN public.pittag.pittag_valeur IS E'Valeur du pittag (donnée utilisée pour identifier le pittag)';
-- ddl-end --
COMMENT ON COLUMN public.pittag.pittag_commentaire IS E'Commentaire sur la pose du pittag';
-- ddl-end --
ALTER TABLE public.pittag OWNER TO esfc;
-- ddl-end --

-- object: public.pittag_type_pittag_type_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.pittag_type_pittag_type_id_seq CASCADE;
CREATE SEQUENCE public.pittag_type_pittag_type_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.pittag_type_pittag_type_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.pittag_type | type: TABLE --
-- DROP TABLE IF EXISTS public.pittag_type CASCADE;
CREATE TABLE public.pittag_type (
	pittag_type_id integer NOT NULL DEFAULT nextval('public.pittag_type_pittag_type_id_seq'::regclass),
	pittag_type_libelle character varying NOT NULL,
	CONSTRAINT pittag_type_pk PRIMARY KEY (pittag_type_id)
);
-- ddl-end --
COMMENT ON TABLE public.pittag_type IS E'Table des types de pittag';
-- ddl-end --
ALTER TABLE public.pittag_type OWNER TO esfc;
-- ddl-end --

-- object: public.poisson_poisson_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.poisson_poisson_id_seq CASCADE;
CREATE SEQUENCE public.poisson_poisson_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.poisson_poisson_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.poisson_campagne_poisson_campagne_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.poisson_campagne_poisson_campagne_id_seq CASCADE;
CREATE SEQUENCE public.poisson_campagne_poisson_campagne_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.poisson_campagne_poisson_campagne_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.poisson_campagne | type: TABLE --
-- DROP TABLE IF EXISTS public.poisson_campagne CASCADE;
CREATE TABLE public.poisson_campagne (
	poisson_campagne_id integer NOT NULL DEFAULT nextval('public.poisson_campagne_poisson_campagne_id_seq'::regclass),
	poisson_id integer NOT NULL,
	repro_statut_id integer NOT NULL,
	annee integer NOT NULL,
	masse real,
	tx_croissance_journalier real,
	specific_growth_rate real,
	CONSTRAINT poisson_campagne_pk PRIMARY KEY (poisson_campagne_id)
);
-- ddl-end --
COMMENT ON TABLE public.poisson_campagne IS E'Table des données des poissons pour une campagne de reproduction';
-- ddl-end --
COMMENT ON COLUMN public.poisson_campagne.annee IS E'Année de campagne';
-- ddl-end --
COMMENT ON COLUMN public.poisson_campagne.masse IS E'Poids du poisson, en kg';
-- ddl-end --
COMMENT ON COLUMN public.poisson_campagne.tx_croissance_journalier IS E'Taux de croissance journalier';
-- ddl-end --
COMMENT ON COLUMN public.poisson_campagne.specific_growth_rate IS E'SGR : (log(w2) - log(w1) )* 100 / nbJour';
-- ddl-end --
ALTER TABLE public.poisson_campagne OWNER TO esfc;
-- ddl-end --

-- object: public.poisson_croisement | type: TABLE --
-- DROP TABLE IF EXISTS public.poisson_croisement CASCADE;
CREATE TABLE public.poisson_croisement (
	poisson_campagne_id integer NOT NULL,
	croisement_id integer NOT NULL,
	CONSTRAINT poisson_croisement_pk PRIMARY KEY (poisson_campagne_id,croisement_id)
);
-- ddl-end --
ALTER TABLE public.poisson_croisement OWNER TO esfc;
-- ddl-end --

-- object: public.poisson_document | type: TABLE --
-- DROP TABLE IF EXISTS public.poisson_document CASCADE;
CREATE TABLE public.poisson_document (
	poisson_id integer NOT NULL,
	document_id integer NOT NULL,
	CONSTRAINT poisson_document_pk PRIMARY KEY (poisson_id,document_id)
);
-- ddl-end --
COMMENT ON TABLE public.poisson_document IS E'Table de liaison des poissons avec les documents';
-- ddl-end --
ALTER TABLE public.poisson_document OWNER TO esfc;
-- ddl-end --

-- object: public.poisson | type: TABLE --
-- DROP TABLE IF EXISTS public.poisson CASCADE;
CREATE TABLE public.poisson (
	poisson_id integer NOT NULL DEFAULT nextval('public.poisson_poisson_id_seq'::regclass),
	poisson_statut_id integer NOT NULL,
	sexe_id integer,
	matricule character varying,
	prenom character varying,
	cohorte character varying,
	capture_date timestamp,
	date_naissance date,
	categorie_id integer NOT NULL DEFAULT 2,
	commentaire character varying,
	vie_modele_id integer,
	CONSTRAINT poisson_pk PRIMARY KEY (poisson_id)
);
-- ddl-end --
COMMENT ON COLUMN public.poisson.cohorte IS E'Année de naissance ou de capture';
-- ddl-end --
COMMENT ON COLUMN public.poisson.capture_date IS E'Date de la capture';
-- ddl-end --
COMMENT ON COLUMN public.poisson.date_naissance IS E'Date de naissance du poisson';
-- ddl-end --
COMMENT ON COLUMN public.poisson.commentaire IS E'Commentaire général concernant le poisson';
-- ddl-end --
ALTER TABLE public.poisson OWNER TO esfc;
-- ddl-end --

-- object: public.poisson_sequence_poisson_sequence_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.poisson_sequence_poisson_sequence_id_seq CASCADE;
CREATE SEQUENCE public.poisson_sequence_poisson_sequence_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.poisson_sequence_poisson_sequence_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.poisson_sequence | type: TABLE --
-- DROP TABLE IF EXISTS public.poisson_sequence CASCADE;
CREATE TABLE public.poisson_sequence (
	poisson_sequence_id integer NOT NULL DEFAULT nextval('public.poisson_sequence_poisson_sequence_id_seq'::regclass),
	poisson_campagne_id integer NOT NULL,
	sequence_id integer NOT NULL,
	ps_statut_id integer,
	ovocyte_masse real,
	ovocyte_expulsion_date timestamp,
	CONSTRAINT poisson_sequence_pk PRIMARY KEY (poisson_sequence_id)
);
-- ddl-end --
COMMENT ON TABLE public.poisson_sequence IS E'Table de rattachement des reproducteurs à une séquence de reproduction';
-- ddl-end --
COMMENT ON COLUMN public.poisson_sequence.ovocyte_masse IS E'Masse des ovocytes, en grammes';
-- ddl-end --
COMMENT ON COLUMN public.poisson_sequence.ovocyte_expulsion_date IS E'Date-heure d''expulsion des ovocytes';
-- ddl-end --
ALTER TABLE public.poisson_sequence OWNER TO esfc;
-- ddl-end --

-- object: public.poisson_statut_poisson_statut_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.poisson_statut_poisson_statut_id_seq CASCADE;
CREATE SEQUENCE public.poisson_statut_poisson_statut_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.poisson_statut_poisson_statut_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.poisson_statut | type: TABLE --
-- DROP TABLE IF EXISTS public.poisson_statut CASCADE;
CREATE TABLE public.poisson_statut (
	poisson_statut_id integer NOT NULL DEFAULT nextval('public.poisson_statut_poisson_statut_id_seq'::regclass),
	poisson_statut_libelle character varying NOT NULL,
	CONSTRAINT poisson_statut_pk PRIMARY KEY (poisson_statut_id)
);
-- ddl-end --
COMMENT ON TABLE public.poisson_statut IS E'Statuts généraux des poissons (juvénile, adulte, relaché, mort, etc.)';
-- ddl-end --
ALTER TABLE public.poisson_statut OWNER TO esfc;
-- ddl-end --

-- object: public.profil_thermique_profil_thermique_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.profil_thermique_profil_thermique_id_seq CASCADE;
CREATE SEQUENCE public.profil_thermique_profil_thermique_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.profil_thermique_profil_thermique_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.profil_thermique | type: TABLE --
-- DROP TABLE IF EXISTS public.profil_thermique CASCADE;
CREATE TABLE public.profil_thermique (
	profil_thermique_id integer NOT NULL DEFAULT nextval('public.profil_thermique_profil_thermique_id_seq'::regclass),
	bassin_campagne_id integer NOT NULL,
	profil_thermique_type_id integer NOT NULL,
	pf_datetime timestamp NOT NULL,
	pf_temperature real NOT NULL,
	CONSTRAINT profil_thermique_pk PRIMARY KEY (profil_thermique_id)
);
-- ddl-end --
COMMENT ON TABLE public.profil_thermique IS E'Table des profils thermiques d''un bassin';
-- ddl-end --
COMMENT ON COLUMN public.profil_thermique.pf_datetime IS E'Date-heure de la température prévue ou constatée';
-- ddl-end --
COMMENT ON COLUMN public.profil_thermique.pf_temperature IS E'Température prévue ou constatée';
-- ddl-end --
ALTER TABLE public.profil_thermique OWNER TO esfc;
-- ddl-end --

-- object: public.profil_thermique_type | type: TABLE --
-- DROP TABLE IF EXISTS public.profil_thermique_type CASCADE;
CREATE TABLE public.profil_thermique_type (
	profil_thermique_type_id integer NOT NULL,
	profil_thermique_type_libelle character varying NOT NULL,
	CONSTRAINT profil_thermique_type_pk PRIMARY KEY (profil_thermique_type_id)
);
-- ddl-end --
COMMENT ON TABLE public.profil_thermique_type IS E'Table des types de profils thermiques\n1 : constaté\n2 : prévu';
-- ddl-end --
COMMENT ON COLUMN public.profil_thermique_type.profil_thermique_type_libelle IS E'1 : constaté\n2 : prévu';
-- ddl-end --
ALTER TABLE public.profil_thermique_type OWNER TO esfc;
-- ddl-end --

-- object: public.ps_evenement_ps_evenement_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.ps_evenement_ps_evenement_id_seq CASCADE;
CREATE SEQUENCE public.ps_evenement_ps_evenement_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.ps_evenement_ps_evenement_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.ps_evenement | type: TABLE --
-- DROP TABLE IF EXISTS public.ps_evenement CASCADE;
CREATE TABLE public.ps_evenement (
	ps_evenement_id integer NOT NULL DEFAULT nextval('public.ps_evenement_ps_evenement_id_seq'::regclass),
	poisson_sequence_id integer NOT NULL,
	ps_datetime timestamp,
	ps_libelle character varying NOT NULL,
	ps_commentaire character varying,
	CONSTRAINT ps_evenement_pk PRIMARY KEY (ps_evenement_id)
);
-- ddl-end --
COMMENT ON TABLE public.ps_evenement IS E'Table des événements rattachés à un poisson pendant une séquence de reproduction';
-- ddl-end --
COMMENT ON COLUMN public.ps_evenement.ps_libelle IS E'Nature de l''événement réalisé';
-- ddl-end --
COMMENT ON COLUMN public.ps_evenement.ps_commentaire IS E'Commentaire';
-- ddl-end --
ALTER TABLE public.ps_evenement OWNER TO esfc;
-- ddl-end --

-- object: public.ps_statut | type: TABLE --
-- DROP TABLE IF EXISTS public.ps_statut CASCADE;
CREATE TABLE public.ps_statut (
	ps_statut_id integer NOT NULL,
	ps_statut_libelle character varying NOT NULL,
	CONSTRAINT ps_statut_pk PRIMARY KEY (ps_statut_id)
);
-- ddl-end --
COMMENT ON TABLE public.ps_statut IS E'Table des statuts possibles pour un poisson pendant une séquence';
-- ddl-end --
ALTER TABLE public.ps_statut OWNER TO esfc;
-- ddl-end --

-- object: public.repart_aliment_repart_aliment_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.repart_aliment_repart_aliment_id_seq CASCADE;
CREATE SEQUENCE public.repart_aliment_repart_aliment_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.repart_aliment_repart_aliment_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.repart_aliment | type: TABLE --
-- DROP TABLE IF EXISTS public.repart_aliment CASCADE;
CREATE TABLE public.repart_aliment (
	repart_aliment_id integer NOT NULL DEFAULT nextval('public.repart_aliment_repart_aliment_id_seq'::regclass),
	repart_template_id integer NOT NULL,
	aliment_id integer NOT NULL,
	repart_alim_taux real,
	consigne character varying,
	matin real,
	midi real,
	nuit real,
	soir real,
	CONSTRAINT repart_aliment_pk PRIMARY KEY (repart_aliment_id)
);
-- ddl-end --
COMMENT ON TABLE public.repart_aliment IS E'Taux de repartition des aliments pour la repartition consideree';
-- ddl-end --
COMMENT ON COLUMN public.repart_aliment.consigne IS E'Consignes lors de la distribution';
-- ddl-end --
COMMENT ON COLUMN public.repart_aliment.matin IS E'Taux de répartition le matin';
-- ddl-end --
COMMENT ON COLUMN public.repart_aliment.midi IS E'Taux de répartition le midi';
-- ddl-end --
COMMENT ON COLUMN public.repart_aliment.nuit IS E'Taux de répartition la nuit';
-- ddl-end --
COMMENT ON COLUMN public.repart_aliment.soir IS E'Taux de répartition le soir';
-- ddl-end --
ALTER TABLE public.repart_aliment OWNER TO esfc;
-- ddl-end --

-- object: public.repart_template_repart_template_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.repart_template_repart_template_id_seq CASCADE;
CREATE SEQUENCE public.repart_template_repart_template_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.repart_template_repart_template_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.repart_template | type: TABLE --
-- DROP TABLE IF EXISTS public.repart_template CASCADE;
CREATE TABLE public.repart_template (
	repart_template_id integer NOT NULL DEFAULT nextval('public.repart_template_repart_template_id_seq'::regclass),
	categorie_id integer NOT NULL,
	repart_template_libelle character varying,
	repart_template_date date NOT NULL,
	actif smallint NOT NULL DEFAULT 1,
	CONSTRAINT repart_template_pk PRIMARY KEY (repart_template_id)
);
-- ddl-end --
COMMENT ON TABLE public.repart_template IS E'Modèles de répartition des aliments';
-- ddl-end --
COMMENT ON COLUMN public.repart_template.repart_template_libelle IS E'Nom de la répartition';
-- ddl-end --
COMMENT ON COLUMN public.repart_template.repart_template_date IS E'Date de création';
-- ddl-end --
COMMENT ON COLUMN public.repart_template.actif IS E'0 : non actif, 1 : actif';
-- ddl-end --
ALTER TABLE public.repart_template OWNER TO esfc;
-- ddl-end --

-- object: public.repartition_repartition_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.repartition_repartition_id_seq CASCADE;
CREATE SEQUENCE public.repartition_repartition_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.repartition_repartition_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.repartition | type: TABLE --
-- DROP TABLE IF EXISTS public.repartition CASCADE;
CREATE TABLE public.repartition (
	repartition_id integer NOT NULL DEFAULT nextval('public.repartition_repartition_id_seq'::regclass),
	categorie_id integer NOT NULL,
	date_debut_periode date NOT NULL,
	date_fin_periode date NOT NULL,
	densite_artemia real,
	repartition_name character varying,
	site_id integer,
	CONSTRAINT repartition_pk PRIMARY KEY (repartition_id)
);
-- ddl-end --
COMMENT ON TABLE public.repartition IS E'Tableau hebdomadaire (ou autre) de répartition des aliments';
-- ddl-end --
COMMENT ON COLUMN public.repartition.date_debut_periode IS E'Date de début de la répartition';
-- ddl-end --
COMMENT ON COLUMN public.repartition.date_fin_periode IS E'Date de fin d''action du tableau de répartition';
-- ddl-end --
COMMENT ON COLUMN public.repartition.densite_artemia IS E'Densité d''artémia au millilitre';
-- ddl-end --
COMMENT ON COLUMN public.repartition.repartition_name IS E'Libellé permettant de nommer la répartition';
-- ddl-end --
ALTER TABLE public.repartition OWNER TO esfc;
-- ddl-end --

-- object: public.repro_statut | type: TABLE --
-- DROP TABLE IF EXISTS public.repro_statut CASCADE;
CREATE TABLE public.repro_statut (
	repro_statut_id integer NOT NULL,
	repro_statut_libelle character varying NOT NULL,
	CONSTRAINT repro_statut_pk PRIMARY KEY (repro_statut_id)
);
-- ddl-end --
COMMENT ON TABLE public.repro_statut IS E'Table des statuts de la reproduction\n1 : adulte potentiel\n2 : pré-sélectionné';
-- ddl-end --
ALTER TABLE public.repro_statut OWNER TO esfc;
-- ddl-end --

-- object: public.requete_requete_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.requete_requete_id_seq CASCADE;
CREATE SEQUENCE public.requete_requete_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.requete_requete_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.request | type: TABLE --
-- DROP TABLE IF EXISTS public.request CASCADE;
CREATE TABLE public.request (
	request_id integer NOT NULL DEFAULT nextval('public.requete_requete_id_seq'::regclass),
	create_date timestamp NOT NULL,
	last_exec timestamp,
	title character varying NOT NULL,
	body character varying NOT NULL,
	login character varying NOT NULL,
	datefields character varying,
	CONSTRAINT requete_pk PRIMARY KEY (request_id)
);
-- ddl-end --
COMMENT ON TABLE public.request IS E'Table des requêtes dans la base de données';
-- ddl-end --
COMMENT ON COLUMN public.request.create_date IS E'Date de création de la requête';
-- ddl-end --
COMMENT ON COLUMN public.request.last_exec IS E'Date de dernière exécution';
-- ddl-end --
COMMENT ON COLUMN public.request.title IS E'Titre de la requête';
-- ddl-end --
COMMENT ON COLUMN public.request.body IS E'Corps de la requête. Ne pas indiquer SELECT, qui sera rajouté automatiquement.';
-- ddl-end --
COMMENT ON COLUMN public.request.login IS E'Login du créateur de la requête';
-- ddl-end --
COMMENT ON COLUMN public.request.datefields IS E'Liste des champs de type date utilisés dans la requête, séparés par une virgule, pour formatage en sortie';
-- ddl-end --
ALTER TABLE public.request OWNER TO esfc;
-- ddl-end --

-- object: public.salinite_salinite_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.salinite_salinite_id_seq CASCADE;
CREATE SEQUENCE public.salinite_salinite_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.salinite_salinite_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.salinite | type: TABLE --
-- DROP TABLE IF EXISTS public.salinite CASCADE;
CREATE TABLE public.salinite (
	salinite_id integer NOT NULL DEFAULT nextval('public.salinite_salinite_id_seq'::regclass),
	bassin_campagne_id integer NOT NULL,
	profil_thermique_type_id integer NOT NULL,
	salinite_datetime timestamp NOT NULL,
	salinite_tx real NOT NULL,
	CONSTRAINT salinite_pk PRIMARY KEY (salinite_id)
);
-- ddl-end --
COMMENT ON TABLE public.salinite IS E'Table des salinités d''un bassin';
-- ddl-end --
COMMENT ON COLUMN public.salinite.salinite_datetime IS E'Date/heure de mesure';
-- ddl-end --
COMMENT ON COLUMN public.salinite.salinite_tx IS E'Taux de salinité';
-- ddl-end --
ALTER TABLE public.salinite OWNER TO esfc;
-- ddl-end --

-- object: public.sequence_sequence_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.sequence_sequence_id_seq CASCADE;
CREATE SEQUENCE public.sequence_sequence_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.sequence_sequence_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.sequence_evenement_sequence_evenement_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.sequence_evenement_sequence_evenement_id_seq CASCADE;
CREATE SEQUENCE public.sequence_evenement_sequence_evenement_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.sequence_evenement_sequence_evenement_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.sequence_evenement | type: TABLE --
-- DROP TABLE IF EXISTS public.sequence_evenement CASCADE;
CREATE TABLE public.sequence_evenement (
	sequence_evenement_id integer NOT NULL DEFAULT nextval('public.sequence_evenement_sequence_evenement_id_seq'::regclass),
	sequence_id integer NOT NULL,
	sequence_evenement_date timestamp NOT NULL,
	sequence_evenement_libelle character varying NOT NULL,
	sequence_evenement_commentaire character varying,
	CONSTRAINT sequence_evenement_pk PRIMARY KEY (sequence_evenement_id)
);
-- ddl-end --
COMMENT ON TABLE public.sequence_evenement IS E'Table des événements d''une séquence';
-- ddl-end --
COMMENT ON COLUMN public.sequence_evenement.sequence_evenement_date IS E'Date de l''événement';
-- ddl-end --
COMMENT ON COLUMN public.sequence_evenement.sequence_evenement_libelle IS E'Nom de l''événement';
-- ddl-end --
COMMENT ON COLUMN public.sequence_evenement.sequence_evenement_commentaire IS E'Commentaire concernant l''événement';
-- ddl-end --
ALTER TABLE public.sequence_evenement OWNER TO esfc;
-- ddl-end --

-- object: public.sequence | type: TABLE --
-- DROP TABLE IF EXISTS public.sequence CASCADE;
CREATE TABLE public.sequence (
	sequence_id integer NOT NULL DEFAULT nextval('public.sequence_sequence_id_seq'::regclass),
	site_id integer,
	annee integer NOT NULL,
	sequence_nom character varying NOT NULL,
	sequence_date_debut timestamp NOT NULL,
	CONSTRAINT sequence_pk PRIMARY KEY (sequence_id)
);
-- ddl-end --
COMMENT ON TABLE public.sequence IS E'Séquences de reproduction';
-- ddl-end --
COMMENT ON COLUMN public.sequence.annee IS E'Année de campagne';
-- ddl-end --
COMMENT ON COLUMN public.sequence.sequence_nom IS E'Nom de la séquence (S1, S2, S3...)';
-- ddl-end --
COMMENT ON COLUMN public.sequence.sequence_date_debut IS E'Date prévisionnelle de début de séquence de repro';
-- ddl-end --
ALTER TABLE public.sequence OWNER TO esfc;
-- ddl-end --

-- object: public.sexe_sexe_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.sexe_sexe_id_seq CASCADE;
CREATE SEQUENCE public.sexe_sexe_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.sexe_sexe_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.sexe | type: TABLE --
-- DROP TABLE IF EXISTS public.sexe CASCADE;
CREATE TABLE public.sexe (
	sexe_id integer NOT NULL DEFAULT nextval('public.sexe_sexe_id_seq'::regclass),
	sexe_libelle character varying NOT NULL,
	sexe_libelle_court character varying NOT NULL,
	CONSTRAINT sexe_pk PRIMARY KEY (sexe_id)
);
-- ddl-end --
COMMENT ON TABLE public.sexe IS E'Table des genres';
-- ddl-end --
COMMENT ON COLUMN public.sexe.sexe_libelle IS E'Libellé long';
-- ddl-end --
COMMENT ON COLUMN public.sexe.sexe_libelle_court IS E'Libellé court';
-- ddl-end --
ALTER TABLE public.sexe OWNER TO esfc;
-- ddl-end --

-- object: public.sortie_sortie_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.sortie_sortie_id_seq CASCADE;
CREATE SEQUENCE public.sortie_sortie_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.sortie_sortie_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.sortie_lieu_sortie_lieu_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.sortie_lieu_sortie_lieu_id_seq CASCADE;
CREATE SEQUENCE public.sortie_lieu_sortie_lieu_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.sortie_lieu_sortie_lieu_id_seq OWNER TO esfc;
-- ddl-end --

-- object: postgis | type: EXTENSION --
-- DROP EXTENSION IF EXISTS postgis CASCADE;
CREATE EXTENSION postgis
;
-- ddl-end --

-- object: public.sortie | type: TABLE --
-- DROP TABLE IF EXISTS public.sortie CASCADE;
CREATE TABLE public.sortie (
	sortie_id integer NOT NULL DEFAULT nextval('public.sortie_sortie_id_seq'::regclass),
	poisson_id integer NOT NULL,
	evenement_id integer NOT NULL,
	sortie_lieu_id integer NOT NULL,
	sortie_date date,
	sortie_commentaire character varying,
	sevre character varying,
	CONSTRAINT sortie_pk PRIMARY KEY (sortie_id)
);
-- ddl-end --
COMMENT ON TABLE public.sortie IS E'Table des sorties du stock';
-- ddl-end --
COMMENT ON COLUMN public.sortie.sortie_date IS E'Date du lâcher';
-- ddl-end --
COMMENT ON COLUMN public.sortie.sortie_commentaire IS E'Remarques sur la sortie';
-- ddl-end --
COMMENT ON COLUMN public.sortie.sevre IS E'Poisson sevré : oui, non, mixte...';
-- ddl-end --
ALTER TABLE public.sortie OWNER TO esfc;
-- ddl-end --

-- object: public.sperme_sperme_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.sperme_sperme_id_seq CASCADE;
CREATE SEQUENCE public.sperme_sperme_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.sperme_sperme_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.sperme_aspect_sperme_aspect_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.sperme_aspect_sperme_aspect_id_seq CASCADE;
CREATE SEQUENCE public.sperme_aspect_sperme_aspect_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.sperme_aspect_sperme_aspect_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.sperme_aspect | type: TABLE --
-- DROP TABLE IF EXISTS public.sperme_aspect CASCADE;
CREATE TABLE public.sperme_aspect (
	sperme_aspect_id integer NOT NULL DEFAULT nextval('public.sperme_aspect_sperme_aspect_id_seq'::regclass),
	sperme_aspect_libelle character varying NOT NULL,
	CONSTRAINT sperme_aspect_pk PRIMARY KEY (sperme_aspect_id)
);
-- ddl-end --
COMMENT ON TABLE public.sperme_aspect IS E'Aspect visuel du sperme';
-- ddl-end --
ALTER TABLE public.sperme_aspect OWNER TO esfc;
-- ddl-end --

-- object: public.sperme_caract | type: TABLE --
-- DROP TABLE IF EXISTS public.sperme_caract CASCADE;
CREATE TABLE public.sperme_caract (
	sperme_id integer NOT NULL,
	sperme_caracteristique_id integer NOT NULL,
	CONSTRAINT sperme_caract_pk PRIMARY KEY (sperme_id,sperme_caracteristique_id)
);
-- ddl-end --
COMMENT ON TABLE public.sperme_caract IS E'Table de relation entre sperme et sperme_caracteristique';
-- ddl-end --
ALTER TABLE public.sperme_caract OWNER TO esfc;
-- ddl-end --

-- object: public.sperme_caracteristique_sperme_caracteristique_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.sperme_caracteristique_sperme_caracteristique_id_seq CASCADE;
CREATE SEQUENCE public.sperme_caracteristique_sperme_caracteristique_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.sperme_caracteristique_sperme_caracteristique_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.sperme_caracteristique | type: TABLE --
-- DROP TABLE IF EXISTS public.sperme_caracteristique CASCADE;
CREATE TABLE public.sperme_caracteristique (
	sperme_caracteristique_id integer NOT NULL DEFAULT nextval('public.sperme_caracteristique_sperme_caracteristique_id_seq'::regclass),
	sperme_caracteristique_libelle character varying NOT NULL,
	CONSTRAINT sperme_caracteristique_pk PRIMARY KEY (sperme_caracteristique_id)
);
-- ddl-end --
COMMENT ON TABLE public.sperme_caracteristique IS E'Table des caractéristiques complémentaires du sperme';
-- ddl-end --
ALTER TABLE public.sperme_caracteristique OWNER TO esfc;
-- ddl-end --

-- object: public.sperme_congelation_sperme_congelation_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.sperme_congelation_sperme_congelation_id_seq CASCADE;
CREATE SEQUENCE public.sperme_congelation_sperme_congelation_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.sperme_congelation_sperme_congelation_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.sperme_congelation | type: TABLE --
-- DROP TABLE IF EXISTS public.sperme_congelation CASCADE;
CREATE TABLE public.sperme_congelation (
	sperme_congelation_id integer NOT NULL DEFAULT nextval('public.sperme_congelation_sperme_congelation_id_seq'::regclass),
	sperme_id integer NOT NULL,
	sperme_dilueur_id integer,
	congelation_date timestamp NOT NULL,
	congelation_volume real,
	nb_paillette integer,
	nb_visiotube integer,
	sperme_congelation_commentaire character varying,
	nb_paillettes_utilisees integer,
	sperme_conservateur_id integer DEFAULT 1,
	volume_conservateur real,
	volume_dilueur real,
	volume_sperme real,
	CONSTRAINT sperme_congelation_pk PRIMARY KEY (sperme_congelation_id)
);
-- ddl-end --
COMMENT ON TABLE public.sperme_congelation IS E'Table des congélations de sperme';
-- ddl-end --
COMMENT ON COLUMN public.sperme_congelation.sperme_dilueur_id IS E'Dilueur de sperme utilisé';
-- ddl-end --
COMMENT ON COLUMN public.sperme_congelation.congelation_date IS E'Date de congélation de la semence';
-- ddl-end --
COMMENT ON COLUMN public.sperme_congelation.congelation_volume IS E'Volume congelé, en ml';
-- ddl-end --
COMMENT ON COLUMN public.sperme_congelation.nb_paillette IS E'Nombre de paillettes préparées';
-- ddl-end --
COMMENT ON COLUMN public.sperme_congelation.nb_visiotube IS E'Nombre de visiotubes utilisés';
-- ddl-end --
ALTER TABLE public.sperme_congelation OWNER TO esfc;
-- ddl-end --

-- object: public.sperme_conservateur_sperme_conservateur_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.sperme_conservateur_sperme_conservateur_id_seq CASCADE;
CREATE SEQUENCE public.sperme_conservateur_sperme_conservateur_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.sperme_conservateur_sperme_conservateur_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.sperme_conservateur | type: TABLE --
-- DROP TABLE IF EXISTS public.sperme_conservateur CASCADE;
CREATE TABLE public.sperme_conservateur (
	sperme_conservateur_id integer NOT NULL DEFAULT nextval('public.sperme_conservateur_sperme_conservateur_id_seq'::regclass),
	sperme_conservateur_libelle character varying NOT NULL,
	CONSTRAINT sperme_conservateur_pk PRIMARY KEY (sperme_conservateur_id)
);
-- ddl-end --
COMMENT ON TABLE public.sperme_conservateur IS E'Table des produits de conservation utilisés pour la congélation des spermes';
-- ddl-end --
ALTER TABLE public.sperme_conservateur OWNER TO esfc;
-- ddl-end --

-- object: public.sperme_dilueur_sperme_dilueur_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.sperme_dilueur_sperme_dilueur_id_seq CASCADE;
CREATE SEQUENCE public.sperme_dilueur_sperme_dilueur_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.sperme_dilueur_sperme_dilueur_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.sperme_dilueur | type: TABLE --
-- DROP TABLE IF EXISTS public.sperme_dilueur CASCADE;
CREATE TABLE public.sperme_dilueur (
	sperme_dilueur_id integer NOT NULL DEFAULT nextval('public.sperme_dilueur_sperme_dilueur_id_seq'::regclass),
	sperme_dilueur_libelle character varying NOT NULL,
	CONSTRAINT sperme_dilueur_pk PRIMARY KEY (sperme_dilueur_id)
);
-- ddl-end --
COMMENT ON TABLE public.sperme_dilueur IS E'Produit dilueur utilisé pour la congélation du sperme';
-- ddl-end --
ALTER TABLE public.sperme_dilueur OWNER TO esfc;
-- ddl-end --

-- object: public.sperme_freezing_measure_sperme_freezing_measure_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.sperme_freezing_measure_sperme_freezing_measure_id_seq CASCADE;
CREATE SEQUENCE public.sperme_freezing_measure_sperme_freezing_measure_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.sperme_freezing_measure_sperme_freezing_measure_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.sperme_freezing_measure | type: TABLE --
-- DROP TABLE IF EXISTS public.sperme_freezing_measure CASCADE;
CREATE TABLE public.sperme_freezing_measure (
	sperme_freezing_measure_id integer NOT NULL DEFAULT nextval('public.sperme_freezing_measure_sperme_freezing_measure_id_seq'::regclass),
	sperme_congelation_id integer NOT NULL,
	measure_date timestamp NOT NULL,
	measure_temp real NOT NULL,
	CONSTRAINT sperme_freezing_measure_pk PRIMARY KEY (sperme_freezing_measure_id)
);
-- ddl-end --
COMMENT ON TABLE public.sperme_freezing_measure IS E'Table des mesures de vitesse de congélation';
-- ddl-end --
COMMENT ON COLUMN public.sperme_freezing_measure.measure_date IS E'Heure exacte de la mesure';
-- ddl-end --
COMMENT ON COLUMN public.sperme_freezing_measure.measure_temp IS E'Mesure de la température';
-- ddl-end --
ALTER TABLE public.sperme_freezing_measure OWNER TO esfc;
-- ddl-end --

-- object: public.sperme_freezing_place_sperme_freezing_place_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.sperme_freezing_place_sperme_freezing_place_id_seq CASCADE;
CREATE SEQUENCE public.sperme_freezing_place_sperme_freezing_place_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.sperme_freezing_place_sperme_freezing_place_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.sperme_freezing_place | type: TABLE --
-- DROP TABLE IF EXISTS public.sperme_freezing_place CASCADE;
CREATE TABLE public.sperme_freezing_place (
	sperme_freezing_place_id integer NOT NULL DEFAULT nextval('public.sperme_freezing_place_sperme_freezing_place_id_seq'::regclass),
	sperme_congelation_id integer NOT NULL,
	cuve_libelle character varying,
	canister_numero character varying,
	position_canister smallint NOT NULL,
	nb_visiotube integer,
	CONSTRAINT sperme_freezing_place_pk PRIMARY KEY (sperme_freezing_place_id)
);
-- ddl-end --
COMMENT ON TABLE public.sperme_freezing_place IS E'Emplacement des paillettes';
-- ddl-end --
COMMENT ON COLUMN public.sperme_freezing_place.cuve_libelle IS E'Nom ou code de la cuve';
-- ddl-end --
COMMENT ON COLUMN public.sperme_freezing_place.canister_numero IS E'N° du canister';
-- ddl-end --
COMMENT ON COLUMN public.sperme_freezing_place.position_canister IS E'Emplacement du canister dans la bouteille\n1 : bas\n2 : haut';
-- ddl-end --
COMMENT ON COLUMN public.sperme_freezing_place.nb_visiotube IS E'Nombre de visiotubes utilisés';
-- ddl-end --
ALTER TABLE public.sperme_freezing_place OWNER TO esfc;
-- ddl-end --

-- object: public.sperme_mesure_sperme_mesure_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.sperme_mesure_sperme_mesure_id_seq CASCADE;
CREATE SEQUENCE public.sperme_mesure_sperme_mesure_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.sperme_mesure_sperme_mesure_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.sperme_mesure | type: TABLE --
-- DROP TABLE IF EXISTS public.sperme_mesure CASCADE;
CREATE TABLE public.sperme_mesure (
	sperme_mesure_id integer NOT NULL DEFAULT nextval('public.sperme_mesure_sperme_mesure_id_seq'::regclass),
	sperme_id integer NOT NULL,
	sperme_qualite_id integer,
	sperme_mesure_date timestamp NOT NULL,
	motilite_initiale real,
	tx_survie_initial real,
	motilite_60 real,
	tx_survie_60 real,
	temps_survie integer,
	sperme_ph real,
	nb_paillette_utilise integer,
	sperme_congelation_id integer,
	CONSTRAINT sperme_mesure_pk PRIMARY KEY (sperme_mesure_id)
);
-- ddl-end --
COMMENT ON TABLE public.sperme_mesure IS E'Table des mesures de qualité du sperme';
-- ddl-end --
COMMENT ON COLUMN public.sperme_mesure.sperme_mesure_date IS E'Date/heure de la réalisation de la mesure';
-- ddl-end --
COMMENT ON COLUMN public.sperme_mesure.motilite_initiale IS E'Motilité initiale, notée de 0 à 5';
-- ddl-end --
COMMENT ON COLUMN public.sperme_mesure.tx_survie_initial IS E'Taux de survie initial, en pourcentage';
-- ddl-end --
COMMENT ON COLUMN public.sperme_mesure.motilite_60 IS E'Motilité à 60 secondes, notée de 0 à 5';
-- ddl-end --
COMMENT ON COLUMN public.sperme_mesure.tx_survie_60 IS E'Taux de survie à 60 secondes, en pourcentage';
-- ddl-end --
COMMENT ON COLUMN public.sperme_mesure.temps_survie IS E'Temps nécessaire pour atteindre 5% de survie, en secondes';
-- ddl-end --
COMMENT ON COLUMN public.sperme_mesure.sperme_ph IS E'Valeur mesurée du pH du sperme';
-- ddl-end --
COMMENT ON COLUMN public.sperme_mesure.nb_paillette_utilise IS E'Nombre de paillettes utilisées pour réaliser l''analyse';
-- ddl-end --
ALTER TABLE public.sperme_mesure OWNER TO esfc;
-- ddl-end --

-- object: public.sperme_qualite | type: TABLE --
-- DROP TABLE IF EXISTS public.sperme_qualite CASCADE;
CREATE TABLE public.sperme_qualite (
	sperme_qualite_id integer NOT NULL,
	sperme_qualite_libelle character varying NOT NULL,
	CONSTRAINT sperme_qualite_pk PRIMARY KEY (sperme_qualite_id)
);
-- ddl-end --
COMMENT ON TABLE public.sperme_qualite IS E'Table de notation de la qualité globale du sperme\n1 : mauvaise à très mauvaise\n2 : moyenne\n3 : bonne\n4 : très bonne';
-- ddl-end --
ALTER TABLE public.sperme_qualite OWNER TO esfc;
-- ddl-end --

-- object: public.sperme | type: TABLE --
-- DROP TABLE IF EXISTS public.sperme CASCADE;
CREATE TABLE public.sperme (
	sperme_id integer NOT NULL DEFAULT nextval('public.sperme_sperme_id_seq'::regclass),
	poisson_campagne_id integer NOT NULL,
	sequence_id integer,
	sperme_date timestamp NOT NULL,
	sperme_commentaire character varying,
	sperme_aspect_id integer,
	sperme_dilueur_id integer,
	sperme_volume real,
	CONSTRAINT sperme_pk PRIMARY KEY (sperme_id)
);
-- ddl-end --
COMMENT ON TABLE public.sperme IS E'Table de suivi de la qualité du sperme';
-- ddl-end --
COMMENT ON COLUMN public.sperme.sperme_date IS E'Date-heure de la mesure';
-- ddl-end --
ALTER TABLE public.sperme OWNER TO esfc;
-- ddl-end --

-- object: public.sperme_utilise_sperme_utilise_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.sperme_utilise_sperme_utilise_id_seq CASCADE;
CREATE SEQUENCE public.sperme_utilise_sperme_utilise_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.sperme_utilise_sperme_utilise_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.sperme_utilise | type: TABLE --
-- DROP TABLE IF EXISTS public.sperme_utilise CASCADE;
CREATE TABLE public.sperme_utilise (
	sperme_utilise_id integer NOT NULL DEFAULT nextval('public.sperme_utilise_sperme_utilise_id_seq'::regclass),
	croisement_id integer NOT NULL,
	sperme_id integer NOT NULL,
	volume_utilise real,
	nb_paillette_croisement integer,
	sperme_congelation_id integer,
	CONSTRAINT sperme_utilise_pk PRIMARY KEY (sperme_utilise_id)
);
-- ddl-end --
COMMENT ON TABLE public.sperme_utilise IS E'Description détaillée du sperme utilisé dans un croisement';
-- ddl-end --
COMMENT ON COLUMN public.sperme_utilise.volume_utilise IS E'Volume utilisé, en ml';
-- ddl-end --
COMMENT ON COLUMN public.sperme_utilise.nb_paillette_croisement IS E'Nombre de paillettes utilisées (congélation)';
-- ddl-end --
ALTER TABLE public.sperme_utilise OWNER TO esfc;
-- ddl-end --

-- object: public.stade_gonade_stade_gonade_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.stade_gonade_stade_gonade_id_seq CASCADE;
CREATE SEQUENCE public.stade_gonade_stade_gonade_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.stade_gonade_stade_gonade_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.stade_gonade | type: TABLE --
-- DROP TABLE IF EXISTS public.stade_gonade CASCADE;
CREATE TABLE public.stade_gonade (
	stade_gonade_id integer NOT NULL DEFAULT nextval('public.stade_gonade_stade_gonade_id_seq'::regclass),
	stade_gonade_libelle character varying NOT NULL,
	CONSTRAINT stade_gonade_pk PRIMARY KEY (stade_gonade_id)
);
-- ddl-end --
COMMENT ON TABLE public.stade_gonade IS E'Table des stades de gonades';
-- ddl-end --
ALTER TABLE public.stade_gonade OWNER TO esfc;
-- ddl-end --

-- object: public.stade_oeuf_stade_oeuf_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.stade_oeuf_stade_oeuf_id_seq CASCADE;
CREATE SEQUENCE public.stade_oeuf_stade_oeuf_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.stade_oeuf_stade_oeuf_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.stade_oeuf | type: TABLE --
-- DROP TABLE IF EXISTS public.stade_oeuf CASCADE;
CREATE TABLE public.stade_oeuf (
	stade_oeuf_id integer NOT NULL DEFAULT nextval('public.stade_oeuf_stade_oeuf_id_seq'::regclass),
	stade_oeuf_libelle character varying NOT NULL,
	CONSTRAINT stade_oeuf_pk PRIMARY KEY (stade_oeuf_id)
);
-- ddl-end --
COMMENT ON TABLE public.stade_oeuf IS E'Table des stades de maturation des oeufs';
-- ddl-end --
ALTER TABLE public.stade_oeuf OWNER TO esfc;
-- ddl-end --

-- object: public.transfert_transfert_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.transfert_transfert_id_seq CASCADE;
CREATE SEQUENCE public.transfert_transfert_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.transfert_transfert_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.transfert | type: TABLE --
-- DROP TABLE IF EXISTS public.transfert CASCADE;
CREATE TABLE public.transfert (
	transfert_id integer NOT NULL DEFAULT nextval('public.transfert_transfert_id_seq'::regclass),
	poisson_id integer NOT NULL,
	bassin_origine integer,
	bassin_destination integer,
	transfert_date date NOT NULL,
	evenement_id integer,
	transfert_commentaire character varying,
	CONSTRAINT transfert_pk PRIMARY KEY (transfert_id)
);
-- ddl-end --
COMMENT ON TABLE public.transfert IS E'Description des transferts de poissons entre bassins';
-- ddl-end --
ALTER TABLE public.transfert OWNER TO esfc;
-- ddl-end --

-- object: public.v_bassin_alim_quotidien | type: VIEW --
-- DROP VIEW IF EXISTS public.v_bassin_alim_quotidien CASCADE;
CREATE VIEW public.v_bassin_alim_quotidien
AS 

WITH bassins AS (
         SELECT t.poisson_id,
            t.bassin_destination AS bassin_id,
            bassin.bassin_nom,
            t.transfert_date AS date_debut,
            ( SELECT min(t1.transfert_date) AS min
                   FROM transfert t1
                  WHERE ((t.poisson_id = t1.poisson_id) AND (t1.transfert_date > t.transfert_date))) AS date_fin
           FROM (transfert t
             JOIN bassin ON ((t.bassin_destination = bassin.bassin_id)))
          WHERE (t.bassin_destination IS NOT NULL)
        )
 SELECT b.poisson_id,
    b.bassin_id,
    b.bassin_nom,
    d.distrib_quotidien_id,
    b.date_debut,
    b.date_fin,
    d.distrib_quotidien_date,
    d.total_distribue,
    d.reste
   FROM (bassins b
     JOIN distrib_quotidien d ON (((b.bassin_id = d.bassin_id) AND ((d.distrib_quotidien_date >= b.date_debut) AND (d.distrib_quotidien_date <=
        CASE
            WHEN (b.date_fin IS NULL) THEN ('now'::text)::date
            ELSE b.date_fin
        END)))));
-- ddl-end --
ALTER VIEW public.v_bassin_alim_quotidien OWNER TO esfc;
-- ddl-end --

-- object: public.v_distribution | type: VIEW --
-- DROP VIEW IF EXISTS public.v_distribution CASCADE;
CREATE VIEW public.v_distribution
AS 

SELECT distribution.repartition_id,
    distribution.distribution_id,
    distribution.bassin_id,
    distribution.evol_taux_nourrissage,
    distribution.taux_nourrissage,
    distribution.total_distribue,
    distribution.ration_commentaire,
    distribution.distribution_consigne,
    distribution.repart_template_id,
    distribution.distribution_masse,
    distribution.reste_zone_calcul,
    distribution.reste_total,
    distribution.taux_reste,
    distribution.distribution_id_prec,
    distribution.distribution_jour,
    distribution.distribution_jour_soir,
    repartition.categorie_id,
    repartition.date_debut_periode,
    repartition.date_fin_periode,
    repartition.densite_artemia,
    repartition.repartition_name
   FROM (distribution
     JOIN repartition USING (repartition_id));
-- ddl-end --
ALTER VIEW public.v_distribution OWNER TO esfc;
-- ddl-end --

-- object: public.v_gender_selection | type: VIEW --
-- DROP VIEW IF EXISTS public.v_gender_selection CASCADE;
CREATE VIEW public.v_gender_selection
AS 

SELECT s.gender_selection_id,
    s.poisson_id,
    s.gender_methode_id,
    s.sexe_id,
    s.gender_selection_date,
    s.evenement_id,
    s.gender_selection_commentaire
   FROM gender_selection s
  WHERE (s.gender_selection_id = ( SELECT s2.gender_selection_id
           FROM gender_selection s2
          WHERE ((s2.gender_methode_id = ANY (ARRAY[1, 4])) AND (s.poisson_id = s2.poisson_id))
          ORDER BY s2.gender_methode_id
         LIMIT 1));
-- ddl-end --
ALTER VIEW public.v_gender_selection OWNER TO esfc;
-- ddl-end --

-- object: public.v_parent_poisson_ntile | type: VIEW --
-- DROP VIEW IF EXISTS public.v_parent_poisson_ntile CASCADE;
CREATE VIEW public.v_parent_poisson_ntile
AS 

SELECT DISTINCT parent_poisson.poisson_id,
    parent_poisson.parent_id,
    ntile(4) OVER (PARTITION BY parent_poisson.poisson_id ORDER BY parent_poisson.parent_id) AS ntile
   FROM parent_poisson;
-- ddl-end --
COMMENT ON VIEW public.v_parent_poisson_ntile IS E'Préparation de la liste des parents, avec numéro d''ordre, pour utilisation par la vue v_parents';
-- ddl-end --
ALTER VIEW public.v_parent_poisson_ntile OWNER TO esfc;
-- ddl-end --

-- object: public.v_parents | type: VIEW --
-- DROP VIEW IF EXISTS public.v_parents CASCADE;
CREATE VIEW public.v_parents
AS 

SELECT DISTINCT p.poisson_id,
    p1.parent_id AS parent1_id,
    p2.parent_id AS parent2_id,
    p3.parent_id AS parent3_id,
    p4.parent_id AS parent4_id
   FROM ((((v_parent_poisson_ntile p
     LEFT JOIN v_parent_poisson_ntile p1 ON (((p.poisson_id = p1.poisson_id) AND (p1.ntile = 1))))
     LEFT JOIN v_parent_poisson_ntile p2 ON (((p.poisson_id = p2.poisson_id) AND (p2.ntile = 2))))
     LEFT JOIN v_parent_poisson_ntile p3 ON (((p.poisson_id = p3.poisson_id) AND (p3.ntile = 3))))
     LEFT JOIN v_parent_poisson_ntile p4 ON (((p.poisson_id = p4.poisson_id) AND (p4.ntile = 4))));
-- ddl-end --
COMMENT ON VIEW public.v_parents IS E'Liste des parents d''un poisson';
-- ddl-end --
ALTER VIEW public.v_parents OWNER TO esfc;
-- ddl-end --

-- object: public.v_pittag_by_poisson | type: VIEW --
-- DROP VIEW IF EXISTS public.v_pittag_by_poisson CASCADE;
CREATE VIEW public.v_pittag_by_poisson
AS 

SELECT pittag.poisson_id,
    array_to_string(array_agg(pittag.pittag_valeur), ' '::text) AS pittag_valeur
   FROM pittag
  GROUP BY pittag.poisson_id;
-- ddl-end --
ALTER VIEW public.v_pittag_by_poisson OWNER TO esfc;
-- ddl-end --

-- object: public.v_poisson_bassins | type: VIEW --
-- DROP VIEW IF EXISTS public.v_poisson_bassins CASCADE;
CREATE VIEW public.v_poisson_bassins
AS 

SELECT t.poisson_id,
    t.bassin_destination AS bassin_id,
    bassin.bassin_nom,
    t.transfert_date AS date_debut,
    ( SELECT min(t1.transfert_date) AS min
           FROM transfert t1
          WHERE ((t.poisson_id = t1.poisson_id) AND (t1.transfert_date > t.transfert_date))) AS date_fin
   FROM (transfert t
     JOIN bassin ON ((t.bassin_destination = bassin.bassin_id)))
  WHERE (t.bassin_destination IS NOT NULL)
  ORDER BY t.poisson_id, t.transfert_date DESC;
-- ddl-end --
COMMENT ON VIEW public.v_poisson_bassins IS E'Liste des bassins fréquentés par un poisson';
-- ddl-end --
ALTER VIEW public.v_poisson_bassins OWNER TO esfc;
-- ddl-end --

-- object: public.v_poisson_last_bassin | type: VIEW --
-- DROP VIEW IF EXISTS public.v_poisson_last_bassin CASCADE;
CREATE VIEW public.v_poisson_last_bassin
AS 

SELECT t.poisson_id,
    bassin.bassin_id,
    bassin.bassin_nom,
    t.transfert_date,
    t.transfert_id,
    t.evenement_id
   FROM (transfert t
     JOIN bassin ON ((t.bassin_destination = bassin.bassin_id)))
  WHERE (t.transfert_date = ( SELECT max(t1.transfert_date) AS max
           FROM transfert t1
          WHERE ((t.poisson_id = t1.poisson_id) AND (t1.bassin_destination > 0))));
-- ddl-end --
ALTER VIEW public.v_poisson_last_bassin OWNER TO esfc;
-- ddl-end --

-- object: public.v_poisson_last_lf | type: VIEW --
-- DROP VIEW IF EXISTS public.v_poisson_last_lf CASCADE;
CREATE VIEW public.v_poisson_last_lf
AS 

SELECT m.poisson_id,
    m.longueur_fourche,
    m.morphologie_date,
    m.morphologie_id,
    m.evenement_id
   FROM morphologie m
  WHERE (m.morphologie_date = ( SELECT max(m1.morphologie_date) AS max
           FROM morphologie m1
          WHERE ((m1.longueur_fourche > (0)::double precision) AND (m.poisson_id = m1.poisson_id))));
-- ddl-end --
ALTER VIEW public.v_poisson_last_lf OWNER TO esfc;
-- ddl-end --

-- object: public.v_poisson_last_lt | type: VIEW --
-- DROP VIEW IF EXISTS public.v_poisson_last_lt CASCADE;
CREATE VIEW public.v_poisson_last_lt
AS 

SELECT m.poisson_id,
    m.longueur_totale,
    m.morphologie_date,
    m.morphologie_id,
    m.evenement_id
   FROM morphologie m
  WHERE (m.morphologie_date = ( SELECT max(m1.morphologie_date) AS max
           FROM morphologie m1
          WHERE ((m1.longueur_totale > (0)::double precision) AND (m.poisson_id = m1.poisson_id))));
-- ddl-end --
ALTER VIEW public.v_poisson_last_lt OWNER TO esfc;
-- ddl-end --

-- object: public.v_poisson_last_masse | type: VIEW --
-- DROP VIEW IF EXISTS public.v_poisson_last_masse CASCADE;
CREATE VIEW public.v_poisson_last_masse
AS 

SELECT m.poisson_id,
    m.masse,
    m.morphologie_date,
    m.morphologie_id,
    m.evenement_id
   FROM morphologie m
  WHERE (m.morphologie_date = ( SELECT max(m1.morphologie_date) AS max
           FROM morphologie m1
          WHERE ((m1.masse > (0)::double precision) AND (m.poisson_id = m1.poisson_id))));
-- ddl-end --
ALTER VIEW public.v_poisson_last_masse OWNER TO esfc;
-- ddl-end --

-- object: public.v_prenom_parent_femelle | type: VIEW --
-- DROP VIEW IF EXISTS public.v_prenom_parent_femelle CASCADE;
CREATE VIEW public.v_prenom_parent_femelle
AS 

SELECT pp.poisson_id,
    array_to_string(array_agg(p.prenom), ' '::text) AS mere
   FROM (parent_poisson pp
     JOIN poisson p ON ((pp.parent_id = p.poisson_id)))
  WHERE (p.sexe_id = 2)
  GROUP BY pp.poisson_id;
-- ddl-end --
ALTER VIEW public.v_prenom_parent_femelle OWNER TO esfc;
-- ddl-end --

-- object: public.v_prenom_parents | type: VIEW --
-- DROP VIEW IF EXISTS public.v_prenom_parents CASCADE;
CREATE VIEW public.v_prenom_parents
AS 

SELECT pp.poisson_id,
    array_to_string(array_agg(p.prenom ORDER BY p.sexe_id DESC, p.prenom), ' '::text) AS parents
   FROM (parent_poisson pp
     JOIN poisson p ON ((pp.parent_id = p.poisson_id)))
  GROUP BY pp.poisson_id;
-- ddl-end --
ALTER VIEW public.v_prenom_parents OWNER TO esfc;
-- ddl-end --

-- object: public.v_prenom_parents_male | type: VIEW --
-- DROP VIEW IF EXISTS public.v_prenom_parents_male CASCADE;
CREATE VIEW public.v_prenom_parents_male
AS 

SELECT pp.poisson_id,
    array_to_string(array_agg(p.prenom ORDER BY p.prenom), '+'::text) AS peres
   FROM (parent_poisson pp
     JOIN poisson p ON ((pp.parent_id = p.poisson_id)))
  WHERE (p.sexe_id = 1)
  GROUP BY pp.poisson_id;
-- ddl-end --
ALTER VIEW public.v_prenom_parents_male OWNER TO esfc;
-- ddl-end --

-- object: public.v_sperme_congelation_date | type: VIEW --
-- DROP VIEW IF EXISTS public.v_sperme_congelation_date CASCADE;
CREATE VIEW public.v_sperme_congelation_date
AS 

SELECT sperme_congelation.sperme_id,
    array_to_string(array_agg(to_char(sperme_congelation.congelation_date, 'DD/MM/YYYY'::text) ORDER BY sperme_congelation.congelation_date), ', '::text) AS congelation_dates
   FROM sperme_congelation
  GROUP BY sperme_congelation.sperme_id;
-- ddl-end --
ALTER VIEW public.v_sperme_congelation_date OWNER TO esfc;
-- ddl-end --

-- object: public.v_transfert_last_bassin_for_poisson | type: VIEW --
-- DROP VIEW IF EXISTS public.v_transfert_last_bassin_for_poisson CASCADE;
CREATE VIEW public.v_transfert_last_bassin_for_poisson
AS 

SELECT transfert.poisson_id,
    max(transfert.transfert_date) AS transfert_date_last
   FROM transfert
  GROUP BY transfert.poisson_id;
-- ddl-end --
ALTER VIEW public.v_transfert_last_bassin_for_poisson OWNER TO esfc;
-- ddl-end --

-- object: public.vie_implantation_vie_implantation_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.vie_implantation_vie_implantation_id_seq CASCADE;
CREATE SEQUENCE public.vie_implantation_vie_implantation_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.vie_implantation_vie_implantation_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.vie_modele_vie_modele_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.vie_modele_vie_modele_id_seq CASCADE;
CREATE SEQUENCE public.vie_modele_vie_modele_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.vie_modele_vie_modele_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.v_vie_modele | type: VIEW --
-- DROP VIEW IF EXISTS public.v_vie_modele CASCADE;
CREATE VIEW public.v_vie_modele
AS 

SELECT vm.vie_modele_id,
    vm.annee,
    vm.couleur,
    vm.vie_implantation_id,
    vm.vie_implantation_id2,
    i.vie_implantation_libelle,
    i2.vie_implantation_libelle AS vie_implantation_libelle2
   FROM ((vie_modele vm
     JOIN vie_implantation i ON ((vm.vie_implantation_id = i.vie_implantation_id)))
     JOIN vie_implantation i2 ON ((vm.vie_implantation_id2 = i2.vie_implantation_id)));
-- ddl-end --
ALTER VIEW public.v_vie_modele OWNER TO esfc;
-- ddl-end --

-- object: public.ventilation_ventilation_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.ventilation_ventilation_id_seq CASCADE;
CREATE SEQUENCE public.ventilation_ventilation_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.ventilation_ventilation_id_seq OWNER TO esfc;
-- ddl-end --

-- object: public.ventilation | type: TABLE --
-- DROP TABLE IF EXISTS public.ventilation CASCADE;
CREATE TABLE public.ventilation (
	ventilation_id integer NOT NULL DEFAULT nextval('public.ventilation_ventilation_id_seq'::regclass),
	poisson_id integer NOT NULL,
	ventilation_date timestamp NOT NULL,
	battement_nb double precision NOT NULL,
	ventilation_commentaire character varying,
	CONSTRAINT ventilation_pk PRIMARY KEY (ventilation_id)
);
-- ddl-end --
COMMENT ON TABLE public.ventilation IS E'Table des relevés de ventilation pour un poissons (nombre de battements par minute)';
-- ddl-end --
COMMENT ON COLUMN public.ventilation.ventilation_date IS E'Date/heure précise de la mesure';
-- ddl-end --
COMMENT ON COLUMN public.ventilation.battement_nb IS E'Nombre de battements/seconde';
-- ddl-end --
ALTER TABLE public.ventilation OWNER TO esfc;
-- ddl-end --

-- object: public.vie_implantation | type: TABLE --
-- DROP TABLE IF EXISTS public.vie_implantation CASCADE;
CREATE TABLE public.vie_implantation (
	vie_implantation_id integer NOT NULL DEFAULT nextval('public.vie_implantation_vie_implantation_id_seq'::regclass),
	vie_implantation_libelle character varying NOT NULL,
	CONSTRAINT vie_implantation_pk PRIMARY KEY (vie_implantation_id)
);
-- ddl-end --
COMMENT ON TABLE public.vie_implantation IS E'table des implantations des marques VIE';
-- ddl-end --
ALTER TABLE public.vie_implantation OWNER TO esfc;
-- ddl-end --

-- object: public.vie_modele | type: TABLE --
-- DROP TABLE IF EXISTS public.vie_modele CASCADE;
CREATE TABLE public.vie_modele (
	vie_modele_id integer NOT NULL DEFAULT nextval('public.vie_modele_vie_modele_id_seq'::regclass),
	vie_implantation_id integer,
	vie_implantation_id2 integer,
	annee integer NOT NULL,
	couleur character varying NOT NULL,
	CONSTRAINT vie_modele_pk PRIMARY KEY (vie_modele_id)
);
-- ddl-end --
COMMENT ON TABLE public.vie_modele IS E'Modèles de marquages VIE';
-- ddl-end --
COMMENT ON COLUMN public.vie_modele.vie_implantation_id IS E'Première implantation de marque';
-- ddl-end --
COMMENT ON COLUMN public.vie_modele.vie_implantation_id2 IS E'Second emplacement de marque';
-- ddl-end --
COMMENT ON COLUMN public.vie_modele.couleur IS E'Couleur de la marque VIE';
-- ddl-end --
ALTER TABLE public.vie_modele OWNER TO esfc;
-- ddl-end --

-- object: aliment_quotidien_aliment_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.aliment_quotidien_aliment_id_idx CASCADE;
CREATE INDEX aliment_quotidien_aliment_id_idx ON public.aliment_quotidien
USING btree
(
	aliment_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: aliment_quotidien_distrib_quotidien_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.aliment_quotidien_distrib_quotidien_id_idx CASCADE;
CREATE INDEX aliment_quotidien_distrib_quotidien_id_idx ON public.aliment_quotidien
USING btree
(
	distrib_quotidien_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: analyse_eau_circuit_eau_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.analyse_eau_circuit_eau_id_idx CASCADE;
CREATE INDEX analyse_eau_circuit_eau_id_idx ON public.analyse_eau
USING btree
(
	circuit_eau_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: cohorte_evenement_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.cohorte_evenement_id_idx CASCADE;
CREATE INDEX cohorte_evenement_id_idx ON public.cohorte
USING btree
(
	evenement_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: cohorte_poisson_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.cohorte_poisson_id_idx CASCADE;
CREATE INDEX cohorte_poisson_id_idx ON public.cohorte
USING btree
(
	poisson_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: distrib_quotidien_bassin_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.distrib_quotidien_bassin_id_idx CASCADE;
CREATE INDEX distrib_quotidien_bassin_id_idx ON public.distrib_quotidien
USING btree
(
	bassin_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: distrib_quotidien_date_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.distrib_quotidien_date_idx CASCADE;
CREATE INDEX distrib_quotidien_date_idx ON public.distrib_quotidien
USING btree
(
	distrib_quotidien_date
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: distribution_bassin_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.distribution_bassin_id_idx CASCADE;
CREATE INDEX distribution_bassin_id_idx ON public.distribution
USING btree
(
	bassin_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: distribution_repart_template_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.distribution_repart_template_id_idx CASCADE;
CREATE INDEX distribution_repart_template_id_idx ON public.distribution
USING btree
(
	repart_template_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: distribution_repartition_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.distribution_repartition_id_idx CASCADE;
CREATE INDEX distribution_repartition_id_idx ON public.distribution
USING btree
(
	repartition_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: evenement_evenement_type_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.evenement_evenement_type_id_idx CASCADE;
CREATE INDEX evenement_evenement_type_id_idx ON public.evenement
USING btree
(
	evenement_type_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: evenement_poisson_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.evenement_poisson_id_idx CASCADE;
CREATE INDEX evenement_poisson_id_idx ON public.evenement
USING btree
(
	poisson_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: gender_selection_evenement_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.gender_selection_evenement_id_idx CASCADE;
CREATE INDEX gender_selection_evenement_id_idx ON public.gender_selection
USING btree
(
	evenement_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: gender_selection_poisson_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.gender_selection_poisson_id_idx CASCADE;
CREATE INDEX gender_selection_poisson_id_idx ON public.gender_selection
USING btree
(
	poisson_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: morphologie_evenement_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.morphologie_evenement_id_idx CASCADE;
CREATE INDEX morphologie_evenement_id_idx ON public.morphologie
USING btree
(
	evenement_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: morphologie_morphologie_date_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.morphologie_morphologie_date_idx CASCADE;
CREATE INDEX morphologie_morphologie_date_idx ON public.morphologie
USING btree
(
	morphologie_date
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: morphologie_poisson_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.morphologie_poisson_id_idx CASCADE;
CREATE INDEX morphologie_poisson_id_idx ON public.morphologie
USING btree
(
	poisson_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: mortalite_evenement_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.mortalite_evenement_id_idx CASCADE;
CREATE INDEX mortalite_evenement_id_idx ON public.mortalite
USING btree
(
	evenement_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: mortalite_poisson_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.mortalite_poisson_id_idx CASCADE;
CREATE INDEX mortalite_poisson_id_idx ON public.mortalite
USING btree
(
	poisson_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: parent_poisson_parent_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.parent_poisson_parent_id_idx CASCADE;
CREATE INDEX parent_poisson_parent_id_idx ON public.parent_poisson
USING btree
(
	parent_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: parent_poisson_poisson_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.parent_poisson_poisson_id_idx CASCADE;
CREATE INDEX parent_poisson_poisson_id_idx ON public.parent_poisson
USING btree
(
	poisson_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: pathologie_evenement_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.pathologie_evenement_id_idx CASCADE;
CREATE INDEX pathologie_evenement_id_idx ON public.pathologie
USING btree
(
	evenement_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: pathologie_poisson_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.pathologie_poisson_id_idx CASCADE;
CREATE INDEX pathologie_poisson_id_idx ON public.pathologie
USING btree
(
	poisson_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: pittag_poisson_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.pittag_poisson_id_idx CASCADE;
CREATE INDEX pittag_poisson_id_idx ON public.pittag
USING btree
(
	poisson_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: sortie_evenement_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.sortie_evenement_id_idx CASCADE;
CREATE INDEX sortie_evenement_id_idx ON public.sortie
USING btree
(
	evenement_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: sortie_poisson_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.sortie_poisson_id_idx CASCADE;
CREATE INDEX sortie_poisson_id_idx ON public.sortie
USING btree
(
	poisson_id
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: transfert_bassin_destination_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.transfert_bassin_destination_idx CASCADE;
CREATE INDEX transfert_bassin_destination_idx ON public.transfert
USING btree
(
	bassin_destination
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: transfert_date_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.transfert_date_idx CASCADE;
CREATE INDEX transfert_date_idx ON public.transfert
USING btree
(
	transfert_date
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: transfert_transfert_date_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.transfert_transfert_date_idx CASCADE;
CREATE INDEX transfert_transfert_date_idx ON public.transfert
USING btree
(
	transfert_date
)
WITH (FILLFACTOR = 90);
-- ddl-end --

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
COMMENT ON TABLE public.site IS E'Liste des sites gérés';
-- ddl-end --
COMMENT ON COLUMN public.site.site_name IS E'Nom du site';
-- ddl-end --
ALTER TABLE public.site OWNER TO postgres;
-- ddl-end --

-- object: public.sonde | type: TABLE --
-- DROP TABLE IF EXISTS public.sonde CASCADE;
CREATE TABLE public.sonde (
	sonde_id integer NOT NULL,
	sonde_name varchar NOT NULL,
	sonde_param json,
	CONSTRAINT sonde_id_pk PRIMARY KEY (sonde_id)
);
-- ddl-end --
COMMENT ON COLUMN public.sonde.sonde_name IS E'Nom du modèle d''intégration de données de la sonde';
-- ddl-end --
COMMENT ON COLUMN public.sonde.sonde_param IS E'Paramètres nécessaires pour gérer l''importation données';
-- ddl-end --
ALTER TABLE public.sonde OWNER TO postgres;
-- ddl-end --

-- object: public.sortie_lieu | type: TABLE --
-- DROP TABLE IF EXISTS public.sortie_lieu CASCADE;
CREATE TABLE public.sortie_lieu (
	sortie_lieu_id integer NOT NULL DEFAULT nextval('public.sortie_lieu_sortie_lieu_id_seq'::regclass),
	localisation character varying NOT NULL,
	longitude_dd double precision,
	latitude_dd double precision,
	actif smallint NOT NULL DEFAULT 1,
	poisson_statut_id integer,
	point_geom geometry,
	CONSTRAINT sortie_lieu_pk PRIMARY KEY (sortie_lieu_id)
);
-- ddl-end --
COMMENT ON TABLE public.sortie_lieu IS E'Lieux des sorties du stock des poissons';
-- ddl-end --
COMMENT ON COLUMN public.sortie_lieu.localisation IS E'information textuelle sur le lieu de lacher';
-- ddl-end --
COMMENT ON COLUMN public.sortie_lieu.longitude_dd IS E'Longitude du point de lâcher, en valeur décimale';
-- ddl-end --
COMMENT ON COLUMN public.sortie_lieu.latitude_dd IS E'Latitude du point de lâcher, en décimal';
-- ddl-end --
COMMENT ON COLUMN public.sortie_lieu.actif IS E'1 : point utilisé actuellement\n0 : ancien point de lâcher';
-- ddl-end --
COMMENT ON COLUMN public.sortie_lieu.poisson_statut_id IS E'Statut que prend le poisson après sortie du stock';
-- ddl-end --
COMMENT ON COLUMN public.sortie_lieu.point_geom IS E'Point géographique, en WGS84';
-- ddl-end --
ALTER TABLE public.sortie_lieu OWNER TO esfc;
-- ddl-end --

-- object: poisson_campagne_poisson_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.poisson_campagne_poisson_id_idx CASCADE;
CREATE INDEX poisson_campagne_poisson_id_idx ON public.poisson_campagne
USING btree
(
	poisson_id
);
-- ddl-end --

-- object: transfert_poisson_id_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.transfert_poisson_id_idx CASCADE;
CREATE INDEX transfert_poisson_id_idx ON public.transfert
USING btree
(
	poisson_id
);
-- ddl-end --

-- object: aliment_type_aliment_fk | type: CONSTRAINT --
-- ALTER TABLE public.aliment DROP CONSTRAINT IF EXISTS aliment_type_aliment_fk CASCADE;
ALTER TABLE public.aliment ADD CONSTRAINT aliment_type_aliment_fk FOREIGN KEY (aliment_type_id)
REFERENCES public.aliment_type (aliment_type_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: aliment_aliment_categorie_fk | type: CONSTRAINT --
-- ALTER TABLE public.aliment_categorie DROP CONSTRAINT IF EXISTS aliment_aliment_categorie_fk CASCADE;
ALTER TABLE public.aliment_categorie ADD CONSTRAINT aliment_aliment_categorie_fk FOREIGN KEY (aliment_id)
REFERENCES public.aliment (aliment_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: categorie_aliment_categorie_fk | type: CONSTRAINT --
-- ALTER TABLE public.aliment_categorie DROP CONSTRAINT IF EXISTS categorie_aliment_categorie_fk CASCADE;
ALTER TABLE public.aliment_categorie ADD CONSTRAINT categorie_aliment_categorie_fk FOREIGN KEY (categorie_id)
REFERENCES public.categorie (categorie_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: aliment_bassin_aliment_fk | type: CONSTRAINT --
-- ALTER TABLE public.aliment_quotidien DROP CONSTRAINT IF EXISTS aliment_bassin_aliment_fk CASCADE;
ALTER TABLE public.aliment_quotidien ADD CONSTRAINT aliment_bassin_aliment_fk FOREIGN KEY (aliment_id)
REFERENCES public.aliment (aliment_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: distrib_quotidien_aliment_quotidien_fk | type: CONSTRAINT --
-- ALTER TABLE public.aliment_quotidien DROP CONSTRAINT IF EXISTS distrib_quotidien_aliment_quotidien_fk CASCADE;
ALTER TABLE public.aliment_quotidien ADD CONSTRAINT distrib_quotidien_aliment_quotidien_fk FOREIGN KEY (distrib_quotidien_id)
REFERENCES public.distrib_quotidien (distrib_quotidien_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: circuit_eau_analyse_eau_fk | type: CONSTRAINT --
-- ALTER TABLE public.analyse_eau DROP CONSTRAINT IF EXISTS circuit_eau_analyse_eau_fk CASCADE;
ALTER TABLE public.analyse_eau ADD CONSTRAINT circuit_eau_analyse_eau_fk FOREIGN KEY (circuit_eau_id)
REFERENCES public.circuit_eau (circuit_eau_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: laboratoire_analyse_analyse_eau_fk | type: CONSTRAINT --
-- ALTER TABLE public.analyse_eau DROP CONSTRAINT IF EXISTS laboratoire_analyse_analyse_eau_fk CASCADE;
ALTER TABLE public.analyse_eau ADD CONSTRAINT laboratoire_analyse_analyse_eau_fk FOREIGN KEY (laboratoire_analyse_id)
REFERENCES public.laboratoire_analyse (laboratoire_analyse_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: analyse_eau_analyse_metal_fk | type: CONSTRAINT --
-- ALTER TABLE public.analyse_metal DROP CONSTRAINT IF EXISTS analyse_eau_analyse_metal_fk CASCADE;
ALTER TABLE public.analyse_metal ADD CONSTRAINT analyse_eau_analyse_metal_fk FOREIGN KEY (analyse_eau_id)
REFERENCES public.analyse_eau (analyse_eau_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: metal_analyse_metal_fk | type: CONSTRAINT --
-- ALTER TABLE public.analyse_metal DROP CONSTRAINT IF EXISTS metal_analyse_metal_fk CASCADE;
ALTER TABLE public.analyse_metal ADD CONSTRAINT metal_analyse_metal_fk FOREIGN KEY (metal_id)
REFERENCES public.metal (metal_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: anesthesie_produit_anesthesie_fk | type: CONSTRAINT --
-- ALTER TABLE public.anesthesie DROP CONSTRAINT IF EXISTS anesthesie_produit_anesthesie_fk CASCADE;
ALTER TABLE public.anesthesie ADD CONSTRAINT anesthesie_produit_anesthesie_fk FOREIGN KEY (anesthesie_produit_id)
REFERENCES public.anesthesie_produit (anesthesie_produit_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: evenement_anesthesie_fk | type: CONSTRAINT --
-- ALTER TABLE public.anesthesie DROP CONSTRAINT IF EXISTS evenement_anesthesie_fk CASCADE;
ALTER TABLE public.anesthesie ADD CONSTRAINT evenement_anesthesie_fk FOREIGN KEY (evenement_id)
REFERENCES public.evenement (evenement_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_anesthesie_fk | type: CONSTRAINT --
-- ALTER TABLE public.anesthesie DROP CONSTRAINT IF EXISTS poisson_anesthesie_fk CASCADE;
ALTER TABLE public.anesthesie ADD CONSTRAINT poisson_anesthesie_fk FOREIGN KEY (poisson_id)
REFERENCES public.poisson (poisson_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: anomalie_db_type_anomalie_db_fk | type: CONSTRAINT --
-- ALTER TABLE public.anomalie_db DROP CONSTRAINT IF EXISTS anomalie_db_type_anomalie_db_fk CASCADE;
ALTER TABLE public.anomalie_db ADD CONSTRAINT anomalie_db_type_anomalie_db_fk FOREIGN KEY (anomalie_db_type_id)
REFERENCES public.anomalie_db_type (anomalie_db_type_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: evenement_anomalie_db_fk | type: CONSTRAINT --
-- ALTER TABLE public.anomalie_db DROP CONSTRAINT IF EXISTS evenement_anomalie_db_fk CASCADE;
ALTER TABLE public.anomalie_db ADD CONSTRAINT evenement_anomalie_db_fk FOREIGN KEY (evenement_id)
REFERENCES public.evenement (evenement_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_anomalie_db_fk | type: CONSTRAINT --
-- ALTER TABLE public.anomalie_db DROP CONSTRAINT IF EXISTS poisson_anomalie_db_fk CASCADE;
ALTER TABLE public.anomalie_db ADD CONSTRAINT poisson_anomalie_db_fk FOREIGN KEY (poisson_id)
REFERENCES public.poisson (poisson_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: bassin_type_bassin_fk | type: CONSTRAINT --
-- ALTER TABLE public.bassin DROP CONSTRAINT IF EXISTS bassin_type_bassin_fk CASCADE;
ALTER TABLE public.bassin ADD CONSTRAINT bassin_type_bassin_fk FOREIGN KEY (bassin_type_id)
REFERENCES public.bassin_type (bassin_type_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: bassin_usage_bassin_fk | type: CONSTRAINT --
-- ALTER TABLE public.bassin DROP CONSTRAINT IF EXISTS bassin_usage_bassin_fk CASCADE;
ALTER TABLE public.bassin ADD CONSTRAINT bassin_usage_bassin_fk FOREIGN KEY (bassin_usage_id)
REFERENCES public.bassin_usage (bassin_usage_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: bassin_zone_bassin_fk | type: CONSTRAINT --
-- ALTER TABLE public.bassin DROP CONSTRAINT IF EXISTS bassin_zone_bassin_fk CASCADE;
ALTER TABLE public.bassin ADD CONSTRAINT bassin_zone_bassin_fk FOREIGN KEY (bassin_zone_id)
REFERENCES public.bassin_zone (bassin_zone_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: circuit_eau_bassin_fk | type: CONSTRAINT --
-- ALTER TABLE public.bassin DROP CONSTRAINT IF EXISTS circuit_eau_bassin_fk CASCADE;
ALTER TABLE public.bassin ADD CONSTRAINT circuit_eau_bassin_fk FOREIGN KEY (circuit_eau_id)
REFERENCES public.circuit_eau (circuit_eau_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: site_site_id_fk | type: CONSTRAINT --
-- ALTER TABLE public.bassin DROP CONSTRAINT IF EXISTS site_site_id_fk CASCADE;
ALTER TABLE public.bassin ADD CONSTRAINT site_site_id_fk FOREIGN KEY (site_id)
REFERENCES public.site (site_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: bassin_bassin_campagne_fk | type: CONSTRAINT --
-- ALTER TABLE public.bassin_campagne DROP CONSTRAINT IF EXISTS bassin_bassin_campagne_fk CASCADE;
ALTER TABLE public.bassin_campagne ADD CONSTRAINT bassin_bassin_campagne_fk FOREIGN KEY (bassin_id)
REFERENCES public.bassin (bassin_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: bassin_bassin_document_fk | type: CONSTRAINT --
-- ALTER TABLE public.bassin_document DROP CONSTRAINT IF EXISTS bassin_bassin_document_fk CASCADE;
ALTER TABLE public.bassin_document ADD CONSTRAINT bassin_bassin_document_fk FOREIGN KEY (bassin_id)
REFERENCES public.bassin (bassin_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: document_bassin_document_fk | type: CONSTRAINT --
-- ALTER TABLE public.bassin_document DROP CONSTRAINT IF EXISTS document_bassin_document_fk CASCADE;
ALTER TABLE public.bassin_document ADD CONSTRAINT document_bassin_document_fk FOREIGN KEY (document_id)
REFERENCES public.document (document_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: bassin_bassin_evenement_fk | type: CONSTRAINT --
-- ALTER TABLE public.bassin_evenement DROP CONSTRAINT IF EXISTS bassin_bassin_evenement_fk CASCADE;
ALTER TABLE public.bassin_evenement ADD CONSTRAINT bassin_bassin_evenement_fk FOREIGN KEY (bassin_id)
REFERENCES public.bassin (bassin_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: bassin_evenement_type_bassin_evenement_fk | type: CONSTRAINT --
-- ALTER TABLE public.bassin_evenement DROP CONSTRAINT IF EXISTS bassin_evenement_type_bassin_evenement_fk CASCADE;
ALTER TABLE public.bassin_evenement ADD CONSTRAINT bassin_evenement_type_bassin_evenement_fk FOREIGN KEY (bassin_evenement_type_id)
REFERENCES public.bassin_evenement_type (bassin_evenement_type_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: bassin_bassin_lot_fk | type: CONSTRAINT --
-- ALTER TABLE public.bassin_lot DROP CONSTRAINT IF EXISTS bassin_bassin_lot_fk CASCADE;
ALTER TABLE public.bassin_lot ADD CONSTRAINT bassin_bassin_lot_fk FOREIGN KEY (bassin_id)
REFERENCES public.bassin (bassin_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: lot_bassin_lot_fk | type: CONSTRAINT --
-- ALTER TABLE public.bassin_lot DROP CONSTRAINT IF EXISTS lot_bassin_lot_fk CASCADE;
ALTER TABLE public.bassin_lot ADD CONSTRAINT lot_bassin_lot_fk FOREIGN KEY (lot_id)
REFERENCES public.lot (lot_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: aliment_categorie_bassin_usage_fk | type: CONSTRAINT --
-- ALTER TABLE public.bassin_usage DROP CONSTRAINT IF EXISTS aliment_categorie_bassin_usage_fk CASCADE;
ALTER TABLE public.bassin_usage ADD CONSTRAINT aliment_categorie_bassin_usage_fk FOREIGN KEY (categorie_id)
REFERENCES public.categorie (categorie_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: biopsie_technique_calcul_biopsie_fk | type: CONSTRAINT --
-- ALTER TABLE public.biopsie DROP CONSTRAINT IF EXISTS biopsie_technique_calcul_biopsie_fk CASCADE;
ALTER TABLE public.biopsie ADD CONSTRAINT biopsie_technique_calcul_biopsie_fk FOREIGN KEY (biopsie_technique_calcul_id)
REFERENCES public.biopsie_technique_calcul (biopsie_technique_calcul_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_campagne_biopsie_fk | type: CONSTRAINT --
-- ALTER TABLE public.biopsie DROP CONSTRAINT IF EXISTS poisson_campagne_biopsie_fk CASCADE;
ALTER TABLE public.biopsie ADD CONSTRAINT poisson_campagne_biopsie_fk FOREIGN KEY (poisson_campagne_id)
REFERENCES public.poisson_campagne (poisson_campagne_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: biopsie_biopsie_document_fk | type: CONSTRAINT --
-- ALTER TABLE public.biopsie_document DROP CONSTRAINT IF EXISTS biopsie_biopsie_document_fk CASCADE;
ALTER TABLE public.biopsie_document ADD CONSTRAINT biopsie_biopsie_document_fk FOREIGN KEY (biopsie_id)
REFERENCES public.biopsie (biopsie_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: document_biopsie_document_fk | type: CONSTRAINT --
-- ALTER TABLE public.biopsie_document DROP CONSTRAINT IF EXISTS document_biopsie_document_fk CASCADE;
ALTER TABLE public.biopsie_document ADD CONSTRAINT document_biopsie_document_fk FOREIGN KEY (document_id)
REFERENCES public.document (document_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: site_site_id_fk | type: CONSTRAINT --
-- ALTER TABLE public.circuit_eau DROP CONSTRAINT IF EXISTS site_site_id_fk CASCADE;
ALTER TABLE public.circuit_eau ADD CONSTRAINT site_site_id_fk FOREIGN KEY (site_id)
REFERENCES public.site (site_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: circuit_eau_circuit_evenement_fk | type: CONSTRAINT --
-- ALTER TABLE public.circuit_evenement DROP CONSTRAINT IF EXISTS circuit_eau_circuit_evenement_fk CASCADE;
ALTER TABLE public.circuit_evenement ADD CONSTRAINT circuit_eau_circuit_evenement_fk FOREIGN KEY (circuit_eau_id)
REFERENCES public.circuit_eau (circuit_eau_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: circuit_evenement_type_circuit_evenement_fk | type: CONSTRAINT --
-- ALTER TABLE public.circuit_evenement DROP CONSTRAINT IF EXISTS circuit_evenement_type_circuit_evenement_fk CASCADE;
ALTER TABLE public.circuit_evenement ADD CONSTRAINT circuit_evenement_type_circuit_evenement_fk FOREIGN KEY (circuit_evenement_type_id)
REFERENCES public.circuit_evenement_type (circuit_evenement_type_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: cohorte_type_cohorte_fk | type: CONSTRAINT --
-- ALTER TABLE public.cohorte DROP CONSTRAINT IF EXISTS cohorte_type_cohorte_fk CASCADE;
ALTER TABLE public.cohorte ADD CONSTRAINT cohorte_type_cohorte_fk FOREIGN KEY (cohorte_type_id)
REFERENCES public.cohorte_type (cohorte_type_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: evenement_cohorte_fk | type: CONSTRAINT --
-- ALTER TABLE public.cohorte DROP CONSTRAINT IF EXISTS evenement_cohorte_fk CASCADE;
ALTER TABLE public.cohorte ADD CONSTRAINT evenement_cohorte_fk FOREIGN KEY (evenement_id)
REFERENCES public.evenement (evenement_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_cohorte_fk | type: CONSTRAINT --
-- ALTER TABLE public.cohorte DROP CONSTRAINT IF EXISTS poisson_cohorte_fk CASCADE;
ALTER TABLE public.cohorte ADD CONSTRAINT poisson_cohorte_fk FOREIGN KEY (poisson_id)
REFERENCES public.poisson (poisson_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: croisement_qualite_croisement_fk | type: CONSTRAINT --
-- ALTER TABLE public.croisement DROP CONSTRAINT IF EXISTS croisement_qualite_croisement_fk CASCADE;
ALTER TABLE public.croisement ADD CONSTRAINT croisement_qualite_croisement_fk FOREIGN KEY (croisement_qualite_id)
REFERENCES public.croisement_qualite (croisement_qualite_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: repro_sequence_croisement_fk | type: CONSTRAINT --
-- ALTER TABLE public.croisement DROP CONSTRAINT IF EXISTS repro_sequence_croisement_fk CASCADE;
ALTER TABLE public.croisement ADD CONSTRAINT repro_sequence_croisement_fk FOREIGN KEY (sequence_id)
REFERENCES public.sequence (sequence_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: categorie_devenir_fk | type: CONSTRAINT --
-- ALTER TABLE public.devenir DROP CONSTRAINT IF EXISTS categorie_devenir_fk CASCADE;
ALTER TABLE public.devenir ADD CONSTRAINT categorie_devenir_fk FOREIGN KEY (categorie_id)
REFERENCES public.categorie (categorie_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: devenir_devenir_fk | type: CONSTRAINT --
-- ALTER TABLE public.devenir DROP CONSTRAINT IF EXISTS devenir_devenir_fk CASCADE;
ALTER TABLE public.devenir ADD CONSTRAINT devenir_devenir_fk FOREIGN KEY (parent_devenir_id)
REFERENCES public.devenir (devenir_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: devenir_type_devenir_fk | type: CONSTRAINT --
-- ALTER TABLE public.devenir DROP CONSTRAINT IF EXISTS devenir_type_devenir_fk CASCADE;
ALTER TABLE public.devenir ADD CONSTRAINT devenir_type_devenir_fk FOREIGN KEY (devenir_type_id)
REFERENCES public.devenir_type (devenir_type_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: lot_devenir_fk | type: CONSTRAINT --
-- ALTER TABLE public.devenir DROP CONSTRAINT IF EXISTS lot_devenir_fk CASCADE;
ALTER TABLE public.devenir ADD CONSTRAINT lot_devenir_fk FOREIGN KEY (lot_id)
REFERENCES public.lot (lot_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: sortie_lieu_devenir_fk | type: CONSTRAINT --
-- ALTER TABLE public.devenir DROP CONSTRAINT IF EXISTS sortie_lieu_devenir_fk CASCADE;
ALTER TABLE public.devenir ADD CONSTRAINT sortie_lieu_devenir_fk FOREIGN KEY (sortie_lieu_id)
REFERENCES public.sortie_lieu (sortie_lieu_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: bassin_distrib_quotidien_fk | type: CONSTRAINT --
-- ALTER TABLE public.distrib_quotidien DROP CONSTRAINT IF EXISTS bassin_distrib_quotidien_fk CASCADE;
ALTER TABLE public.distrib_quotidien ADD CONSTRAINT bassin_distrib_quotidien_fk FOREIGN KEY (bassin_id)
REFERENCES public.bassin (bassin_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: bassin_distribution_fk | type: CONSTRAINT --
-- ALTER TABLE public.distribution DROP CONSTRAINT IF EXISTS bassin_distribution_fk CASCADE;
ALTER TABLE public.distribution ADD CONSTRAINT bassin_distribution_fk FOREIGN KEY (bassin_id)
REFERENCES public.bassin (bassin_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: repart_template_distribution_fk | type: CONSTRAINT --
-- ALTER TABLE public.distribution DROP CONSTRAINT IF EXISTS repart_template_distribution_fk CASCADE;
ALTER TABLE public.distribution ADD CONSTRAINT repart_template_distribution_fk FOREIGN KEY (repart_template_id)
REFERENCES public.repart_template (repart_template_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: repartition_distribution_fk | type: CONSTRAINT --
-- ALTER TABLE public.distribution DROP CONSTRAINT IF EXISTS repartition_distribution_fk CASCADE;
ALTER TABLE public.distribution ADD CONSTRAINT repartition_distribution_fk FOREIGN KEY (repartition_id)
REFERENCES public.repartition (repartition_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: mime_type_document_fk | type: CONSTRAINT --
-- ALTER TABLE public.document DROP CONSTRAINT IF EXISTS mime_type_document_fk CASCADE;
ALTER TABLE public.document ADD CONSTRAINT mime_type_document_fk FOREIGN KEY (mime_type_id)
REFERENCES public.mime_type (mime_type_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: evenement_dosage_sanguin_fk | type: CONSTRAINT --
-- ALTER TABLE public.dosage_sanguin DROP CONSTRAINT IF EXISTS evenement_dosage_sanguin_fk CASCADE;
ALTER TABLE public.dosage_sanguin ADD CONSTRAINT evenement_dosage_sanguin_fk FOREIGN KEY (evenement_id)
REFERENCES public.evenement (evenement_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_campagne_dosage_sanguin_fk | type: CONSTRAINT --
-- ALTER TABLE public.dosage_sanguin DROP CONSTRAINT IF EXISTS poisson_campagne_dosage_sanguin_fk CASCADE;
ALTER TABLE public.dosage_sanguin ADD CONSTRAINT poisson_campagne_dosage_sanguin_fk FOREIGN KEY (poisson_campagne_id)
REFERENCES public.poisson_campagne (poisson_campagne_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_dosage_sanguin_fk | type: CONSTRAINT --
-- ALTER TABLE public.dosage_sanguin DROP CONSTRAINT IF EXISTS poisson_dosage_sanguin_fk CASCADE;
ALTER TABLE public.dosage_sanguin ADD CONSTRAINT poisson_dosage_sanguin_fk FOREIGN KEY (poisson_id)
REFERENCES public.poisson (poisson_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: evenement_echographie_fk | type: CONSTRAINT --
-- ALTER TABLE public.echographie DROP CONSTRAINT IF EXISTS evenement_echographie_fk CASCADE;
ALTER TABLE public.echographie ADD CONSTRAINT evenement_echographie_fk FOREIGN KEY (evenement_id)
REFERENCES public.evenement (evenement_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_echographie_fk | type: CONSTRAINT --
-- ALTER TABLE public.echographie DROP CONSTRAINT IF EXISTS poisson_echographie_fk CASCADE;
ALTER TABLE public.echographie ADD CONSTRAINT poisson_echographie_fk FOREIGN KEY (poisson_id)
REFERENCES public.poisson (poisson_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: stade_gonade_echographie_fk | type: CONSTRAINT --
-- ALTER TABLE public.echographie DROP CONSTRAINT IF EXISTS stade_gonade_echographie_fk CASCADE;
ALTER TABLE public.echographie ADD CONSTRAINT stade_gonade_echographie_fk FOREIGN KEY (stade_gonade_id)
REFERENCES public.stade_gonade (stade_gonade_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: stade_oeuf_echographie_fk | type: CONSTRAINT --
-- ALTER TABLE public.echographie DROP CONSTRAINT IF EXISTS stade_oeuf_echographie_fk CASCADE;
ALTER TABLE public.echographie ADD CONSTRAINT stade_oeuf_echographie_fk FOREIGN KEY (stade_oeuf_id)
REFERENCES public.stade_oeuf (stade_oeuf_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: document_evenement_document_fk | type: CONSTRAINT --
-- ALTER TABLE public.evenement_document DROP CONSTRAINT IF EXISTS document_evenement_document_fk CASCADE;
ALTER TABLE public.evenement_document ADD CONSTRAINT document_evenement_document_fk FOREIGN KEY (document_id)
REFERENCES public.document (document_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: evenement_evenement_document_fk | type: CONSTRAINT --
-- ALTER TABLE public.evenement_document DROP CONSTRAINT IF EXISTS evenement_evenement_document_fk CASCADE;
ALTER TABLE public.evenement_document ADD CONSTRAINT evenement_evenement_document_fk FOREIGN KEY (evenement_id)
REFERENCES public.evenement (evenement_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: evenement_type_evenement_fk | type: CONSTRAINT --
-- ALTER TABLE public.evenement DROP CONSTRAINT IF EXISTS evenement_type_evenement_fk CASCADE;
ALTER TABLE public.evenement ADD CONSTRAINT evenement_type_evenement_fk FOREIGN KEY (evenement_type_id)
REFERENCES public.evenement_type (evenement_type_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_evenement_fk | type: CONSTRAINT --
-- ALTER TABLE public.evenement DROP CONSTRAINT IF EXISTS poisson_evenement_fk CASCADE;
ALTER TABLE public.evenement ADD CONSTRAINT poisson_evenement_fk FOREIGN KEY (poisson_id)
REFERENCES public.poisson (poisson_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: evenement_gender_selection_fk | type: CONSTRAINT --
-- ALTER TABLE public.gender_selection DROP CONSTRAINT IF EXISTS evenement_gender_selection_fk CASCADE;
ALTER TABLE public.gender_selection ADD CONSTRAINT evenement_gender_selection_fk FOREIGN KEY (evenement_id)
REFERENCES public.evenement (evenement_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: gender_methode_gender_selection_fk | type: CONSTRAINT --
-- ALTER TABLE public.gender_selection DROP CONSTRAINT IF EXISTS gender_methode_gender_selection_fk CASCADE;
ALTER TABLE public.gender_selection ADD CONSTRAINT gender_methode_gender_selection_fk FOREIGN KEY (gender_methode_id)
REFERENCES public.gender_methode (gender_methode_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_gender_selection_fk | type: CONSTRAINT --
-- ALTER TABLE public.gender_selection DROP CONSTRAINT IF EXISTS poisson_gender_selection_fk CASCADE;
ALTER TABLE public.gender_selection ADD CONSTRAINT poisson_gender_selection_fk FOREIGN KEY (poisson_id)
REFERENCES public.poisson (poisson_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: sexe_gender_selection_fk | type: CONSTRAINT --
-- ALTER TABLE public.gender_selection DROP CONSTRAINT IF EXISTS sexe_gender_selection_fk CASCADE;
ALTER TABLE public.gender_selection ADD CONSTRAINT sexe_gender_selection_fk FOREIGN KEY (sexe_id)
REFERENCES public.sexe (sexe_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: evenement_genetique_fk | type: CONSTRAINT --
-- ALTER TABLE public.genetique DROP CONSTRAINT IF EXISTS evenement_genetique_fk CASCADE;
ALTER TABLE public.genetique ADD CONSTRAINT evenement_genetique_fk FOREIGN KEY (evenement_id)
REFERENCES public.evenement (evenement_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: nageoire_genetique_fk | type: CONSTRAINT --
-- ALTER TABLE public.genetique DROP CONSTRAINT IF EXISTS nageoire_genetique_fk CASCADE;
ALTER TABLE public.genetique ADD CONSTRAINT nageoire_genetique_fk FOREIGN KEY (nageoire_id)
REFERENCES public.nageoire (nageoire_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_genetique_fk | type: CONSTRAINT --
-- ALTER TABLE public.genetique DROP CONSTRAINT IF EXISTS poisson_genetique_fk CASCADE;
ALTER TABLE public.genetique ADD CONSTRAINT poisson_genetique_fk FOREIGN KEY (poisson_id)
REFERENCES public.poisson (poisson_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: hormone_injection_fk | type: CONSTRAINT --
-- ALTER TABLE public.injection DROP CONSTRAINT IF EXISTS hormone_injection_fk CASCADE;
ALTER TABLE public.injection ADD CONSTRAINT hormone_injection_fk FOREIGN KEY (hormone_id)
REFERENCES public.hormone (hormone_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_campagne_injection_fk | type: CONSTRAINT --
-- ALTER TABLE public.injection DROP CONSTRAINT IF EXISTS poisson_campagne_injection_fk CASCADE;
ALTER TABLE public.injection ADD CONSTRAINT poisson_campagne_injection_fk FOREIGN KEY (poisson_campagne_id)
REFERENCES public.poisson_campagne (poisson_campagne_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: sequence_injection_fk | type: CONSTRAINT --
-- ALTER TABLE public.injection DROP CONSTRAINT IF EXISTS sequence_injection_fk CASCADE;
ALTER TABLE public.injection ADD CONSTRAINT sequence_injection_fk FOREIGN KEY (sequence_id)
REFERENCES public.sequence (sequence_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: croisement_lot_fk | type: CONSTRAINT --
-- ALTER TABLE public.lot DROP CONSTRAINT IF EXISTS croisement_lot_fk CASCADE;
ALTER TABLE public.lot ADD CONSTRAINT croisement_lot_fk FOREIGN KEY (croisement_id)
REFERENCES public.croisement (croisement_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: vie_modele_lot_fk | type: CONSTRAINT --
-- ALTER TABLE public.lot DROP CONSTRAINT IF EXISTS vie_modele_lot_fk CASCADE;
ALTER TABLE public.lot ADD CONSTRAINT vie_modele_lot_fk FOREIGN KEY (vie_modele_id)
REFERENCES public.vie_modele (vie_modele_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: lot_lot_mesure_fk | type: CONSTRAINT --
-- ALTER TABLE public.lot_mesure DROP CONSTRAINT IF EXISTS lot_lot_mesure_fk CASCADE;
ALTER TABLE public.lot_mesure ADD CONSTRAINT lot_lot_mesure_fk FOREIGN KEY (lot_id)
REFERENCES public.lot (lot_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: evenement_morphologie_fk | type: CONSTRAINT --
-- ALTER TABLE public.morphologie DROP CONSTRAINT IF EXISTS evenement_morphologie_fk CASCADE;
ALTER TABLE public.morphologie ADD CONSTRAINT evenement_morphologie_fk FOREIGN KEY (evenement_id)
REFERENCES public.evenement (evenement_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_morphologie_fk | type: CONSTRAINT --
-- ALTER TABLE public.morphologie DROP CONSTRAINT IF EXISTS poisson_morphologie_fk CASCADE;
ALTER TABLE public.morphologie ADD CONSTRAINT poisson_morphologie_fk FOREIGN KEY (poisson_id)
REFERENCES public.poisson (poisson_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: evenement_mortalite_fk | type: CONSTRAINT --
-- ALTER TABLE public.mortalite DROP CONSTRAINT IF EXISTS evenement_mortalite_fk CASCADE;
ALTER TABLE public.mortalite ADD CONSTRAINT evenement_mortalite_fk FOREIGN KEY (evenement_id)
REFERENCES public.evenement (evenement_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: mortalite_type_mortalite_fk | type: CONSTRAINT --
-- ALTER TABLE public.mortalite DROP CONSTRAINT IF EXISTS mortalite_type_mortalite_fk CASCADE;
ALTER TABLE public.mortalite ADD CONSTRAINT mortalite_type_mortalite_fk FOREIGN KEY (mortalite_type_id)
REFERENCES public.mortalite_type (mortalite_type_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_mortalite_fk | type: CONSTRAINT --
-- ALTER TABLE public.mortalite DROP CONSTRAINT IF EXISTS poisson_mortalite_fk CASCADE;
ALTER TABLE public.mortalite ADD CONSTRAINT poisson_mortalite_fk FOREIGN KEY (poisson_id)
REFERENCES public.poisson (poisson_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_parent_fk | type: CONSTRAINT --
-- ALTER TABLE public.parent_poisson DROP CONSTRAINT IF EXISTS poisson_parent_fk CASCADE;
ALTER TABLE public.parent_poisson ADD CONSTRAINT poisson_parent_fk FOREIGN KEY (poisson_id)
REFERENCES public.poisson (poisson_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_parent_fk1 | type: CONSTRAINT --
-- ALTER TABLE public.parent_poisson DROP CONSTRAINT IF EXISTS poisson_parent_fk1 CASCADE;
ALTER TABLE public.parent_poisson ADD CONSTRAINT poisson_parent_fk1 FOREIGN KEY (parent_id)
REFERENCES public.poisson (poisson_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: determination_parente_parente_fk | type: CONSTRAINT --
-- ALTER TABLE public.parente DROP CONSTRAINT IF EXISTS determination_parente_parente_fk CASCADE;
ALTER TABLE public.parente ADD CONSTRAINT determination_parente_parente_fk FOREIGN KEY (determination_parente_id)
REFERENCES public.determination_parente (determination_parente_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: evenement_parente_fk | type: CONSTRAINT --
-- ALTER TABLE public.parente DROP CONSTRAINT IF EXISTS evenement_parente_fk CASCADE;
ALTER TABLE public.parente ADD CONSTRAINT evenement_parente_fk FOREIGN KEY (evenement_id)
REFERENCES public.evenement (evenement_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_parente_fk | type: CONSTRAINT --
-- ALTER TABLE public.parente DROP CONSTRAINT IF EXISTS poisson_parente_fk CASCADE;
ALTER TABLE public.parente ADD CONSTRAINT poisson_parente_fk FOREIGN KEY (poisson_id)
REFERENCES public.poisson (poisson_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: evenement_pathologie_fk | type: CONSTRAINT --
-- ALTER TABLE public.pathologie DROP CONSTRAINT IF EXISTS evenement_pathologie_fk CASCADE;
ALTER TABLE public.pathologie ADD CONSTRAINT evenement_pathologie_fk FOREIGN KEY (evenement_id)
REFERENCES public.evenement (evenement_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: pathologie_type_pathologie_fk | type: CONSTRAINT --
-- ALTER TABLE public.pathologie DROP CONSTRAINT IF EXISTS pathologie_type_pathologie_fk CASCADE;
ALTER TABLE public.pathologie ADD CONSTRAINT pathologie_type_pathologie_fk FOREIGN KEY (pathologie_type_id)
REFERENCES public.pathologie_type (pathologie_type_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_pathologie_fk | type: CONSTRAINT --
-- ALTER TABLE public.pathologie DROP CONSTRAINT IF EXISTS poisson_pathologie_fk CASCADE;
ALTER TABLE public.pathologie ADD CONSTRAINT poisson_pathologie_fk FOREIGN KEY (poisson_id)
REFERENCES public.poisson (poisson_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: pittag_type_pittag_fk | type: CONSTRAINT --
-- ALTER TABLE public.pittag DROP CONSTRAINT IF EXISTS pittag_type_pittag_fk CASCADE;
ALTER TABLE public.pittag ADD CONSTRAINT pittag_type_pittag_fk FOREIGN KEY (pittag_type_id)
REFERENCES public.pittag_type (pittag_type_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_pittag_fk | type: CONSTRAINT --
-- ALTER TABLE public.pittag DROP CONSTRAINT IF EXISTS poisson_pittag_fk CASCADE;
ALTER TABLE public.pittag ADD CONSTRAINT poisson_pittag_fk FOREIGN KEY (poisson_id)
REFERENCES public.poisson (poisson_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_poisson_campagne_fk | type: CONSTRAINT --
-- ALTER TABLE public.poisson_campagne DROP CONSTRAINT IF EXISTS poisson_poisson_campagne_fk CASCADE;
ALTER TABLE public.poisson_campagne ADD CONSTRAINT poisson_poisson_campagne_fk FOREIGN KEY (poisson_id)
REFERENCES public.poisson (poisson_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: repro_statut_poisson_campagne_fk | type: CONSTRAINT --
-- ALTER TABLE public.poisson_campagne DROP CONSTRAINT IF EXISTS repro_statut_poisson_campagne_fk CASCADE;
ALTER TABLE public.poisson_campagne ADD CONSTRAINT repro_statut_poisson_campagne_fk FOREIGN KEY (repro_statut_id)
REFERENCES public.repro_statut (repro_statut_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: croisement_poisson_croisement_fk | type: CONSTRAINT --
-- ALTER TABLE public.poisson_croisement DROP CONSTRAINT IF EXISTS croisement_poisson_croisement_fk CASCADE;
ALTER TABLE public.poisson_croisement ADD CONSTRAINT croisement_poisson_croisement_fk FOREIGN KEY (croisement_id)
REFERENCES public.croisement (croisement_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_campagne_poisson_croisement_fk | type: CONSTRAINT --
-- ALTER TABLE public.poisson_croisement DROP CONSTRAINT IF EXISTS poisson_campagne_poisson_croisement_fk CASCADE;
ALTER TABLE public.poisson_croisement ADD CONSTRAINT poisson_campagne_poisson_croisement_fk FOREIGN KEY (poisson_campagne_id)
REFERENCES public.poisson_campagne (poisson_campagne_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: document_poisson_document_fk | type: CONSTRAINT --
-- ALTER TABLE public.poisson_document DROP CONSTRAINT IF EXISTS document_poisson_document_fk CASCADE;
ALTER TABLE public.poisson_document ADD CONSTRAINT document_poisson_document_fk FOREIGN KEY (document_id)
REFERENCES public.document (document_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_poisson_document_fk | type: CONSTRAINT --
-- ALTER TABLE public.poisson_document DROP CONSTRAINT IF EXISTS poisson_poisson_document_fk CASCADE;
ALTER TABLE public.poisson_document ADD CONSTRAINT poisson_poisson_document_fk FOREIGN KEY (poisson_id)
REFERENCES public.poisson (poisson_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: categorie_poisson_fk | type: CONSTRAINT --
-- ALTER TABLE public.poisson DROP CONSTRAINT IF EXISTS categorie_poisson_fk CASCADE;
ALTER TABLE public.poisson ADD CONSTRAINT categorie_poisson_fk FOREIGN KEY (categorie_id)
REFERENCES public.categorie (categorie_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_statut_poisson_fk | type: CONSTRAINT --
-- ALTER TABLE public.poisson DROP CONSTRAINT IF EXISTS poisson_statut_poisson_fk CASCADE;
ALTER TABLE public.poisson ADD CONSTRAINT poisson_statut_poisson_fk FOREIGN KEY (poisson_statut_id)
REFERENCES public.poisson_statut (poisson_statut_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: sexe_poisson_fk | type: CONSTRAINT --
-- ALTER TABLE public.poisson DROP CONSTRAINT IF EXISTS sexe_poisson_fk CASCADE;
ALTER TABLE public.poisson ADD CONSTRAINT sexe_poisson_fk FOREIGN KEY (sexe_id)
REFERENCES public.sexe (sexe_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: vie_modele_poisson_fk | type: CONSTRAINT --
-- ALTER TABLE public.poisson DROP CONSTRAINT IF EXISTS vie_modele_poisson_fk CASCADE;
ALTER TABLE public.poisson ADD CONSTRAINT vie_modele_poisson_fk FOREIGN KEY (vie_modele_id)
REFERENCES public.vie_modele (vie_modele_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_campagne_poisson_sequence_fk | type: CONSTRAINT --
-- ALTER TABLE public.poisson_sequence DROP CONSTRAINT IF EXISTS poisson_campagne_poisson_sequence_fk CASCADE;
ALTER TABLE public.poisson_sequence ADD CONSTRAINT poisson_campagne_poisson_sequence_fk FOREIGN KEY (poisson_campagne_id)
REFERENCES public.poisson_campagne (poisson_campagne_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: ps_statut_poisson_sequence_fk | type: CONSTRAINT --
-- ALTER TABLE public.poisson_sequence DROP CONSTRAINT IF EXISTS ps_statut_poisson_sequence_fk CASCADE;
ALTER TABLE public.poisson_sequence ADD CONSTRAINT ps_statut_poisson_sequence_fk FOREIGN KEY (ps_statut_id)
REFERENCES public.ps_statut (ps_statut_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: repro_sequence_poisson_sequence_fk | type: CONSTRAINT --
-- ALTER TABLE public.poisson_sequence DROP CONSTRAINT IF EXISTS repro_sequence_poisson_sequence_fk CASCADE;
ALTER TABLE public.poisson_sequence ADD CONSTRAINT repro_sequence_poisson_sequence_fk FOREIGN KEY (sequence_id)
REFERENCES public.sequence (sequence_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: bassin_campagne_profil_thermique_fk | type: CONSTRAINT --
-- ALTER TABLE public.profil_thermique DROP CONSTRAINT IF EXISTS bassin_campagne_profil_thermique_fk CASCADE;
ALTER TABLE public.profil_thermique ADD CONSTRAINT bassin_campagne_profil_thermique_fk FOREIGN KEY (bassin_campagne_id)
REFERENCES public.bassin_campagne (bassin_campagne_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: profil_thermique_type_profil_thermique_fk | type: CONSTRAINT --
-- ALTER TABLE public.profil_thermique DROP CONSTRAINT IF EXISTS profil_thermique_type_profil_thermique_fk CASCADE;
ALTER TABLE public.profil_thermique ADD CONSTRAINT profil_thermique_type_profil_thermique_fk FOREIGN KEY (profil_thermique_type_id)
REFERENCES public.profil_thermique_type (profil_thermique_type_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_sequence_ps_evenement_fk | type: CONSTRAINT --
-- ALTER TABLE public.ps_evenement DROP CONSTRAINT IF EXISTS poisson_sequence_ps_evenement_fk CASCADE;
ALTER TABLE public.ps_evenement ADD CONSTRAINT poisson_sequence_ps_evenement_fk FOREIGN KEY (poisson_sequence_id)
REFERENCES public.poisson_sequence (poisson_sequence_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: aliment_aliment_repartition_part_fk | type: CONSTRAINT --
-- ALTER TABLE public.repart_aliment DROP CONSTRAINT IF EXISTS aliment_aliment_repartition_part_fk CASCADE;
ALTER TABLE public.repart_aliment ADD CONSTRAINT aliment_aliment_repartition_part_fk FOREIGN KEY (aliment_id)
REFERENCES public.aliment (aliment_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: repart_template_repart_aliment_fk | type: CONSTRAINT --
-- ALTER TABLE public.repart_aliment DROP CONSTRAINT IF EXISTS repart_template_repart_aliment_fk CASCADE;
ALTER TABLE public.repart_aliment ADD CONSTRAINT repart_template_repart_aliment_fk FOREIGN KEY (repart_template_id)
REFERENCES public.repart_template (repart_template_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: categorie_repart_template_fk | type: CONSTRAINT --
-- ALTER TABLE public.repart_template DROP CONSTRAINT IF EXISTS categorie_repart_template_fk CASCADE;
ALTER TABLE public.repart_template ADD CONSTRAINT categorie_repart_template_fk FOREIGN KEY (categorie_id)
REFERENCES public.categorie (categorie_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: categorie_repartition_fk | type: CONSTRAINT --
-- ALTER TABLE public.repartition DROP CONSTRAINT IF EXISTS categorie_repartition_fk CASCADE;
ALTER TABLE public.repartition ADD CONSTRAINT categorie_repartition_fk FOREIGN KEY (categorie_id)
REFERENCES public.categorie (categorie_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: site_site_id_fk | type: CONSTRAINT --
-- ALTER TABLE public.repartition DROP CONSTRAINT IF EXISTS site_site_id_fk CASCADE;
ALTER TABLE public.repartition ADD CONSTRAINT site_site_id_fk FOREIGN KEY (site_id)
REFERENCES public.site (site_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: bassin_campagne_salinite_fk | type: CONSTRAINT --
-- ALTER TABLE public.salinite DROP CONSTRAINT IF EXISTS bassin_campagne_salinite_fk CASCADE;
ALTER TABLE public.salinite ADD CONSTRAINT bassin_campagne_salinite_fk FOREIGN KEY (bassin_campagne_id)
REFERENCES public.bassin_campagne (bassin_campagne_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: profil_thermique_type_salinite_fk | type: CONSTRAINT --
-- ALTER TABLE public.salinite DROP CONSTRAINT IF EXISTS profil_thermique_type_salinite_fk CASCADE;
ALTER TABLE public.salinite ADD CONSTRAINT profil_thermique_type_salinite_fk FOREIGN KEY (profil_thermique_type_id)
REFERENCES public.profil_thermique_type (profil_thermique_type_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: sequence_sequence_evenement_fk | type: CONSTRAINT --
-- ALTER TABLE public.sequence_evenement DROP CONSTRAINT IF EXISTS sequence_sequence_evenement_fk CASCADE;
ALTER TABLE public.sequence_evenement ADD CONSTRAINT sequence_sequence_evenement_fk FOREIGN KEY (sequence_id)
REFERENCES public.sequence (sequence_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: site_site_id_fk | type: CONSTRAINT --
-- ALTER TABLE public.sequence DROP CONSTRAINT IF EXISTS site_site_id_fk CASCADE;
ALTER TABLE public.sequence ADD CONSTRAINT site_site_id_fk FOREIGN KEY (site_id)
REFERENCES public.site (site_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: evenement_sortie_fk | type: CONSTRAINT --
-- ALTER TABLE public.sortie DROP CONSTRAINT IF EXISTS evenement_sortie_fk CASCADE;
ALTER TABLE public.sortie ADD CONSTRAINT evenement_sortie_fk FOREIGN KEY (evenement_id)
REFERENCES public.evenement (evenement_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_lacher_fk | type: CONSTRAINT --
-- ALTER TABLE public.sortie DROP CONSTRAINT IF EXISTS poisson_lacher_fk CASCADE;
ALTER TABLE public.sortie ADD CONSTRAINT poisson_lacher_fk FOREIGN KEY (poisson_id)
REFERENCES public.poisson (poisson_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: sortie_lieu_sortie_fk | type: CONSTRAINT --
-- ALTER TABLE public.sortie DROP CONSTRAINT IF EXISTS sortie_lieu_sortie_fk CASCADE;
ALTER TABLE public.sortie ADD CONSTRAINT sortie_lieu_sortie_fk FOREIGN KEY (sortie_lieu_id)
REFERENCES public.sortie_lieu (sortie_lieu_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: sperme_caracteristique_sperme_caract_fk | type: CONSTRAINT --
-- ALTER TABLE public.sperme_caract DROP CONSTRAINT IF EXISTS sperme_caracteristique_sperme_caract_fk CASCADE;
ALTER TABLE public.sperme_caract ADD CONSTRAINT sperme_caracteristique_sperme_caract_fk FOREIGN KEY (sperme_caracteristique_id)
REFERENCES public.sperme_caracteristique (sperme_caracteristique_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: sperme_sperme_caract_fk | type: CONSTRAINT --
-- ALTER TABLE public.sperme_caract DROP CONSTRAINT IF EXISTS sperme_sperme_caract_fk CASCADE;
ALTER TABLE public.sperme_caract ADD CONSTRAINT sperme_sperme_caract_fk FOREIGN KEY (sperme_id)
REFERENCES public.sperme (sperme_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: sperme_conservateur_sperme_congelation_fk | type: CONSTRAINT --
-- ALTER TABLE public.sperme_congelation DROP CONSTRAINT IF EXISTS sperme_conservateur_sperme_congelation_fk CASCADE;
ALTER TABLE public.sperme_congelation ADD CONSTRAINT sperme_conservateur_sperme_congelation_fk FOREIGN KEY (sperme_conservateur_id)
REFERENCES public.sperme_conservateur (sperme_conservateur_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: sperme_dilueur_sperme_congelation_fk | type: CONSTRAINT --
-- ALTER TABLE public.sperme_congelation DROP CONSTRAINT IF EXISTS sperme_dilueur_sperme_congelation_fk CASCADE;
ALTER TABLE public.sperme_congelation ADD CONSTRAINT sperme_dilueur_sperme_congelation_fk FOREIGN KEY (sperme_dilueur_id)
REFERENCES public.sperme_dilueur (sperme_dilueur_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: sperme_sperme_congelation_fk | type: CONSTRAINT --
-- ALTER TABLE public.sperme_congelation DROP CONSTRAINT IF EXISTS sperme_sperme_congelation_fk CASCADE;
ALTER TABLE public.sperme_congelation ADD CONSTRAINT sperme_sperme_congelation_fk FOREIGN KEY (sperme_id)
REFERENCES public.sperme (sperme_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: sperme_congelation_sperme_freezing_measure_fk | type: CONSTRAINT --
-- ALTER TABLE public.sperme_freezing_measure DROP CONSTRAINT IF EXISTS sperme_congelation_sperme_freezing_measure_fk CASCADE;
ALTER TABLE public.sperme_freezing_measure ADD CONSTRAINT sperme_congelation_sperme_freezing_measure_fk FOREIGN KEY (sperme_congelation_id)
REFERENCES public.sperme_congelation (sperme_congelation_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: sperme_congelation_sperme_freezing_place_fk | type: CONSTRAINT --
-- ALTER TABLE public.sperme_freezing_place DROP CONSTRAINT IF EXISTS sperme_congelation_sperme_freezing_place_fk CASCADE;
ALTER TABLE public.sperme_freezing_place ADD CONSTRAINT sperme_congelation_sperme_freezing_place_fk FOREIGN KEY (sperme_congelation_id)
REFERENCES public.sperme_congelation (sperme_congelation_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: sperme_mesure_sperme_congelation_fk | type: CONSTRAINT --
-- ALTER TABLE public.sperme_mesure DROP CONSTRAINT IF EXISTS sperme_mesure_sperme_congelation_fk CASCADE;
ALTER TABLE public.sperme_mesure ADD CONSTRAINT sperme_mesure_sperme_congelation_fk FOREIGN KEY (sperme_congelation_id)
REFERENCES public.sperme_congelation (sperme_congelation_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: sperme_qualite_sperme_mesure_fk | type: CONSTRAINT --
-- ALTER TABLE public.sperme_mesure DROP CONSTRAINT IF EXISTS sperme_qualite_sperme_mesure_fk CASCADE;
ALTER TABLE public.sperme_mesure ADD CONSTRAINT sperme_qualite_sperme_mesure_fk FOREIGN KEY (sperme_qualite_id)
REFERENCES public.sperme_qualite (sperme_qualite_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: sperme_sperme_mesure_fk | type: CONSTRAINT --
-- ALTER TABLE public.sperme_mesure DROP CONSTRAINT IF EXISTS sperme_sperme_mesure_fk CASCADE;
ALTER TABLE public.sperme_mesure ADD CONSTRAINT sperme_sperme_mesure_fk FOREIGN KEY (sperme_id)
REFERENCES public.sperme (sperme_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_campagne_sperme_qualite_fk | type: CONSTRAINT --
-- ALTER TABLE public.sperme DROP CONSTRAINT IF EXISTS poisson_campagne_sperme_qualite_fk CASCADE;
ALTER TABLE public.sperme ADD CONSTRAINT poisson_campagne_sperme_qualite_fk FOREIGN KEY (poisson_campagne_id)
REFERENCES public.poisson_campagne (poisson_campagne_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: sequence_sperme_fk | type: CONSTRAINT --
-- ALTER TABLE public.sperme DROP CONSTRAINT IF EXISTS sequence_sperme_fk CASCADE;
ALTER TABLE public.sperme ADD CONSTRAINT sequence_sperme_fk FOREIGN KEY (sequence_id)
REFERENCES public.sequence (sequence_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: sperme_aspect_sperme_fk | type: CONSTRAINT --
-- ALTER TABLE public.sperme DROP CONSTRAINT IF EXISTS sperme_aspect_sperme_fk CASCADE;
ALTER TABLE public.sperme ADD CONSTRAINT sperme_aspect_sperme_fk FOREIGN KEY (sperme_aspect_id)
REFERENCES public.sperme_aspect (sperme_aspect_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: sperme_dilueur_sperme_fk | type: CONSTRAINT --
-- ALTER TABLE public.sperme DROP CONSTRAINT IF EXISTS sperme_dilueur_sperme_fk CASCADE;
ALTER TABLE public.sperme ADD CONSTRAINT sperme_dilueur_sperme_fk FOREIGN KEY (sperme_dilueur_id)
REFERENCES public.sperme_dilueur (sperme_dilueur_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: croisement_sperme_utilise_fk | type: CONSTRAINT --
-- ALTER TABLE public.sperme_utilise DROP CONSTRAINT IF EXISTS croisement_sperme_utilise_fk CASCADE;
ALTER TABLE public.sperme_utilise ADD CONSTRAINT croisement_sperme_utilise_fk FOREIGN KEY (croisement_id)
REFERENCES public.croisement (croisement_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: sperme_congelation_sperme_utilise_fk | type: CONSTRAINT --
-- ALTER TABLE public.sperme_utilise DROP CONSTRAINT IF EXISTS sperme_congelation_sperme_utilise_fk CASCADE;
ALTER TABLE public.sperme_utilise ADD CONSTRAINT sperme_congelation_sperme_utilise_fk FOREIGN KEY (sperme_congelation_id)
REFERENCES public.sperme_congelation (sperme_congelation_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: sperme_sperme_utilise_fk | type: CONSTRAINT --
-- ALTER TABLE public.sperme_utilise DROP CONSTRAINT IF EXISTS sperme_sperme_utilise_fk CASCADE;
ALTER TABLE public.sperme_utilise ADD CONSTRAINT sperme_sperme_utilise_fk FOREIGN KEY (sperme_id)
REFERENCES public.sperme (sperme_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: bassin_transfert_fk | type: CONSTRAINT --
-- ALTER TABLE public.transfert DROP CONSTRAINT IF EXISTS bassin_transfert_fk CASCADE;
ALTER TABLE public.transfert ADD CONSTRAINT bassin_transfert_fk FOREIGN KEY (bassin_origine)
REFERENCES public.bassin (bassin_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: bassin_transfert_fk1 | type: CONSTRAINT --
-- ALTER TABLE public.transfert DROP CONSTRAINT IF EXISTS bassin_transfert_fk1 CASCADE;
ALTER TABLE public.transfert ADD CONSTRAINT bassin_transfert_fk1 FOREIGN KEY (bassin_destination)
REFERENCES public.bassin (bassin_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: evenement_transfert_fk | type: CONSTRAINT --
-- ALTER TABLE public.transfert DROP CONSTRAINT IF EXISTS evenement_transfert_fk CASCADE;
ALTER TABLE public.transfert ADD CONSTRAINT evenement_transfert_fk FOREIGN KEY (evenement_id)
REFERENCES public.evenement (evenement_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_transfert_fk | type: CONSTRAINT --
-- ALTER TABLE public.transfert DROP CONSTRAINT IF EXISTS poisson_transfert_fk CASCADE;
ALTER TABLE public.transfert ADD CONSTRAINT poisson_transfert_fk FOREIGN KEY (poisson_id)
REFERENCES public.poisson (poisson_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_ventilation_fk | type: CONSTRAINT --
-- ALTER TABLE public.ventilation DROP CONSTRAINT IF EXISTS poisson_ventilation_fk CASCADE;
ALTER TABLE public.ventilation ADD CONSTRAINT poisson_ventilation_fk FOREIGN KEY (poisson_id)
REFERENCES public.poisson (poisson_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: vie_implantation_vie_modele_fk | type: CONSTRAINT --
-- ALTER TABLE public.vie_modele DROP CONSTRAINT IF EXISTS vie_implantation_vie_modele_fk CASCADE;
ALTER TABLE public.vie_modele ADD CONSTRAINT vie_implantation_vie_modele_fk FOREIGN KEY (vie_implantation_id)
REFERENCES public.vie_implantation (vie_implantation_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: vie_implantation_vie_modele_fk1 | type: CONSTRAINT --
-- ALTER TABLE public.vie_modele DROP CONSTRAINT IF EXISTS vie_implantation_vie_modele_fk1 CASCADE;
ALTER TABLE public.vie_modele ADD CONSTRAINT vie_implantation_vie_modele_fk1 FOREIGN KEY (vie_implantation_id2)
REFERENCES public.vie_implantation (vie_implantation_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: poisson_statut_sortie_lieu_fk | type: CONSTRAINT --
-- ALTER TABLE public.sortie_lieu DROP CONSTRAINT IF EXISTS poisson_statut_sortie_lieu_fk CASCADE;
ALTER TABLE public.sortie_lieu ADD CONSTRAINT poisson_statut_sortie_lieu_fk FOREIGN KEY (poisson_statut_id)
REFERENCES public.poisson_statut (poisson_statut_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "grant_X_d95a5aa54f" | type: PERMISSION --
GRANT EXECUTE
   ON FUNCTION public.alim_populate(date,date,integer,double precision,double precision,double precision,double precision,double precision,double precision,double precision,double precision)
   TO esfc;
-- ddl-end --

-- object: "grant_X_8d513404e8" | type: PERMISSION --
GRANT EXECUTE
   ON FUNCTION public.alim_populate(date,date,integer,double precision,double precision,double precision,double precision,double precision,double precision,double precision,double precision)
   TO PUBLIC;
-- ddl-end --

-- object: "grant_X_4f79d5bf20" | type: PERMISSION --
GRANT EXECUTE
   ON FUNCTION public.exec(text)
   TO esfc;
-- ddl-end --

-- object: "grant_X_c19de0d843" | type: PERMISSION --
GRANT EXECUTE
   ON FUNCTION public.exec(text)
   TO PUBLIC;
-- ddl-end --

-- object: "grant_X_50042a048b" | type: PERMISSION --
GRANT EXECUTE
   ON FUNCTION public.f_bassin_masse_at_date(integer,timestamp)
   TO esfc;
-- ddl-end --

-- object: "grant_X_a8440f5bc8" | type: PERMISSION --
GRANT EXECUTE
   ON FUNCTION public.f_bassin_masse_at_date(integer,timestamp)
   TO PUBLIC;
-- ddl-end --

-- object: "grant_X_495986ca0a" | type: PERMISSION --
GRANT EXECUTE
   ON FUNCTION public.f_poisson_masse_at_date(integer,timestamp)
   TO esfc;
-- ddl-end --

-- object: "grant_X_48793b944d" | type: PERMISSION --
GRANT EXECUTE
   ON FUNCTION public.f_poisson_masse_at_date(integer,timestamp)
   TO PUBLIC;
-- ddl-end --

-- object: "grant_X_fc757e25db" | type: PERMISSION --
GRANT EXECUTE
   ON FUNCTION public.masse_bassin_date(integer,date)
   TO esfc;
-- ddl-end --

-- object: "grant_X_01bacb3e1d" | type: PERMISSION --
GRANT EXECUTE
   ON FUNCTION public.masse_bassin_date(integer,date)
   TO PUBLIC;
-- ddl-end --

-- object: "grant_X_9d6b46808e" | type: PERMISSION --
GRANT EXECUTE
   ON FUNCTION public.poisson_bassin_date(integer,date)
   TO esfc;
-- ddl-end --

-- object: "grant_X_5edd1c21f5" | type: PERMISSION --
GRANT EXECUTE
   ON FUNCTION public.poisson_bassin_date(integer,date)
   TO PUBLIC;
-- ddl-end --

-- object: "grant_X_110f1efc58" | type: PERMISSION --
GRANT EXECUTE
   ON FUNCTION public.poisson_masse_date(integer,date)
   TO esfc;
-- ddl-end --

-- object: "grant_X_115e2ae7c9" | type: PERMISSION --
GRANT EXECUTE
   ON FUNCTION public.poisson_masse_date(integer,date)
   TO PUBLIC;
-- ddl-end --

-- object: "grant_X_1172ef7328" | type: PERMISSION --
GRANT EXECUTE
   ON FUNCTION public.update_sturat_geom()
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_6849f366eb" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.aliment
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_41f2e67690" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.aliment_categorie
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_5df05387dc" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.aliment_quotidien
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_f567fc892c" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.aliment_type
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_c03995aa15" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.analyse_eau
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_ed47f6f843" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.analyse_metal
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_d57d05bff3" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.anesthesie
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_295261ebfb" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.anesthesie_produit
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_4bcd997684" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.anomalie_db
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_e2372f37bf" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.anomalie_db_type
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_e5c86a6ac6" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.bassin
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_6960cbf3de" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.bassin_campagne
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_2d013eac02" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.bassin_document
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_2a81249940" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.bassin_evenement
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_0c27d8e7a1" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.bassin_evenement_type
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_39d3fad633" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.bassin_lot
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_54880a2299" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.bassin_type
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_79d65497b8" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.bassin_usage
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_4a4d37a025" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.bassin_zone
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_a77da8d70a" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.biopsie
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_e371b6638e" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.biopsie_document
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_e6ce174fd0" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.biopsie_technique_calcul
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_5a9f00ec7e" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.categorie
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_1df7753f1f" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.circuit_eau
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_9563df1906" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.circuit_evenement
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_512d92d104" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.circuit_evenement_type
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_fb5cf1274b" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.cohorte
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_67bbaf4859" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.cohorte_type
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_0033977498" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.croisement
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_e072f65180" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.croisement_qualite
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_c9a9ee5be7" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.devenir
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_7fb9ac6cc6" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.devenir_type
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_a00424cc70" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.distrib_quotidien
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_b9d0b2f3e6" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.distribution
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_4a6dcdddae" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.document
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_8a4fef28ff" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.dosage_sanguin
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_209551cda0" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.echographie
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_4fd2843c22" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.evenement
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_7cb9894efb" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.evenement_document
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_44367c2f55" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.evenement_type
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_6beab09619" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.gender_methode
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_8217a1ca5c" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.gender_selection
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_23f5cc9237" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.genetique
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_a08f1304c8" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.hormone
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_791e28dba8" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.import_alim
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_66f3aeaad6" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.injection
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_1b966ce1d3" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.laboratoire_analyse
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_481c4ac432" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.lot
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_e53e4c6bff" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.lot_mesure
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_ef70423bbf" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.lot_repart_template
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_a3e0f3bebc" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.metal
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_fbf2442733" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.mime_type
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_25e3eb451c" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.morphologie
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_c128f07335" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.mortalite
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_b2d8d5fc5c" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.mortalite_type
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_a5313d7d85" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.nageoire
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_94c1687c12" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.parent_poisson
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_bfa2a1bf4e" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.pathologie
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_946d89d544" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.pathologie_type
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_ea37ef3fdd" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.pittag
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_ca1209161e" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.pittag_type
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_eeda3c1859" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.poisson
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_870a9e5e18" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.poisson_campagne
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_06325c5d83" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.poisson_croisement
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_65468f3d5c" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.poisson_document
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_8130192656" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.poisson_sequence
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_c2f99695f8" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.poisson_statut
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_b953e03e28" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.profil_thermique
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_eac62b72b5" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.profil_thermique_type
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_1bafa99dc0" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.ps_evenement
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_916f37a887" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.ps_statut
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_d74ffad536" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.repart_aliment
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_b3f61c8019" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.repart_template
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_fdcbcca0f4" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.repartition
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_f7269a386c" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.repro_statut
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_a3de74ca89" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.salinite
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_f6dedd945a" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.sequence
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_aebbedb0cf" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.sequence_evenement
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_69b02136ec" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.sexe
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_fab8c46146" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.sortie
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_a7025888c7" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.sortie_lieu
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_9018692424" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.sperme
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_285cdb03cc" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.sperme_aspect
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_cf55a04cb8" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.sperme_caract
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_2c5d069bd4" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.sperme_caracteristique
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_c8e8c1b04c" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.sperme_congelation
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_75eb7f1f7e" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.sperme_dilueur
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_daab7f6320" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.sperme_mesure
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_9e295f3b89" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.sperme_qualite
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_70e203939b" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.sperme_utilise
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_b3b65ce569" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.stade_gonade
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_ec690e03f4" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.stade_oeuf
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_c85b1afe16" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.transfert
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_fc23e03a34" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.v_bassin_alim_quotidien
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_b5af8290ef" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.v_distribution
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_a5e76d9a7e" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.v_gender_selection
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_db3b595863" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.v_parent_poisson_ntile
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_2e07e428a2" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.v_parents
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_b3f2e96d30" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.v_pittag_by_poisson
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_4c9a5b0071" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.v_poisson_bassins
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_672fc92041" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.v_poisson_last_bassin
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_75bead6fd2" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.v_poisson_last_lf
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_bc2607264c" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.v_poisson_last_lt
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_4968bb75a7" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.v_poisson_last_masse
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_a831e17054" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.v_prenom_parent_femelle
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_07ba187571" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.v_prenom_parents
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_94eacb15e7" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.v_prenom_parents_male
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_10e180c850" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.v_sperme_congelation_date
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_f8a9d4a555" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.v_transfert_last_bassin_for_poisson
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_37fe8e298c" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.vie_implantation
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_af7ad9cd24" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.vie_modele
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_0876631d52" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.v_vie_modele
   TO esfc;
-- ddl-end --

-- object: "grant_rawdDxt_244d6968d2" | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE public.ventilation
   TO esfc;
-- ddl-end --


