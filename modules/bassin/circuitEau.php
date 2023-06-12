<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 4 mars 2014
 */
require_once 'modules/classes/circuitEau.class.php';
$dataClass = new CircuitEau($bdd,$ObjetBDDParam);
$keyName = "circuit_eau_id";
$id = $_REQUEST[$keyName];
if (!isset($_SESSION["searchCircuitEau"])) {
	$_SESSION["searchCircuitEau"] = new SearchCircuitEau();
}

switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		$_SESSION["searchCircuitEau"]->setParam ( $_REQUEST );
		$dataSearch = $_SESSION["searchCircuitEau"]->getParam ();
		if ($_SESSION["searchCircuitEau"]->isSearch () == 1) {
			$vue->set(1 , "isSearch"); 
		}
		$vue->set($dataSearch , "circuitEauSearch"); 
		if ($_SESSION["searchCircuitEau"]->isSearch () == 1) {
			$vue->set( $dataClass->getListeSearch ( $dataSearch ), "data");
			/*
			 * Recuperation des donnees d'analyse
			 */
			if ($_REQUEST["circuit_eau_id"] > 0) {
				require_once "modules/classes/analyseEau.class.php";
				$analyseEau = new AnalyseEau($bdd, $ObjetBDDParam);
				$vue->set($analyseEau->getDetailByCircuitEau($_REQUEST["circuit_eau_id"], $dataSearch["analyse_eau_date"]) , "dataAnalyse");
			}
		}
		$vue->set("bassin/circuitEauList.tpl" , "corps");
		require_once 'modules/classes/site.class.php';
		$site = new Site($bdd, $ObjetBDDParam);
		$vue->set( $site->getListe(2), "site");
		$_SESSION["bassinParentModule"] = "circuitEauList";
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$vue->set($dataClass->lire($id) , "data");
		/*
		 * Recuperation des dernieres analyses d'eau
		 */
		/*
		 * Traitement des valeurs next et previous, si fournies
		 */
		$_SESSION["searchCircuitEau"]->setParam($_REQUEST);
		$dataSearch = $_SESSION["searchCircuitEau"]->getParam ();
		if ($_REQUEST["next"] > 0 ) {
			$dataSearch["offset"] = $dataSearch["offset"] + $dataSearch["limit"];
			$_SESSION["searchCircuitEau"]->setParam("offset",$dataSearch["offset"]);
		}
		if ($_REQUEST["previous"] > 0) {
			$dataSearch["offset"] = $dataSearch["offset"] - $dataSearch["limit"];
			if ($dataSearch["offset"] < 0) $dataSearch["offset"] = 0;
			$_SESSION["searchCircuitEau"]->setParam("offset",$dataSearch["offset"]);
		}
		$vue->set($dataSearch , "dataSearch");
		require_once "modules/classes/analyseEau.class.php";
		$analyseEau = new AnalyseEau($bdd, $ObjetBDDParam);
		$vue->set( $analyseEau->getDetailByCircuitEau($id, $dataSearch["analyse_date"], $dataSearch["limit"], $dataSearch["offset"]), "dataAnalyse");
		/*
		 * Recuperation des bassins associes
		 */
		require_once "modules/classes/bassin.class.php";
		$bassin = new Bassin($bdd, $ObjetBDDParam);
		$vue->set($bassin->getListeByCircuitEau($id) , "dataBassin");
		/*
		 * Recuperation des evenements
		 */
		require_once "modules/classes/circuitEvenement.class.php";
		$circuitEvenement = new CircuitEvenement($bdd, $ObjetBDDParam);
		$vue->set($circuitEvenement->getListeBycircuit($id) , "dataCircuitEvnt");
		/*
		 * Affichage
		*/
		$vue->set("bassin/circuitEauDisplay.tpl" , "corps");
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead($dataClass, $id, "bassin/circuitEauChange.tpl");
		require_once 'modules/classes/site.class.php';
		$site = new Site($bdd, $ObjetBDDParam);
		$vue->set( $site->getListe(2), "site");
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
}
