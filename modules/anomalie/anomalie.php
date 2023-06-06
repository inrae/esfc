<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 17 mars 2014
 */
include_once 'modules/classes/anomalie.class.php';
$dataClass = new Anomalie_db($bdd, $ObjetBDDParam);
$keyName = "anomalie_db_id";
$id = $_REQUEST[$keyName];
switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		if (!isset($_SESSION["searchAnomalie"])) {
			$_SESSION["searchAnomalie"] = new SearchAnomalie();
		}
		$_SESSION["searchAnomalie"]->setParam($_REQUEST);
		$dataAnomalie = $_SESSION["searchAnomalie"]->getParam();
		if ($_SESSION["searchAnomalie"]->isSearch() == 1) {
			$vue->set($dataClass->getListeSearch($dataAnomalie), "dataAnomalie");
			$vue->set(1, "isSearch");
		}
		$vue->set($dataAnomalie, "anomalieSearch");
		$vue->set("anomalie/anomalieList.tpl", "corps");
		/*
		 * Recuperation des types d'anomalie
		 */
		require_once "modules/classes/anomalie_db_type.class.php";
		$anomalieType = new Anomalie_db_type($bdd, $ObjetBDDParam);
		$vue->set($anomalieType->getListe(), "anomalieType");
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$vue->set($dataClass->lire($id), "data");
		$vue->set("anomalie/anomalieDisplay.tpl", "corps");
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = dataRead($dataClass, $id, "anomalie/anomalieChange.tpl");
		if ($_REQUEST["poisson_id"] > 0) {
			test();
			/**
			 * Recuperation des informations generales sur le poisson
			 */
			include_once 'modules/classes/poisson.class.php';
			$poisson = new Poisson($bdd, $ObjetBDDParam);
			$vue->set($dataPoisson = $poisson->getDetail($_REQUEST["poisson_id"]), "dataPoisson");
		}
		if ($id == 0) {
			if ($_REQUEST["poisson_id"] > 0) {
				$data["poisson_id"] = $dataPoisson["poisson_id"];
				$data["matricule"] = $dataPoisson["matricule"];
				$data["prenom"] = $dataPoisson["prenom"];
				$data["pittag_valeur"] = $dataPoisson["pittag_valeur"];
			}
		}
		/*
		 * Passage en parametre de la liste parente
		*/
		$vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
		require_once "modules/classes/anomalie_db_type.class.php";
		$anomalieType = new Anomalie_db_type($bdd, $ObjetBDDParam);
		$vue->set($anomalieType->getListe(), "anomalieType");
		if ($_REQUEST["module_origine"] == "poissonDisplay") {
			$vue->set("poissonDisplay", "module_origine");
		}
		$vue->set($data, "data");
		break;
	case "write":
		/*
		 * write record in database
		 */
		$id = dataWrite($dataClass, $_REQUEST);
		if ($id > 0) {
			$_REQUEST[$keyName] = $id;
		}
		if ($_REQUEST["module_origine"] == "poissonDisplay") {
			$vue->set("poissonDisplay", "module_origine");
		}
		break;
	case "delete":
		/*
		 * delete record
		 */
		dataDelete($dataClass, $id);
		break;
}
