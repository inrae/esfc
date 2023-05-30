<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 2 avr. 2014
 */
include_once 'modules/classes/bassinEvenement.class.php';
$dataClass = new BassinEvenement($bdd, $ObjetBDDParam);
$keyName = "bassin_evenement_id";
$id = $_REQUEST[$keyName];
switch ($t_module["param"]) {
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead($dataClass, $id, "bassin/bassinEvenementChange.tpl", $_REQUEST["bassin_id"]);
		/*
		 * Lecture des types d'événements
		 */
		require_once "modules/classes/bassinEvenementType.class.php";
		$bassinEvenementType = new BassinEvenementType($bdd, $ObjetBDDParam);
		$vue->set($bassinEvenementType->getListe(1), "dataEvntType");

		/*
		 * Lecture du bassin
		 */
		include_once "modules/classes/bassin.class.php";
		$bassin = new Bassin($bdd, $ObjetBDDParam);
		$vue->set($bassin->getDetail($_REQUEST["bassin_id"]), "dataBassin");
		$vue->set($_SESSION["bassinParentModule"], "bassinParentModule");
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
