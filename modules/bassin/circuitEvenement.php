<?php
/**
 * @author : quinton
 * @date : 15 mars 2016
 * @encoding : UTF-8
 * (c) 2016 - All rights reserved
 */include_once 'modules/classes/bassin.class.php';
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
		$circuitEvenementType = new circuitEvenementType($bdd, $ObjetBDDParam);
		$smarty->assign("dataEvntType", $circuitEvenementType->getListe(1));
		/*
		 * Lecture du circuit d'eau
		 */
		$circuit = new CircuitEau($bdd, $ObjetBDDParam);
		$smarty->assign("dataCircuit", $circuit->lire($_REQUEST["circuit_eau_id"]));
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