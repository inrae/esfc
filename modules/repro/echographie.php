<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 11 mars 2015
 */
 
include_once 'modules/classes/echographie.class.php';
$dataClass = new Echographie($bdd,$ObjetBDDParam);
$keyName = "echographie_id";
$id = $_REQUEST[$keyName];
if (isset($_SESSION["sequence_id"]))
	$smarty->assign("sequence_id", $_SESSION["sequence_id"]);
$smarty->assign ( "poissonDetailParent", $_SESSION ["poissonDetailParent"] );
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
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		require_once 'modules/classes/poissonRepro.class.php';
		$poissonCampagne = new PoissonCampagne($bdd, $ObjetBDDParam);	
		$data = dataRead($dataClass, $id, "repro/echographieChange.tpl", $_REQUEST["poisson_campagne_id"]);
		$smarty->assign("dataPoisson", $poissonCampagne->lire($data["poisson_campagne_id"]));
		/*
		 * Tables des stades
		 */
		require_once 'modules/classes/stadeGonade.class.php';
		require_once 'modules/classes/stadeOeuf.class.php';
		$stadeGonade = new StadeGonade($bdd, $ObjetBDDParam);
		$stadeOeuf = new StadeOeuf($bdd, $ObjetBDDParam);
		$smarty->assign("gonades", $stadeGonade->getListe(1));
		$smarty->assign("oeufs", $stadeOeuf->getListe(1));
		/*
		 * Gestion des documents associes
		 */
		$smarty->assign ( "moduleParent", "echographieChange" );
		$smarty->assign ( "parentType", "echographie" );
		$smarty->assign ( "parentIdName", "echographie_id" );
		$smarty->assign ( "parent_id", $id );
		include_once "modules/classes/documentSturio.class.php";
		require_once 'modules/document/documentFunctions.php';
		$smarty->assign("dataDoc", getListeDocument("echographie", $id, $_REQUEST["document_limit"], $_REQUEST["document_offset"]));
		
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