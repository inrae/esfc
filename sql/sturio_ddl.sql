-- BEGIN TABLE aliment
CREATE TABLE aliment
(
   aliment_id             serial       NOT NULL,
   aliment_type_id        integer       NOT NULL,
   aliment_libelle        varchar       NOT NULL,
   actif                  smallint      DEFAULT 1 NOT NULL,
   aliment_libelle_court  varchar(8)    NOT NULL
);

-- Column aliment_id is associated with sequence public.aliment_aliment_id_seq

ALTER TABLE aliment
   ADD CONSTRAINT aliment_pk
   PRIMARY KEY (aliment_id);

COMMENT ON COLUMN aliment.actif IS '0 : aliment non utilisé
1 : aliment en cours d''utilisation';
COMMENT ON COLUMN aliment.aliment_libelle_court IS 'Nom de l''aliment - 8 caractères';

GRANT SELECT ON aliment TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON aliment TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON aliment TO sturio_rw;
-- END TABLE aliment

-- BEGIN TABLE aliment_categorie
CREATE TABLE aliment_categorie
(
   aliment_id    integer    NOT NULL,
   categorie_id  integer    NOT NULL
);

ALTER TABLE aliment_categorie
   ADD CONSTRAINT aliment_categorie_pk
   PRIMARY KEY (aliment_id, categorie_id);

COMMENT ON TABLE aliment_categorie IS 'Caractérisation de l''aliment par rapport à la catégorie de poisson nourri (adulte, juvénile, repro)';
GRANT SELECT ON aliment_categorie TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON aliment_categorie TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON aliment_categorie TO sturio_rw;
-- END TABLE aliment_categorie

-- BEGIN TABLE aliment_quotidien
CREATE TABLE aliment_quotidien
(
   aliment_quotidien_id  serial    NOT NULL,
   aliment_id            integer    NOT NULL,
   quantite              float4,
   distrib_quotidien_id  integer    NOT NULL
);

-- Column aliment_quotidien_id is associated with sequence public.aliment_quotidien_aliment_quotidien_id_seq

ALTER TABLE aliment_quotidien
   ADD CONSTRAINT aliment_quotidien_pk
   PRIMARY KEY (aliment_quotidien_id);

CREATE INDEX aliment_quotidien_aliment_id_idx ON aliment_quotidien USING btree (aliment_id);
CREATE INDEX aliment_quotidien_distrib_quotidien_id_idx ON aliment_quotidien USING btree (distrib_quotidien_id);


COMMENT ON TABLE aliment_quotidien IS 'Table des répartitions quotidiennes d''aliments';
COMMENT ON COLUMN aliment_quotidien.quantite IS 'Quantité quotidienne distribuée, en grammes';

GRANT SELECT ON aliment_quotidien TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON aliment_quotidien TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON aliment_quotidien TO sturio_rw;
-- END TABLE aliment_quotidien

-- BEGIN TABLE aliment_type
CREATE TABLE aliment_type
(
   aliment_type_id       serial    NOT NULL,
   aliment_type_libelle  varchar    NOT NULL
);

-- Column aliment_type_id is associated with sequence public.aliment_type_aliment_type_id_seq

ALTER TABLE aliment_type
   ADD CONSTRAINT aliment_type_pk
   PRIMARY KEY (aliment_type_id);

COMMENT ON TABLE aliment_type IS 'Type d''aliment (naturel, artificiel, etc.)';
GRANT SELECT ON aliment_type TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON aliment_type TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON aliment_type TO sturio_rw;
-- END TABLE aliment_type

-- BEGIN TABLE analyse_eau
CREATE TABLE analyse_eau
(
   analyse_eau_id                   serial      NOT NULL,
   circuit_eau_id                   integer      NOT NULL,
   analyse_eau_date                 timestamp    NOT NULL,
   temperature                      float4,
   oxygene                          float4,
   salinite                         float4,
   ph                               float4,
   nh4                              float4,
   n_nh4                            float4,
   no2                              float4,
   no2_seuil                        varchar,
   n_no2                            float4,
   no3                              float4,
   no3_seuil                        varchar,
   n_no3                            float4,
   backwash_mecanique               smallint     DEFAULT 0,
   backwash_biologique_commentaire  varchar,
   debit_eau_riviere                float4,
   debit_eau_forage                 float4,
   observations                     varchar,
   nh4_seuil                        varchar,
   backwash_biologique              smallint     DEFAULT 0 NOT NULL,
   laboratoire_analyse_id           integer,
   debit_eau_mer                    float8
);

-- Column analyse_eau_id is associated with sequence public.analyse_eau_analyse_eau_id_seq

ALTER TABLE analyse_eau
   ADD CONSTRAINT analyse_eau_pk
   PRIMARY KEY (analyse_eau_id);

CREATE INDEX analyse_eau_circuit_eau_id_idx ON analyse_eau USING btree (circuit_eau_id);


COMMENT ON TABLE analyse_eau IS 'Liste des analyses d''eau réalisées dans les circuits d''eau';
COMMENT ON COLUMN analyse_eau.analyse_eau_date IS 'Date - heure de l''analyse';
COMMENT ON COLUMN analyse_eau.temperature IS 'Temperature en degrés centigrades';
COMMENT ON COLUMN analyse_eau.oxygene IS 'O2 dissous';
COMMENT ON COLUMN analyse_eau.salinite IS 'Salinité en o/oo';
COMMENT ON COLUMN analyse_eau.ph IS 'pH - potentiel hydrogène';
COMMENT ON COLUMN analyse_eau.nh4 IS 'Oxyde d''ammoniac - NH4+ (n-nh4 x 1.288)';
COMMENT ON COLUMN analyse_eau.n_nh4 IS 'Azote ammoniacal (nh4 x 0.776)';
COMMENT ON COLUMN analyse_eau.no2 IS 'NO2 - oxyde nitrique';
COMMENT ON COLUMN analyse_eau.no2_seuil IS 'NO2 exprimé par rapport à un seuil de référence';
COMMENT ON COLUMN analyse_eau.n_no2 IS 'ion nitrite';
COMMENT ON COLUMN analyse_eau.no3 IS 'Oxyde nitrate - NO3 - valeur réellement mesurée (n-no3 x 4.427)';
COMMENT ON COLUMN analyse_eau.no3_seuil IS 'NO3 - valeur exprimée par rapport à un seuil de référence';
COMMENT ON COLUMN analyse_eau.n_no3 IS 'Ion nitrate N-NO3 (NO3 x 0.226)';
COMMENT ON COLUMN analyse_eau.backwash_mecanique IS '0 : non - 1 : oui';
COMMENT ON COLUMN analyse_eau.backwash_biologique_commentaire IS 'commentaires lors du backwash biologique';
COMMENT ON COLUMN analyse_eau.debit_eau_riviere IS 'Débit d''eau de rivière utilisé (l/mn)';
COMMENT ON COLUMN analyse_eau.debit_eau_forage IS 'Débit d''eau de forage utilisé (l/mn)';
COMMENT ON COLUMN analyse_eau.observations IS 'Observations lors du prélèvement d''eau';
COMMENT ON COLUMN analyse_eau.nh4_seuil IS 'Taux de NH4, exprimé sous forme de seuil ou de fourchette de valeurs';
COMMENT ON COLUMN analyse_eau.backwash_biologique IS '0 : non effectué
1 : effectué';
COMMENT ON COLUMN analyse_eau.debit_eau_mer IS 'En litre/mn';

GRANT SELECT ON analyse_eau TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON analyse_eau TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON analyse_eau TO sturio_rw;
-- END TABLE analyse_eau

-- BEGIN TABLE analyse_metal
CREATE TABLE analyse_metal
(
   analyse_metal_id  serial    NOT NULL,
   analyse_eau_id    integer    NOT NULL,
   metal_id          integer    NOT NULL,
   mesure            float4,
   mesure_seuil      varchar
);

ALTER TABLE analyse_metal
   ADD CONSTRAINT analyse_metal_pk
   PRIMARY KEY (analyse_metal_id);

COMMENT ON TABLE analyse_metal IS 'Table des analyses des métaux';
COMMENT ON COLUMN analyse_metal.mesure IS 'Mesure réelle effectuée';
COMMENT ON COLUMN analyse_metal.mesure_seuil IS 'Mesure exprimée sous forme de seuil';

GRANT SELECT ON analyse_metal TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON analyse_metal TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON analyse_metal TO sturio_rw;
-- END TABLE analyse_metal

-- BEGIN TABLE anomalie_db
CREATE TABLE anomalie_db
(
   anomalie_db_id               serial     NOT NULL,
   anomalie_db_date             date        NOT NULL,
   anomalie_db_type_id          integer     NOT NULL,
   poisson_id                   integer,
   evenement_id                 integer,
   anomalie_db_commentaire      varchar,
   anomalie_db_statut           smallint    DEFAULT 1 NOT NULL,
   anomalie_db_date_traitement  date
);

-- Column anomalie_db_id is associated with sequence public.anomalie_db_anomalie_db_id_seq

ALTER TABLE anomalie_db
   ADD CONSTRAINT anomalie_db_pk
   PRIMARY KEY (anomalie_db_id);

COMMENT ON TABLE anomalie_db IS 'Table des anomalies détectées dans la base de données';
COMMENT ON COLUMN anomalie_db.anomalie_db_date IS 'Date de détection de l''anomalie';
COMMENT ON COLUMN anomalie_db.anomalie_db_statut IS '1 : anomalie non traitée
0 : anomalie levée';
COMMENT ON COLUMN anomalie_db.anomalie_db_date_traitement IS 'Date de levée de l''anomalie';

GRANT SELECT ON anomalie_db TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON anomalie_db TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON anomalie_db TO sturio_rw;
-- END TABLE anomalie_db

-- BEGIN TABLE anomalie_db_type
CREATE TABLE anomalie_db_type
(
   anomalie_db_type_id       serial    NOT NULL,
   anomalie_db_type_libelle  varchar    NOT NULL
);

-- Column anomalie_db_type_id is associated with sequence public.anomalie_db_type_anomalie_db_type_id_seq

ALTER TABLE anomalie_db_type
   ADD CONSTRAINT anomalie_db_type_pk
   PRIMARY KEY (anomalie_db_type_id);

COMMENT ON TABLE anomalie_db_type IS 'Types des anomalies détectées dans la base de données';
GRANT SELECT ON anomalie_db_type TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON anomalie_db_type TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON anomalie_db_type TO sturio_rw;
-- END TABLE anomalie_db_type

-- BEGIN TABLE bassin
CREATE TABLE bassin
(
   bassin_id           serial     NOT NULL,
   bassin_zone_id      integer,
   bassin_type_id      integer,
   circuit_eau_id      integer,
   bassin_usage_id     integer,
   bassin_nom          varchar     NOT NULL,
   bassin_description  varchar,
   longueur            integer,
   largeur_diametre    integer,
   surface             integer,
   hauteur_eau         integer,
   volume              integer,
   actif               smallint    DEFAULT 1
);

-- Column bassin_id is associated with sequence public.bassin_bassin_id_seq

ALTER TABLE bassin
   ADD CONSTRAINT bassin_pk
   PRIMARY KEY (bassin_id);

COMMENT ON TABLE bassin IS 'Description des bassins';
COMMENT ON COLUMN bassin.bassin_nom IS 'Nom du bassin';
COMMENT ON COLUMN bassin.bassin_description IS 'Description du bassin';
COMMENT ON COLUMN bassin.longueur IS 'En cm';
COMMENT ON COLUMN bassin.largeur_diametre IS 'Largeur ou diametre, en cm';
COMMENT ON COLUMN bassin.surface IS 'Surface en cm2';
COMMENT ON COLUMN bassin.hauteur_eau IS 'Hauteur d''eau, en cm';
COMMENT ON COLUMN bassin.volume IS 'Volume, en litre - dm3';
COMMENT ON COLUMN bassin.actif IS 'Indique si le bassin est toujours utilisé ou non';

GRANT SELECT ON bassin TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON bassin TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON bassin TO sturio_rw;
-- END TABLE bassin

-- BEGIN TABLE bassin_campagne
CREATE TABLE bassin_campagne
(
   bassin_campagne_id  serial    NOT NULL,
   bassin_id           integer    NOT NULL,
   annee               integer    NOT NULL,
   bassin_utilisation  varchar
);

-- Column bassin_campagne_id is associated with sequence public.bassin_campagne_bassin_campagne_id_seq

ALTER TABLE bassin_campagne
   ADD CONSTRAINT bassin_campagne_pk
   PRIMARY KEY (bassin_campagne_id);

COMMENT ON COLUMN bassin_campagne.bassin_utilisation IS 'Utilisation du bassin dans le cadre de la reproduction';

GRANT SELECT ON bassin_campagne TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON bassin_campagne TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON bassin_campagne TO sturio_rw;
-- END TABLE bassin_campagne

-- BEGIN TABLE bassin_document
CREATE TABLE bassin_document
(
   bassin_id    integer    NOT NULL,
   document_id  integer    NOT NULL
);

ALTER TABLE bassin_document
   ADD CONSTRAINT bassin_document_pk
   PRIMARY KEY (bassin_id, document_id);

COMMENT ON TABLE bassin_document IS 'Table de liaison des bassins avec les documents';
GRANT SELECT ON bassin_document TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON bassin_document TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON bassin_document TO sturio_rw;
-- END TABLE bassin_document

-- BEGIN TABLE bassin_evenement
CREATE TABLE bassin_evenement
(
   bassin_evenement_id           serial    NOT NULL,
   bassin_id                     integer    NOT NULL,
   bassin_evenement_type_id      integer    NOT NULL,
   bassin_evenement_date         date       NOT NULL,
   bassin_evenement_commentaire  varchar
);

-- Column bassin_evenement_id is associated with sequence public.bassin_evenement_bassin_evenement_id_seq

ALTER TABLE bassin_evenement
   ADD CONSTRAINT bassin_evenement_pk
   PRIMARY KEY (bassin_evenement_id);

COMMENT ON TABLE bassin_evenement IS 'Table des événements survenant dans les bassins';
COMMENT ON COLUMN bassin_evenement.bassin_evenement_date IS 'Date de survenue de l''événement dans le bassin';
COMMENT ON COLUMN bassin_evenement.bassin_evenement_commentaire IS 'Commentaire concernant l''événement';

GRANT SELECT ON bassin_evenement TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON bassin_evenement TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON bassin_evenement TO sturio_rw;
-- END TABLE bassin_evenement

-- BEGIN TABLE bassin_evenement_type
CREATE TABLE bassin_evenement_type
(
   bassin_evenement_type_id       serial    NOT NULL,
   bassin_evenement_type_libelle  varchar    NOT NULL
);

-- Column bassin_evenement_type_id is associated with sequence public.bassin_evenement_type_bassin_evenement_type_id_seq

ALTER TABLE bassin_evenement_type
   ADD CONSTRAINT bassin_evenement_type_pk
   PRIMARY KEY (bassin_evenement_type_id);

