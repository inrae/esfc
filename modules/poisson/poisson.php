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
			$smarty->assign ( "data", $data );
		}
		$_SESSION["poissonDetailParent"] = "poissonList";
		$smarty->assign("corps", "poisson/poissonList.tpl");
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->getDetail($id);
		$smarty->assign("dataPoisson", $data);
		/*
		 * Passage en parametre de la liste parente
		 */
		$smarty->assign("poissonDetailParent", $_SESSION["poissonDetailParent"]);
		/*
		 * Recuperation des morphologies
		 */
		$morphologie = new Morphologie($bdd, $ObjetBDDParam);
		$smarty->assign("dataMorpho", $morphologie->getListeByPoisson($id));
		/*
		 * Recuperation des événements
		 */
		include_once 'modules/classes/evenement.class.php';
		$evenement = new Evenement($bdd, $ObjetBDDParam);
		$smarty->assign("dataEvenement",$evenement->getEvenementByPoisson($id));
		/*
		 * Recuperation du sexage
		 */
		$gender_selection = new Gender_selection($bdd, $ObjetBDDParam);
		$smarty->assign("dataGender",$gender_selection->getListByPoisson($id));
		/*
		 * Recuperation des pathologies
		 */
		$pathologie = new Pathologie($bdd, $ObjetBDDParam);
		$smarty->assign("dataPatho", $pathologie->getListByPoisson($id));
		/*
		 * Recuperation des pittag
		 */
		$pittag = new Pittag($bdd, $ObjetBDDParam);
		$smarty->assign("dataPittag", $pittag->getListByPoisson($id));
		/*
		 * Recuperation des transferts
		 */
		$transfert = new Transfert($bdd, $ObjetBDDParam);
		$smarty->assign("dataTransfert", $transfert->getListByPoisson($id));
		/*
		 * Recuperation des mortalites
		 */
		$mortalite = new Mortalite($bdd, $ObjetBDDParam);
		$smarty->assign("dataMortalite", $mortalite->getListByPoisson($id));
		/*
		 * Recuperation des cohortes
		*/
		$cohorte = new Cohorte($bdd, $ObjetBDDParam);
		$smarty->assign("dataCohorte", $cohorte->getListByPoisson($id));
		/*
		 * Recuperation des parents
		 */
		$parent = new Parent_poisson($bdd, $ObjetBDDParam);
		$smarty->assign("dataParent", $parent->getListParent($id));
		/*
		 * Recuperation des anomalies
		 */
		include_once ("modules/classes/anomalie.class.php");
		$anomalie = new Anomalie_db($bdd, $ObjetBDDParam);
		$smarty->assign("dataAnomalie", $anomalie->getListByPoisson($id));
		/*
		 * Recuperation des sorties
		 */
		$sortie = new Sortie($bdd, $ObjetBDDParam);
		$smarty->assign("dataSortie", $sortie->getListByPoisson($id));
		/*
		 * Recuperation des echographies
		 */
		$echographie = new Echographie($bdd, $ObjetBDDParam);
		$smarty->assign("dataEcho", $echographie->getListByPoisson($id));
		/*
		 * Recuperation des anesthesies
		 */
		$anesthesie = new Anesthesie($bdd, $ObjetBDDParam);
		$smarty->assign("dataAnesthesie", $anesthesie->getListByPoisson($id));
		/*
		 * Recuperation des mesures de ventilation
		 */
		$ventilation = new Ventilation($bdd, $ObjetBDDParam);
		$smarty->assign("dataVentilation", $ventilation->getListByPoisson($id));
		/*
		 * Recuperation des campagnes de reproduction
		 */
		require_once 'modules/classes/poissonRepro.class.php';
		$poissonCampagne = new PoissonCampagne($bdd, $ObjetBDDParam);
		$smarty->assign("dataRepro", $poissonCampagne->getListFromPoisson($id));
		/*
		 * Recuperation des dosages sanguins
		 */
		require_once 'modules/classes/dosageSanguin.class.php';
		$dosageSanguin = new DosageSanguin($bdd, $ObjetBDDParam);
		$smarty->assign("dataDosageSanguin", $dosageSanguin->getListeFromPoisson($id));
		/*
		 * Gestion des documents associes
		*/
		$smarty->assign ( "moduleParent", "poissonDisplay" );
		$smarty->assign ( "parentType", "poisson" );
		$smarty->assign ( "parentIdName", "poisson_id" );
		$smarty->assign ( "parent_id", $id );
		include_once "modules/classes/documentSturio.class.php";
		$documentSturio = new DocumentSturio($bdd, $ObjetBDDParam);
		$smarty->assign("dataDoc", $documentSturio->getListeDocument("poisson", $id));
		/*
		 * Affichage
		 */
		$smarty->assign("corps", "poisson/poissonDisplay.tpl");
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
		$smarty->assign("sexe", $sexe->getListe(1));
		$poissonStatut = new Poisson_statut($bdd, $ObjetBDDParam);
		$smarty->assign("poissonStatut", $poissonStatut->getListe(1));
		$categorie = new Categorie($bdd, $ObjetBDDParam);
		$smarty->assign("categorie", $categorie->getListe(1));
		
		/*
		 * Modeles de marquages VIE, pour creation a partir des juveniles
		 */
		require_once "modules/classes/lot.class.php";
		$vieModele = new VieModele($bdd, $ObjetBDDParam);
		$smarty->assign("modeles", $vieModele->getAllModeles());
		/*
		 * Passage en parametre de la liste parente
		*/
		$smarty->assign("poissonDetailParent", $_SESSION["poissonDetailParent"]);
		
		/*
		 * Recuperation de la liste des types de pittag
		*/
		$pittagType = new Pittag_type($bdd, $ObjetBDDParam);
		$smarty->assign("pittagType", $pittagType->getListe(2));
		/*
		 * Recuperation du dernier pittag connu
		 */
		$pittag = new Pittag($bdd,$ObjetBDDParam);
		$smarty->assign("dataPittag", $pittag->getListByPoisson($id,1));
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
					$message.=formatErrorData($pittag->getErrorData());
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