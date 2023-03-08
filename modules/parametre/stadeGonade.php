<?php
/**
 * Created : 3 févr. 2017
 * Creator : quinton
 * Encoding : UTF-8
 * Copyright 2017 - All rights reserved
 */
include_once 'modules/classes/stadeGonade.class.php';
$dataClass = new StadeGonade($bdd,$ObjetBDDParam);
$keyName = "stade_gonade_id";
$id = $_REQUEST[$keyName];
switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		$vue->set( , "");("data", $dataClass->getListe(2));
		$vue->set( , "");("corps", "parametre/stadeGonadeList.tpl");
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead($dataClass, $id, "parametre/stadeGonadeChange.tpl");
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