COMMENT ON TABLE bassin_evenement_type IS 'Table des types d''événements dans les bassins';
GRANT SELECT ON bassin_evenement_type TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON bassin_evenement_type TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON bassin_evenement_type TO sturio_rw;
-- END TABLE bassin_evenement_type

-- BEGIN TABLE bassin_lot
CREATE TABLE bassin_lot
(
   bassin_lot_id    serial      NOT NULL,
   bassin_id        integer      NOT NULL,
   lot_id           integer      NOT NULL,
   bl_date_arrivee  timestamp    NOT NULL,
   bl_date_depart   timestamp
);

-- Column bassin_lot_id is associated with sequence public.bassin_lot_bassin_lot_id_seq

ALTER TABLE bassin_lot
   ADD CONSTRAINT bassin_lot_pk
   PRIMARY KEY (bassin_lot_id);

COMMENT ON TABLE bassin_lot IS 'Suivi des lots dans les bassins';
COMMENT ON COLUMN bassin_lot.bl_date_arrivee IS 'Date d''arrivée dans le bassin';
COMMENT ON COLUMN bassin_lot.bl_date_depart IS 'Date de départ du bassin';

GRANT SELECT ON bassin_lot TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON bassin_lot TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON bassin_lot TO sturio_rw;
-- END TABLE bassin_lot

-- BEGIN TABLE bassin_type
CREATE TABLE bassin_type
(
   bassin_type_id       serial    NOT NULL,
   bassin_type_libelle  varchar    NOT NULL
);

-- Column bassin_type_id is associated with sequence public.bassin_type_bassin_type_id_seq

ALTER TABLE bassin_type
   ADD CONSTRAINT bassin_type_pk
   PRIMARY KEY (bassin_type_id);

COMMENT ON TABLE bassin_type IS 'Type de bassin';
GRANT SELECT ON bassin_type TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON bassin_type TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON bassin_type TO sturio_rw;
-- END TABLE bassin_type

-- BEGIN TABLE bassin_usage
CREATE TABLE bassin_usage
(
   bassin_usage_id       serial    NOT NULL,
   bassin_usage_libelle  varchar    NOT NULL,
   categorie_id          integer
);

-- Column bassin_usage_id is associated with sequence public.bassin_usage_bassin_usage_id_seq

ALTER TABLE bassin_usage
   ADD CONSTRAINT bassin_usage_pk
   PRIMARY KEY (bassin_usage_id);

COMMENT ON TABLE bassin_usage IS 'Élevage des adultes, des juvéniles, infirmerie, etc.';
GRANT SELECT ON bassin_usage TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON bassin_usage TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON bassin_usage TO sturio_rw;
-- END TABLE bassin_usage

-- BEGIN TABLE bassin_zone
CREATE TABLE bassin_zone
(
   bassin_zone_id       serial    NOT NULL,
   bassin_zone_libelle  varchar    NOT NULL
);

-- Column bassin_zone_id is associated with sequence public.bassin_zone_bassin_zone_id_seq

ALTER TABLE bassin_zone
   ADD CONSTRAINT bassin_zone_pk
   PRIMARY KEY (bassin_zone_id);

COMMENT ON TABLE bassin_zone IS 'Zones d''implantation des bassins';
GRANT SELECT ON bassin_zone TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON bassin_zone TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON bassin_zone TO sturio_rw;
-- END TABLE bassin_zone

-- BEGIN TABLE biopsie
CREATE TABLE biopsie
(
   biopsie_id                   serial      NOT NULL,
   poisson_campagne_id          integer      NOT NULL,
   biopsie_technique_calcul_id  integer,
   biopsie_date                 timestamp,
   diam_moyen                   float4,
   diametre_ecart_type          float4,
   tx_opi                       float4,
   tx_coloration_normal         float4,
   ringer_t50                   varchar,
   ringer_tx_max                float4,
   ringer_duree                 varchar,
   ringer_commentaire           varchar,
   tx_eclatement                float4,
   leibovitz_t50                varchar,
   leibovitz_tx_max             float4,
   leibovitz_duree              varchar,
   leibovitz_commentaire        varchar,
   biopsie_commentaire          varchar
);

-- Column biopsie_id is associated with sequence public.biopsie_biopsie_id_seq

ALTER TABLE biopsie
   ADD CONSTRAINT biopsie_pk
   PRIMARY KEY (biopsie_id);

COMMENT ON TABLE biopsie IS 'Biopsies pratiquées et relevés biométriques correspondants';
COMMENT ON COLUMN biopsie.biopsie_date IS 'Date/heure de la biopsie';
COMMENT ON COLUMN biopsie.diam_moyen IS 'Diamètre moyen des ovocytes, en mm';
COMMENT ON COLUMN biopsie.diametre_ecart_type IS 'Écart type du calcul du diamètre moyen des ovocytes';
COMMENT ON COLUMN biopsie.tx_opi IS 'Pourcentage d''ovocytes de forme ovoide';
COMMENT ON COLUMN biopsie.tx_coloration_normal IS 'Pourcentage d''ovocytes de coloration normale';
COMMENT ON COLUMN biopsie.ringer_t50 IS 'Test Ringer, T50 h ref 12-15 h';
COMMENT ON COLUMN biopsie.ringer_tx_max IS 'Test Ringer - Taux max';
COMMENT ON COLUMN biopsie.ringer_duree IS 'Test Ringer - durée maxi 17 heures';
COMMENT ON COLUMN biopsie.ringer_commentaire IS 'Commentaires concernant le test Ringer';
COMMENT ON COLUMN biopsie.tx_eclatement IS 'Taux d''éclatement des ovocytes. Test Ringer/Lelb';
COMMENT ON COLUMN biopsie.leibovitz_t50 IS 'T50 - test leibovitz';
COMMENT ON COLUMN biopsie.leibovitz_tx_max IS 'Test Leibovitz - taux max';
COMMENT ON COLUMN biopsie.leibovitz_duree IS 'Test Leibovitz - durée';

GRANT SELECT ON biopsie TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON biopsie TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON biopsie TO sturio_rw;
-- END TABLE biopsie

-- BEGIN TABLE biopsie_document
CREATE TABLE biopsie_document
(
   document_id  integer    NOT NULL,
   biopsie_id   integer    NOT NULL
);

ALTER TABLE biopsie_document
   ADD CONSTRAINT biopsie_document_pk
   PRIMARY KEY (document_id, biopsie_id);

COMMENT ON TABLE biopsie_document IS 'Table des documents associés avec la biopsie';
GRANT SELECT ON biopsie_document TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON biopsie_document TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON biopsie_document TO sturio_rw;
-- END TABLE biopsie_document

-- BEGIN TABLE biopsie_technique_calcul
CREATE TABLE biopsie_technique_calcul
(
   biopsie_technique_calcul_id       serial    NOT NULL,
   biopsie_technique_calcul_libelle  varchar    NOT NULL
);

-- Column biopsie_technique_calcul_id is associated with sequence public.biopsie_technique_calcul_biopsie_technique_calcul_id_seq

ALTER TABLE biopsie_technique_calcul
   ADD CONSTRAINT biopsie_technique_calcul_pk
   PRIMARY KEY (biopsie_technique_calcul_id);

COMMENT ON TABLE biopsie_technique_calcul IS 'Table des techniques utilisées pour le calcul du diamètre moyen des ovocytes
1 : ImageJ
2 : logiciel Boris';
GRANT SELECT ON biopsie_technique_calcul TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON biopsie_technique_calcul TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON biopsie_technique_calcul TO sturio_rw;
-- END TABLE biopsie_technique_calcul

-- BEGIN TABLE categorie
CREATE TABLE categorie
(
   categorie_id       serial    NOT NULL,
   categorie_libelle  varchar    NOT NULL
);

-- Column categorie_id is associated with sequence public.categorie_categorie_id_seq

ALTER TABLE categorie
   ADD CONSTRAINT categorie_pk
   PRIMARY KEY (categorie_id);

COMMENT ON TABLE categorie IS 'Catégorie ou destination de l''aliment (juvénile, adulte, reproduction...)';
COMMENT ON COLUMN categorie.categorie_libelle IS 'Adulte, juvénile, reproduction...';

GRANT SELECT ON categorie TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON categorie TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON categorie TO sturio_rw;
-- END TABLE categorie

-- BEGIN TABLE circuit_eau
CREATE TABLE circuit_eau
(
   circuit_eau_id       serial     NOT NULL,
   circuit_eau_libelle  varchar     NOT NULL,
   circuit_eau_actif    smallint
);

-- Column circuit_eau_id is associated with sequence public.circuit_eau_circuit_eau_id_seq

ALTER TABLE circuit_eau
   ADD CONSTRAINT circuit_eau_pk
   PRIMARY KEY (circuit_eau_id);

COMMENT ON TABLE circuit_eau IS 'Circuit d''eau utilisé par le ou les bassins';
COMMENT ON COLUMN circuit_eau.circuit_eau_actif IS '0 : circuit d''eau non utilisé
1 : circuit d''eau en service';

GRANT SELECT ON circuit_eau TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON circuit_eau TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON circuit_eau TO sturio_rw;
-- END TABLE circuit_eau

-- BEGIN TABLE cohorte
CREATE TABLE cohorte
(
   cohorte_id             serial    NOT NULL,
   poisson_id             integer    NOT NULL,
   evenement_id           integer    NOT NULL,
   cohorte_determination  varchar,
   cohorte_commentaire    varchar,
   cohorte_date           date,
   cohorte_type_id        integer
);

-- Column cohorte_id is associated with sequence public.cohorte_cohorte_id_seq

ALTER TABLE cohorte
   ADD CONSTRAINT cohorte_pk
   PRIMARY KEY (cohorte_id);

CREATE INDEX cohorte_evenement_id_idx ON cohorte USING btree (evenement_id);
CREATE INDEX cohorte_poisson_id_idx ON cohorte USING btree (poisson_id);


COMMENT ON TABLE cohorte IS 'Table des déterminations de cohortes';
COMMENT ON COLUMN cohorte.cohorte_determination IS 'Valeur déterminée';
COMMENT ON COLUMN cohorte.cohorte_date IS 'Date de détermination de la cohorte';

GRANT SELECT ON cohorte TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON cohorte TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON cohorte TO sturio_rw;
-- END TABLE cohorte

-- BEGIN TABLE cohorte_type
CREATE TABLE cohorte_type
(
   cohorte_type_id       serial    NOT NULL,
   cohorte_type_libelle  varchar    NOT NULL
);

-- Column cohorte_type_id is associated with sequence public.cohorte_type_cohorte_type_id_seq

ALTER TABLE cohorte_type
   ADD CONSTRAINT cohorte_type_pk
   PRIMARY KEY (cohorte_type_id);

COMMENT ON TABLE cohorte_type IS 'Type de détermination des cohortes';
GRANT SELECT ON cohorte_type TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON cohorte_type TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON cohorte_type TO sturio_rw;
-- END TABLE cohorte_type

-- BEGIN TABLE croisement
CREATE TABLE croisement
(
   croisement_id          serial      NOT NULL,
   sequence_id            integer      NOT NULL,
   croisement_qualite_id  integer,
   croisement_nom         varchar      NOT NULL,
   croisement_date        timestamp,
   ovocyte_masse          float4,
   ovocyte_densite        float4,
   tx_fecondation         float4,
   tx_survie_estime       float4,
   croisement_parents     varchar
);

-- Column croisement_id is associated with sequence public.croisement_croisement_id_seq

ALTER TABLE croisement
   ADD CONSTRAINT croisement_pk
   PRIMARY KEY (croisement_id);

COMMENT ON TABLE croisement IS 'Table des croisements réalisés';
COMMENT ON COLUMN croisement.croisement_nom IS 'Nom du croisement';
COMMENT ON COLUMN croisement.croisement_date IS 'Date/heure de la fécondation';
COMMENT ON COLUMN croisement.ovocyte_masse IS 'Masse des ovocytes utilisés dans le croisement, en grammes';
COMMENT ON COLUMN croisement.ovocyte_densite IS 'Nbre d''ovocytes par gramme';
COMMENT ON COLUMN croisement.tx_fecondation IS 'Taux de fécondation';
COMMENT ON COLUMN croisement.tx_survie_estime IS 'Taux de survie estimé';
COMMENT ON COLUMN croisement.croisement_parents IS 'Parents du croisement, sous forme textuelle';

GRANT SELECT ON croisement TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON croisement TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON croisement TO sturio_rw;
-- END TABLE croisement

-- BEGIN TABLE croisement_qualite
CREATE TABLE croisement_qualite
(
   croisement_qualite_id       integer    NOT NULL,
   croisement_qualite_libelle  varchar    NOT NULL
);

ALTER TABLE croisement_qualite
   ADD CONSTRAINT croisement_qualite_pk
   PRIMARY KEY (croisement_qualite_id);

COMMENT ON TABLE croisement_qualite IS 'Qualité des croisements (1 : très bon, 2 : bon, 3 : moyen, 4 : mauvais)';
GRANT SELECT ON croisement_qualite TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON croisement_qualite TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON croisement_qualite TO sturio_rw;
-- END TABLE croisement_qualite

-- BEGIN TABLE distrib_quotidien
CREATE TABLE distrib_quotidien
(
   distrib_quotidien_id    serial    NOT NULL,
   bassin_id               integer    NOT NULL,
   distrib_quotidien_date  date       NOT NULL,
   total_distribue         float4,
   reste                   float4
);

-- Column distrib_quotidien_id is associated with sequence public.distrib_quotidien_distrib_quotidien_id_seq

ALTER TABLE distrib_quotidien
   ADD CONSTRAINT distrib_quotidien_pk
   PRIMARY KEY (distrib_quotidien_id);

CREATE INDEX distrib_quotidien_bassin_id_idx ON distrib_quotidien USING btree (bassin_id);


COMMENT ON TABLE distrib_quotidien IS 'Table générale récapitulant les distributions quotidiennes';
COMMENT ON COLUMN distrib_quotidien.total_distribue IS 'Quantité totale distribuée, en grammes';
COMMENT ON COLUMN distrib_quotidien.reste IS 'Reste estimé, en grammes';

GRANT SELECT ON distrib_quotidien TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON distrib_quotidien TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON distrib_quotidien TO sturio_rw;
-- END TABLE distrib_quotidien

-- BEGIN TABLE distribution
CREATE TABLE distribution
(
   distribution_id         serial    NOT NULL,
   repartition_id          integer    NOT NULL,
   bassin_id               integer    NOT NULL,
   evol_taux_nourrissage   float4,
   taux_nourrissage        float4,
   total_distribue         float4,
   ration_commentaire      varchar,
   distribution_consigne   varchar,
   repart_template_id      integer    NOT NULL,
   distribution_masse      float4,
   reste_zone_calcul       varchar,
   reste_total             float4,
   taux_reste              float4,
   distribution_id_prec    integer,
   distribution_jour       varchar,
   distribution_jour_soir  varchar
);

