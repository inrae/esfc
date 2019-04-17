<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 4 mars 2014
 */
include_once 'modules/classes/bassin.class.php';
$dataClass = new Circuit_eau($bdd,$ObjetBDDParam);
$keyName = "circuit_eau_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		$searchCircuitEau->setParam ( $_REQUEST );
		$dataSearch = $searchCircuitEau->getParam ();
		if ($searchCircuitEau->isSearch () == 1) {
			$smarty->assign ("isSearch", 1);
		}
		$smarty->assign ("circuitEauSearch", $dataSearch);
		if ($searchCircuitEau->isSearch () == 1) {
			$data = $dataClass->getListeSearch ( $dataSearch );
			$smarty->assign ( "data", $data );
			/*
			 * Recuperation des donnees d'analyse
			 */
			if ($_REQUEST["circuit_eau_id"] > 0) {
				$analyseEau = new AnalyseEau($bdd, $ObjetBDDParam);
				$dataAnalyse = $analyseEau->getDetailByCircuitEau($_REQUEST["circuit_eau_id"], $dataSearch["analyse_eau_date"]);
				$smarty->assign("dataAnalyse", $dataAnalyse );
			}
		}
		$smarty->assign("corps", "bassin/circuitEauList.tpl");
		require_once 'modules/classes/site.class.php';
		$site = new Site($bdd, $ObjetBDDParam);
		$smarty->assign("site", $site->getListe(2));
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data= $dataClass->lire($id);
		$smarty->assign("data", $data);
		/*
		 * Recuperation des dernieres analyses d'eau
		 */
		/*
		 * Traitement des valeurs next et previous, si fournies
		 */
		$searchCircuitEau->setParam($_REQUEST);
		$dataSearch = $searchCircuitEau->getParam ();
		if ($_REQUEST["next"] > 0 ) {
			$dataSearch["offset"] = $dataSearch["offset"] + $dataSearch["limit"];
			$searchCircuitEau->setParam("offset",$dataSearch["offset"]);
		}
		if ($_REQUEST["previous"] > 0) {
			$dataSearch["offset"] = $dataSearch["offset"] - $dataSearch["limit"];
			if ($dataSearch["offset"] < 0) $dataSearch["offset"] = 0;
			$searchCircuitEau->setParam("offset",$dataSearch["offset"]);
		}
		$smarty->assign("dataSearch",$dataSearch);
		$analyseEau = new AnalyseEau($bdd, $ObjetBDDParam);
		$dataAnalyse = $analyseEau->getDetailByCircuitEau($id, $dataSearch["analyse_date"], $dataSearch["limit"], $dataSearch["offset"]);
		$smarty->assign("dataAnalyse", $dataAnalyse);
		/*
		 * Recuperation des bassins associes
		 */
		$bassin = new Bassin($bdd, $ObjetBDDParam);
		$smarty->assign("dataBassin", $bassin->getListeByCircuitEau($id));
		/*
		 * Recuperation des evenements
		 */
		$circuitEvenement = new CircuitEvenement($bdd, $ObjetBDDParam);
		$smarty->assign("dataCircuitEvnt", $circuitEvenement->getListeBycircuit($id));
		/*
		 * Affichage
		*/
		$smarty->assign("corps", "bassin/circuitEauDisplay.tpl");
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
		$smarty->assign("site", $site->getListe(2));
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

?>