<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 1 avr. 2015
 */
require_once 'modules/classes/vieModele.class.php';
$dataClass = new VieModele($bdd, $ObjetBDDParam);
$keyName = "vie_modele_id";
$id = $_REQUEST[$keyName];

require "modules/repro/setAnnee.php";

switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		$vue->set($dataClass->getModelesFromAnnee($_SESSION["annee"]), "data");
		$vue->set("repro/vieModeleList.tpl", "corps");
		/*
		 * Lecture des annees
		 */
		require_once 'modules/classes/poissonCampagne.class.php';
		$poissonCampagne = new PoissonCampagne($bdd, $ObjetBDDParam);
		$vue->set($poissonCampagne->getAnnees(), "annees");
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = dataRead($dataClass, $id, "repro/vieModeleChange.tpl");
		if ($id == 0) {
			$data["annee"] = $_SESSION["annee"];
			$vue->set($data, "data");
		}
		/*
		 * Recuperation des emplacements d'implantation des marques vie
		 */
		require_once "modules/classes/vieImplantation.class.php";
		$vieImplantation = new VieImplantation($bdd, $ObjetBDDParam);
		$vue->set($vieImplantation->getListe(2), "implantations");

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
