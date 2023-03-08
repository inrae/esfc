<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 4 mars 2014
 */
require_once 'modules/bassin/bassin.functions.php';

include_once 'modules/classes/bassin.class.php';
$dataClass = new Bassin($bdd, $ObjetBDDParam);
$keyName = "bassin_id";
if (isset($_REQUEST[$keyName])) {
	$id = $_REQUEST[$keyName];
} elseif (isset($_SESSION["bassin_id"])) {
	$id = $_SESSION["bassin_id"];
} else
	$id = -1;

switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		include "modules/bassin/bassinSearch.php";
		if ($searchBassin->isSearch() == 1) {
			$data = $dataClass->getListeSearch($dataSearch);
			$vue->set( , "");("data", $data);
		}
		/*
		 * Preparation des dates pour la generation du recapitulatif des aliments
		 */
		!isset($_REQUEST["dateFin"]) ? $dateFin = date("d/m/Y") : $dateFin = $_REQUEST["dateFin"];
		!isset($_REQUEST["dateDebut"]) ? $dateDebut = date("d/m/") . (date("Y") - 1) : $dateDebut = $_REQUEST["dateDebut"];
		$vue->set( , "");("dateDebut", $dateDebut);
		$vue->set( , "");("dateFin", $dateFin);
		$vue->set( , "");("corps", "bassin/bassinList.tpl");
		$_SESSION["bassinParentModule"] = "bassinList";
		$site = new Site($bdd, $ObjetBDDParam);
		$vue->set( , "");("site", $site->getListe(2));
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->getDetail($id);
		$vue->set( , "");("dataBassin", $data);
		/*
		 * Recuperation de la liste des poissons presents
		 */
		include_once 'modules/classes/poisson.class.php';
		$transfert = new Transfert($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataPoisson", $transfert->getListPoissonPresentByBassin($id));
		/*
		 * Recuperation des evenements
		 */
		$bassinEvenement = new BassinEvenement($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataBassinEvnt", $bassinEvenement->getListeByBassin($id));
		/*
		 * Recuperation des aliments consommés sur la période déterminée
		 */
		include_once 'modules/classes/aliment.class.php';
		$distribQuotidien = new DistribQuotidien($bdd, $ObjetBDDParam);
		/*
		 * Dates de recherche
		 */
		$searchAlimentation->setParam($_REQUEST);
		$param = $searchAlimentation->getParam();
		$vue->set( , "");("searchAlim", $param);
		$vue->set( , "");("dataAlim", $distribQuotidien->getListeConsommation($id, $param["date_debut"], $param["date_fin"]));
		$vue->set( , "");("alimentListe", $distribQuotidien->alimentListe);
		/*
		 * Gestion des documents associes
		 */
		$vue->set( , "");("moduleParent", "bassinDisplay");
		$vue->set( , "");("parentType", "bassin");
		$vue->set( , "");("parentIdName", "bassin_id");
		$vue->set( , "");("parent_id", $id);
		require_once 'modules/document/documentFunctions.php';
		$vue->set( , "");("dataDoc", getListeDocument("bassin", $id, $_REQUEST["document_limit"], $_REQUEST["document_offset"]));
		/*
		 * Affichage
		 */
		$vue->set( , "");("corps", "bassin/bassinDisplay.tpl");
		$vue->set( , "");("bassinParentModule", $_SESSION["bassinParentModule"]);
		$_SESSION["poissonDetailParent"] = "bassinDisplay";
		$_SESSION["bassin_id"] = $id;
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead($dataClass, $id, "bassin/bassinChange.tpl");
		/*
		 * Integration des tables de parametres
		 */
		include 'modules/bassin/bassinParamAssocie.php';
		$vue->set( , "");("bassinParentModule", $_SESSION["bassinParentModule"]);
		require_once 'modules/classes/site.class.php';
		$site = new Site($bdd, $ObjetBDDParam);
		$vue->set( , "");("site", $site->getListe(2));
		break;
	case "write":
		/*
		 * write record in database
		 */
		$id = dataWrite($dataClass, $_REQUEST);
		if ($id > 0) {
			$_REQUEST[$keyName] = $id;
		}
		break;
	case "delete":
		/*
		 * delete record
		 */
		dataDelete($dataClass, $id);
		break;
	case "calculMasseAjax":
		include_once 'modules/classes/poisson.class.php';
		if ($_REQUEST["bassin_id"] > 0) {
			$masse = $dataClass->calculMasse($_REQUEST["bassin_id"]);
			$masseJson = '{"0": {"val": "' . $masse . '" } }';
			echo $masseJson;
		}
		break;
	case "recapAlim":
		$data = $dataClass->getRecapAlim($_REQUEST, $searchBassin->getParam());
		ob_clean();
		download_send_headers("sturio_bassin_alim_recap_" . date("Y-m-d") . ".csv");
		echo array2csv($data);
		die();
		break;
}
?>