-- Column distribution_id is associated with sequence public.distribution_distribution_id_seq

ALTER TABLE distribution
   ADD CONSTRAINT distribution_pk
   PRIMARY KEY (distribution_id);

CREATE INDEX distribution_repartition_id_idx ON distribution USING btree (repartition_id);
CREATE INDEX distribution_repart_template_id_idx ON distribution USING btree (repart_template_id);
CREATE INDEX distribution_bassin_id_idx ON distribution USING btree (bassin_id);


COMMENT ON TABLE distribution IS 'Table de distribution des aliments pour une période donnée';
COMMENT ON COLUMN distribution.evol_taux_nourrissage IS 'Evolution du taux de nourrissage par rapport à la semaine précédente, (pourcentage de la biomasse * 100)';
COMMENT ON COLUMN distribution.taux_nourrissage IS 'Taux quotidien de nourrissage (pourcentage de la biomasse  * 100)';
COMMENT ON COLUMN distribution.total_distribue IS 'Ration totale distribuee, en grammes';
COMMENT ON COLUMN distribution.ration_commentaire IS 'Commentaires sur la manière dont la ration a été consommée';
COMMENT ON COLUMN distribution.distribution_consigne IS 'Consignes de distribution';
COMMENT ON COLUMN distribution.distribution_masse IS 'Masse (poids) des poissons dans le bassin';
COMMENT ON COLUMN distribution.reste_zone_calcul IS 'Zone permettant de saisir les différents restes quotidiens, pour totalisation.
Accepte uniquement des chiffres et le signe +';
COMMENT ON COLUMN distribution.reste_total IS 'Quantité de nourriture restante totale pour la période';
COMMENT ON COLUMN distribution.taux_reste IS 'Taux de reste : reste / quantité distribuée * 100';
COMMENT ON COLUMN distribution.distribution_id_prec IS 'Identifiant de la distribution precedente';
COMMENT ON COLUMN distribution.distribution_jour IS 'Jour de distribution, selon la forme :
1,1,1,1,1,1,1
Le premier chiffre correspond au lundi';
COMMENT ON COLUMN distribution.distribution_jour_soir IS 'Distribution exclusivement le soir d''une demi-ration';

GRANT SELECT ON distribution TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON distribution TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON distribution TO sturio_rw;
-- END TABLE distribution

-- BEGIN TABLE document
CREATE TABLE document
(
   document_id           serial    NOT NULL,
   mime_type_id          integer    NOT NULL,
   document_date_import  date       NOT NULL,
   document_nom          varchar    NOT NULL,
   document_description  varchar,
   data                  bytea,
   size                  integer,
   thumbnail             bytea
);

-- Column document_id is associated with sequence public.document_document_id_seq

ALTER TABLE document
   ADD CONSTRAINT document_pk
   PRIMARY KEY (document_id);

COMMENT ON TABLE document IS 'Documents numériques rattachés à un poisson ou à un événement';
COMMENT ON COLUMN document.document_nom IS 'Nom d''origine du document';
COMMENT ON COLUMN document.document_description IS 'Description libre du document';

GRANT SELECT ON document TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON document TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON document TO sturio_rw;
-- END TABLE document

-- BEGIN TABLE dosage_sanguin
CREATE TABLE dosage_sanguin
(
   dosage_sanguin_id           serial      NOT NULL,
   poisson_campagne_id         integer      NOT NULL,
   dosage_sanguin_date         timestamp,
   tx_e2                       float4,
   tx_e2_texte                 varchar,
   tx_calcium                  float4,
   tx_hematocrite              float4,
   dosage_sanguin_commentaire  varchar
);

-- Column dosage_sanguin_id is associated with sequence public.dosage_sanguin_dosage_sanguin_id_seq

ALTER TABLE dosage_sanguin
   ADD CONSTRAINT dosage_sanguin_pk
   PRIMARY KEY (dosage_sanguin_id);

COMMENT ON TABLE dosage_sanguin IS 'Table des dosages sanguins';
COMMENT ON COLUMN dosage_sanguin.tx_e2 IS 'Tx E2, en pg/ml';
COMMENT ON COLUMN dosage_sanguin.tx_e2_texte IS 'Taux E2 en pg/ml, sous forme textuelle';
COMMENT ON COLUMN dosage_sanguin.tx_calcium IS 'Taux de calcium, en mg/l';
COMMENT ON COLUMN dosage_sanguin.tx_hematocrite IS 'Taux d''hématocrite';

GRANT SELECT ON dosage_sanguin TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON dosage_sanguin TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON dosage_sanguin TO sturio_rw;
-- END TABLE dosage_sanguin

-- BEGIN TABLE echographie
CREATE TABLE echographie
(
   echographie_id           serial      NOT NULL,
   evenement_id             integer      NOT NULL,
   poisson_id               integer      NOT NULL,
   echographie_date         timestamp,
   echographie_commentaire  varchar      NOT NULL,
   cliche_nb                integer,
   cliche_ref               varchar
);

-- Column echographie_id is associated with sequence public.echographie_echographie_id_seq

ALTER TABLE echographie
   ADD CONSTRAINT echographie_pk
   PRIMARY KEY (echographie_id);

COMMENT ON TABLE echographie IS 'Echographies réalisées';
COMMENT ON COLUMN echographie.echographie_date IS 'Date de l''échographie';
COMMENT ON COLUMN echographie.echographie_commentaire IS 'Commentaires de l''échographie';
COMMENT ON COLUMN echographie.cliche_nb IS 'Nombre de clichés pris';
COMMENT ON COLUMN echographie.cliche_ref IS 'Référence des clichés pris';

GRANT SELECT ON echographie TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON echographie TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON echographie TO sturio_rw;
-- END TABLE echographie

-- BEGIN TABLE evenement
CREATE TABLE evenement
(
   evenement_id           serial      NOT NULL,
   evenement_type_id      integer      NOT NULL,
   evenement_date         timestamp,
   poisson_id             integer      NOT NULL,
   evenement_commentaire  varchar
);

-- Column evenement_id is associated with sequence public.evenement_evenement_id_seq

ALTER TABLE evenement
   ADD CONSTRAINT evenement_pk
   PRIMARY KEY (evenement_id);

CREATE INDEX evenement_evenement_type_id_idx ON evenement USING btree (evenement_type_id);
CREATE INDEX evenement_poisson_id_idx ON evenement USING btree (poisson_id);


COMMENT ON TABLE evenement IS 'Table des événements ou des opérations particulières réalisées';
GRANT SELECT ON evenement TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON evenement TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON evenement TO sturio_rw;
-- END TABLE evenement

-- BEGIN TABLE evenement_document
CREATE TABLE evenement_document
(
   evenement_id  integer    NOT NULL,
   document_id   integer    NOT NULL
);

ALTER TABLE evenement_document
   ADD CONSTRAINT evenement_document_pk
   PRIMARY KEY (evenement_id, document_id);

COMMENT ON TABLE evenement_document IS 'Table de liaison des événements avec des documents';
GRANT SELECT ON evenement_document TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON evenement_document TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON evenement_document TO sturio_rw;
-- END TABLE evenement_document

-- BEGIN TABLE evenement_type
CREATE TABLE evenement_type
(
   evenement_type_id       serial     NOT NULL,
   evenement_type_libelle  varchar     NOT NULL,
   evenement_type_actif    smallint    DEFAULT 1 NOT NULL
);

-- Column evenement_type_id is associated with sequence public.evenement_type_evenement_type_id_seq

ALTER TABLE evenement_type
   ADD CONSTRAINT evenement_type_pk
   PRIMARY KEY (evenement_type_id);

COMMENT ON TABLE evenement_type IS 'Table des types d''événements';
COMMENT ON COLUMN evenement_type.evenement_type_actif IS '0 : non, 1 : oui';

GRANT SELECT ON evenement_type TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON evenement_type TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON evenement_type TO sturio_rw;
-- END TABLE evenement_type

-- BEGIN TABLE gender_methode
CREATE TABLE gender_methode
(
   gender_methode_id       serial    NOT NULL,
   gender_methode_libelle  varchar    NOT NULL
);

-- Column gender_methode_id is associated with sequence public.gender_methode_gender_methode_id_seq

ALTER TABLE gender_methode
   ADD CONSTRAINT gender_methode_pk
   PRIMARY KEY (gender_methode_id);

COMMENT ON TABLE gender_methode IS 'Méthodes de détermination du sexe';
GRANT SELECT ON gender_methode TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON gender_methode TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON gender_methode TO sturio_rw;
-- END TABLE gender_methode

-- BEGIN TABLE gender_selection
CREATE TABLE gender_selection
(
   gender_selection_id           serial      NOT NULL,
   poisson_id                    integer      NOT NULL,
   gender_methode_id             integer,
   sexe_id                       integer,
   gender_selection_date         timestamp,
   evenement_id                  integer,
   gender_selection_commentaire  varchar
);

-- Column gender_selection_id is associated with sequence public.gender_selection_gender_selection_id_seq

ALTER TABLE gender_selection
   ADD CONSTRAINT gender_selection_pk
   PRIMARY KEY (gender_selection_id);

CREATE INDEX gender_selection_evenement_id_idx ON gender_selection USING btree (evenement_id);
CREATE INDEX gender_selection_poisson_id_idx ON gender_selection USING btree (poisson_id);


COMMENT ON TABLE gender_selection IS 'Opérations de détermination du sexe';
COMMENT ON COLUMN gender_selection.gender_selection_date IS 'Date de détermination';

GRANT SELECT ON gender_selection TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON gender_selection TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON gender_selection TO sturio_rw;
-- END TABLE gender_selection

-- BEGIN TABLE hormone
CREATE TABLE hormone
(
   hormone_id     serial    NOT NULL,
   hormone_nom    varchar    NOT NULL,
   hormone_unite  varchar
);

-- Column hormone_id is associated with sequence public.hormone_hormone_id_seq

ALTER TABLE hormone
   ADD CONSTRAINT hormone_pk
   PRIMARY KEY (hormone_id);

COMMENT ON TABLE hormone IS 'Table des hormones injectées lors des reproductions';
COMMENT ON COLUMN hormone.hormone_nom IS 'Nom de l''hormone';
COMMENT ON COLUMN hormone.hormone_unite IS 'Unité utilisée pour le dosage de l''hormone';

GRANT SELECT ON hormone TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON hormone TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON hormone TO sturio_rw;
-- END TABLE hormone

-- BEGIN TABLE import_alim
CREATE TABLE import_alim
(
   import_alim_id  serial    NOT NULL,
   date_debut      date       NOT NULL,
   date_fin        date       NOT NULL,
   bassin_id       integer    NOT NULL,
   larve           float4,
   terreau         float4,
   nrd2000         float4,
   coppens         float4,
   biomar          float4,
   chiro           float4,
   krill           float4,
   crevette        float4
);

-- Column import_alim_id is associated with sequence public.import_alim_import_alim_id_seq

ALTER TABLE import_alim
   ADD CONSTRAINT import_alim_pk
   PRIMARY KEY (import_alim_id);

COMMENT ON TABLE import_alim IS 'Table temporaire pour importer les aliments, entre deux dates';
GRANT SELECT ON import_alim TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON import_alim TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON import_alim TO sturio_rw;
-- END TABLE import_alim

-- BEGIN TABLE injection
CREATE TABLE injection
(
   injection_id           serial      NOT NULL,
   poisson_campagne_id    integer      NOT NULL,
   sequence_id            integer      NOT NULL,
   hormone_id             integer,
   injection_date         timestamp    NOT NULL,
   injection_dose         float4,
   injection_commentaire  varchar
);

-- Column injection_id is associated with sequence public.injection_injection_id_seq

ALTER TABLE injection
   ADD CONSTRAINT injection_pk
   PRIMARY KEY (injection_id);

COMMENT ON TABLE injection IS 'Table des injections d''hormones';
COMMENT ON COLUMN injection.injection_date IS 'Date/heure de l''injection réalisée';
COMMENT ON COLUMN injection.injection_dose IS 'Dose injectée';

GRANT SELECT ON injection TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON injection TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON injection TO sturio_rw;
-- END TABLE injection

-- BEGIN TABLE laboratoire_analyse
CREATE TABLE laboratoire_analyse
(
   laboratoire_analyse_id       serial     NOT NULL,
   laboratoire_analyse_libelle  varchar     NOT NULL,
   laboratoire_analyse_actif    smallint    DEFAULT 1 NOT NULL
);

-- Column laboratoire_analyse_id is associated with sequence public.laboratoire_analyse_laboratoire_analyse_id_seq

ALTER TABLE laboratoire_analyse
   ADD CONSTRAINT laboratoire_analyse_pk
   PRIMARY KEY (laboratoire_analyse_id);

COMMENT ON TABLE laboratoire_analyse IS 'Table des laboratoires d''analyse de l''eau';
COMMENT ON COLUMN laboratoire_analyse.laboratoire_analyse_libelle IS 'Nom du laboratoire';
COMMENT ON COLUMN laboratoire_analyse.laboratoire_analyse_actif IS '0 : non sollicité actuellement
1 : laboratoire sollicité actuellement';

GRANT SELECT ON laboratoire_analyse TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON laboratoire_analyse TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON laboratoire_analyse TO sturio_rw;
-- END TABLE laboratoire_analyse

-- BEGIN TABLE lot
CREATE TABLE lot
(
   lot_id             serial      NOT NULL,
   croisement_id      integer      NOT NULL,
   lot_nom            varchar      NOT NULL,
   eclosion_date      timestamp,
   nb_larve_initial   float4,
   nb_larve_compte    float4,
   vie_date_marquage  timestamp,
   vie_modele_id      integer
);

-- Column lot_id is associated with sequence public.lot_lot_id_seq

ALTER TABLE lot
   ADD CONSTRAINT lot_pk
   PRIMARY KEY (lot_id);

ALTER TABLE lot
   ADD CONSTRAINT lot_vie_modele_id UNIQUE (vie_modele_id);



COMMENT ON TABLE lot IS 'Lots issus des croisements (au moins un lot par croisement réussi)';
COMMENT ON COLUMN lot.lot_nom IS 'Nom du lot';
COMMENT ON COLUMN lot.eclosion_date IS 'Date d''éclosion';
COMMENT ON COLUMN lot.nb_larve_initial IS 'Nombre de larves comptées';
COMMENT ON COLUMN lot.nb_larve_compte IS 'Nombre de larves final';
COMMENT ON COLUMN lot.vie_date_marquage IS 'Date de marquage du lot avec une marque VIE';

GRANT SELECT ON lot TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON lot TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON lot TO sturio_rw;
-- END TABLE lot

