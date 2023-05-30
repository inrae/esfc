<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 4 mars 2014
 */
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
		if ($_SESSION["searchBassin"]->isSearch() == 1) {
			$vue->set($dataClass->getListeSearch($dataSearch), "data");
		}
		/*
		 * Preparation des dates pour la generation du recapitulatif des aliments
		 */
		!isset($_REQUEST["dateFin"]) ? $dateFin = date("d/m/Y") : $dateFin = $_REQUEST["dateFin"];
		!isset($_REQUEST["dateDebut"]) ? $dateDebut = date("d/m/") . (date("Y") - 1) : $dateDebut = $_REQUEST["dateDebut"];
		$vue->set($dateDebut, "dateDebut");
		$vue->set($dateFin, "dateFin");
		$vue->set("bassin/bassinList.tpl", "corps");
		$_SESSION["bassinParentModule"] = "bassinList";
		require_once "modules/classes/site.class.php";
		$site = new Site($bdd, $ObjetBDDParam);
		$vue->set($site->getListe(2), "site");
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->getDetail($id);
		$vue->set($data, "dataBassin");
		/*
		 * Recuperation de la liste des poissons presents
		 */
		include_once 'modules/classes/transfert.class.php';
		$transfert = new Transfert($bdd, $ObjetBDDParam);
		$vue->set($transfert->getListPoissonPresentByBassin($id), "dataPoisson");
		/*
		 * Recuperation des evenements
		 */
		require_once "modules/classes/bassinEvenement.class.php";
		$bassinEvenement = new BassinEvenement($bdd, $ObjetBDDParam);
		$vue->set($bassinEvenement->getListeByBassin($id), "dataBassinEvnt");
		/*
		 * Recuperation des aliments consommés sur la période déterminée
		 */
		include_once 'modules/classes/distribQuotidien.class.php';
		$distribQuotidien = new DistribQuotidien($bdd, $ObjetBDDParam);
		/*
		 * Dates de recherche
		 */
		$searchAlimentation->setParam($_REQUEST);
		$param = $searchAlimentation->getParam();
		$vue->set($param, "searchAlim");
		$vue->set($distribQuotidien->getListeConsommation($id, $param["date_debut"], $param["date_fin"]), "dataAlim");
		$vue->set($distribQuotidien->alimentListe, "alimentListe");
		/*
		 * Gestion des documents associes
		 */
		$vue->set("bassinDisplay", "moduleParent");
		$vue->set("bassin", "parentType");
		$vue->set("bassin_id", "parentIdName");
		$vue->set($id, "parent_id");
		require_once 'modules/document/documentFunctions.php';
		$vue->set(getListeDocument("bassin", $id, $_REQUEST["document_limit"], $_REQUEST["document_offset"]), "dataDoc");
		/*
		 * Affichage
		 */
		$vue->set("bassin/bassinDisplay.tpl", "corps");
		$vue->set($_SESSION["bassinParentModule"], "bassinParentModule");
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
		$vue->set($_SESSION["bassinParentModule"], "bassinParentModule");
		require_once 'modules/classes/site.class.php';
		$site = new Site($bdd, $ObjetBDDParam);
		$vue->set($site->getListe(2), "site");
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
			$vue->set(array("val" => $masse));
		}
		break;
	case "recapAlim":
		$vue->set($dataClass->getRecapAlim($_REQUEST, $searchBassin->getParam()));
}
