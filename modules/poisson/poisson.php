<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 25 févr. 2014
 */
include_once 'modules/classes/poisson.class.php';
$dataClass = new Poisson($bdd,$ObjetBDDParam);
$keyName = "poisson_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		/*
		 * $searchExample must be defined into modules/beforesession.inc.php :
		 * include_once 'modules/classes/searchParam.class.php';
		 * and into modules/common.inc.php :
		 * if (!isset($_SESSION["searchExample"])) {
		 * $searchExample = new SearchExample();
		 *	$_SESSION["searchExample"] = $searchExample;
		 *	} else {
		 *	$searchExample = $_SESSION["searchExample"];
		 *	}
		 * and, also, into modules/classes/searchParam.class.php...
		 */
		include "modules/poisson/poissonSearch.php";
		if ($searchPoisson->isSearch () == 1) {
			$data = $dataClass->getListeSearch ( $dataSearch );
			$vue->set($data , "data"); ( "",  );
		}
		$_SESSION["poissonDetailParent"] = "poissonList";
		$vue->set("poisson/poissonList.tpl" , "corps");("", );
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->getDetail($id);
		$vue->set( , "");("dataPoisson", $data);
		/*
		 * Passage en parametre de la liste parente
		 */
		$vue->set( , "");("poissonDetailParent", $_SESSION["poissonDetailParent"]);
		/*
		 * Recuperation des morphologies
		 */
		$morphologie = new Morphologie($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataMorpho", $morphologie->getListeByPoisson($id));
		/*
		 * Recuperation des événements
		 */
		include_once 'modules/classes/evenement.class.php';
		$evenement = new Evenement($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataEvenement",$evenement->getEvenementByPoisson($id));
		/*
		 * Recuperation du sexage
		 */
		$gender_selection = new Gender_selection($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataGender",$gender_selection->getListByPoisson($id));
		/*
		 * Recuperation des pathologies
		 */
		$pathologie = new Pathologie($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataPatho", $pathologie->getListByPoisson($id));
		/*
		 * Recuperation des pittag
		 */
		$pittag = new Pittag($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataPittag", $pittag->getListByPoisson($id));
		/*
		 * Recuperation des transferts
		 */
		$transfert = new Transfert($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataTransfert", $transfert->getListByPoisson($id));
		/*
		 * Recuperation des mortalites
		 */
		$mortalite = new Mortalite($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataMortalite", $mortalite->getListByPoisson($id));
		/*
		 * Recuperation des cohortes
		*/
		$cohorte = new Cohorte($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataCohorte", $cohorte->getListByPoisson($id));
		/*
		 * Recuperation des parents
		 */
		$parent = new Parent_poisson($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataParent", $parent->getListParent($id));
		/*
		 * Recuperation des anomalies
		 */
		include_once ("modules/classes/anomalie.class.php");
		$anomalie = new Anomalie_db($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataAnomalie", $anomalie->getListByPoisson($id));
		/*
		 * Recuperation des sorties
		 */
		$sortie = new Sortie($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataSortie", $sortie->getListByPoisson($id));
		/*
		 * Recuperation des echographies
		 */
		$echographie = new Echographie($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataEcho", $echographie->getListByPoisson($id));
		/*
		 * Recuperation des anesthesies
		 */
		$anesthesie = new Anesthesie($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataAnesthesie", $anesthesie->getListByPoisson($id));
		/*
		 * Recuperation des mesures de ventilation
		 */
		$ventilation = new Ventilation($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataVentilation", $ventilation->getListByPoisson($id));
		/*
		 * Recuperation des campagnes de reproduction
		 */
		require_once 'modules/classes/poissonRepro.class.php';
		$poissonCampagne = new PoissonCampagne($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataRepro", $poissonCampagne->getListFromPoisson($id));
		/*
		 * Recuperation des dosages sanguins
		 */
		require_once 'modules/classes/dosageSanguin.class.php';
		$dosageSanguin = new DosageSanguin($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataDosageSanguin", $dosageSanguin->getListeFromPoisson($id));
		
		/*
		 * Recuperation des prelevements genetiques
		 */
		$genetique = new Genetique($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataGenetique", $genetique->getListByPoisson($id));
		
		/*
		 * Recuperation des determinations de parente
		 */
		$parente = new Parente($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataParente", $parente->getListByPoisson($id));
		
		/*
		 * Gestion des documents associes
		*/
		$vue->set( , ""); ( "moduleParent", "poissonDisplay" );
		$vue->set( , ""); ( "parentType", "poisson" );
		$vue->set( , ""); ( "parentIdName", "poisson_id" );
		$vue->set( , ""); ( "parent_id", $id );
		require_once 'modules/document/documentFunctions.php';
		$vue->set( , "");("dataDoc", getListeDocument("poisson", $id, $_REQUEST["document_limit"], $_REQUEST["document_offset"]));
		/*
		 * Affichage
		 */
		$vue->set( , "");("corps", "poisson/poissonDisplay.tpl");
		/*
		 * Module de retour au poisson
		 */
		$_SESSION ["poissonParent"] = "poissonDisplay";
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		include_once "modules/classes/categorie.class.php";
		$data=dataRead($dataClass, $id, "poisson/poissonChange.tpl");
		$sexe = new Sexe($bdd, $ObjetBDDParam);
		$vue->set( , "");("sexe", $sexe->getListe(1));
		$poissonStatut = new Poisson_statut($bdd, $ObjetBDDParam);
		$vue->set( , "");("poissonStatut", $poissonStatut->getListe(1));
		$categorie = new Categorie($bdd, $ObjetBDDParam);
		$vue->set( , "");("categorie", $categorie->getListe(1));
		
		/*
		 * Modeles de marquages VIE, pour creation a partir des juveniles
		 */
		require_once "modules/classes/lot.class.php";
		$vieModele = new VieModele($bdd, $ObjetBDDParam);
		$vue->set( , "");("modeles", $vieModele->getAllModeles());
		/*
		 * Passage en parametre de la liste parente
		*/
		$vue->set( , "");("poissonDetailParent", $_SESSION["poissonDetailParent"]);
		
		/*
		 * Recuperation de la liste des types de pittag
		*/
		$pittagType = new Pittag_type($bdd, $ObjetBDDParam);
		$vue->set( , "");("pittagType", $pittagType->getListe(2));
		/*
		 * Recuperation du dernier pittag connu
		 */
		$pittag = new Pittag($bdd,$ObjetBDDParam);
		$vue->set( , "");("dataPittag", $pittag->getListByPoisson($id,1));
		break;
	case "write":
		/*
		 * write record in database
		 */
		$id = dataWrite($dataClass, $_REQUEST);
		if ($id > 0) {
			$_REQUEST[$keyName] = $id;
			/*
			 * Ecriture du pittag
			 */
			if (strlen($_REQUEST["pittag_valeur"]) > 0) {
				$pittag = new Pittag($bdd,$ObjetBDDParam);
				$idPittag = $pittag->ecrire($_REQUEST);
				if (! $idPittag > 0) {
					$module_coderetour = -1;
					$message.=$pittag->getErrorData());
					$message.=$LANG["message"][12];
				}
			}
		}
		break;
	case "delete":
		/*
		 * delete record
		 */
		dataDelete($dataClass, $id);
		break;
	case "getListeAjaxJson":
		/*
		 * retourne la liste des poissons a partir du libelle fourni
		 * au format JSON, en mode Ajax
		 */
		if (strlen($_REQUEST["libelle"]) > 0) {
			$data = $dataClass->getListPoissonFromName($_REQUEST["libelle"]);
			$dataJson = array();
			$i = 0;
			/*
			 * Mise en forme du tableau pour etre facile a manipuler cote client
			 */
			foreach ($data as $key => $value) {
				$dataJson[$i]["id"] = $value["poisson_id"];
				$valeur = "";
				$flag = 0;
				if (strlen($value["matricule"]) > 0 ) {
					$valeur = $value["matricule"];
					$flag = 1;
				}
				if (strlen($value["pittag_valeur"]) > 0 ) {
					if ($flag == 1) $valeur .= " - "; else $flag = 1;
					$valeur .= $value["pittag_valeur"];
				} 
				if (strlen($value["prenom"]) > 0 ) {
					if ($flag == 1) $valeur .= " - ";
					$valeur .= $value["prenom"];
				}
				$dataJson[$i]["val"] = $valeur;
				$i ++;
			}
			echo json_encode ($dataJson) ;
		}
		break;
}

?>