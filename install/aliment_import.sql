CREATE SEQUENCE sturio.public.import_alim_import_alim_id_seq;

CREATE TABLE sturio.public.import_alim (
                import_alim_id INTEGER NOT NULL DEFAULT nextval('sturio.public.import_alim_import_alim_id_seq'),
                date_debut DATE NOT NULL,
                date_fin DATE NOT NULL,
                bassin_id INTEGER NOT NULL,
                larve REAL,
                terreau REAL,
                nrd2000 REAL,
                coppens REAL,
                biomar REAL,
                chiro REAL,
                krill REAL,
                crevette REAL,
                CONSTRAINT import_alim_pk PRIMARY KEY (import_alim_id)
);
COMMENT ON TABLE sturio.public.import_alim IS 'Table temporaire pour importer les aliments, entre deux dates';


ALTER SEQUENCE sturio.public.import_alim_import_alim_id_seq OWNED BY sturio.public.import_alim.import_alim_id;
