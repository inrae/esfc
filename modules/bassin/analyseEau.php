<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 11 mars 2014
 */
include_once 'modules/classes/bassin.class.php';
$dataClass = new AnalyseEau($bdd,$ObjetBDDParam);
$keyName = "analyse_eau_id";
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
		/*
		$searchExample->setParam ( $_REQUEST );
		$dataSearch = $searchExample->getParam ();
		if ($searchExample->isSearch () == 1) {
			$data = $dataClass->getListeSearch ( $dataExample );
			$smarty->assign ( "data", $data );
			$smarty->assign ("isSearch", 1);
		}
		$smarty->assign ("exampleSearch", $dataSearch);
		$smarty->assign("data", $dataClass->getListe());
		$smarty->assign("corps", "example/exampleList.tpl");
		*/
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		/*
		$data = $dataClass->lire($id);
		$smarty->assign("data", $data);
		$smarty->assign("corps", "example/exampleDisplay.tpl");
		*/
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data=dataRead($dataClass, $id, "bassin/analyseEauChange.tpl", $_REQUEST["circuit_eau_id"]);
		/*
		 * Lecture des donnees concernant le circuit d'eau
		 */
		$circuitEau = new Circuit_eau($bdd, $ObjetBDDParam);
		$smarty->assign("dataCircuitEau", $circuitEau->lire($_REQUEST["circuit_eau_id"]));
		/*
		 * Lecture des laboratoires
		 */
		$laboratoireAnalyse = new LaboratoireAnalyse($bdd, $ObjetBDDParam);
		$smarty->assign("laboratoire", $laboratoireAnalyse->getListeActif());
		/*
		 * Forcage de la date de reference (date de recherche) si creation d'un nouvel enregistrement
		 */
		if ($id == 0) {
			$dataSearch = $searchCircuitEau->getParam ();
			$data["analyse_eau_date"] = $dataSearch["analyse_date"];
			$smarty->assign("data", $data);
		}
		$smarty->assign("origine", $_REQUEST["origine"]);
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