

ALTER TABLE ONLY sturio.public.aliment ALTER COLUMN actif TYPE SMALLINT, ALTER COLUMN actif SET NOT NULL;

ALTER TABLE ONLY sturio.public.aliment ALTER COLUMN aliment_libelle TYPE VARCHAR, ALTER COLUMN aliment_libelle SET NOT NULL;

ALTER TABLE ONLY sturio.public.aliment ALTER COLUMN aliment_libelle_court TYPE VARCHAR(8), ALTER COLUMN aliment_libelle_court SET NOT NULL;

ALTER TABLE ONLY sturio.public.aliment_quotidien ALTER COLUMN quantite TYPE REAL, ALTER COLUMN quantite DROP NOT NULL;

ALTER TABLE ONLY sturio.public.aliment_type ALTER COLUMN aliment_type_libelle TYPE VARCHAR, ALTER COLUMN aliment_type_libelle SET NOT NULL;

ALTER TABLE sturio.public.analyse_eau ADD COLUMN backwash_biologique SMALLINT DEFAULT 0 NOT NULL;

ALTER TABLE ONLY sturio.public.analyse_eau ALTER COLUMN backwash_biologique_commentaire TYPE VARCHAR, ALTER COLUMN backwash_biologique_commentaire DROP NOT NULL;

ALTER TABLE ONLY sturio.public.analyse_eau ALTER COLUMN backwash_mecanique TYPE SMALLINT, ALTER COLUMN backwash_mecanique DROP NOT NULL;

ALTER TABLE ONLY sturio.public.analyse_eau ALTER COLUMN debit_eau_forage TYPE REAL, ALTER COLUMN debit_eau_forage DROP NOT NULL;

ALTER TABLE ONLY sturio.public.analyse_eau ALTER COLUMN debit_eau_riviere TYPE REAL, ALTER COLUMN debit_eau_riviere DROP NOT NULL;

ALTER TABLE sturio.public.analyse_eau ADD COLUMN laboratoire_analyse_id INTEGER ;

ALTER TABLE ONLY sturio.public.analyse_eau ALTER COLUMN n_nh4 TYPE REAL, ALTER COLUMN n_nh4 DROP NOT NULL;

ALTER TABLE ONLY sturio.public.analyse_eau ALTER COLUMN n_no2 TYPE REAL, ALTER COLUMN n_no2 DROP NOT NULL;

ALTER TABLE ONLY sturio.public.analyse_eau ALTER COLUMN n_no3 TYPE REAL, ALTER COLUMN n_no3 DROP NOT NULL;

ALTER TABLE ONLY sturio.public.analyse_eau ALTER COLUMN nh4 TYPE REAL, ALTER COLUMN nh4 DROP NOT NULL;

ALTER TABLE ONLY sturio.public.analyse_eau ALTER COLUMN nh4_seuil TYPE VARCHAR, ALTER COLUMN nh4_seuil DROP NOT NULL;

ALTER TABLE ONLY sturio.public.analyse_eau ALTER COLUMN no2 TYPE REAL, ALTER COLUMN no2 DROP NOT NULL;

ALTER TABLE ONLY sturio.public.analyse_eau ALTER COLUMN no2_seuil TYPE VARCHAR, ALTER COLUMN no2_seuil DROP NOT NULL;

ALTER TABLE ONLY sturio.public.analyse_eau ALTER COLUMN no3 TYPE REAL, ALTER COLUMN no3 DROP NOT NULL;

ALTER TABLE ONLY sturio.public.analyse_eau ALTER COLUMN no3_seuil TYPE VARCHAR, ALTER COLUMN no3_seuil DROP NOT NULL;

ALTER TABLE ONLY sturio.public.analyse_eau ALTER COLUMN observations TYPE VARCHAR, ALTER COLUMN observations DROP NOT NULL;

ALTER TABLE ONLY sturio.public.analyse_eau ALTER COLUMN oxygene TYPE REAL, ALTER COLUMN oxygene DROP NOT NULL;

ALTER TABLE ONLY sturio.public.analyse_eau ALTER COLUMN ph TYPE REAL, ALTER COLUMN ph DROP NOT NULL;