-- BEGIN TABLE lot_mesure
CREATE TABLE lot_mesure
(
   lot_mesure_id           serial      NOT NULL,
   lot_id                  integer      NOT NULL,
   lot_mesure_date         timestamp    NOT NULL,
   nb_jour                 integer,
   lot_mortalite           integer,
   lot_mesure_masse        float4,
   lot_mesure_masse_indiv  float4
);

-- Column lot_mesure_id is associated with sequence public.lot_mesure_lot_mesure_id_seq

ALTER TABLE lot_mesure
   ADD CONSTRAINT lot_mesure_pk
   PRIMARY KEY (lot_mesure_id);

COMMENT ON TABLE lot_mesure IS 'Mesures effectuées sur un lot';
COMMENT ON COLUMN lot_mesure.nb_jour IS 'Nbre de jours depuis l''éclosion';
COMMENT ON COLUMN lot_mesure.lot_mortalite IS 'Mortalité recensée, en nombre d''individus';
COMMENT ON COLUMN lot_mesure.lot_mesure_masse IS 'Masse totale des poissons du lot';
COMMENT ON COLUMN lot_mesure.lot_mesure_masse_indiv IS 'Masse moyenne individuelle du lot';

GRANT SELECT ON lot_mesure TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON lot_mesure TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON lot_mesure TO sturio_rw;
-- END TABLE lot_mesure

-- BEGIN TABLE lot_repart_template
CREATE TABLE lot_repart_template
(
   lot_repart_template_id  serial    NOT NULL,
   age                     integer    NOT NULL,
   artemia                 integer,
   chironome               float4
);

-- Column lot_repart_template_id is associated with sequence public.lot_repart_template_lot_repart_template_id_seq

ALTER TABLE lot_repart_template
   ADD CONSTRAINT lot_repart_template_pk
   PRIMARY KEY (lot_repart_template_id);

COMMENT ON TABLE lot_repart_template IS 'Modèle de répartition des aliments pour les lots';
COMMENT ON COLUMN lot_repart_template.age IS 'Age, en  jours, du lot (depuis la naissance)';
COMMENT ON COLUMN lot_repart_template.artemia IS 'Nombre d''artémia par poisson';
COMMENT ON COLUMN lot_repart_template.chironome IS 'Masse de chironomes à distribuer, en pourcentage  de la masse des poissons du lot';

GRANT SELECT ON lot_repart_template TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON lot_repart_template TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON lot_repart_template TO sturio_rw;
-- END TABLE lot_repart_template

-- BEGIN TABLE metal
CREATE TABLE metal
(
   metal_id     serial     NOT NULL,
   metal_nom    varchar     NOT NULL,
   metal_unite  varchar,
   metal_actif  smallint    DEFAULT 1 NOT NULL
);

-- Column metal_id is associated with sequence public.metal_metal_id_seq

ALTER TABLE metal
   ADD CONSTRAINT metal_pk
   PRIMARY KEY (metal_id);

COMMENT ON TABLE metal IS 'Table des métaux analysés';
COMMENT ON COLUMN metal.metal_nom IS 'Nom du métal analysé';
COMMENT ON COLUMN metal.metal_unite IS 'Unité de mesure';
COMMENT ON COLUMN metal.metal_actif IS '1 si le métal est analysé';

GRANT SELECT ON metal TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON metal TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON metal TO sturio_rw;
-- END TABLE metal

-- BEGIN TABLE mime_type
CREATE TABLE mime_type
(
   mime_type_id  serial    NOT NULL,
   content_type  varchar    NOT NULL,
   extension     varchar    NOT NULL
);

-- Column mime_type_id is associated with sequence public.mime_type_mime_type_id_seq

ALTER TABLE mime_type
   ADD CONSTRAINT mime_type_pk
   PRIMARY KEY (mime_type_id);

COMMENT ON TABLE mime_type IS 'Table des types mime, pour les documents associés';
COMMENT ON COLUMN mime_type.content_type IS 'type mime officiel';
COMMENT ON COLUMN mime_type.extension IS 'Extension du fichier correspondant';

GRANT SELECT ON mime_type TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON mime_type TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON mime_type TO sturio_rw;
-- END TABLE mime_type

-- BEGIN TABLE morphologie
CREATE TABLE morphologie
(
   morphologie_id           serial      NOT NULL,
   poisson_id               integer      NOT NULL,
   longueur_fourche         float4,
   longueur_totale          float4,
   morphologie_date         timestamp,
   evenement_id             integer,
   morphologie_commentaire  varchar,
   masse                    float4
);

-- Column morphologie_id is associated with sequence public.morphologie_morphologie_id_seq

ALTER TABLE morphologie
   ADD CONSTRAINT morphologie_pk
   PRIMARY KEY (morphologie_id);

CREATE INDEX morphologie_morphologie_date_idx ON morphologie USING btree (morphologie_date);
CREATE INDEX morphologie_evenement_id_idx ON morphologie USING btree (evenement_id);
CREATE INDEX morphologie_poisson_id_idx ON morphologie USING btree (poisson_id);


COMMENT ON TABLE morphologie IS 'Données morphologiques';
COMMENT ON COLUMN morphologie.longueur_fourche IS 'Longueur à la fourche, en cm';
COMMENT ON COLUMN morphologie.longueur_totale IS 'longueur totale, en cm';
COMMENT ON COLUMN morphologie.masse IS 'Masse de l''animal, en grammes';

GRANT SELECT ON morphologie TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON morphologie TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON morphologie TO sturio_rw;
-- END TABLE morphologie

-- BEGIN TABLE mortalite
CREATE TABLE mortalite
(
   mortalite_id           serial    NOT NULL,
   poisson_id             integer    NOT NULL,
   mortalite_type_id      integer    NOT NULL,
   mortalite_date         date,
   mortalite_commentaire  varchar,
   evenement_id           integer    NOT NULL
);

-- Column mortalite_id is associated with sequence public.mortalite_mortalite_id_seq

ALTER TABLE mortalite
   ADD CONSTRAINT mortalite_pk
   PRIMARY KEY (mortalite_id);

CREATE INDEX mortalite_evenement_id_idx ON mortalite USING btree (evenement_id);
CREATE INDEX mortalite_poisson_id_idx ON mortalite USING btree (poisson_id);


COMMENT ON TABLE mortalite IS 'Informations concernant la mortalité du poisson';
COMMENT ON COLUMN mortalite.mortalite_date IS 'Date de la mortalité';

GRANT SELECT ON mortalite TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON mortalite TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON mortalite TO sturio_rw;
-- END TABLE mortalite

-- BEGIN TABLE mortalite_type
CREATE TABLE mortalite_type
(
   mortalite_type_id       serial    NOT NULL,
   mortalite_type_libelle  varchar    NOT NULL
);

-- Column mortalite_type_id is associated with sequence public.mortalite_type_mortalite_type_id_seq

ALTER TABLE mortalite_type
   ADD CONSTRAINT mortalite_type_pk
   PRIMARY KEY (mortalite_type_id);

COMMENT ON TABLE mortalite_type IS 'Types de mortalité';
GRANT SELECT ON mortalite_type TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON mortalite_type TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON mortalite_type TO sturio_rw;
-- END TABLE mortalite_type

-- BEGIN TABLE parent_poisson
CREATE TABLE parent_poisson
(
   parent_poisson_id  serial    NOT NULL,
   poisson_id         integer    NOT NULL,
   parent_id          integer    NOT NULL
);

-- Column parent_poisson_id is associated with sequence public.parent_poisson_parent_poisson_id_seq

ALTER TABLE parent_poisson
   ADD CONSTRAINT parent_poisson_pkey
   PRIMARY KEY (parent_poisson_id);

CREATE INDEX parent_poisson_parent_id_idx ON parent_poisson USING btree (parent_id);
CREATE INDEX parent_poisson_poisson_id_idx ON parent_poisson USING btree (poisson_id);


COMMENT ON TABLE parent_poisson IS 'Table contenant les parents d''un poisson';
GRANT SELECT ON parent_poisson TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON parent_poisson TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON parent_poisson TO sturio_rw;
-- END TABLE parent_poisson

-- BEGIN TABLE pathologie
CREATE TABLE pathologie
(
   pathologie_id           serial      NOT NULL,
   poisson_id              integer      NOT NULL,
   pathologie_type_id      integer      NOT NULL,
   pathologie_date         timestamp,
   pathologie_commentaire  varchar,
   evenement_id            integer,
   pathologie_valeur       float4
);

-- Column pathologie_id is associated with sequence public.pathologie_pathologie_id_seq

ALTER TABLE pathologie
   ADD CONSTRAINT pathologie_pk
   PRIMARY KEY (pathologie_id);

CREATE INDEX pathologie_evenement_id_idx ON pathologie USING btree (evenement_id);
CREATE INDEX pathologie_poisson_id_idx ON pathologie USING btree (poisson_id);


COMMENT ON TABLE pathologie IS 'Liste des pathologies subies par les poissons';
COMMENT ON COLUMN pathologie.pathologie_valeur IS 'Valeur numérique associée à la pathologie';

GRANT SELECT ON pathologie TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON pathologie TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON pathologie TO sturio_rw;
-- END TABLE pathologie

-- BEGIN TABLE pathologie_type
CREATE TABLE pathologie_type
(
   pathologie_type_id             serial    NOT NULL,
   pathologie_type_libelle        varchar    NOT NULL,
   pathologie_type_libelle_court  varchar
);

-- Column pathologie_type_id is associated with sequence public.pathologie_type_pathologie_type_id_seq

ALTER TABLE pathologie_type
   ADD CONSTRAINT pathologie_type_pk
   PRIMARY KEY (pathologie_type_id);

COMMENT ON TABLE pathologie_type IS 'Types de pathologie rencontrés';
GRANT SELECT ON pathologie_type TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON pathologie_type TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON pathologie_type TO sturio_rw;
-- END TABLE pathologie_type

-- BEGIN TABLE pittag
CREATE TABLE pittag
(
   pittag_id           serial      NOT NULL,
   poisson_id          integer      NOT NULL,
   pittag_type_id      integer,
   pittag_valeur       varchar      NOT NULL,
   pittag_date_pose    timestamp,
   pittag_commentaire  varchar
);

-- Column pittag_id is associated with sequence public.pittag_pittag_id_seq

ALTER TABLE pittag
   ADD CONSTRAINT pittag_pk
   PRIMARY KEY (pittag_id);

CREATE INDEX pittag_poisson_id_idx ON pittag USING btree (poisson_id);


COMMENT ON TABLE pittag IS 'Table des marques utilisées pour suivre les poissons';
COMMENT ON COLUMN pittag.pittag_valeur IS 'Valeur du pittag (donnée utilisée pour identifier le pittag)';
COMMENT ON COLUMN pittag.pittag_commentaire IS 'Commentaire sur la pose du pittag';

GRANT SELECT ON pittag TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON pittag TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON pittag TO sturio_rw;
-- END TABLE pittag

-- BEGIN TABLE pittag_type
CREATE TABLE pittag_type
(
   pittag_type_id       serial    NOT NULL,
   pittag_type_libelle  varchar    NOT NULL
);

-- Column pittag_type_id is associated with sequence public.pittag_type_pittag_type_id_seq

ALTER TABLE pittag_type
   ADD CONSTRAINT pittag_type_pk
   PRIMARY KEY (pittag_type_id);

COMMENT ON TABLE pittag_type IS 'Table des types de pittag';
GRANT SELECT ON pittag_type TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON pittag_type TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON pittag_type TO sturio_rw;
-- END TABLE pittag_type

-- BEGIN TABLE poisson
CREATE TABLE poisson
(
   poisson_id         serial      NOT NULL,
   poisson_statut_id  integer      NOT NULL,
   sexe_id            integer,
   matricule          varchar,
   prenom             varchar,
   cohorte            varchar,
   capture_date       timestamp,
   date_naissance     date,
   categorie_id       integer      DEFAULT 2 NOT NULL,
   commentaire        varchar,
   vie_modele_id      integer
);

-- Column poisson_id is associated with sequence public.poisson_poisson_id_seq

ALTER TABLE poisson
   ADD CONSTRAINT poisson_pk
   PRIMARY KEY (poisson_id);

COMMENT ON COLUMN poisson.cohorte IS 'Année de naissance ou de capture';
COMMENT ON COLUMN poisson.capture_date IS 'Date de la capture';
COMMENT ON COLUMN poisson.date_naissance IS 'Date de naissance du poisson';
COMMENT ON COLUMN poisson.commentaire IS 'Commentaire général concernant le poisson';

GRANT SELECT ON poisson TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON poisson TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON poisson TO sturio_rw;
-- END TABLE poisson

-- BEGIN TABLE poisson_campagne
CREATE TABLE poisson_campagne
(
   poisson_campagne_id       serial    NOT NULL,
   poisson_id                integer    NOT NULL,
   repro_statut_id           integer    NOT NULL,
   annee                     integer    NOT NULL,
   masse                     float4,
   tx_croissance_journalier  float4,
   specific_growth_rate      float4
);

-- Column poisson_campagne_id is associated with sequence public.poisson_campagne_poisson_campagne_id_seq

ALTER TABLE poisson_campagne
   ADD CONSTRAINT poisson_campagne_pk
   PRIMARY KEY (poisson_campagne_id);

COMMENT ON TABLE poisson_campagne IS 'Table des données des poissons pour une campagne de reproduction';
COMMENT ON COLUMN poisson_campagne.annee IS 'Année de campagne';
COMMENT ON COLUMN poisson_campagne.masse IS 'Poids du poisson, en kg';
COMMENT ON COLUMN poisson_campagne.tx_croissance_journalier IS 'Taux de croissance journalier';
COMMENT ON COLUMN poisson_campagne.specific_growth_rate IS 'SGR : (log(w2) - log(w1) )* 100 / nbJour';

GRANT SELECT ON poisson_campagne TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON poisson_campagne TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON poisson_campagne TO sturio_rw;
-- END TABLE poisson_campagne

-- BEGIN TABLE poisson_croisement
CREATE TABLE poisson_croisement
(
   poisson_campagne_id  integer    NOT NULL,
   croisement_id        integer    NOT NULL
);

ALTER TABLE poisson_croisement
   ADD CONSTRAINT poisson_croisement_pk
   PRIMARY KEY (poisson_campagne_id, croisement_id);

GRANT SELECT ON poisson_croisement TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON poisson_croisement TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON poisson_croisement TO sturio_rw;
-- END TABLE poisson_croisement

-- BEGIN TABLE poisson_document
CREATE TABLE poisson_document
(
   poisson_id   integer    NOT NULL,
   document_id  integer    NOT NULL
);

ALTER TABLE poisson_document
   ADD CONSTRAINT poisson_document_pk
   PRIMARY KEY (poisson_id, document_id);

COMMENT ON TABLE poisson_document IS 'Table de liaison des poissons avec les documents';
GRANT SELECT ON poisson_document TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON poisson_document TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON poisson_document TO sturio_rw;
-- END TABLE poisson_document

