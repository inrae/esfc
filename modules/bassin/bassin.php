<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 4 mars 2014
 */
require_once 'modules/classes/bassin.class.php';
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
		require "modules/bassin/bassinSearch.php";
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
		require_once 'modules/classes/transfert.class.php';
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
		require_once 'modules/classes/distribQuotidien.class.php';
		$distribQuotidien = new DistribQuotidien($bdd, $ObjetBDDParam);
		/*
		 * Dates de recherche
		 */
		if (!isset($_SESSION["searchAlimentation"])) {
			$_SESSION["searchAlimentation"] = new SearchAlimentation();
		}
		$_SESSION["searchAlimentation"]->setParam($_REQUEST);
		$param = $_SESSION["searchAlimentation"]->getParam();
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
		/**
		 * Ajout des informations pour le transfert des poissons
		 */
		include_once "modules/classes/evenementType.class.php";
		$eventType = new Evenement_type($bdd, $ObjetBDDParam);
		$vue->set($eventType->getListe("evenement_type_actif desc, evenement_type_libelle"), "evntType");
		$dataBassin["site_id"] > 0 ? $siteId = $dataBassin["site_id"] : $siteId = 0;
		$vue->set($dataClass->getListBassin($siteId, 1), "bassinListActif");
		$vue->set(date($_SESSION["MASKDATE"]), "currentDate");
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
		require 'modules/bassin/bassinParamAssocie.php';
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
		require_once 'modules/classes/poisson.class.php';
		if ($_REQUEST["bassin_id"] > 0) {
			$masse = $dataClass->calculMasse($_REQUEST["bassin_id"]);
			$vue->set(array("val" => $masse));
		}
		break;
	case "recapAlim":
		$vue->set($dataClass->getRecapAlim($_REQUEST, $_SESSION["searchBassin"]->getParam()));
		break;
	case "bassinPoissonTransfert":
		include_once "modules/classes/evenement.class.php";
		include_once "modules/classes/transfert.class.php";
		$event = new Evenement($bdd, $ObjetBDDParam);
		$transfert = new Transfert($bdd, $ObjetBDDParam);
		try {
			$bdd->beginTransaction();
			$nb = 0;
			$data = [
				"evenement_id"=>0,
				"evenement_type_id"=>$_POST["evenement_type_id"],
				"evenement_date"=>$_POST["evenement_date"],
				"commentaire" => $_REQUEST["commentaire"],
				"bassin_origine" =>$_POST["bassin_origine"],
				"bassin_destination"=>$_POST["bassin_destination"],
				"transfert_date"=>$_POST["evenement_date"],
				"transfert_id"=>0
			];
		foreach($_POST["poissons"] as $poisson_id) {
			$data["poisson_id"] = $poisson_id;
			$data["evenement_id"] = $event->ecrire($data);
			$transfert->ecrire($data);
			$data["evenement_id"] = 0;
			$nb ++;
		}
		$bdd->commit();
		$message->set(sprintf(_("%s poissons transférés"), $nb));
		$module_coderetour = 1;
		} catch (Exception $e) {
			$bdd->rollback();
			$message->set("{t}Une erreur est survenue pendant le transfert des poissons", true);
			$message->set($e->getMessage());
			$message->setSyslog($e->getMessage());
			$module_coderetour = -1;
		}
		break;
}