ALTER TABLE ONLY sturio.public.analyse_eau ALTER COLUMN salinite TYPE REAL, ALTER COLUMN salinite DROP NOT NULL;

ALTER TABLE ONLY sturio.public.analyse_eau ALTER COLUMN temperature TYPE REAL, ALTER COLUMN temperature DROP NOT NULL;

ALTER TABLE ONLY sturio.public.anomalie_db ALTER COLUMN anomalie_db_commentaire TYPE VARCHAR, ALTER COLUMN anomalie_db_commentaire DROP NOT NULL;

ALTER TABLE ONLY sturio.public.anomalie_db ALTER COLUMN anomalie_db_statut TYPE SMALLINT, ALTER COLUMN anomalie_db_statut SET NOT NULL;

ALTER TABLE ONLY sturio.public.anomalie_db_type ALTER COLUMN anomalie_db_type_libelle TYPE VARCHAR, ALTER COLUMN anomalie_db_type_libelle SET NOT NULL;

ALTER TABLE ONLY sturio.public.bassin ALTER COLUMN actif TYPE SMALLINT, ALTER COLUMN actif DROP NOT NULL;

ALTER TABLE ONLY sturio.public.bassin ALTER COLUMN bassin_description TYPE VARCHAR, ALTER COLUMN bassin_description DROP NOT NULL;

ALTER TABLE ONLY sturio.public.bassin ALTER COLUMN bassin_nom TYPE VARCHAR, ALTER COLUMN bassin_nom SET NOT NULL;

CREATE SEQUENCE sturio.public.bassin_evenement_bassin_evenement_id_seq;

CREATE TABLE sturio.public.bassin_evenement (
                bassin_evenement_id INTEGER NOT NULL DEFAULT nextval('sturio.public.bassin_evenement_bassin_evenement_id_seq'),
                bassin_id INTEGER NOT NULL,
                bassin_evenement_type_id INTEGER NOT NULL,
                bassin_evenement_date DATE NOT NULL,
                bassin_evenement_commentaire VARCHAR,
                CONSTRAINT bassin_evenement_pk PRIMARY KEY (bassin_evenement_id)
);
COMMENT ON TABLE sturio.public.bassin_evenement IS 'Table des événements survenant dans les bassins';
COMMENT ON COLUMN sturio.public.bassin_evenement.bassin_evenement_date IS 'Date de survenue de l''événement dans le bassin';
COMMENT ON COLUMN sturio.public.bassin_evenement.bassin_evenement_commentaire IS 'Commentaire concernant l''événement';


ALTER SEQUENCE sturio.public.bassin_evenement_bassin_evenement_id_seq OWNED BY sturio.public.bassin_evenement.bassin_evenement_id;

CREATE SEQUENCE sturio.public.bassin_evenement_type_bassin_evenement_type_id_seq;

CREATE TABLE sturio.public.bassin_evenement_type (
                bassin_evenement_type_id INTEGER NOT NULL DEFAULT nextval('sturio.public.bassin_evenement_type_bassin_evenement_type_id_seq'),
                bassin_evenement_type_libelle VARCHAR NOT NULL,
                CONSTRAINT bassin_evenement_type_pk PRIMARY KEY (bassin_evenement_type_id)
);
COMMENT ON TABLE sturio.public.bassin_evenement_type IS 'Table des types d''événements dans les bassins';


ALTER SEQUENCE sturio.public.bassin_evenement_type_bassin_evenement_type_id_seq OWNED BY sturio.public.bassin_evenement_type.bassin_evenement_type_id;

ALTER TABLE ONLY sturio.public.bassin_type ALTER COLUMN bassin_type_libelle TYPE VARCHAR, ALTER COLUMN bassin_type_libelle SET NOT NULL;

ALTER TABLE ONLY sturio.public.bassin_usage ALTER COLUMN bassin_usage_libelle TYPE VARCHAR, ALTER COLUMN bassin_usage_libelle SET NOT NULL;

ALTER TABLE ONLY sturio.public.bassin_zone ALTER COLUMN bassin_zone_libelle TYPE VARCHAR, ALTER COLUMN bassin_zone_libelle SET NOT NULL;

ALTER TABLE ONLY sturio.public.categorie ALTER COLUMN categorie_libelle TYPE VARCHAR, ALTER COLUMN categorie_libelle SET NOT NULL;