-- BEGIN TABLE poisson_sequence
CREATE TABLE poisson_sequence
(
   poisson_sequence_id     serial      NOT NULL,
   poisson_campagne_id     integer      NOT NULL,
   sequence_id             integer      NOT NULL,
   ps_statut_id            integer,
   ovocyte_masse           float4,
   ovocyte_expulsion_date  timestamp
);

-- Column poisson_sequence_id is associated with sequence public.poisson_sequence_poisson_sequence_id_seq

ALTER TABLE poisson_sequence
   ADD CONSTRAINT poisson_sequence_pk
   PRIMARY KEY (poisson_sequence_id);

COMMENT ON TABLE poisson_sequence IS 'Table de rattachement des reproducteurs à une séquence de reproduction';
COMMENT ON COLUMN poisson_sequence.ovocyte_masse IS 'Masse des ovocytes, en grammes';
COMMENT ON COLUMN poisson_sequence.ovocyte_expulsion_date IS 'Date-heure d''expulsion des ovocytes';

GRANT SELECT ON poisson_sequence TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON poisson_sequence TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON poisson_sequence TO sturio_rw;
-- END TABLE poisson_sequence

-- BEGIN TABLE poisson_statut
CREATE TABLE poisson_statut
(
   poisson_statut_id       serial    NOT NULL,
   poisson_statut_libelle  varchar    NOT NULL
);

-- Column poisson_statut_id is associated with sequence public.poisson_statut_poisson_statut_id_seq

ALTER TABLE poisson_statut
   ADD CONSTRAINT poisson_statut_pk
   PRIMARY KEY (poisson_statut_id);

COMMENT ON TABLE poisson_statut IS 'Statuts généraux des poissons (juvénile, adulte, relaché, mort, etc.)';
GRANT SELECT ON poisson_statut TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON poisson_statut TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON poisson_statut TO sturio_rw;
-- END TABLE poisson_statut

-- BEGIN TABLE profil_thermique
CREATE TABLE profil_thermique
(
   profil_thermique_id       serial      NOT NULL,
   bassin_campagne_id        integer      NOT NULL,
   profil_thermique_type_id  integer      NOT NULL,
   pf_datetime               timestamp    NOT NULL,
   pf_temperature            float4       NOT NULL
);

-- Column profil_thermique_id is associated with sequence public.profil_thermique_profil_thermique_id_seq

ALTER TABLE profil_thermique
   ADD CONSTRAINT profil_thermique_pk
   PRIMARY KEY (profil_thermique_id);

COMMENT ON TABLE profil_thermique IS 'Table des profils thermiques d''un bassin';
COMMENT ON COLUMN profil_thermique.pf_datetime IS 'Date-heure de la température prévue ou constatée';
COMMENT ON COLUMN profil_thermique.pf_temperature IS 'Température prévue ou constatée';

GRANT SELECT ON profil_thermique TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON profil_thermique TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON profil_thermique TO sturio_rw;
-- END TABLE profil_thermique

-- BEGIN TABLE profil_thermique_type
CREATE TABLE profil_thermique_type
(
   profil_thermique_type_id       integer    NOT NULL,
   profil_thermique_type_libelle  varchar    NOT NULL
);

ALTER TABLE profil_thermique_type
   ADD CONSTRAINT profil_thermique_type_pk
   PRIMARY KEY (profil_thermique_type_id);

COMMENT ON TABLE profil_thermique_type IS 'Table des types de profils thermiques
1 : constaté
2 : prévu';
COMMENT ON COLUMN profil_thermique_type.profil_thermique_type_libelle IS '1 : constaté
2 : prévu';

GRANT SELECT ON profil_thermique_type TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON profil_thermique_type TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON profil_thermique_type TO sturio_rw;
-- END TABLE profil_thermique_type

-- BEGIN TABLE ps_evenement
CREATE TABLE ps_evenement
(
   ps_evenement_id      serial      NOT NULL,
   poisson_sequence_id  integer      NOT NULL,
   ps_datetime          timestamp,
   ps_libelle           varchar      NOT NULL,
   ps_commentaire       varchar
);

-- Column ps_evenement_id is associated with sequence public.ps_evenement_ps_evenement_id_seq

ALTER TABLE ps_evenement
   ADD CONSTRAINT ps_evenement_pk
   PRIMARY KEY (ps_evenement_id);

COMMENT ON TABLE ps_evenement IS 'Table des événements rattachés à un poisson pendant une séquence de reproduction';
COMMENT ON COLUMN ps_evenement.ps_libelle IS 'Nature de l''événement réalisé';
COMMENT ON COLUMN ps_evenement.ps_commentaire IS 'Commentaire';

GRANT SELECT ON ps_evenement TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON ps_evenement TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON ps_evenement TO sturio_rw;
-- END TABLE ps_evenement

-- BEGIN TABLE ps_statut
CREATE TABLE ps_statut
(
   ps_statut_id       integer    NOT NULL,
   ps_statut_libelle  varchar    NOT NULL
);

ALTER TABLE ps_statut
   ADD CONSTRAINT ps_statut_pk
   PRIMARY KEY (ps_statut_id);

COMMENT ON TABLE ps_statut IS 'Table des statuts possibles pour un poisson pendant une séquence';
GRANT SELECT ON ps_statut TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON ps_statut TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON ps_statut TO sturio_rw;
-- END TABLE ps_statut

-- BEGIN TABLE repart_aliment
CREATE TABLE repart_aliment
(
   repart_aliment_id   serial    NOT NULL,
   repart_template_id  integer    NOT NULL,
   aliment_id          integer    NOT NULL,
   repart_alim_taux    float4,
   consigne            varchar,
   matin               float4,
   midi                float4,
   nuit                float4,
   soir                float4
);

-- Column repart_aliment_id is associated with sequence public.repart_aliment_repart_aliment_id_seq

ALTER TABLE repart_aliment
   ADD CONSTRAINT repart_aliment_pk
   PRIMARY KEY (repart_aliment_id);

COMMENT ON TABLE repart_aliment IS 'Taux de repartition des aliments pour la repartition consideree';
COMMENT ON COLUMN repart_aliment.consigne IS 'Consignes lors de la distribution';
COMMENT ON COLUMN repart_aliment.matin IS 'Taux de répartition le matin';
COMMENT ON COLUMN repart_aliment.midi IS 'Taux de répartition le midi';
COMMENT ON COLUMN repart_aliment.nuit IS 'Taux de répartition la nuit';
COMMENT ON COLUMN repart_aliment.soir IS 'Taux de répartition le soir';

GRANT SELECT ON repart_aliment TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON repart_aliment TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON repart_aliment TO sturio_rw;
-- END TABLE repart_aliment

-- BEGIN TABLE repart_template
CREATE TABLE repart_template
(
   repart_template_id       serial     NOT NULL,
   categorie_id             integer     NOT NULL,
   repart_template_libelle  varchar,
   repart_template_date     date        NOT NULL,
   actif                    smallint    DEFAULT 1 NOT NULL
);

-- Column repart_template_id is associated with sequence public.repart_template_repart_template_id_seq

ALTER TABLE repart_template
   ADD CONSTRAINT repart_template_pk
   PRIMARY KEY (repart_template_id);

COMMENT ON TABLE repart_template IS 'Modèles de répartition des aliments';
COMMENT ON COLUMN repart_template.repart_template_libelle IS 'Nom de la répartition';
COMMENT ON COLUMN repart_template.repart_template_date IS 'Date de création';
COMMENT ON COLUMN repart_template.actif IS '0 : non actif, 1 : actif';

GRANT SELECT ON repart_template TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON repart_template TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON repart_template TO sturio_rw;
-- END TABLE repart_template

-- BEGIN TABLE repartition
CREATE TABLE repartition
(
   repartition_id      serial    NOT NULL,
   categorie_id        integer    NOT NULL,
   date_debut_periode  date       NOT NULL,
   date_fin_periode    date       NOT NULL,
   densite_artemia     float4
);

-- Column repartition_id is associated with sequence public.repartition_repartition_id_seq

ALTER TABLE repartition
   ADD CONSTRAINT repartition_pk
   PRIMARY KEY (repartition_id);

COMMENT ON TABLE repartition IS 'Tableau hebdomadaire (ou autre) de répartition des aliments';
COMMENT ON COLUMN repartition.date_debut_periode IS 'Date de début de la répartition';
COMMENT ON COLUMN repartition.date_fin_periode IS 'Date de fin d''action du tableau de répartition';
COMMENT ON COLUMN repartition.densite_artemia IS 'Densité d''artémia au litre';

GRANT SELECT ON repartition TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON repartition TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON repartition TO sturio_rw;
-- END TABLE repartition

-- BEGIN TABLE repro_statut
CREATE TABLE repro_statut
(
   repro_statut_id       integer    NOT NULL,
   repro_statut_libelle  varchar    NOT NULL
);

ALTER TABLE repro_statut
   ADD CONSTRAINT repro_statut_pk
   PRIMARY KEY (repro_statut_id);

COMMENT ON TABLE repro_statut IS 'Table des statuts de la reproduction
1 : adulte potentiel
2 : pré-sélectionné';
GRANT SELECT ON repro_statut TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON repro_statut TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON repro_statut TO sturio_rw;
-- END TABLE repro_statut

-- BEGIN TABLE salinite
CREATE TABLE salinite
(
   salinite_id               serial      NOT NULL,
   bassin_campagne_id        integer      NOT NULL,
   profil_thermique_type_id  integer      NOT NULL,
   salinite_datetime         timestamp    NOT NULL,
   salinite_tx               float4       NOT NULL
);

-- Column salinite_id is associated with sequence public.salinite_salinite_id_seq

ALTER TABLE salinite
   ADD CONSTRAINT salinite_pk
   PRIMARY KEY (salinite_id);

COMMENT ON TABLE salinite IS 'Table des salinités d''un bassin';
COMMENT ON COLUMN salinite.salinite_datetime IS 'Date/heure de mesure';
COMMENT ON COLUMN salinite.salinite_tx IS 'Taux de salinité';

GRANT SELECT ON salinite TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON salinite TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON salinite TO sturio_rw;
-- END TABLE salinite

-- BEGIN TABLE sequence
CREATE TABLE sequence
(
   sequence_id          serial      NOT NULL,
   annee                integer      NOT NULL,
   sequence_nom         varchar      NOT NULL,
   sequence_date_debut  timestamp    NOT NULL
);

-- Column sequence_id is associated with sequence public.sequence_sequence_id_seq

ALTER TABLE sequence
   ADD CONSTRAINT sequence_pk
   PRIMARY KEY (sequence_id);

COMMENT ON TABLE sequence IS 'Séquences de reproduction';
COMMENT ON COLUMN sequence.annee IS 'Année de campagne';
COMMENT ON COLUMN sequence.sequence_nom IS 'Nom de la séquence (S1, S2, S3...)';
COMMENT ON COLUMN sequence.sequence_date_debut IS 'Date prévisionnelle de début de séquence de repro';

GRANT SELECT ON sequence TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON sequence TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON sequence TO sturio_rw;
-- END TABLE sequence

-- BEGIN TABLE sequence_evenement
CREATE TABLE sequence_evenement
(
   sequence_evenement_id           serial      NOT NULL,
   sequence_id                     integer      NOT NULL,
   sequence_evenement_date         timestamp    NOT NULL,
   sequence_evenement_libelle      varchar      NOT NULL,
   sequence_evenement_commentaire  varchar
);

-- Column sequence_evenement_id is associated with sequence public.sequence_evenement_sequence_evenement_id_seq

ALTER TABLE sequence_evenement
   ADD CONSTRAINT sequence_evenement_pk
   PRIMARY KEY (sequence_evenement_id);

COMMENT ON TABLE sequence_evenement IS 'Table des événements d''une séquence';
COMMENT ON COLUMN sequence_evenement.sequence_evenement_date IS 'Date de l''événement';
COMMENT ON COLUMN sequence_evenement.sequence_evenement_libelle IS 'Nom de l''événement';
COMMENT ON COLUMN sequence_evenement.sequence_evenement_commentaire IS 'Commentaire concernant l''événement';

GRANT SELECT ON sequence_evenement TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON sequence_evenement TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON sequence_evenement TO sturio_rw;
-- END TABLE sequence_evenement

-- BEGIN TABLE sexe
CREATE TABLE sexe
(
   sexe_id             serial    NOT NULL,
   sexe_libelle        varchar    NOT NULL,
   sexe_libelle_court  varchar    NOT NULL
);

-- Column sexe_id is associated with sequence public.sexe_sexe_id_seq

ALTER TABLE sexe
   ADD CONSTRAINT sexe_pk
   PRIMARY KEY (sexe_id);

COMMENT ON TABLE sexe IS 'Table des genres';
COMMENT ON COLUMN sexe.sexe_libelle IS 'Libellé long';
COMMENT ON COLUMN sexe.sexe_libelle_court IS 'Libellé court';

GRANT SELECT ON sexe TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON sexe TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON sexe TO sturio_rw;
-- END TABLE sexe

-- BEGIN TABLE sortie
CREATE TABLE sortie
(
   sortie_id           serial    NOT NULL,
   poisson_id          integer    NOT NULL,
   evenement_id        integer    NOT NULL,
   sortie_lieu_id      integer    NOT NULL,
   sortie_date         date,
   sortie_commentaire  varchar,
   sevre               varchar
);

-- Column sortie_id is associated with sequence public.sortie_sortie_id_seq

ALTER TABLE sortie
   ADD CONSTRAINT sortie_pk
   PRIMARY KEY (sortie_id);

CREATE INDEX sortie_evenement_id_idx ON sortie USING btree (evenement_id);
CREATE INDEX sortie_poisson_id_idx ON sortie USING btree (poisson_id);


COMMENT ON TABLE sortie IS 'Table des sorties du stock';
COMMENT ON COLUMN sortie.sortie_date IS 'Date du lâcher';
COMMENT ON COLUMN sortie.sortie_commentaire IS 'Remarques sur la sortie';
COMMENT ON COLUMN sortie.sevre IS 'Poisson sevré : oui, non, mixte...';

GRANT SELECT ON sortie TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON sortie TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON sortie TO sturio_rw;
-- END TABLE sortie

-- BEGIN TABLE sortie_lieu
CREATE TABLE sortie_lieu
(
   sortie_lieu_id     serial     NOT NULL,
   localisation       varchar     NOT NULL,
   longitude_dd       float8,
   latitude_dd        float8,
   actif              smallint    DEFAULT 1 NOT NULL,
   poisson_statut_id  integer,
   point_geom         geometry
);

ALTER TABLE sortie_lieu ALTER point_geom SET STORAGE MAIN;

-- Column sortie_lieu_id is associated with sequence public.sortie_lieu_sortie_lieu_id_seq

ALTER TABLE sortie_lieu
   ADD CONSTRAINT sortie_lieu_pk
   PRIMARY KEY (sortie_lieu_id);

