<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 11 mars 2015
 */
include_once 'modules/classes/salinite.class.php';
$dataClass = new Salinite($bdd, $ObjetBDDParam);
$keyName = "salinite_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$vue->set($dataClass->lire($id), "data");
		$vue->set("repro/saliniteChange.tpl", "corps");
		break;
	case "new":
		$id = 0;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = dataRead($dataClass, $id, "repro/saliniteChange.tpl", $_REQUEST["bassin_campagne_id"]);
		/*
		 * Recuperation des donnees du bassin
		 */
		require_once 'modules/classes/bassin.class.php';
		$bassinCampagne = new BassinCampagne($bdd, $ObjetBDDParam);
		$bassin = new Bassin($bdd, $ObjetBDDParam);
		$vue->set($bassinCampagne->lire($data["bassin_campagne_id"]), "dataBassinCampagne");
		$vue->set($bassin->lire($dataBassinCampagne["bassin_id"]), "dataBassin");
		/*
		 * Recuperation des donnees de salinite deja existantes
		 */
		$salinites = $dataClass->getListFromBassinCampagne($data["bassin_campagne_id"]);
		$vue->set($salinites, "salinites");
		/*
		 * Assignation des valeurs par defaut en prenant en reference la derniere valeur entree
		 */
		$nbProfil = count($salinites);
		if ($nbProfil > 0 && $id == 0) {
			$data["salinite_datetime"] = $salinites[$nbProfil - 1]["salinite_datetime"];
			$vue->set($data, "data");
		}
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