ALTER TABLE ONLY sturio.public.circuit_eau ALTER COLUMN circuit_eau_actif TYPE SMALLINT, ALTER COLUMN circuit_eau_actif DROP NOT NULL;

ALTER TABLE ONLY sturio.public.circuit_eau ALTER COLUMN circuit_eau_libelle TYPE VARCHAR, ALTER COLUMN circuit_eau_libelle SET NOT NULL;

ALTER TABLE ONLY sturio.public.cohorte ALTER COLUMN cohorte_commentaire TYPE VARCHAR, ALTER COLUMN cohorte_commentaire DROP NOT NULL;

ALTER TABLE ONLY sturio.public.cohorte ALTER COLUMN cohorte_determination TYPE VARCHAR, ALTER COLUMN cohorte_determination DROP NOT NULL;

ALTER TABLE ONLY sturio.public.cohorte_type ALTER COLUMN cohorte_type_libelle TYPE VARCHAR, ALTER COLUMN cohorte_type_libelle SET NOT NULL;

ALTER TABLE ONLY sturio.public.distrib_quotidien ALTER COLUMN reste TYPE REAL, ALTER COLUMN reste DROP NOT NULL;

ALTER TABLE ONLY sturio.public.distrib_quotidien ALTER COLUMN total_distribue TYPE REAL, ALTER COLUMN total_distribue DROP NOT NULL;

ALTER TABLE ONLY sturio.public.distribution ALTER COLUMN distribution_consigne TYPE VARCHAR, ALTER COLUMN distribution_consigne DROP NOT NULL;
COMMENT ON COLUMN sturio.public.distribution.distribution_consigne IS 'Consignes de distribution';

ALTER TABLE ONLY sturio.public.distribution ALTER COLUMN evol_taux_nourrissage TYPE REAL, ALTER COLUMN evol_taux_nourrissage DROP NOT NULL;

ALTER TABLE ONLY sturio.public.distribution ALTER COLUMN ration_commentaire TYPE VARCHAR, ALTER COLUMN ration_commentaire DROP NOT NULL;
COMMENT ON COLUMN sturio.public.distribution.ration_commentaire IS 'Commentaires sur la manière dont la ration a été consommée';

ALTER TABLE ONLY sturio.public.distribution ALTER COLUMN reste_total TYPE REAL, ALTER COLUMN reste_total DROP NOT NULL;

ALTER TABLE ONLY sturio.public.distribution ALTER COLUMN reste_zone_calcul TYPE VARCHAR, ALTER COLUMN reste_zone_calcul DROP NOT NULL;

ALTER TABLE ONLY sturio.public.distribution ALTER COLUMN taux_nourrissage TYPE REAL, ALTER COLUMN taux_nourrissage DROP NOT NULL;

ALTER TABLE ONLY sturio.public.distribution ALTER COLUMN taux_reste TYPE REAL, ALTER COLUMN taux_reste DROP NOT NULL;

ALTER TABLE ONLY sturio.public.distribution ALTER COLUMN total_distribue TYPE REAL, ALTER COLUMN total_distribue DROP NOT NULL;

ALTER TABLE ONLY sturio.public.document ALTER COLUMN document_description TYPE VARCHAR, ALTER COLUMN document_description DROP NOT NULL;

ALTER TABLE ONLY sturio.public.document ALTER COLUMN document_nom TYPE VARCHAR, ALTER COLUMN document_nom SET NOT NULL;

ALTER TABLE ONLY sturio.public.evenement_type ALTER COLUMN evenement_type_actif TYPE SMALLINT, ALTER COLUMN evenement_type_actif SET NOT NULL;

ALTER TABLE ONLY sturio.public.evenement_type ALTER COLUMN evenement_type_libelle TYPE VARCHAR, ALTER COLUMN evenement_type_libelle SET NOT NULL;

ALTER TABLE ONLY sturio.public.gender_methode ALTER COLUMN gender_methode_libelle TYPE VARCHAR, ALTER COLUMN gender_methode_libelle SET NOT NULL;

ALTER TABLE ONLY sturio.public.gender_selection ALTER COLUMN gender_selection_commentaire TYPE VARCHAR, ALTER COLUMN gender_selection_commentaire DROP NOT NULL;

