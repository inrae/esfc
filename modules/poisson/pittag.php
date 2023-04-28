<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 26 févr. 2014
 */
include_once 'modules/classes/pittag.class.php';
$dataClass = new Pittag($bdd, $ObjetBDDParam);
$keyName = "pittag_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead($dataClass, $id, "poisson/pittagChange.tpl", $_REQUEST["poisson_id"]);
		/*
		 * Recuperation de la liste des types de pittag
		 */
		include_once "modules/classes/pittagType.class.php";
		$pittagType = new Pittag_type($bdd, $ObjetBDDParam);
		$vue->set($pittagType->getListe(), "pittagType");
		/*
		 * Lecture du poisson
		*/
		include_once "modules/classes/poisson.class.php";
		$poisson = new Poisson($bdd, $ObjetBDDParam);
		$vue->set($poisson->getDetail($_REQUEST["poisson_id"]), "dataPoisson");
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