COMMENT ON TABLE sortie_lieu IS 'Lieux des sorties du stock des poissons';
COMMENT ON COLUMN sortie_lieu.localisation IS 'information textuelle sur le lieu de lacher';
COMMENT ON COLUMN sortie_lieu.longitude_dd IS 'Longitude du point de lâcher, en valeur décimale';
COMMENT ON COLUMN sortie_lieu.latitude_dd IS 'Latitude du point de lâcher, en décimal';
COMMENT ON COLUMN sortie_lieu.actif IS '1 : point utilisé actuellement
0 : ancien point de lâcher';
COMMENT ON COLUMN sortie_lieu.poisson_statut_id IS 'Statut que prend le poisson après sortie du stock';
COMMENT ON COLUMN sortie_lieu.point_geom IS 'Point géographique, en WGS84';

GRANT SELECT ON sortie_lieu TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON sortie_lieu TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON sortie_lieu TO sturio_rw;
-- END TABLE sortie_lieu

-- BEGIN TABLE spatial_ref_sys
CREATE TABLE spatial_ref_sys
(
   srid       integer          NOT NULL,
   auth_name  varchar(256),
   auth_srid  integer,
   srtext     varchar(2048),
   proj4text  varchar(2048),
   CONSTRAINT spatial_ref_sys_srid_check CHECK ((srid > 0) AND (srid <= 998999))
);

ALTER TABLE public.spatial_ref_sys SET OWNER TO sturio_owner;

ALTER TABLE spatial_ref_sys
   ADD CONSTRAINT spatial_ref_sys_pkey
   PRIMARY KEY (srid);

GRANT SELECT ON spatial_ref_sys TO sturio_r;
GRANT SELECT ON spatial_ref_sys TO sturio_sturwild_r;
GRANT SELECT ON spatial_ref_sys TO sturio_sturwild_rw;
GRANT SELECT ON spatial_ref_sys TO sturio_sturat_rw;
GRANT UPDATE, TRIGGER, SELECT, DELETE, TRUNCATE, INSERT, REFERENCES ON spatial_ref_sys TO sturio_owner;
GRANT INSERT, SELECT, DELETE, UPDATE ON spatial_ref_sys TO sturio_rw;
GRANT SELECT ON spatial_ref_sys TO sturio_sturat_r;
-- END TABLE spatial_ref_sys

-- BEGIN TABLE sperme
CREATE TABLE sperme
(
   sperme_id            serial      NOT NULL,
   poisson_campagne_id  integer      NOT NULL,
   sperme_qualite_id    integer,
   sequence_id          integer,
   sperme_date          timestamp    NOT NULL,
   motilite_initiale    float4,
   tx_survie_initial    float4,
   motilite_60          float4,
   tx_survie_60         float4,
   temps_survie         integer,
   sperme_commentaire   varchar
);

-- Column sperme_id is associated with sequence public.sperme_sperme_id_seq

ALTER TABLE sperme
   ADD CONSTRAINT sperme_pk
   PRIMARY KEY (sperme_id);

COMMENT ON TABLE sperme IS 'Table de suivi de la qualité du sperme';
COMMENT ON COLUMN sperme.sperme_date IS 'Date-heure de la mesure';
COMMENT ON COLUMN sperme.motilite_initiale IS 'Motilité initiale, notée de 0 à 5';
COMMENT ON COLUMN sperme.tx_survie_initial IS 'Taux de survie initial, en pourcentage';
COMMENT ON COLUMN sperme.motilite_60 IS 'Motilité à 60 secondes, notée de 0 à 5';
COMMENT ON COLUMN sperme.tx_survie_60 IS 'Taux de survie à 60 secondes, en pourcentage';
COMMENT ON COLUMN sperme.temps_survie IS 'Temps nécessaire pour atteindre 5% de survie, en secondes';

GRANT SELECT ON sperme TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON sperme TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON sperme TO sturio_rw;
-- END TABLE sperme

-- BEGIN TABLE sperme_qualite
CREATE TABLE sperme_qualite
(
   sperme_qualite_id       integer    NOT NULL,
   sperme_qualite_libelle  varchar    NOT NULL
);

ALTER TABLE sperme_qualite
   ADD CONSTRAINT sperme_qualite_pk
   PRIMARY KEY (sperme_qualite_id);

COMMENT ON TABLE sperme_qualite IS 'Table de notation de la qualité globale du sperme
1 : mauvaise à très mauvaise
2 : moyenne
3 : bonne
4 : très bonne';
GRANT SELECT ON sperme_qualite TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON sperme_qualite TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON sperme_qualite TO sturio_rw;
-- END TABLE sperme_qualite

-- BEGIN TABLE transfert
CREATE TABLE transfert
(
   transfert_id           serial    NOT NULL,
   poisson_id             integer    NOT NULL,
   bassin_origine         integer,
   bassin_destination     integer,
   transfert_date         date       NOT NULL,
   evenement_id           integer,
   transfert_commentaire  varchar
);

-- Column transfert_id is associated with sequence public.transfert_transfert_id_seq

ALTER TABLE transfert
   ADD CONSTRAINT transfert_pk
   PRIMARY KEY (transfert_id);

CREATE INDEX transfert_bassin_destination_idx ON transfert USING btree (bassin_destination);
CREATE INDEX transfert_transfert_date_idx ON transfert USING btree (transfert_date);


COMMENT ON TABLE transfert IS 'Description des transferts de poissons entre bassins';
GRANT SELECT ON transfert TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON transfert TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON transfert TO sturio_rw;
-- END TABLE transfert

-- BEGIN TABLE vie_implantation
CREATE TABLE vie_implantation
(
   vie_implantation_id       serial    NOT NULL,
   vie_implantation_libelle  varchar    NOT NULL
);

-- Column vie_implantation_id is associated with sequence public.vie_implantation_vie_implantation_id_seq

ALTER TABLE vie_implantation
   ADD CONSTRAINT vie_implantation_pk
   PRIMARY KEY (vie_implantation_id);

COMMENT ON TABLE vie_implantation IS 'table des implantations des marques VIE';
GRANT SELECT ON vie_implantation TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON vie_implantation TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON vie_implantation TO sturio_rw;
-- END TABLE vie_implantation

-- BEGIN TABLE vie_modele
CREATE TABLE vie_modele
(
   vie_modele_id         serial    NOT NULL,
   vie_implantation_id   integer,
   vie_implantation_id2  integer,
   annee                 integer    NOT NULL,
   couleur               varchar    NOT NULL
);

-- Column vie_modele_id is associated with sequence public.vie_modele_vie_modele_id_seq

ALTER TABLE vie_modele
   ADD CONSTRAINT vie_modele_pk
   PRIMARY KEY (vie_modele_id);

COMMENT ON TABLE vie_modele IS 'Modèles de marquages VIE';
COMMENT ON COLUMN vie_modele.vie_implantation_id IS 'Première implantation de marque';
COMMENT ON COLUMN vie_modele.vie_implantation_id2 IS 'Second emplacement de marque';
COMMENT ON COLUMN vie_modele.couleur IS 'Couleur de la marque VIE';

GRANT SELECT ON vie_modele TO sturio_r;
GRANT UPDATE, TRUNCATE, INSERT, TRIGGER, REFERENCES, DELETE, SELECT ON vie_modele TO \"eric.quinton\";
GRANT INSERT, SELECT, TRIGGER, DELETE, UPDATE, TRUNCATE, REFERENCES ON vie_modele TO sturio_rw;
-- END TABLE vie_modele

