<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 4 mars 2014
 */
include_once 'modules/classes/bassinUsage.class.php';
$dataClass = new Bassin_usage($bdd, $ObjetBDDParam);
$keyName = "bassin_usage_id";
$id = $_REQUEST[$keyName];
switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		$vue->set($dataClass->getListe(2), "data");
		$vue->set("parametre/bassinUsageList.tpl", "corps");
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead($dataClass, $id, "parametre/bassinUsageChange.tpl");
		/*
		 * Lecture de la categorie d'alimentation
		 */
		include_once 'modules/classes/categorie.class.php';
		$categorie = new Categorie($bdd, $ObjetBDDParam);
		$vue->set($categorie->getListe(1), "categorie");
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
