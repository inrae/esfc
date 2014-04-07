

ALTER TABLE sturio.public.document DROP CONSTRAINT evenement_document_fk;

ALTER TABLE sturio.public.document DROP CONSTRAINT poisson_document_fk;

ALTER TABLE ONLY sturio.public.aliment ALTER COLUMN actif TYPE SMALLINT, ALTER COLUMN actif SET NOT NULL;

ALTER TABLE ONLY sturio.public.aliment ALTER COLUMN aliment_libelle TYPE VARCHAR, ALTER COLUMN aliment_libelle SET NOT NULL;

ALTER TABLE ONLY sturio.public.aliment_quotidien ALTER COLUMN quantite TYPE REAL, ALTER COLUMN quantite DROP NOT NULL;

ALTER TABLE ONLY sturio.public.aliment_type ALTER COLUMN aliment_type_libelle TYPE VARCHAR, ALTER COLUMN aliment_type_libelle SET NOT NULL;

ALTER TABLE ONLY sturio.public.analyse_eau ALTER COLUMN backwash_biologique TYPE SMALLINT, ALTER COLUMN backwash_biologique SET NOT NULL;
COMMENT ON COLUMN sturio.public.analyse_eau.backwash_biologique IS '0 : non effectué
1 : effectué';

ALTER TABLE ONLY sturio.public.analyse_eau ALTER COLUMN backwash_biologique_commentaire TYPE VARCHAR, ALTER COLUMN backwash_biologique_commentaire DROP NOT NULL;

ALTER TABLE ONLY sturio.public.analyse_eau ALTER COLUMN backwash_mecanique TYPE SMALLINT, ALTER COLUMN backwash_mecanique DROP NOT NULL;

ALTER TABLE ONLY sturio.public.analyse_eau ALTER COLUMN debit_eau_forage TYPE REAL, ALTER COLUMN debit_eau_forage DROP NOT NULL;

ALTER TABLE ONLY sturio.public.analyse_eau ALTER COLUMN debit_eau_riviere TYPE REAL, ALTER COLUMN debit_eau_riviere DROP NOT NULL;

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

CREATE TABLE sturio.public.bassin_document (
                bassin_id INTEGER NOT NULL,
                document_id INTEGER NOT NULL,
                CONSTRAINT bassin_document_pk PRIMARY KEY (bassin_id, document_id)
);
COMMENT ON TABLE sturio.public.bassin_document IS 'Table de liaison des bassins avec les documents';


ALTER TABLE ONLY sturio.public.bassin_evenement ALTER COLUMN bassin_evenement_commentaire TYPE VARCHAR, ALTER COLUMN bassin_evenement_commentaire DROP NOT NULL;

ALTER TABLE ONLY sturio.public.bassin_evenement_type ALTER COLUMN bassin_evenement_type_libelle TYPE VARCHAR, ALTER COLUMN bassin_evenement_type_libelle SET NOT NULL;

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

ALTER TABLE ONLY sturio.public.distribution ALTER COLUMN distribution_jour TYPE VARCHAR, ALTER COLUMN distribution_jour DROP NOT NULL;
COMMENT ON COLUMN sturio.public.distribution.distribution_jour IS 'Jour de distribution, selon la forme :
1,1,1,1,1,1,1
Le premier chiffre correspond au lundi';

ALTER TABLE ONLY sturio.public.distribution ALTER COLUMN evol_taux_nourrissage TYPE REAL, ALTER COLUMN evol_taux_nourrissage DROP NOT NULL;

ALTER TABLE ONLY sturio.public.distribution ALTER COLUMN ration_commentaire TYPE VARCHAR, ALTER COLUMN ration_commentaire DROP NOT NULL;

ALTER TABLE ONLY sturio.public.distribution ALTER COLUMN reste_total TYPE REAL, ALTER COLUMN reste_total DROP NOT NULL;

ALTER TABLE ONLY sturio.public.distribution ALTER COLUMN reste_zone_calcul TYPE VARCHAR, ALTER COLUMN reste_zone_calcul DROP NOT NULL;

ALTER TABLE ONLY sturio.public.distribution ALTER COLUMN taux_nourrissage TYPE REAL, ALTER COLUMN taux_nourrissage DROP NOT NULL;

ALTER TABLE ONLY sturio.public.distribution ALTER COLUMN taux_reste TYPE REAL, ALTER COLUMN taux_reste DROP NOT NULL;

ALTER TABLE ONLY sturio.public.distribution ALTER COLUMN total_distribue TYPE REAL, ALTER COLUMN total_distribue DROP NOT NULL;

ALTER TABLE sturio.public.document ADD COLUMN data BYTEA;

ALTER TABLE ONLY sturio.public.document ALTER COLUMN document_description TYPE VARCHAR, ALTER COLUMN document_description DROP NOT NULL;
COMMENT ON COLUMN sturio.public.document.document_description IS 'Description libre du document';

ALTER TABLE ONLY sturio.public.document ALTER COLUMN document_nom TYPE VARCHAR, ALTER COLUMN document_nom SET NOT NULL;

ALTER TABLE sturio.public.document DROP COLUMN evenement_id;

ALTER TABLE sturio.public.document DROP COLUMN poisson_id;

ALTER TABLE sturio.public.document ADD COLUMN size INTEGER;

ALTER TABLE sturio.public.document ADD COLUMN thumbnail BYTEA;

