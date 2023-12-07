<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 24 févr. 2014
 */
require_once 'modules/classes/evenementType.class.php';
$dataClass = new Evenement_type($bdd, $ObjetBDDParam);
$keyName = "evenement_type_id";
$id = $_REQUEST[$keyName];
switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		$vue->set($dataClass->getListe(2), "data");
		$vue->set("parametre/evenementTypeList.tpl", "corps");
		break;

	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead($dataClass, $id, "parametre/evenementTypeChange.tpl");
		/**
		 * Get the list of status of fish
		 */
		require_once "modules/classes/poissonStatut.class.php";
		$poissonStatut = new Poisson_statut($bdd, $ObjetBDDParam);
		$vue->set($poissonStatut->getListe(2), "poissonStatuts");
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
