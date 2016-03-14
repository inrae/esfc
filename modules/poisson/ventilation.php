<?php
/**
 * @author : quinton
 * @date : 14 mars 2016
 * @encoding : UTF-8
 * (c) 2016 - All rights reserved
 */
include_once 'modules/classes/poisson.class.php';
$dataClass = new Ventilation($bdd,$ObjetBDDParam);
$keyName = "ventilation_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
	case "list":
		break;
	case "display":
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead($dataClass, $id, "poisson/ventilationChange.tpl", $_REQUEST["poisson_id"]);
		/*
		 * Recuperation de la liste des types de pittag
		*/
		/*
		 * Lecture du poisson
		*/
		$poisson = new Poisson($bdd, $ObjetBDDParam);
		$smarty->assign("dataPoisson", $poisson->getDetail($_REQUEST["poisson_id"]));
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