CREATE TABLE sturio.public.evenement_document (
                evenement_id INTEGER NOT NULL,
                document_id INTEGER NOT NULL,
                CONSTRAINT evenement_document_pk PRIMARY KEY (evenement_id, document_id)
);
COMMENT ON TABLE sturio.public.evenement_document IS 'Table de liaison des événements avec des documents';


ALTER TABLE ONLY sturio.public.evenement_type ALTER COLUMN evenement_type_actif TYPE SMALLINT, ALTER COLUMN evenement_type_actif SET NOT NULL;

ALTER TABLE ONLY sturio.public.evenement_type ALTER COLUMN evenement_type_libelle TYPE VARCHAR, ALTER COLUMN evenement_type_libelle SET NOT NULL;

ALTER TABLE ONLY sturio.public.gender_methode ALTER COLUMN gender_methode_libelle TYPE VARCHAR, ALTER COLUMN gender_methode_libelle SET NOT NULL;

ALTER TABLE ONLY sturio.public.gender_selection ALTER COLUMN gender_selection_commentaire TYPE VARCHAR, ALTER COLUMN gender_selection_commentaire DROP NOT NULL;

ALTER TABLE ONLY sturio.public.laboratoire_analyse ALTER COLUMN laboratoire_analyse_actif TYPE SMALLINT, ALTER COLUMN laboratoire_analyse_actif SET NOT NULL;

ALTER TABLE ONLY sturio.public.laboratoire_analyse ALTER COLUMN laboratoire_analyse_libelle TYPE VARCHAR, ALTER COLUMN laboratoire_analyse_libelle SET NOT NULL;
COMMENT ON TABLE sturio.public.mime_type IS 'Table des types mime, pour les documents associés';

ALTER TABLE ONLY sturio.public.mime_type ALTER COLUMN content_type TYPE VARCHAR, ALTER COLUMN content_type SET NOT NULL;

ALTER TABLE ONLY sturio.public.mime_type ALTER COLUMN extension TYPE VARCHAR, ALTER COLUMN extension SET NOT NULL;
COMMENT ON COLUMN sturio.public.mime_type.extension IS 'Extension du fichier correspondant';

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

CREATE TABLE sturio.public.poisson_document (
                poisson_id INTEGER NOT NULL,
                document_id INTEGER NOT NULL,
                CONSTRAINT poisson_document_pk PRIMARY KEY (poisson_id, document_id)
);
COMMENT ON TABLE sturio.public.poisson_document IS 'Table de liaison des poissons avec les documents';


ALTER TABLE ONLY sturio.public.poisson_statut ALTER COLUMN poisson_statut_libelle TYPE VARCHAR, ALTER COLUMN poisson_statut_libelle SET NOT NULL;

ALTER TABLE ONLY sturio.public.repart_aliment ALTER COLUMN consigne TYPE VARCHAR, ALTER COLUMN consigne DROP NOT NULL;

ALTER TABLE ONLY sturio.public.repart_aliment ALTER COLUMN matin TYPE REAL, ALTER COLUMN matin DROP NOT NULL;

ALTER TABLE ONLY sturio.public.repart_aliment ALTER COLUMN midi TYPE REAL, ALTER COLUMN midi DROP NOT NULL;

ALTER TABLE ONLY sturio.public.repart_aliment ALTER COLUMN nuit TYPE REAL, ALTER COLUMN nuit DROP NOT NULL;

ALTER TABLE ONLY sturio.public.repart_aliment ALTER COLUMN repart_alim_taux TYPE REAL, ALTER COLUMN repart_alim_taux DROP NOT NULL;

ALTER TABLE ONLY sturio.public.repart_aliment ALTER COLUMN soir TYPE REAL, ALTER COLUMN soir DROP NOT NULL;

ALTER TABLE ONLY sturio.public.repart_template ALTER COLUMN actif TYPE SMALLINT, ALTER COLUMN actif SET NOT NULL;

ALTER TABLE ONLY sturio.public.repart_template ALTER COLUMN repart_template_libelle TYPE VARCHAR, ALTER COLUMN repart_template_libelle DROP NOT NULL;

ALTER TABLE ONLY sturio.public.sexe ALTER COLUMN sexe_libelle TYPE VARCHAR, ALTER COLUMN sexe_libelle SET NOT NULL;

ALTER TABLE ONLY sturio.public.sexe ALTER COLUMN sexe_libelle_court TYPE VARCHAR, ALTER COLUMN sexe_libelle_court SET NOT NULL;


ALTER TABLE sturio.public.bassin_document ADD CONSTRAINT bassin_bassin_document_fk
FOREIGN KEY (bassin_id)
REFERENCES sturio.public.bassin (bassin_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.bassin_document ADD CONSTRAINT document_bassin_document_fk
FOREIGN KEY (document_id)
REFERENCES sturio.public.document (document_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.evenement_document ADD CONSTRAINT document_evenement_document_fk
FOREIGN KEY (document_id)
REFERENCES sturio.public.document (document_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.poisson_document ADD CONSTRAINT document_poisson_document_fk
FOREIGN KEY (document_id)
REFERENCES sturio.public.document (document_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.evenement_document ADD CONSTRAINT evenement_evenement_document_fk
FOREIGN KEY (evenement_id)
REFERENCES sturio.public.evenement (evenement_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.poisson_document ADD CONSTRAINT poisson_poisson_document_fk
FOREIGN KEY (poisson_id)
REFERENCES sturio.public.poisson (poisson_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
