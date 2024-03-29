<?php
/**
 * @author : quinton
 * @date : 15 mars 2016
 * @encoding : UTF-8
 * (c) 2016 - All rights reserved
 */
require_once 'modules/classes/bassin.class.php';
$dataClass = new CircuitEvenement($bdd,$ObjetBDDParam);
$keyName = "circuit_evenement_id";
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
		dataRead($dataClass, $id, "bassin/circuitEvenementChange.tpl",$_REQUEST["circuit_eau_id"]);
		/*
		 * Lecture des types d'événements
		 */
		require_once "modules/classes/circuitEvenementType.class.php";
		$circuitEvenementType = new circuitEvenementType($bdd, $ObjetBDDParam);
		$vue->set($circuitEvenementType->getListe(1) , "dataEvntType");
		/*
		 * Lecture du circuit d'eau
		 */
		require_once "modules/classes/circuitEau.class.php";
		$circuit = new CircuitEau($bdd, $ObjetBDDParam);
		$vue->set($circuit->lire($_REQUEST["circuit_eau_id"]) , "dataCircuit");
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