CREATE SEQUENCE sturio.public.laboratoire_analyse_laboratoire_analyse_id_seq;

CREATE TABLE sturio.public.laboratoire_analyse (
                laboratoire_analyse_id INTEGER NOT NULL DEFAULT nextval('sturio.public.laboratoire_analyse_laboratoire_analyse_id_seq'),
                laboratoire_analyse_libelle VARCHAR NOT NULL,
                actif SMALLINT DEFAULT 1 NOT NULL,
                CONSTRAINT laboratoire_analyse_pk PRIMARY KEY (laboratoire_analyse_id)
);
COMMENT ON TABLE sturio.public.laboratoire_analyse IS 'Table des laboratoires d''analyse de l''eau';
COMMENT ON COLUMN sturio.public.laboratoire_analyse.laboratoire_analyse_libelle IS 'Nom du laboratoire';
COMMENT ON COLUMN sturio.public.laboratoire_analyse.actif IS '0 : non sollicité actuellement
1 : laboratoire sollicité actuellement';


ALTER SEQUENCE sturio.public.laboratoire_analyse_laboratoire_analyse_id_seq OWNED BY sturio.public.laboratoire_analyse.laboratoire_analyse_id;

ALTER TABLE ONLY sturio.public.mime_type ALTER COLUMN content_type TYPE VARCHAR, ALTER COLUMN content_type SET NOT NULL;

ALTER TABLE ONLY sturio.public.mime_type ALTER COLUMN extension TYPE VARCHAR, ALTER COLUMN extension SET NOT NULL;

ALTER TABLE ONLY sturio.public.morphologie ALTER COLUMN longueur_fourche TYPE REAL, ALTER COLUMN longueur_fourche DROP NOT NULL;

ALTER TABLE ONLY sturio.public.morphologie ALTER COLUMN longueur_totale TYPE REAL, ALTER COLUMN longueur_totale DROP NOT NULL;

ALTER TABLE ONLY sturio.public.morphologie ALTER COLUMN masse TYPE REAL, ALTER COLUMN masse DROP NOT NULL;

ALTER TABLE ONLY sturio.public.morphologie ALTER COLUMN morphologie_commentaire TYPE VARCHAR, ALTER COLUMN morphologie_commentaire DROP NOT NULL;

ALTER TABLE ONLY sturio.public.mortalite ALTER COLUMN mortalite_commentaire TYPE VARCHAR, ALTER COLUMN mortalite_commentaire DROP NOT NULL;

ALTER TABLE ONLY sturio.public.mortalite_type ALTER COLUMN mortalite_type_libelle TYPE VARCHAR, ALTER COLUMN mortalite_type_libelle SET NOT NULL;

ALTER TABLE ONLY sturio.public.pathologie ALTER COLUMN pathologie_commentaire TYPE VARCHAR, ALTER COLUMN pathologie_commentaire DROP NOT NULL;

ALTER TABLE ONLY sturio.public.pathologie ALTER COLUMN pathologie_valeur TYPE REAL, ALTER COLUMN pathologie_valeur DROP NOT NULL;

ALTER TABLE ONLY sturio.public.pathologie_type ALTER COLUMN pathologie_type_libelle TYPE VARCHAR, ALTER COLUMN pathologie_type_libelle SET NOT NULL;

ALTER TABLE ONLY sturio.public.pathologie_type ALTER COLUMN pathologie_type_libelle_court TYPE VARCHAR, ALTER COLUMN pathologie_type_libelle_court DROP NOT NULL;

ALTER TABLE ONLY sturio.public.pittag ALTER COLUMN pittag_commentaire TYPE VARCHAR, ALTER COLUMN pittag_commentaire DROP NOT NULL;

ALTER TABLE ONLY sturio.public.pittag_type ALTER COLUMN pittag_type_libelle TYPE VARCHAR, ALTER COLUMN pittag_type_libelle SET NOT NULL;

ALTER TABLE ONLY sturio.public.poisson ALTER COLUMN cohorte TYPE VARCHAR, ALTER COLUMN cohorte DROP NOT NULL;

