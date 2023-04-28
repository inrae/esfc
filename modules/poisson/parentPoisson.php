<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 19 mars 2014
 */
include_once 'modules/classes/parentPoisson.class.php';
$dataClass = new Parent_poisson($bdd, $ObjetBDDParam);
$keyName = "parent_poisson_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {

	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		/*
		 * Passage en parametre de la liste parente
		*/
		$vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
		dataRead($dataClass, $id, "poisson/parentPoissonChange.tpl", $_REQUEST["poisson_id"]);
		if ($id > 0) {
			/*
			 * Recuperation des donnees avec le poisson parent
			 */
			$vue->set($dataClass->lireAvecParent($id), "data");
		}
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
