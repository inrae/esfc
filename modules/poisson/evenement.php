<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 25 févr. 2014
 */
include_once 'modules/classes/evenement.class.php';
$dataClass = new Evenement($bdd, $ObjetBDDParam);
$keyName = "evenement_id";
$id = $_REQUEST[$keyName];
switch ($t_module["param"]) {
    case "list":
        break;
    case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->lire($id);
        $smarty->assign("data", $data);
        $smarty->assign("corps", "example/exampleDisplay.tpl");
        break;
    case "change":
        if ($_REQUEST["poisson_id"] > 0) {
            /*
             * open the form to modify the record If is a new record, generate a new record with default value : $_REQUEST["idParent"] contains the identifiant of the parent record
             */
            /*
             * Passage en parametre de la liste parente
             */
            $smarty->assign("poissonDetailParent", $_SESSION["poissonDetailParent"]);
            
            /*
             * Lecture des tables de parametres necessaires a la saisie
             */
            include_once 'modules/classes/poisson.class.php';
            include_once 'modules/classes/bassin.class.php';
            require_once 'modules/classes/dosageSanguin.class.php';
            $evenement_type = new Evenement_type($bdd, $ObjetBDDParam);
            $smarty->assign("evntType", $evenement_type->getListe(2));
            $pathologie_type = new Pathologie_type($bdd, $ObjetBDDParam);
            $smarty->assign("pathoType", $pathologie_type->getListe(2));
            $gender_methode = new Gender_methode($bdd, $ObjetBDDParam);
            $smarty->assign("genderMethode", $gender_methode->getListe(1));
            $sexe = new Sexe($bdd, $ObjetBDDParam);
            $smarty->assign("sexe", $sexe->getListe(1));
            $bassin = new Bassin($bdd, $ObjetBDDParam);
            $smarty->assign("bassinList", $bassin->getListe());
            $smarty->assign("bassinListActif", $bassin->getListe(1));
            $mortalite_type = new Mortalite_type($bdd, $ObjetBDDParam);
            $smarty->assign("mortaliteType", $mortalite_type->getListe(2));
            $cohorte_type = new Cohorte_type($bdd, $ObjetBDDParam);
            $smarty->assign("cohorteType", $cohorte_type->getListe(2));
            $sortie_lieu = new SortieLieu($bdd, $ObjetBDDParam);
            $smarty->assign("sortieLieu", $sortie_lieu->getListeActif(1));
            $anesthesie_produit = new Anesthesie_produit($bdd, $ObjetBDDParam);
            $dataProduit = $anesthesie_produit->getListeActif(1);
            dataRead($dataClass, $id, "poisson/evenementChange.tpl", $_REQUEST["poisson_id"]);
            $nageoire = new Nageoire($bdd, $ObjetBDDParam);
            $smarty->assign("nageoire", $nageoire->getListe(1));
            $determinationParente = new DeterminationParente($bdd, $ObjetBDDParam);
            $smarty->assign("determinationParente", $determinationParente->getListe(1));
            
            /*
             * Tables des stades de maturation des oeufs ou gonades
             */
            require_once 'modules/classes/stadeGonade.class.php';
            require_once 'modules/classes/stadeOeuf.class.php';
            $stadeGonade = new StadeGonade($bdd, $ObjetBDDParam);
            $stadeOeuf = new StadeOeuf($bdd, $ObjetBDDParam);
            $smarty->assign("gonades", $stadeGonade->getListe(1));
            $smarty->assign("oeufs", $stadeOeuf->getListe(1));
            /*
             * Lecture du poisson
             */
            $poisson = new Poisson($bdd, $ObjetBDDParam);
            $dataPoisson = $poisson->getDetail($_REQUEST["poisson_id"]);
            $smarty->assign("dataPoisson", $dataPoisson);
            $dataTransfert = array();
            /*
             * Lecture des tables associees
             */
            if ($id > 0) {
                $morphologie = new Morphologie($bdd, $ObjetBDDParam);
                $smarty->assign("dataMorpho", $morphologie->getDataByEvenement($id));
                $pathologie = new Pathologie($bdd, $ObjetBDDParam);
                $smarty->assign("dataPatho", $pathologie->getDataByEvenement($id));
                $genderSelection = new Gender_selection($bdd, $ObjetBDDParam);
                $smarty->assign("dataGender", $genderSelection->getDataByEvenement($id));
                $mortalite = new Mortalite($bdd, $ObjetBDDParam);
                $smarty->assign("dataMortalite", $mortalite->getDataByEvenement($id));
                $cohorte = new Cohorte($bdd, $ObjetBDDParam);
                $smarty->assign("dataCohorte", $cohorte->getDataByEvenement($id));
                $sortie = new Sortie($bdd, $ObjetBDDParam);
                $smarty->assign("dataSortie", $sortie->getDataByEvenement($id));
                $echographie = new Echographie($bdd, $ObjetBDDParam);
                $smarty->assign("dataEcho", $echographie->getDataByEvenement($id));
                $anesthesie = new Anesthesie($bdd, $ObjetBDDParam);
                $dataAnesthesie = $anesthesie->getDataByEvenement($id);
                $dosageSanguin = new DosageSanguin($bdd, $ObjetBDDParam);
                $smarty->assign("dataDosageSanguin", $dosageSanguin->getDataByEvenement($id));
                $genetique = new Genetique($bdd, $ObjetBDDParam);
                $smarty->assign("dataGenetique", $genetique->getDataByEvenement($id));
                $smarty->assign("dataAnesthesie", $dataAnesthesie);
                $parente = new Parente($bdd, $ObjetBDDParam);
                $smarty->assign("dataParente", $parente->getDataByEvenement($id));
                
                /*
                 * Recherche si le produit est toujours utilise
                 */
                if (isset($dataAnesthesie["anesthesie_produit_id"])) {
                    $is_found = false;
                    foreach ($dataProduit as $key => $value) {
                        if ($value["anesthesie_produit_id"] == $dataAnesthesie["anesthesie_produit_id"])
                            $is_found = true;
                    }
                    if ($is_found == false) {
                        $dataProduit[] = array(
                            $dataAnesthesie["anesthesie_produit_id"],
                            $dataAnesthesie["anesthesie_produit_libelle"]
                        );
                    }
                }
                $smarty->assign("produit", $dataProduit);
                
                /*
                 * Traitement particulier du transfert
                 */
                $transfert = new Transfert($bdd, $ObjetBDDParam);
                $dataTransfert = $transfert->getDataByEvenement($id);
            }
            
            if ($dataPoisson["bassin_id"] > 0) {
                $dataTransfert["dernier_bassin_connu"] = $dataPoisson["bassin_id"];
                $dataTransfert["dernier_bassin_connu_libelle"] = $dataPoisson["bassin_nom"];
            }
            $smarty->assign("dataTransfert", $dataTransfert);
            /*
             * Gestion des documents associes
             */
            $smarty->assign("moduleParent", "evenementChange");
            $smarty->assign("parentType", "evenement");
            $smarty->assign("parentIdName", "evenement_id");
            $smarty->assign("parent_id", $id);
            require_once 'modules/document/documentFunctions.php';
            $smarty->assign("dataDoc", getListeDocument("evenement", $id, $_REQUEST["document_limit"], $_REQUEST["document_offset"]));
        }
        break;
    case "write":
		/*
		 * write record in database
		 */
		$id = dataWrite($dataClass, $_REQUEST);
        if ($id > 0) {
            $_REQUEST[$keyName] = $id;
            /*
             * Ecriture des informations complementaires
             */
            include_once 'modules/classes/poisson.class.php';
            include_once 'modules/classes/bassin.class.php';
            /*
             * Morphologie
             */
            if ($_REQUEST["longueur_fourche"] > 0 || $_REQUEST["longueur"] > 0 || $_REQUEST["masse"] > 0 || $_REQUEST["circonference"] > 0 || strlen($_REQUEST["morphologie_commentaire"]) > 0) {
                $morphologie = new Morphologie($bdd, $ObjetBDDParam);
                $_REQUEST["morphologie_date"] = $_REQUEST["evenement_date"];
                $morpho_id = $morphologie->ecrire($_REQUEST);
                if (! $morpho_id > 0) {
                    $message .= formatErrorData($morphologie->getErrorData());
                    $message .= $LANG["message"][12];
                    $module_coderetour = - 1;
                }
            }
            /*
             * Pathologie
             */
            if ($_REQUEST["pathologie_type_id"] > 0) {
                $pathologie = new Pathologie($bdd, $ObjetBDDParam);
                $_REQUEST["pathologie_date"] = $_REQUEST["evenement_date"];
                $patho_id = $pathologie->ecrire($_REQUEST);
                if (! $patho_id > 0) {
                    $message .= formatErrorData($pathologie->getErrorData());
                    $message .= $LANG["message"][12];
                    $module_coderetour = - 1;
                }
            }
            /*
             * Sexage
             */
            if ($_REQUEST["gender_methode_id"] > 0 && $_REQUEST["sexe_id"] > 0) {
                $genderSelection = new Gender_selection($bdd, $ObjetBDDParam);
                $_REQUEST["gender_selection_date"] = $_REQUEST["evenement_date"];
                $gender_id = $genderSelection->ecrire($_REQUEST);
                if (! $gender_id > 0) {
                    $message .= formatErrorData($genderSelection->getErrorData());
                    $message .= $LANG["message"][12];
                    $module_coderetour = - 1;
                }
            }
            /*
             * Transfert
             */
            if ($_REQUEST["bassin_destination"] > 0) {
                $transfert = new Transfert($bdd, $ObjetBDDParam);
                $_REQUEST["transfert_date"] = $_REQUEST["evenement_date"];
                $transfert_id = $transfert->ecrire($_REQUEST);
                if (! $transfert_id > 0) {
                    $message .= formatErrorData($transfert->getErrorData());
                    $message .= $LANG["message"][12];
                    $module_coderetour = - 1;
                }
            }
            /*
             * Mortalite
             */
            if ($_REQUEST["mortalite_type_id"] > 0) {
                $mortalite = new Mortalite($bdd, $ObjetBDDParam);
                $_REQUEST["mortalite_date"] = $_REQUEST["evenement_date"];
                $mortalite_id = $mortalite->ecrire($_REQUEST);
                if (! $mortalite_id > 0) {
                    $message .= formatErrorData($mortalite->getErrorData());
                    $message .= $LANG["message"][12];
                    $module_coderetour = - 1;
                }
            }
            /*
             * Cohorte
             */
            if ($_REQUEST["cohorte_type_id"] > 0) {
                $cohorte = new Cohorte($bdd, $ObjetBDDParam);
                $_REQUEST["cohorte_date"] = $_REQUEST["evenement_date"];
                $cohorte_id = $cohorte->ecrire($_REQUEST);
                if (! $cohorte_id > 0) {
                    $message .= formatErrorData($cohorte->getErrorData());
                    $message .= $LANG["message"][12];
                    $module_coderetour = - 1;
                }
            }
            /*
             * Sortie
             */
            if ($_REQUEST["sortie_lieu_id"] > 0) {
                $sortie = new Sortie($bdd, $ObjetBDDParam);
                $_REQUEST["sortie_date"] = $_REQUEST["evenement_date"];
                $sortie_id = $sortie->ecrire($_REQUEST);
                if (! $sortie_id > 0) {
                    $message .= formatErrorData($sortie->getErrorData());
                    $message .= $LANG["message"][12];
                    $module_coderetour = - 1;
                }
            }
            /*
             * Echographie
             */
            if (strlen($_REQUEST["echographie_commentaire"]) > 0 || $_REQUEST["stade_gonade_id"] > 0 || $_REQUEST["stade_oeuf_id"] > 0 || $_FILES["documentName"]['error'] == 0 || $_FILES["documentName"]['error'][0] == 0) {
                $echographie = new Echographie($bdd, $ObjetBDDParam);
                $_REQUEST["echographie_date"] = $_REQUEST["evenement_date"];
                $echographie_id = $echographie->ecrire($_REQUEST);
                if (! $echographie_id > 0) {
                    $message .= formatErrorData($echographie->getErrorData());
                    $message .= $LANG["message"][12];
                    $module_coderetour = - 1;
                }
                /*
                 * Traitement des photos a importer
                 */
                if ($echographie_id > 0 && isset($_FILES["documentName"])) {
                    require_once 'modules/document/documentFunctions.php';
                    /*
                     * Preparation de files
                     */
                    $files = formatFiles();
                    $documentSturio = new DocumentSturio($bdd, $ObjetBDDParam);
                    foreach ($files as $file) {
                        $document_id = $documentSturio->ecrire($file, $_REQUEST["document_description"]);
                        if ($document_id > 0) {
                            /*
                             * Ecriture de l'enregistrement en table liee
                             */
                            $documentLie = new DocumentLie($bdd, $ObjetBDDParam, 'evenement');
                            $data = array(
                                "document_id" => $document_id,
                                "evenement_id" => $id
                            );
                            $documentLie->ecrire($data);
                        }
                    }
                }
            }
            /*
             * Anesthesie
             */
            if ($_REQUEST["anesthesie_produit_id"] > 0) {
                $anesthesie = new Anesthesie($bdd, $ObjetBDDParam);
                $_REQUEST["anesthesie_date"] = $_REQUEST["evenement_date"];
                $anesthesie_id = $anesthesie->ecrire($_REQUEST);
                if (! $anesthesie_id > 0) {
                    $message .= formatErrorData($anesthesie->getErrorData());
                    $message .= $LANG["message"][12];
                    $module_coderetour = - 1;
                }
            }
            /*
             * Dosage sanguin
             */
            $fields = array(
                "tx_e2",
                "tx_e2_texte",
                "tx_calcium",
                "tx_hematocrite",
                "dosage_sanguin_commentaire"
            );
            $flag = false;
            foreach ($fields as $field) {
                if (strlen($_REQUEST[$field]) > 0)
                    $flag = true;
            }
            if ($flag == true) {
                require_once 'modules/classes/dosageSanguin.class.php';
                $_REQUEST["dosage_sanguin_date"] = $_REQUEST["evenement_date"];
                $dosageSanguin = new DosageSanguin($bdd, $ObjetBDDParam);
                $dosage_sanguin_id = $dosageSanguin->ecrire($_REQUEST);
                if (! $dosage_sanguin_id > 0) {
                    $message .= formatErrorData($dosageSanguin->getErrorData());
                    $message .= $LANG["message"][12];
                    $module_coderetour = - 1;
                }
            }
            /*
             * Prelevement genetique
             */
            if (strlen($_REQUEST["genetique_reference"]) > 0) {
                $_REQUEST["genetique_date"] = $_REQUEST["evenement_date"];
                $genetique = new Genetique($bdd, $ObjetBDDParam);
                $genetique_id = $genetique->ecrire($_REQUEST);
                if (! $genetique_id > 0) {
                    $message .= formatErrorData($genetique->getErrorData());
                    $message .= $LANG["message"][12];
                    $module_coderetour = - 1;
                }
            }
            
            /*
             * Determination de parente
             */
            if ($_REQUEST["determination_parente_id"] > 0) {
                $_REQUEST["parente_date"] = $_REQUEST["evenement_date"];
                $parente = new Parente($bdd, $ObjetBDDParam);
                $parente_id = $parente->ecrire($_REQUEST);
                if (! $parente_id > 0) {
                    $message .= formatErrorData($parente->getErrorData());
                    $message .= $LANG["message"][12];
                    $module_coderetour = - 1;
                }
            }
            
            /*
             * Creation d'une nouvelle anomalie a traiter en cas de souci
             */
            if ($_REQUEST["anomalie_flag"] > 0) {
                include_once "modules/classes/anomalie.class.php";
                $anomalie = new Anomalie_db($bdd, $ObjetBDDParam);
                $_REQUEST["anomalie_id"] = 0;
                $_REQUEST["anomalie_db_date"] = $_REQUEST["evenement_date"];
                $_REQUEST["anomalie_db_statut"] = 0;
                $_REQUEST["anomalie_db_type_id"] = $_REQUEST["anomalie_flag"];
                $anomalie_id = $anomalie->ecrire($_REQUEST);
                if (! $anomalie_id > 0) {
                    $message .= formatErrorData($anomalie->getErrorData());
                    $message .= $LANG["message"][12];
                    $module_coderetour = - 1;
                }
            }
        }
        break;
    case "delete":
		/*
		 * delete record
		 */
		include_once "modules/classes/poisson.class.php";
        include_once 'modules/classes/anomalie.class.php';
        dataDelete($dataClass, $id);
        break;
    case "getAllCSV":
		/*
		 * Retourne la liste de tous les événements pour les poissons sélectionnés, 
		 * au format CSV
		 */	
		require_once 'modules/classes/export.class.php';
        $export = new Export();
        $data = $dataClass->getAllEvenements($searchPoisson->getParam());
        if (is_array($data)) {
            $export->exportCSVinit("sturio-evenements", "tab");
            /*
             * Preparation de la ligne d'entete
             */
            $entete = array();
            foreach ($data[0] as $key => $value) {
                $entete[] = $key;
            }
            $export->setLigneCSV($entete);
            /*
             * Envoi de toutes les lignes
             */
            foreach ($data as $key => $value) {
                $export->setLigneCSV($value);
            }
            /*
             * Envoi au navigateur
             */
            $export->exportCSV();
        }
        break;
}

?>