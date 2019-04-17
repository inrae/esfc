<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 6 mars 2015
 */
 
include_once 'modules/classes/dosageSanguin.class.php';
require_once 'modules/classes/poissonRepro.class.php';
$dataClass = new DosageSanguin($bdd,$ObjetBDDParam);
$keyName = "dosage_sanguin_id";
$id = $_REQUEST[$keyName];
if (isset($_SESSION["sequence_id"]))
	$smarty->assign("sequence_id", $_SESSION["sequence_id"]);
$smarty->assign ( "poissonDetailParent", $_SESSION ["poissonDetailParent"] );
switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
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
		$poissonCampagne = new poissonCampagne($bdd, $ObjetBDDParam);
		$data = dataRead($dataClass, $id, "repro/dosageSanguinChange.tpl", $_REQUEST["poisson_campagne_id"]);
		$smarty->assign("dataPoisson", $poissonCampagne->lire($data["poisson_campagne_id"]));
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