-- BEGIN FOREIGN KEYS --
ALTER TABLE aliment
  ADD CONSTRAINT aliment_type_aliment_fk FOREIGN KEY (aliment_type_id)
  REFERENCES aliment_type (aliment_type_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE aliment_categorie
  ADD CONSTRAINT aliment_aliment_categorie_fk FOREIGN KEY (aliment_id)
  REFERENCES aliment (aliment_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE aliment_categorie
  ADD CONSTRAINT categorie_aliment_categorie_fk FOREIGN KEY (categorie_id)
  REFERENCES categorie (categorie_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE aliment_quotidien
  ADD CONSTRAINT aliment_bassin_aliment_fk FOREIGN KEY (aliment_id)
  REFERENCES aliment (aliment_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE aliment_quotidien
  ADD CONSTRAINT distrib_quotidien_aliment_quotidien_fk FOREIGN KEY (distrib_quotidien_id)
  REFERENCES distrib_quotidien (distrib_quotidien_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE analyse_eau
  ADD CONSTRAINT circuit_eau_analyse_eau_fk FOREIGN KEY (circuit_eau_id)
  REFERENCES circuit_eau (circuit_eau_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE analyse_eau
  ADD CONSTRAINT laboratoire_analyse_analyse_eau_fk FOREIGN KEY (laboratoire_analyse_id)
  REFERENCES laboratoire_analyse (laboratoire_analyse_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE analyse_metal
  ADD CONSTRAINT analyse_eau_analyse_metal_fk FOREIGN KEY (analyse_eau_id)
  REFERENCES analyse_eau (analyse_eau_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE analyse_metal
  ADD CONSTRAINT metal_analyse_metal_fk FOREIGN KEY (metal_id)
  REFERENCES metal (metal_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE anomalie_db
  ADD CONSTRAINT anomalie_db_type_anomalie_db_fk FOREIGN KEY (anomalie_db_type_id)
  REFERENCES anomalie_db_type (anomalie_db_type_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE anomalie_db
  ADD CONSTRAINT evenement_anomalie_db_fk FOREIGN KEY (evenement_id)
  REFERENCES evenement (evenement_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE anomalie_db
  ADD CONSTRAINT poisson_anomalie_db_fk FOREIGN KEY (poisson_id)
  REFERENCES poisson (poisson_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE bassin
  ADD CONSTRAINT bassin_type_bassin_fk FOREIGN KEY (bassin_type_id)
  REFERENCES bassin_type (bassin_type_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE bassin
  ADD CONSTRAINT bassin_usage_bassin_fk FOREIGN KEY (bassin_usage_id)
  REFERENCES bassin_usage (bassin_usage_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE bassin
  ADD CONSTRAINT bassin_zone_bassin_fk FOREIGN KEY (bassin_zone_id)
  REFERENCES bassin_zone (bassin_zone_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE bassin
  ADD CONSTRAINT circuit_eau_bassin_fk FOREIGN KEY (circuit_eau_id)
  REFERENCES circuit_eau (circuit_eau_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE bassin_campagne
  ADD CONSTRAINT bassin_bassin_campagne_fk FOREIGN KEY (bassin_id)
  REFERENCES bassin (bassin_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE bassin_document
  ADD CONSTRAINT bassin_bassin_document_fk FOREIGN KEY (bassin_id)
  REFERENCES bassin (bassin_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE bassin_document
  ADD CONSTRAINT document_bassin_document_fk FOREIGN KEY (document_id)
  REFERENCES document (document_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE bassin_evenement
  ADD CONSTRAINT bassin_bassin_evenement_fk FOREIGN KEY (bassin_id)
  REFERENCES bassin (bassin_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE bassin_evenement
  ADD CONSTRAINT bassin_evenement_type_bassin_evenement_fk FOREIGN KEY (bassin_evenement_type_id)
  REFERENCES bassin_evenement_type (bassin_evenement_type_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE bassin_lot
  ADD CONSTRAINT bassin_bassin_lot_fk FOREIGN KEY (bassin_id)
  REFERENCES bassin (bassin_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE bassin_lot
  ADD CONSTRAINT lot_bassin_lot_fk FOREIGN KEY (lot_id)
  REFERENCES lot (lot_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE bassin_usage
  ADD CONSTRAINT aliment_categorie_bassin_usage_fk FOREIGN KEY (categorie_id)
  REFERENCES categorie (categorie_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE biopsie
  ADD CONSTRAINT biopsie_technique_calcul_biopsie_fk FOREIGN KEY (biopsie_technique_calcul_id)
  REFERENCES biopsie_technique_calcul (biopsie_technique_calcul_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE biopsie
  ADD CONSTRAINT poisson_campagne_biopsie_fk FOREIGN KEY (poisson_campagne_id)
  REFERENCES poisson_campagne (poisson_campagne_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE biopsie_document
  ADD CONSTRAINT biopsie_biopsie_document_fk FOREIGN KEY (biopsie_id)
  REFERENCES biopsie (biopsie_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE biopsie_document
  ADD CONSTRAINT document_biopsie_document_fk FOREIGN KEY (document_id)
  REFERENCES document (document_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE cohorte
  ADD CONSTRAINT cohorte_type_cohorte_fk FOREIGN KEY (cohorte_type_id)
  REFERENCES cohorte_type (cohorte_type_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE cohorte
  ADD CONSTRAINT evenement_cohorte_fk FOREIGN KEY (evenement_id)
  REFERENCES evenement (evenement_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE cohorte
  ADD CONSTRAINT poisson_cohorte_fk FOREIGN KEY (poisson_id)
  REFERENCES poisson (poisson_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE croisement
  ADD CONSTRAINT croisement_qualite_croisement_fk FOREIGN KEY (croisement_qualite_id)
  REFERENCES croisement_qualite (croisement_qualite_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE croisement
  ADD CONSTRAINT repro_sequence_croisement_fk FOREIGN KEY (sequence_id)
  REFERENCES sequence (sequence_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE distrib_quotidien
  ADD CONSTRAINT bassin_distrib_quotidien_fk FOREIGN KEY (bassin_id)
  REFERENCES bassin (bassin_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE distribution
  ADD CONSTRAINT bassin_distribution_fk FOREIGN KEY (bassin_id)
  REFERENCES bassin (bassin_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE distribution
  ADD CONSTRAINT repart_template_distribution_fk FOREIGN KEY (repart_template_id)
  REFERENCES repart_template (repart_template_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE distribution
  ADD CONSTRAINT repartition_distribution_fk FOREIGN KEY (repartition_id)
  REFERENCES repartition (repartition_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE document
  ADD CONSTRAINT mime_type_document_fk FOREIGN KEY (mime_type_id)
  REFERENCES mime_type (mime_type_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE dosage_sanguin
  ADD CONSTRAINT poisson_campagne_dosage_sanguin_fk FOREIGN KEY (poisson_campagne_id)
  REFERENCES poisson_campagne (poisson_campagne_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE echographie
  ADD CONSTRAINT evenement_echographie_fk FOREIGN KEY (evenement_id)
  REFERENCES evenement (evenement_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE echographie
  ADD CONSTRAINT poisson_echographie_fk FOREIGN KEY (poisson_id)
  REFERENCES poisson (poisson_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE evenement
  ADD CONSTRAINT evenement_type_evenement_fk FOREIGN KEY (evenement_type_id)
  REFERENCES evenement_type (evenement_type_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE evenement
  ADD CONSTRAINT poisson_evenement_fk FOREIGN KEY (poisson_id)
  REFERENCES poisson (poisson_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE evenement_document
  ADD CONSTRAINT document_evenement_document_fk FOREIGN KEY (document_id)
  REFERENCES document (document_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE evenement_document
  ADD CONSTRAINT evenement_evenement_document_fk FOREIGN KEY (evenement_id)
  REFERENCES evenement (evenement_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE gender_selection
  ADD CONSTRAINT evenement_gender_selection_fk FOREIGN KEY (evenement_id)
  REFERENCES evenement (evenement_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE gender_selection
  ADD CONSTRAINT gender_methode_gender_selection_fk FOREIGN KEY (gender_methode_id)
  REFERENCES gender_methode (gender_methode_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE gender_selection
  ADD CONSTRAINT poisson_gender_selection_fk FOREIGN KEY (poisson_id)
  REFERENCES poisson (poisson_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE gender_selection
  ADD CONSTRAINT sexe_gender_selection_fk FOREIGN KEY (sexe_id)
  REFERENCES sexe (sexe_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE injection
  ADD CONSTRAINT hormone_injection_fk FOREIGN KEY (hormone_id)
  REFERENCES hormone (hormone_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE injection
  ADD CONSTRAINT poisson_campagne_injection_fk FOREIGN KEY (poisson_campagne_id)
  REFERENCES poisson_campagne (poisson_campagne_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE injection
  ADD CONSTRAINT sequence_injection_fk FOREIGN KEY (sequence_id)
  REFERENCES sequence (sequence_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE lot
  ADD CONSTRAINT croisement_lot_fk FOREIGN KEY (croisement_id)
  REFERENCES croisement (croisement_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE lot
  ADD CONSTRAINT vie_modele_lot_fk FOREIGN KEY (vie_modele_id)
  REFERENCES vie_modele (vie_modele_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE lot_mesure
  ADD CONSTRAINT lot_lot_mesure_fk FOREIGN KEY (lot_id)
  REFERENCES lot (lot_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE morphologie
  ADD CONSTRAINT evenement_morphologie_fk FOREIGN KEY (evenement_id)
  REFERENCES evenement (evenement_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE morphologie
  ADD CONSTRAINT poisson_morphologie_fk FOREIGN KEY (poisson_id)
  REFERENCES poisson (poisson_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE mortalite
  ADD CONSTRAINT evenement_mortalite_fk FOREIGN KEY (evenement_id)
  REFERENCES evenement (evenement_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE mortalite
  ADD CONSTRAINT mortalite_type_mortalite_fk FOREIGN KEY (mortalite_type_id)
  REFERENCES mortalite_type (mortalite_type_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE mortalite
  ADD CONSTRAINT poisson_mortalite_fk FOREIGN KEY (poisson_id)
  REFERENCES poisson (poisson_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE parent_poisson
  ADD CONSTRAINT poisson_parent_fk1 FOREIGN KEY (parent_id)
  REFERENCES poisson (poisson_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE parent_poisson
  ADD CONSTRAINT poisson_parent_fk FOREIGN KEY (poisson_id)
  REFERENCES poisson (poisson_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE pathologie
  ADD CONSTRAINT evenement_pathologie_fk FOREIGN KEY (evenement_id)
  REFERENCES evenement (evenement_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE pathologie
  ADD CONSTRAINT pathologie_type_pathologie_fk FOREIGN KEY (pathologie_type_id)
  REFERENCES pathologie_type (pathologie_type_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE pathologie
  ADD CONSTRAINT poisson_pathologie_fk FOREIGN KEY (poisson_id)
  REFERENCES poisson (poisson_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE pittag
  ADD CONSTRAINT pittag_type_pittag_fk FOREIGN KEY (pittag_type_id)
  REFERENCES pittag_type (pittag_type_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE pittag
  ADD CONSTRAINT poisson_pittag_fk FOREIGN KEY (poisson_id)
  REFERENCES poisson (poisson_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE poisson
  ADD CONSTRAINT categorie_poisson_fk FOREIGN KEY (categorie_id)
  REFERENCES categorie (categorie_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE poisson
  ADD CONSTRAINT poisson_statut_poisson_fk FOREIGN KEY (poisson_statut_id)
  REFERENCES poisson_statut (poisson_statut_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE poisson
  ADD CONSTRAINT sexe_poisson_fk FOREIGN KEY (sexe_id)
  REFERENCES sexe (sexe_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE poisson
  ADD CONSTRAINT vie_modele_poisson_fk FOREIGN KEY (vie_modele_id)
  REFERENCES vie_modele (vie_modele_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE poisson_campagne
  ADD CONSTRAINT poisson_poisson_campagne_fk FOREIGN KEY (poisson_id)
  REFERENCES poisson (poisson_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE poisson_campagne
  ADD CONSTRAINT repro_statut_poisson_campagne_fk FOREIGN KEY (repro_statut_id)
  REFERENCES repro_statut (repro_statut_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE poisson_croisement
  ADD CONSTRAINT croisement_poisson_croisement_fk FOREIGN KEY (croisement_id)
  REFERENCES croisement (croisement_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE poisson_croisement
  ADD CONSTRAINT poisson_campagne_poisson_croisement_fk FOREIGN KEY (poisson_campagne_id)
  REFERENCES poisson_campagne (poisson_campagne_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE poisson_document
  ADD CONSTRAINT document_poisson_document_fk FOREIGN KEY (document_id)
  REFERENCES document (document_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE poisson_document
  ADD CONSTRAINT poisson_poisson_document_fk FOREIGN KEY (poisson_id)
  REFERENCES poisson (poisson_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE poisson_sequence
  ADD CONSTRAINT poisson_campagne_poisson_sequence_fk FOREIGN KEY (poisson_campagne_id)
  REFERENCES poisson_campagne (poisson_campagne_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE poisson_sequence
  ADD CONSTRAINT ps_statut_poisson_sequence_fk FOREIGN KEY (ps_statut_id)
  REFERENCES ps_statut (ps_statut_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE poisson_sequence
  ADD CONSTRAINT repro_sequence_poisson_sequence_fk FOREIGN KEY (sequence_id)
  REFERENCES sequence (sequence_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE profil_thermique
  ADD CONSTRAINT bassin_campagne_profil_thermique_fk FOREIGN KEY (bassin_campagne_id)
  REFERENCES bassin_campagne (bassin_campagne_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE profil_thermique
  ADD CONSTRAINT profil_thermique_type_profil_thermique_fk FOREIGN KEY (profil_thermique_type_id)
  REFERENCES profil_thermique_type (profil_thermique_type_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE ps_evenement
  ADD CONSTRAINT poisson_sequence_ps_evenement_fk FOREIGN KEY (poisson_sequence_id)
  REFERENCES poisson_sequence (poisson_sequence_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE repart_aliment
  ADD CONSTRAINT aliment_aliment_repartition_part_fk FOREIGN KEY (aliment_id)
  REFERENCES aliment (aliment_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE repart_aliment
  ADD CONSTRAINT repart_template_repart_aliment_fk FOREIGN KEY (repart_template_id)
  REFERENCES repart_template (repart_template_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE repart_template
  ADD CONSTRAINT categorie_repart_template_fk FOREIGN KEY (categorie_id)
  REFERENCES categorie (categorie_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE repartition
  ADD CONSTRAINT categorie_repartition_fk FOREIGN KEY (categorie_id)
  REFERENCES categorie (categorie_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE salinite
  ADD CONSTRAINT bassin_campagne_salinite_fk FOREIGN KEY (bassin_campagne_id)
  REFERENCES bassin_campagne (bassin_campagne_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE salinite
  ADD CONSTRAINT profil_thermique_type_salinite_fk FOREIGN KEY (profil_thermique_type_id)
  REFERENCES profil_thermique_type (profil_thermique_type_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE sequence_evenement
  ADD CONSTRAINT sequence_sequence_evenement_fk FOREIGN KEY (sequence_id)
  REFERENCES sequence (sequence_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE sortie
  ADD CONSTRAINT evenement_sortie_fk FOREIGN KEY (evenement_id)
  REFERENCES evenement (evenement_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE sortie
  ADD CONSTRAINT poisson_lacher_fk FOREIGN KEY (poisson_id)
  REFERENCES poisson (poisson_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE sortie
  ADD CONSTRAINT sortie_lieu_sortie_fk FOREIGN KEY (sortie_lieu_id)
  REFERENCES sortie_lieu (sortie_lieu_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE sortie_lieu
  ADD CONSTRAINT poisson_statut_sortie_lieu_fk FOREIGN KEY (poisson_statut_id)
  REFERENCES poisson_statut (poisson_statut_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE sperme
  ADD CONSTRAINT poisson_campagne_sperme_qualite_fk FOREIGN KEY (poisson_campagne_id)
  REFERENCES poisson_campagne (poisson_campagne_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE sperme
  ADD CONSTRAINT sequence_sperme_fk FOREIGN KEY (sequence_id)
  REFERENCES sequence (sequence_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE sperme
  ADD CONSTRAINT sperme_qualite_sperme_fk FOREIGN KEY (sperme_qualite_id)
  REFERENCES sperme_qualite (sperme_qualite_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE transfert
  ADD CONSTRAINT bassin_transfert_fk1 FOREIGN KEY (bassin_destination)
  REFERENCES bassin (bassin_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE transfert
  ADD CONSTRAINT bassin_transfert_fk FOREIGN KEY (bassin_origine)
  REFERENCES bassin (bassin_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE transfert
  ADD CONSTRAINT evenement_transfert_fk FOREIGN KEY (evenement_id)
  REFERENCES evenement (evenement_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE transfert
  ADD CONSTRAINT poisson_transfert_fk FOREIGN KEY (poisson_id)
  REFERENCES poisson (poisson_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE vie_modele
  ADD CONSTRAINT vie_implantation_vie_modele_fk FOREIGN KEY (vie_implantation_id)
  REFERENCES vie_implantation (vie_implantation_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE vie_modele
  ADD CONSTRAINT vie_implantation_vie_modele_fk1 FOREIGN KEY (vie_implantation_id2)
  REFERENCES vie_implantation (vie_implantation_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;
-- END FOREIGN KEYS --

-- BEGIN VIEW geography_columns
CREATE VIEW geography_columns
AS 
 SELECT current_database() AS f_table_catalog,
    n.nspname AS f_table_schema,
    c.relname AS f_table_name,
    a.attname AS f_geography_column,
    postgis_typmod_dims(a.atttypmod) AS coord_dimension,
    postgis_typmod_srid(a.atttypmod) AS srid,
    postgis_typmod_type(a.atttypmod) AS type
   FROM pg_class c,
    pg_attribute a,
    pg_type t,
    pg_namespace n
  WHERE t.typname = 'geography'::name AND a.attisdropped = false AND a.atttypid = t.oid AND a.attrelid = c.oid AND c.relnamespace = n.oid AND NOT pg_is_other_temp_schema(c.relnamespace) AND has_table_privilege(c.oid, 'SELECT'::text);


GRANT SELECT ON geography_columns TO sturio_r;
GRANT TRUNCATE, INSERT, TRIGGER, UPDATE, SELECT, DELETE, REFERENCES ON geography_columns TO sturio_owner;
GRANT INSERT, SELECT, DELETE, UPDATE ON geography_columns TO sturio_rw;

-- END VIEW geography_columns

-- BEGIN VIEW geometry_columns
CREATE VIEW geometry_columns
AS 
 SELECT current_database()::character varying(256) AS f_table_catalog,
    n.nspname::character varying(256) AS f_table_schema,
    c.relname::character varying(256) AS f_table_name,
    a.attname::character varying(256) AS f_geometry_column,
    COALESCE(NULLIF(postgis_typmod_dims(a.atttypmod), 2), postgis_constraint_dims(n.nspname::text, c.relname::text, a.attname::text), 2) AS coord_dimension,
    COALESCE(NULLIF(postgis_typmod_srid(a.atttypmod), 0), postgis_constraint_srid(n.nspname::text, c.relname::text, a.attname::text), 0) AS srid,
    replace(replace(COALESCE(NULLIF(upper(postgis_typmod_type(a.atttypmod)), 'GEOMETRY'::text), postgis_constraint_type(n.nspname::text, c.relname::text, a.attname::text)::text, 'GEOMETRY'::text), 'ZM'::text, ''::text), 'Z'::text, ''::text)::character varying(30) AS type
   FROM pg_class c,
    pg_attribute a,
    pg_type t,
    pg_namespace n
  WHERE t.typname = 'geometry'::name AND a.attisdropped = false AND a.atttypid = t.oid AND a.attrelid = c.oid AND c.relnamespace = n.oid AND (c.relkind = 'r'::"char" OR c.relkind = 'v'::"char" OR c.relkind = 'm'::"char" OR c.relkind = 'f'::"char") AND NOT pg_is_other_temp_schema(c.relnamespace) AND NOT (n.nspname = 'public'::name AND c.relname = 'raster_columns'::name) AND has_table_privilege(c.oid, 'SELECT'::text);


GRANT SELECT ON geometry_columns TO sturio_r;
GRANT TRUNCATE, INSERT, TRIGGER, UPDATE, SELECT, DELETE, REFERENCES ON geometry_columns TO sturio_owner;
GRANT INSERT, SELECT, DELETE, UPDATE ON geometry_columns TO sturio_rw;



CREATE RULE geometry_columns_delete AS
    ON DELETE TO geometry_columns DO INSTEAD NOTHING;
CREATE RULE geometry_columns_insert AS
    ON INSERT TO geometry_columns DO INSTEAD NOTHING;
CREATE RULE geometry_columns_update AS
    ON UPDATE TO geometry_columns DO INSTEAD NOTHING;
-- END VIEW geometry_columns

-- BEGIN VIEW raster_columns
CREATE VIEW raster_columns
AS 
 SELECT current_database() AS r_table_catalog,
    n.nspname AS r_table_schema,
    c.relname AS r_table_name,
    a.attname AS r_raster_column,
    COALESCE(_raster_constraint_info_srid(n.nspname, c.relname, a.attname), ( SELECT st_srid('010100000000000000000000000000000000000000'::geometry) AS st_srid)) AS srid,
    _raster_constraint_info_scale(n.nspname, c.relname, a.attname, 'x'::bpchar) AS scale_x,
    _raster_constraint_info_scale(n.nspname, c.relname, a.attname, 'y'::bpchar) AS scale_y,
    _raster_constraint_info_blocksize(n.nspname, c.relname, a.attname, 'width'::text) AS blocksize_x,
    _raster_constraint_info_blocksize(n.nspname, c.relname, a.attname, 'height'::text) AS blocksize_y,
    COALESCE(_raster_constraint_info_alignment(n.nspname, c.relname, a.attname), false) AS same_alignment,
    COALESCE(_raster_constraint_info_regular_blocking(n.nspname, c.relname, a.attname), false) AS regular_blocking,
    _raster_constraint_info_num_bands(n.nspname, c.relname, a.attname) AS num_bands,
    _raster_constraint_info_pixel_types(n.nspname, c.relname, a.attname) AS pixel_types,
    _raster_constraint_info_nodata_values(n.nspname, c.relname, a.attname) AS nodata_values,
    _raster_constraint_info_out_db(n.nspname, c.relname, a.attname) AS out_db,
    _raster_constraint_info_extent(n.nspname, c.relname, a.attname) AS extent
   FROM pg_class c,
    pg_attribute a,
    pg_type t,
    pg_namespace n
  WHERE t.typname = 'raster'::name AND a.attisdropped = false AND a.atttypid = t.oid AND a.attrelid = c.oid AND c.relnamespace = n.oid AND (c.relkind::text = ANY (ARRAY['r'::character(1), 'v'::character(1), 'm'::character(1), 'f'::character(1)]::text[])) AND NOT pg_is_other_temp_schema(c.relnamespace);


GRANT SELECT ON raster_columns TO sturio_r;
GRANT TRUNCATE, INSERT, TRIGGER, UPDATE, SELECT, DELETE, REFERENCES ON raster_columns TO sturio_owner;
GRANT INSERT, SELECT, DELETE, UPDATE ON raster_columns TO sturio_rw;

-- END VIEW raster_columns

-- BEGIN VIEW raster_overviews
CREATE VIEW raster_overviews
AS 
 SELECT current_database() AS o_table_catalog,
    n.nspname AS o_table_schema,
    c.relname AS o_table_name,
    a.attname AS o_raster_column,
    current_database() AS r_table_catalog,
    split_part(split_part(s.consrc, '''::name'::text, 1), ''''::text, 2)::name AS r_table_schema,
    split_part(split_part(s.consrc, '''::name'::text, 2), ''''::text, 2)::name AS r_table_name,
    split_part(split_part(s.consrc, '''::name'::text, 3), ''''::text, 2)::name AS r_raster_column,
    btrim(split_part(s.consrc, ','::text, 2))::integer AS overview_factor
   FROM pg_class c,
    pg_attribute a,
    pg_type t,
    pg_namespace n,
    pg_constraint s
  WHERE t.typname = 'raster'::name AND a.attisdropped = false AND a.atttypid = t.oid AND a.attrelid = c.oid AND c.relnamespace = n.oid AND (c.relkind::text = ANY (ARRAY['r'::character(1), 'v'::character(1), 'm'::character(1), 'f'::character(1)]::text[])) AND s.connamespace = n.oid AND s.conrelid = c.oid AND s.consrc ~~ '%_overview_constraint(%'::text AND NOT pg_is_other_temp_schema(c.relnamespace);


GRANT SELECT ON raster_overviews TO sturio_r;
GRANT TRUNCATE, INSERT, TRIGGER, UPDATE, SELECT, DELETE, REFERENCES ON raster_overviews TO sturio_owner;
GRANT INSERT, SELECT, DELETE, UPDATE ON raster_overviews TO sturio_rw;

-- END VIEW raster_overviews

-- BEGIN VIEW v_bassin_alim_quotidien
CREATE VIEW v_bassin_alim_quotidien
AS 
 WITH bassins AS (
         SELECT t.poisson_id,
            t.bassin_destination AS bassin_id,
            bassin.bassin_nom,
            t.transfert_date AS date_debut,
            ( SELECT min(t1.transfert_date) AS min
                   FROM transfert t1
                  WHERE t.poisson_id = t1.poisson_id AND t1.transfert_date > t.transfert_date) AS date_fin
           FROM transfert t
             JOIN bassin ON t.bassin_destination = bassin.bassin_id
          WHERE t.bassin_destination IS NOT NULL
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
   FROM bassins b
     JOIN distrib_quotidien d ON b.bassin_id = d.bassin_id AND d.distrib_quotidien_date >= b.date_debut AND d.distrib_quotidien_date <=
        CASE
            WHEN b.date_fin IS NULL THEN 'now'::text::date
            ELSE b.date_fin
        END;


GRANT SELECT ON v_bassin_alim_quotidien TO sturio_r;
GRANT DELETE, INSERT, SELECT, UPDATE, TRUNCATE, REFERENCES, TRIGGER ON v_bassin_alim_quotidien TO eric.quinton;
GRANT INSERT, TRIGGER, SELECT, DELETE, UPDATE, TRUNCATE, REFERENCES ON v_bassin_alim_quotidien TO sturio_rw;

-- END VIEW v_bassin_alim_quotidien

-- BEGIN VIEW v_parent_poisson_ntile
CREATE VIEW v_parent_poisson_ntile
AS 
 SELECT DISTINCT parent_poisson.poisson_id,
    parent_poisson.parent_id,
    ntile(4) OVER (PARTITION BY parent_poisson.poisson_id ORDER BY parent_poisson.parent_id) AS ntile
   FROM parent_poisson;


GRANT SELECT ON v_parent_poisson_ntile TO sturio_r;
GRANT DELETE, INSERT, SELECT, UPDATE, TRUNCATE, REFERENCES, TRIGGER ON v_parent_poisson_ntile TO eric.quinton;
GRANT INSERT, TRIGGER, SELECT, DELETE, UPDATE, TRUNCATE, REFERENCES ON v_parent_poisson_ntile TO sturio_rw;

COMMENT ON VIEW v_parent_poisson_ntile IS 'Préparation de la liste des parents, avec numéro d''ordre, pour utilisation par la vue v_parents';
-- END VIEW v_parent_poisson_ntile

-- BEGIN VIEW v_parents
CREATE VIEW v_parents
AS 
 SELECT DISTINCT p.poisson_id,
    p1.parent_id AS parent1_id,
    p2.parent_id AS parent2_id,
    p3.parent_id AS parent3_id,
    p4.parent_id AS parent4_id
   FROM v_parent_poisson_ntile p
     LEFT JOIN v_parent_poisson_ntile p1 ON p.poisson_id = p1.poisson_id AND p1.ntile = 1
     LEFT JOIN v_parent_poisson_ntile p2 ON p.poisson_id = p2.poisson_id AND p2.ntile = 2
     LEFT JOIN v_parent_poisson_ntile p3 ON p.poisson_id = p3.poisson_id AND p3.ntile = 3
     LEFT JOIN v_parent_poisson_ntile p4 ON p.poisson_id = p4.poisson_id AND p4.ntile = 4;


GRANT SELECT ON v_parents TO sturio_r;
GRANT DELETE, INSERT, SELECT, UPDATE, TRUNCATE, REFERENCES, TRIGGER ON v_parents TO eric.quinton;
GRANT INSERT, TRIGGER, SELECT, DELETE, UPDATE, TRUNCATE, REFERENCES ON v_parents TO sturio_rw;

COMMENT ON VIEW v_parents IS 'Liste des parents d''un poisson';
-- END VIEW v_parents

-- BEGIN VIEW v_pittag_by_poisson
CREATE VIEW v_pittag_by_poisson
AS 
 SELECT pittag.poisson_id,
    array_to_string(array_agg(pittag.pittag_valeur), ' '::text) AS pittag_valeur
   FROM pittag
  GROUP BY pittag.poisson_id;


GRANT SELECT ON v_pittag_by_poisson TO sturio_r;
GRANT DELETE, INSERT, SELECT, UPDATE, TRUNCATE, REFERENCES, TRIGGER ON v_pittag_by_poisson TO eric.quinton;
GRANT INSERT, TRIGGER, SELECT, DELETE, UPDATE, TRUNCATE, REFERENCES ON v_pittag_by_poisson TO sturio_rw;

-- END VIEW v_pittag_by_poisson

-- BEGIN VIEW v_poisson_bassins
CREATE VIEW v_poisson_bassins
AS 
 SELECT t.poisson_id,
    t.bassin_destination AS bassin_id,
    bassin.bassin_nom,
    t.transfert_date AS date_debut,
    ( SELECT min(t1.transfert_date) AS min
           FROM transfert t1
          WHERE t.poisson_id = t1.poisson_id AND t1.transfert_date > t.transfert_date) AS date_fin
   FROM transfert t
     JOIN bassin ON t.bassin_destination = bassin.bassin_id
  WHERE t.bassin_destination IS NOT NULL
  ORDER BY t.poisson_id, t.transfert_date DESC;


GRANT SELECT ON v_poisson_bassins TO sturio_r;
GRANT DELETE, INSERT, SELECT, UPDATE, TRUNCATE, REFERENCES, TRIGGER ON v_poisson_bassins TO eric.quinton;
GRANT INSERT, TRIGGER, SELECT, DELETE, UPDATE, TRUNCATE, REFERENCES ON v_poisson_bassins TO sturio_rw;

COMMENT ON VIEW v_poisson_bassins IS 'Liste des bassins fréquentés par un poisson';
-- END VIEW v_poisson_bassins

-- BEGIN VIEW v_poisson_last_bassin
CREATE VIEW v_poisson_last_bassin
AS 
 SELECT t.poisson_id,
    bassin.bassin_id,
    bassin.bassin_nom,
    t.transfert_date,
    t.transfert_id,
    t.evenement_id
   FROM transfert t
     JOIN bassin ON t.bassin_destination = bassin.bassin_id
  WHERE t.transfert_date = (( SELECT max(t1.transfert_date) AS max
           FROM transfert t1
          WHERE t.poisson_id = t1.poisson_id AND t1.bassin_destination > 0));


GRANT SELECT ON v_poisson_last_bassin TO sturio_r;
GRANT DELETE, INSERT, SELECT, UPDATE, TRUNCATE, REFERENCES, TRIGGER ON v_poisson_last_bassin TO eric.quinton;
GRANT INSERT, TRIGGER, SELECT, DELETE, UPDATE, TRUNCATE, REFERENCES ON v_poisson_last_bassin TO sturio_rw;

-- END VIEW v_poisson_last_bassin

-- BEGIN VIEW v_poisson_last_lf
CREATE VIEW v_poisson_last_lf
AS 
 SELECT m.poisson_id,
    m.longueur_fourche,
    m.morphologie_date,
    m.morphologie_id,
    m.evenement_id
   FROM morphologie m
  WHERE m.morphologie_date = (( SELECT max(m1.morphologie_date) AS max
           FROM morphologie m1
          WHERE m1.longueur_fourche > 0::double precision AND m.poisson_id = m1.poisson_id));


GRANT SELECT ON v_poisson_last_lf TO sturio_r;
GRANT DELETE, INSERT, SELECT, UPDATE, TRUNCATE, REFERENCES, TRIGGER ON v_poisson_last_lf TO eric.quinton;
GRANT INSERT, TRIGGER, SELECT, DELETE, UPDATE, TRUNCATE, REFERENCES ON v_poisson_last_lf TO sturio_rw;

-- END VIEW v_poisson_last_lf

-- BEGIN VIEW v_poisson_last_lt
CREATE VIEW v_poisson_last_lt
AS 
 SELECT m.poisson_id,
    m.longueur_totale,
    m.morphologie_date,
    m.morphologie_id,
    m.evenement_id
   FROM morphologie m
  WHERE m.morphologie_date = (( SELECT max(m1.morphologie_date) AS max
           FROM morphologie m1
          WHERE m1.longueur_totale > 0::double precision AND m.poisson_id = m1.poisson_id));


GRANT SELECT ON v_poisson_last_lt TO sturio_r;
GRANT DELETE, INSERT, SELECT, UPDATE, TRUNCATE, REFERENCES, TRIGGER ON v_poisson_last_lt TO eric.quinton;
GRANT INSERT, TRIGGER, SELECT, DELETE, UPDATE, TRUNCATE, REFERENCES ON v_poisson_last_lt TO sturio_rw;

-- END VIEW v_poisson_last_lt

-- BEGIN VIEW v_poisson_last_masse
CREATE VIEW v_poisson_last_masse
AS 
 SELECT m.poisson_id,
    m.masse,
    m.morphologie_date,
    m.morphologie_id,
    m.evenement_id
   FROM morphologie m
  WHERE m.morphologie_date = (( SELECT max(m1.morphologie_date) AS max
           FROM morphologie m1
          WHERE m1.masse > 0::double precision AND m.poisson_id = m1.poisson_id));


GRANT SELECT ON v_poisson_last_masse TO sturio_r;
GRANT DELETE, INSERT, SELECT, UPDATE, TRUNCATE, REFERENCES, TRIGGER ON v_poisson_last_masse TO eric.quinton;
GRANT INSERT, TRIGGER, SELECT, DELETE, UPDATE, TRUNCATE, REFERENCES ON v_poisson_last_masse TO sturio_rw;

-- END VIEW v_poisson_last_masse

-- BEGIN VIEW v_prenom_parents
CREATE VIEW v_prenom_parents
AS 
 SELECT pp.poisson_id,
    array_to_string(array_agg(p.prenom), ' '::text) AS parents
   FROM parent_poisson pp
     JOIN poisson p ON pp.parent_id = p.poisson_id
  GROUP BY pp.poisson_id;


GRANT SELECT ON v_prenom_parents TO sturio_r;
GRANT DELETE, INSERT, SELECT, UPDATE, TRUNCATE, REFERENCES, TRIGGER ON v_prenom_parents TO eric.quinton;
GRANT INSERT, TRIGGER, SELECT, DELETE, UPDATE, TRUNCATE, REFERENCES ON v_prenom_parents TO sturio_rw;

-- END VIEW v_prenom_parents

-- BEGIN VIEW v_transfert_last_bassin_for_poisson
CREATE VIEW v_transfert_last_bassin_for_poisson
AS 
 SELECT transfert.poisson_id,
    max(transfert.transfert_date) AS transfert_date_last
   FROM transfert
  GROUP BY transfert.poisson_id;


GRANT SELECT ON v_transfert_last_bassin_for_poisson TO sturio_r;
GRANT DELETE, INSERT, SELECT, UPDATE, TRUNCATE, REFERENCES, TRIGGER ON v_transfert_last_bassin_for_poisson TO eric.quinton;
GRANT INSERT, TRIGGER, SELECT, DELETE, UPDATE, TRUNCATE, REFERENCES ON v_transfert_last_bassin_for_poisson TO sturio_rw;

-- END VIEW v_transfert_last_bassin_for_poisson

-- BEGIN VIEW v_vie_modele
CREATE VIEW v_vie_modele
AS 
 SELECT vm.vie_modele_id,
    vm.annee,
    vm.couleur,
    vm.vie_implantation_id,
    vm.vie_implantation_id2,
    i.vie_implantation_libelle,
    i2.vie_implantation_libelle AS vie_implantation_libelle2
   FROM vie_modele vm
     JOIN vie_implantation i ON vm.vie_implantation_id = i.vie_implantation_id
     JOIN vie_implantation i2 ON vm.vie_implantation_id2 = i2.vie_implantation_id;


GRANT SELECT ON v_vie_modele TO sturio_r;
GRANT DELETE, INSERT, SELECT, UPDATE, TRUNCATE, REFERENCES, TRIGGER ON v_vie_modele TO eric.quinton;
GRANT INSERT, TRIGGER, SELECT, DELETE, UPDATE, TRUNCATE, REFERENCES ON v_vie_modele TO sturio_rw;

-- END VIEW v_vie_modele


COMMIT;

