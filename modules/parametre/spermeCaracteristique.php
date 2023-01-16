<?php
/**
 * @author : quinton
 * @date : 16 mars 2016
 * @encoding : UTF-8
 * (c) 2016 - All rights reserved
 */
include_once 'modules/classes/sperme.class.php';
$dataClass = new SpermeCaracteristique($bdd,$ObjetBDDParam);
$keyName = "sperme_caracteristique_id";
$id = $_REQUEST[$keyName];
switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		$smarty->assign("data", $dataClass->getListe(2));
		$smarty->assign("corps", "parametre/spermeCaracteristiqueList.tpl");
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead($dataClass, $id, "parametre/spermeCaracteristiqueChange.tpl");
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