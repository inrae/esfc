--
-- PostgreSQL database dump
--
-- Creation des tables dans le schema gacl
-- Droits positionnes pour le groupe g_gacl, a adapter le cas echeant
-- 

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: gacl; Type: SCHEMA; Schema: -; Owner: quinton
--

CREATE SCHEMA gacl;


ALTER SCHEMA gacl OWNER TO postgres;

SET search_path = gacl, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: gaclacl; Type: TABLE; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE TABLE gaclacl (
    id integer DEFAULT 0 NOT NULL,
    section_value character varying(230) DEFAULT 'system'::character varying NOT NULL,
    allow integer DEFAULT 0 NOT NULL,
    enabled integer DEFAULT 0 NOT NULL,
    return_value text,
    note text,
    updated_date integer DEFAULT 0 NOT NULL
);


ALTER TABLE gacl.gaclacl OWNER TO postgres;

--
-- Name: gaclacl_sections; Type: TABLE; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE TABLE gaclacl_sections (
    id integer DEFAULT 0 NOT NULL,
    value character varying(230) NOT NULL,
    order_value integer DEFAULT 0 NOT NULL,
    name character varying(230) NOT NULL,
    hidden integer DEFAULT 0 NOT NULL
);


ALTER TABLE gacl.gaclacl_sections OWNER TO postgres;

--
-- Name: gaclacl_seq; Type: SEQUENCE; Schema: gacl; Owner: g_gacl
--

CREATE SEQUENCE gaclacl_seq
    START WITH 10
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE gacl.gaclacl_seq OWNER TO postgres;

--
-- Name: gaclaco; Type: TABLE; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE TABLE gaclaco (
    id integer DEFAULT 0 NOT NULL,
    section_value character varying(240) DEFAULT '0'::character varying NOT NULL,
    value character varying(240) NOT NULL,
    order_value integer DEFAULT 0 NOT NULL,
    name character varying(255) NOT NULL,
    hidden integer DEFAULT 0 NOT NULL
);


ALTER TABLE gacl.gaclaco OWNER TO postgres;

--
-- Name: gaclaco_map; Type: TABLE; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE TABLE gaclaco_map (
    acl_id integer DEFAULT 0 NOT NULL,
    section_value character varying(230) DEFAULT '0'::character varying NOT NULL,
    value character varying(230) NOT NULL
);


ALTER TABLE gacl.gaclaco_map OWNER TO postgres;

--
-- Name: gaclaco_sections; Type: TABLE; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE TABLE gaclaco_sections (
    id integer DEFAULT 0 NOT NULL,
    value character varying(230) NOT NULL,
    order_value integer DEFAULT 0 NOT NULL,
    name character varying(230) NOT NULL,
    hidden integer DEFAULT 0 NOT NULL
);


ALTER TABLE gacl.gaclaco_sections OWNER TO postgres;

--
-- Name: gaclaco_sections_seq; Type: SEQUENCE; Schema: gacl; Owner: g_gacl
--

CREATE SEQUENCE gaclaco_sections_seq
    START WITH 10
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE gacl.gaclaco_sections_seq OWNER TO postgres;

--
-- Name: gaclaco_seq; Type: SEQUENCE; Schema: gacl; Owner: g_gacl
--

CREATE SEQUENCE gaclaco_seq
    START WITH 10
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE gacl.gaclaco_seq OWNER TO postgres;

--
-- Name: gaclaro; Type: TABLE; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE TABLE gaclaro (
    id integer DEFAULT 0 NOT NULL,
    section_value character varying(240) DEFAULT '0'::character varying NOT NULL,
    value character varying(240) NOT NULL,
    order_value integer DEFAULT 0 NOT NULL,
    name character varying(255) NOT NULL,
    hidden integer DEFAULT 0 NOT NULL
);


ALTER TABLE gacl.gaclaro OWNER TO postgres;