ALTER TABLE ONLY sturio.public.poisson ALTER COLUMN matricule TYPE VARCHAR, ALTER COLUMN matricule DROP NOT NULL;

ALTER TABLE ONLY sturio.public.poisson ALTER COLUMN prenom TYPE VARCHAR, ALTER COLUMN prenom DROP NOT NULL;

ALTER TABLE ONLY sturio.public.poisson_statut ALTER COLUMN poisson_statut_libelle TYPE VARCHAR, ALTER COLUMN poisson_statut_libelle SET NOT NULL;

ALTER TABLE ONLY sturio.public.repart_aliment ALTER COLUMN consigne TYPE VARCHAR, ALTER COLUMN consigne DROP NOT NULL;

ALTER TABLE ONLY sturio.public.repart_aliment ALTER COLUMN matin TYPE REAL, ALTER COLUMN matin DROP NOT NULL;

ALTER TABLE ONLY sturio.public.repart_aliment ALTER COLUMN midi TYPE REAL, ALTER COLUMN midi DROP NOT NULL;

ALTER TABLE ONLY sturio.public.repart_aliment ALTER COLUMN nuit TYPE REAL, ALTER COLUMN nuit DROP NOT NULL;

ALTER TABLE ONLY sturio.public.repart_aliment ALTER COLUMN repart_alim_taux TYPE REAL, ALTER COLUMN repart_alim_taux DROP NOT NULL;

ALTER TABLE ONLY sturio.public.repart_aliment ALTER COLUMN soir TYPE REAL, ALTER COLUMN soir DROP NOT NULL;

ALTER TABLE ONLY sturio.public.repart_template ALTER COLUMN actif TYPE SMALLINT, ALTER COLUMN actif SET NOT NULL;

ALTER TABLE ONLY sturio.public.repart_template ALTER COLUMN repart_template_libelle TYPE VARCHAR, ALTER COLUMN repart_template_libelle DROP NOT NULL;

ALTER TABLE ONLY sturio.public.repartition ALTER COLUMN dimanche TYPE SMALLINT, ALTER COLUMN dimanche DROP NOT NULL;

ALTER TABLE ONLY sturio.public.repartition ALTER COLUMN jeudi TYPE SMALLINT, ALTER COLUMN jeudi DROP NOT NULL;

ALTER TABLE ONLY sturio.public.repartition ALTER COLUMN lundi TYPE SMALLINT, ALTER COLUMN lundi DROP NOT NULL;

ALTER TABLE ONLY sturio.public.repartition ALTER COLUMN mardi TYPE SMALLINT, ALTER COLUMN mardi DROP NOT NULL;

ALTER TABLE ONLY sturio.public.repartition ALTER COLUMN mercredi TYPE SMALLINT, ALTER COLUMN mercredi DROP NOT NULL;

ALTER TABLE ONLY sturio.public.repartition ALTER COLUMN samedi TYPE SMALLINT, ALTER COLUMN samedi DROP NOT NULL;

ALTER TABLE ONLY sturio.public.repartition ALTER COLUMN vendredi TYPE SMALLINT, ALTER COLUMN vendredi DROP NOT NULL;

ALTER TABLE ONLY sturio.public.sexe ALTER COLUMN sexe_libelle TYPE VARCHAR, ALTER COLUMN sexe_libelle SET NOT NULL;

ALTER TABLE ONLY sturio.public.sexe ALTER COLUMN sexe_libelle_court TYPE VARCHAR, ALTER COLUMN sexe_libelle_court SET NOT NULL;


ALTER TABLE sturio.public.bassin_evenement ADD CONSTRAINT bassin_bassin_evenement_fk
FOREIGN KEY (bassin_id)
REFERENCES sturio.public.bassin (bassin_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.bassin_evenement ADD CONSTRAINT bassin_evenement_type_bassin_evenement_fk
FOREIGN KEY (bassin_evenement_type_id)
REFERENCES sturio.public.bassin_evenement_type (bassin_evenement_type_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.analyse_eau ADD CONSTRAINT laboratoire_analyse_analyse_eau_fk
FOREIGN KEY (laboratoire_analyse_id)
REFERENCES sturio.public.laboratoire_analyse (laboratoire_analyse_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

alter table laboratoire_analyse rename column actif to laboratoire_analyse_actif;