--
-- Name: gaclaro_groups; Type: TABLE; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE TABLE gaclaro_groups (
    id integer DEFAULT 0 NOT NULL,
    parent_id integer DEFAULT 0 NOT NULL,
    lft integer DEFAULT 0 NOT NULL,
    rgt integer DEFAULT 0 NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE gacl.gaclaro_groups OWNER TO postgres;

--
-- Name: gaclaro_groups_id_seq; Type: SEQUENCE; Schema: gacl; Owner: g_gacl
--

CREATE SEQUENCE gaclaro_groups_id_seq
    START WITH 10
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE gacl.gaclaro_groups_id_seq OWNER TO postgres;

--
-- Name: gaclaro_groups_map; Type: TABLE; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE TABLE gaclaro_groups_map (
    acl_id integer DEFAULT 0 NOT NULL,
    group_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE gacl.gaclaro_groups_map OWNER TO postgres;

--
-- Name: gaclaro_map; Type: TABLE; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE TABLE gaclaro_map (
    acl_id integer DEFAULT 0 NOT NULL,
    section_value character varying(230) DEFAULT '0'::character varying NOT NULL,
    value character varying(230) NOT NULL
);


ALTER TABLE gacl.gaclaro_map OWNER TO postgres;

--
-- Name: gaclaro_sections; Type: TABLE; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE TABLE gaclaro_sections (
    id integer DEFAULT 0 NOT NULL,
    value character varying(230) NOT NULL,
    order_value integer DEFAULT 0 NOT NULL,
    name character varying(230) NOT NULL,
    hidden integer DEFAULT 0 NOT NULL
);


ALTER TABLE gacl.gaclaro_sections OWNER TO postgres;

--
-- Name: gaclaro_sections_seq; Type: SEQUENCE; Schema: gacl; Owner: g_gacl
--

CREATE SEQUENCE gaclaro_sections_seq
    START WITH 10
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE gacl.gaclaro_sections_seq OWNER TO postgres;

--
-- Name: gaclaro_seq; Type: SEQUENCE; Schema: gacl; Owner: g_gacl
--

CREATE SEQUENCE gaclaro_seq
    START WITH 10
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE gacl.gaclaro_seq OWNER TO postgres;

--
-- Name: gaclaxo; Type: TABLE; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE TABLE gaclaxo (
    id integer DEFAULT 0 NOT NULL,
    section_value character varying(240) DEFAULT '0'::character varying NOT NULL,
    value character varying(240) NOT NULL,
    order_value integer DEFAULT 0 NOT NULL,
    name character varying(255) NOT NULL,
    hidden integer DEFAULT 0 NOT NULL
);


ALTER TABLE gacl.gaclaxo OWNER TO postgres;

--
-- Name: gaclaxo_groups; Type: TABLE; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE TABLE gaclaxo_groups (
    id integer DEFAULT 0 NOT NULL,
    parent_id integer DEFAULT 0 NOT NULL,
    lft integer DEFAULT 0 NOT NULL,
    rgt integer DEFAULT 0 NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE gacl.gaclaxo_groups OWNER TO postgres;

--
-- Name: gaclaxo_groups_map; Type: TABLE; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE TABLE gaclaxo_groups_map (
    acl_id integer DEFAULT 0 NOT NULL,
    group_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE gacl.gaclaxo_groups_map OWNER TO postgres;

--
-- Name: gaclaxo_map; Type: TABLE; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE TABLE gaclaxo_map (
    acl_id integer DEFAULT 0 NOT NULL,
    section_value character varying(230) DEFAULT '0'::character varying NOT NULL,
    value character varying(230) NOT NULL
);


ALTER TABLE gacl.gaclaxo_map OWNER TO postgres;

--
-- Name: gaclaxo_sections; Type: TABLE; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE TABLE gaclaxo_sections (
    id integer DEFAULT 0 NOT NULL,
    value character varying(230) NOT NULL,
    order_value integer DEFAULT 0 NOT NULL,
    name character varying(230) NOT NULL,
    hidden integer DEFAULT 0 NOT NULL
);


ALTER TABLE gacl.gaclaxo_sections OWNER TO postgres;

--
-- Name: gaclgroups_aro_map; Type: TABLE; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE TABLE gaclgroups_aro_map (
    group_id integer DEFAULT 0 NOT NULL,
    aro_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE gacl.gaclgroups_aro_map OWNER TO postgres;

--
-- Name: gaclgroups_axo_map; Type: TABLE; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE TABLE gaclgroups_axo_map (
    group_id integer DEFAULT 0 NOT NULL,
    axo_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE gacl.gaclgroups_axo_map OWNER TO postgres;

--
-- Name: gaclphpgacl; Type: TABLE; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE TABLE gaclphpgacl (
    name character varying(230) NOT NULL,
    value character varying(230) NOT NULL
);


ALTER TABLE gacl.gaclphpgacl OWNER TO postgres;

--
-- Name: logingestion; Type: TABLE; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE TABLE logingestion (
    id integer NOT NULL,
    login character varying(32) NOT NULL,
    password character varying(255),
    nom character varying(32),
    prenom character varying(32),
    mail character varying(255),
    datemodif date
);


ALTER TABLE gacl.logingestion OWNER TO postgres;

--
-- Name: seq_logingestion_id; Type: SEQUENCE; Schema: gacl; Owner: g_gacl
--

CREATE SEQUENCE seq_logingestion_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1;


ALTER TABLE gacl.seq_logingestion_id OWNER TO postgres;

--
-- Name: seq_logingestion_id; Type: SEQUENCE OWNED BY; Schema: gacl; Owner: g_gacl
--

ALTER SEQUENCE seq_logingestion_id OWNED BY logingestion.id;


--
-- Name: id; Type: DEFAULT; Schema: gacl; Owner: g_gacl
--

ALTER TABLE ONLY logingestion ALTER COLUMN id SET DEFAULT nextval('seq_logingestion_id'::regclass);


--
-- Data for Name: gaclacl; Type: TABLE DATA; Schema: gacl; Owner: g_gacl
--

COPY gaclacl (id, section_value, allow, enabled, return_value, note, updated_date) FROM stdin;
10	user	1	1			1381741218
11	user	1	1			1381741231
12	user	1	1			1381741255
\.


--
-- Data for Name: gaclacl_sections; Type: TABLE DATA; Schema: gacl; Owner: g_gacl
--

COPY gaclacl_sections (id, value, order_value, name, hidden) FROM stdin;
1	system	1	System	0
2	user	2	User	0
\.


--
-- Name: gaclacl_seq; Type: SEQUENCE SET; Schema: gacl; Owner: g_gacl
--

SELECT pg_catalog.setval('gaclacl_seq', 12, true);


--
-- Data for Name: gaclaco; Type: TABLE DATA; Schema: gacl; Owner: g_gacl
--

COPY gaclaco (id, section_value, value, order_value, name, hidden) FROM stdin;
10	appli	admin	1	admin	0
11	appli	gestion	1	gestion	0
12	appli	consult	1	consult	0
\.


--
-- Data for Name: gaclaco_map; Type: TABLE DATA; Schema: gacl; Owner: g_gacl
--

COPY gaclaco_map (acl_id, section_value, value) FROM stdin;
10	appli	admin
11	appli	gestion
12	appli	consult
\.


--
-- Data for Name: gaclaco_sections; Type: TABLE DATA; Schema: gacl; Owner: g_gacl
--

COPY gaclaco_sections (id, value, order_value, name, hidden) FROM stdin;
10	appli	1	appli	0
\.


--
-- Name: gaclaco_sections_seq; Type: SEQUENCE SET; Schema: gacl; Owner: g_gacl
--

SELECT pg_catalog.setval('gaclaco_sections_seq', 10, true);


--
-- Name: gaclaco_seq; Type: SEQUENCE SET; Schema: gacl; Owner: g_gacl
--

SELECT pg_catalog.setval('gaclaco_seq', 12, true);


--
-- Data for Name: gaclaro; Type: TABLE DATA; Schema: gacl; Owner: g_gacl
--

COPY gaclaro (id, section_value, value, order_value, name, hidden) FROM stdin;
10	login	admin	1	admin	0
11	login	gestion	1	gestion	0
\.


--
-- Data for Name: gaclaro_groups; Type: TABLE DATA; Schema: gacl; Owner: g_gacl
--

COPY gaclaro_groups (id, parent_id, lft, rgt, name, value) FROM stdin;
11	10	2	5	consult	consult
12	11	3	4	gestion	gestion
10	0	1	8	appli	appli
13	10	6	7	admin	admin
\.


--
-- Name: gaclaro_groups_id_seq; Type: SEQUENCE SET; Schema: gacl; Owner: g_gacl
--

SELECT pg_catalog.setval('gaclaro_groups_id_seq', 13, true);


--
-- Data for Name: gaclaro_groups_map; Type: TABLE DATA; Schema: gacl; Owner: g_gacl
--

COPY gaclaro_groups_map (acl_id, group_id) FROM stdin;
10	13
11	12
12	11
\.


--
-- Data for Name: gaclaro_map; Type: TABLE DATA; Schema: gacl; Owner: g_gacl
--

COPY gaclaro_map (acl_id, section_value, value) FROM stdin;
\.


--
-- Data for Name: gaclaro_sections; Type: TABLE DATA; Schema: gacl; Owner: g_gacl
--

COPY gaclaro_sections (id, value, order_value, name, hidden) FROM stdin;
10	login	1	login	0
\.


--
-- Name: gaclaro_sections_seq; Type: SEQUENCE SET; Schema: gacl; Owner: g_gacl
--

SELECT pg_catalog.setval('gaclaro_sections_seq', 10, true);


--
-- Name: gaclaro_seq; Type: SEQUENCE SET; Schema: gacl; Owner: g_gacl
--

SELECT pg_catalog.setval('gaclaro_seq', 11, true);


--
-- Data for Name: gaclaxo; Type: TABLE DATA; Schema: gacl; Owner: g_gacl
--

COPY gaclaxo (id, section_value, value, order_value, name, hidden) FROM stdin;
\.


--
-- Data for Name: gaclaxo_groups; Type: TABLE DATA; Schema: gacl; Owner: g_gacl
--

COPY gaclaxo_groups (id, parent_id, lft, rgt, name, value) FROM stdin;
\.


--
-- Data for Name: gaclaxo_groups_map; Type: TABLE DATA; Schema: gacl; Owner: g_gacl
--

COPY gaclaxo_groups_map (acl_id, group_id) FROM stdin;
\.


--
-- Data for Name: gaclaxo_map; Type: TABLE DATA; Schema: gacl; Owner: g_gacl
--

COPY gaclaxo_map (acl_id, section_value, value) FROM stdin;
\.


--
-- Data for Name: gaclaxo_sections; Type: TABLE DATA; Schema: gacl; Owner: g_gacl
--

COPY gaclaxo_sections (id, value, order_value, name, hidden) FROM stdin;
\.


--
-- Data for Name: gaclgroups_aro_map; Type: TABLE DATA; Schema: gacl; Owner: g_gacl
--

COPY gaclgroups_aro_map (group_id, aro_id) FROM stdin;
13	10
12	10
12	11
\.


--
-- Data for Name: gaclgroups_axo_map; Type: TABLE DATA; Schema: gacl; Owner: g_gacl
--

COPY gaclgroups_axo_map (group_id, axo_id) FROM stdin;
\.


--
-- Data for Name: gaclphpgacl; Type: TABLE DATA; Schema: gacl; Owner: g_gacl
--

COPY gaclphpgacl (name, value) FROM stdin;
version	3.3.7
schema_version	2.1
\.


--
-- Data for Name: logingestion; Type: TABLE DATA; Schema: gacl; Owner: g_gacl
--

COPY logingestion (id, login, password, nom, prenom, mail, datemodif) FROM stdin;
1	admin	5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8	Administrateur	\N	\N	\N
5	gestion	5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8	Gestionnaire	\N	\N	\N
\.


--
-- Name: seq_logingestion_id; Type: SEQUENCE SET; Schema: gacl; Owner: g_gacl
--

SELECT pg_catalog.setval('seq_logingestion_id', 1, false);


--
-- Name: gaclacl_pkey; Type: CONSTRAINT; Schema: gacl; Owner: g_gacl; Tablespace: 
--

ALTER TABLE ONLY gaclacl
    ADD CONSTRAINT gaclacl_pkey PRIMARY KEY (id);


--
-- Name: gaclacl_sections_pkey; Type: CONSTRAINT; Schema: gacl; Owner: g_gacl; Tablespace: 
--

ALTER TABLE ONLY gaclacl_sections
    ADD CONSTRAINT gaclacl_sections_pkey PRIMARY KEY (id);


--
-- Name: gaclaco_map_pkey; Type: CONSTRAINT; Schema: gacl; Owner: g_gacl; Tablespace: 
--

ALTER TABLE ONLY gaclaco_map
    ADD CONSTRAINT gaclaco_map_pkey PRIMARY KEY (acl_id, section_value, value);


--
-- Name: gaclaco_pkey; Type: CONSTRAINT; Schema: gacl; Owner: g_gacl; Tablespace: 
--

ALTER TABLE ONLY gaclaco
    ADD CONSTRAINT gaclaco_pkey PRIMARY KEY (id);


--
-- Name: gaclaco_sections_pkey; Type: CONSTRAINT; Schema: gacl; Owner: g_gacl; Tablespace: 
--

ALTER TABLE ONLY gaclaco_sections
    ADD CONSTRAINT gaclaco_sections_pkey PRIMARY KEY (id);


--
-- Name: gaclaro_groups_map_pkey; Type: CONSTRAINT; Schema: gacl; Owner: g_gacl; Tablespace: 
--

ALTER TABLE ONLY gaclaro_groups_map
    ADD CONSTRAINT gaclaro_groups_map_pkey PRIMARY KEY (acl_id, group_id);


--
-- Name: gaclaro_groups_pkey; Type: CONSTRAINT; Schema: gacl; Owner: g_gacl; Tablespace: 
--

ALTER TABLE ONLY gaclaro_groups
    ADD CONSTRAINT gaclaro_groups_pkey PRIMARY KEY (id, value);


--
-- Name: gaclaro_map_pkey; Type: CONSTRAINT; Schema: gacl; Owner: g_gacl; Tablespace: 
--

ALTER TABLE ONLY gaclaro_map
    ADD CONSTRAINT gaclaro_map_pkey PRIMARY KEY (acl_id, section_value, value);


--
-- Name: gaclaro_pkey; Type: CONSTRAINT; Schema: gacl; Owner: g_gacl; Tablespace: 
--

ALTER TABLE ONLY gaclaro
    ADD CONSTRAINT gaclaro_pkey PRIMARY KEY (id);


--
-- Name: gaclaro_sections_pkey; Type: CONSTRAINT; Schema: gacl; Owner: g_gacl; Tablespace: 
--

ALTER TABLE ONLY gaclaro_sections
    ADD CONSTRAINT gaclaro_sections_pkey PRIMARY KEY (id);


--
-- Name: gaclaxo_groups_map_pkey; Type: CONSTRAINT; Schema: gacl; Owner: g_gacl; Tablespace: 
--

ALTER TABLE ONLY gaclaxo_groups_map
    ADD CONSTRAINT gaclaxo_groups_map_pkey PRIMARY KEY (acl_id, group_id);


--
-- Name: gaclaxo_groups_pkey; Type: CONSTRAINT; Schema: gacl; Owner: g_gacl; Tablespace: 
--

ALTER TABLE ONLY gaclaxo_groups
    ADD CONSTRAINT gaclaxo_groups_pkey PRIMARY KEY (id, value);


--
-- Name: gaclaxo_map_pkey; Type: CONSTRAINT; Schema: gacl; Owner: g_gacl; Tablespace: 
--

ALTER TABLE ONLY gaclaxo_map
    ADD CONSTRAINT gaclaxo_map_pkey PRIMARY KEY (acl_id, section_value, value);


--
-- Name: gaclaxo_pkey; Type: CONSTRAINT; Schema: gacl; Owner: g_gacl; Tablespace: 
--

ALTER TABLE ONLY gaclaxo
    ADD CONSTRAINT gaclaxo_pkey PRIMARY KEY (id);


--
-- Name: gaclaxo_sections_pkey; Type: CONSTRAINT; Schema: gacl; Owner: g_gacl; Tablespace: 
--

ALTER TABLE ONLY gaclaxo_sections
    ADD CONSTRAINT gaclaxo_sections_pkey PRIMARY KEY (id);


--
-- Name: gaclgroups_aro_map_pkey; Type: CONSTRAINT; Schema: gacl; Owner: g_gacl; Tablespace: 
--

ALTER TABLE ONLY gaclgroups_aro_map
    ADD CONSTRAINT gaclgroups_aro_map_pkey PRIMARY KEY (group_id, aro_id);


--
-- Name: gaclgroups_axo_map_pkey; Type: CONSTRAINT; Schema: gacl; Owner: g_gacl; Tablespace: 
--

ALTER TABLE ONLY gaclgroups_axo_map
    ADD CONSTRAINT gaclgroups_axo_map_pkey PRIMARY KEY (group_id, axo_id);


--
-- Name: gaclphpgacl_pkey; Type: CONSTRAINT; Schema: gacl; Owner: g_gacl; Tablespace: 
--

ALTER TABLE ONLY gaclphpgacl
    ADD CONSTRAINT gaclphpgacl_pkey PRIMARY KEY (name);


--
-- Name: pk_logingestion; Type: CONSTRAINT; Schema: gacl; Owner: g_gacl; Tablespace: 
--

ALTER TABLE ONLY logingestion
    ADD CONSTRAINT pk_logingestion PRIMARY KEY (id);


--
-- Name: gaclaro_id; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE INDEX gaclaro_id ON gaclgroups_aro_map USING btree (aro_id);


--
-- Name: gaclaxo_id; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE INDEX gaclaxo_id ON gaclgroups_axo_map USING btree (axo_id);


--
-- Name: gaclenabled_acl; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE INDEX gaclenabled_acl ON gaclacl USING btree (enabled);


--
-- Name: gaclhidden_acl_sections; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE INDEX gaclhidden_acl_sections ON gaclacl_sections USING btree (hidden);


--
-- Name: gaclhidden_aco; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE INDEX gaclhidden_aco ON gaclaco USING btree (hidden);


--
-- Name: gaclhidden_aco_sections; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE INDEX gaclhidden_aco_sections ON gaclaco_sections USING btree (hidden);


--
-- Name: gaclhidden_aro; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE INDEX gaclhidden_aro ON gaclaro USING btree (hidden);


--
-- Name: gaclhidden_aro_sections; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE INDEX gaclhidden_aro_sections ON gaclaro_sections USING btree (hidden);


--
-- Name: gaclhidden_axo; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE INDEX gaclhidden_axo ON gaclaxo USING btree (hidden);


--
-- Name: gaclhidden_axo_sections; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE INDEX gaclhidden_axo_sections ON gaclaxo_sections USING btree (hidden);


--
-- Name: gacllft_rgt_aro_groups; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE INDEX gacllft_rgt_aro_groups ON gaclaro_groups USING btree (lft, rgt);


--
-- Name: gacllft_rgt_axo_groups; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE INDEX gacllft_rgt_axo_groups ON gaclaxo_groups USING btree (lft, rgt);


--
-- Name: gaclparent_id_aro_groups; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE INDEX gaclparent_id_aro_groups ON gaclaro_groups USING btree (parent_id);


--
-- Name: gaclparent_id_axo_groups; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE INDEX gaclparent_id_axo_groups ON gaclaxo_groups USING btree (parent_id);


--
-- Name: gaclsection_value_acl; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE INDEX gaclsection_value_acl ON gaclacl USING btree (section_value);


--
-- Name: gaclsection_value_value_aco; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE UNIQUE INDEX gaclsection_value_value_aco ON gaclaco USING btree (section_value, value);


--
-- Name: gaclsection_value_value_aro; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE UNIQUE INDEX gaclsection_value_value_aro ON gaclaro USING btree (section_value, value);


--
-- Name: gaclsection_value_value_axo; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE UNIQUE INDEX gaclsection_value_value_axo ON gaclaxo USING btree (section_value, value);


--
-- Name: gaclupdated_date_acl; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE INDEX gaclupdated_date_acl ON gaclacl USING btree (updated_date);


--
-- Name: gaclvalue_acl_sections; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE UNIQUE INDEX gaclvalue_acl_sections ON gaclacl_sections USING btree (value);


--
-- Name: gaclvalue_aco_sections; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE UNIQUE INDEX gaclvalue_aco_sections ON gaclaco_sections USING btree (value);


--
-- Name: gaclvalue_aro_groups; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE UNIQUE INDEX gaclvalue_aro_groups ON gaclaro_groups USING btree (value);


--
-- Name: gaclvalue_aro_sections; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE UNIQUE INDEX gaclvalue_aro_sections ON gaclaro_sections USING btree (value);


--
-- Name: gaclvalue_axo_groups; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE UNIQUE INDEX gaclvalue_axo_groups ON gaclaxo_groups USING btree (value);


--
-- Name: gaclvalue_axo_sections; Type: INDEX; Schema: gacl; Owner: g_gacl; Tablespace: 
--

CREATE UNIQUE INDEX gaclvalue_axo_sections ON gaclaxo_sections USING btree (value);


--
-- Name: gacl; Type: ACL; Schema: -; Owner: quinton
--

REVOKE ALL ON SCHEMA gacl FROM PUBLIC;
REVOKE ALL ON SCHEMA gacl FROM postgres;
GRANT ALL ON SCHEMA gacl TO postgres;
GRANT ALL ON SCHEMA gacl TO g_gacl;


--
-- Name: logingestion; Type: ACL; Schema: gacl; Owner: g_gacl
--

REVOKE ALL ON TABLE logingestion FROM PUBLIC;
REVOKE ALL ON TABLE logingestion FROM g_gacl;
GRANT ALL ON TABLE logingestion TO g_gacl;


--
-- Name: seq_logingestion_id; Type: ACL; Schema: gacl; Owner: g_gacl
--

REVOKE ALL ON SEQUENCE seq_logingestion_id FROM PUBLIC;
REVOKE ALL ON SEQUENCE seq_logingestion_id FROM g_gacl;
GRANT ALL ON SEQUENCE seq_logingestion_id TO g_gacl;


--
-- PostgreSQL database dump complete
--

