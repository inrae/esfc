<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 17 mars 2014
 */
include_once 'modules/classes/anomalie.class.php';
$dataClass = new Anomalie_db ( $bdd, $ObjetBDDParam );
$keyName = "anomalie_db_id";
$id = $_REQUEST [$keyName];
switch ($t_module ["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		$searchAnomalie->setParam ( $_REQUEST );
		$dataAnomalie = $searchAnomalie->getParam ();
		if ($searchAnomalie->isSearch () == 1) {
			$data = $dataClass->getListeSearch ( $dataAnomalie );
			$vue->set( , ""); ( "dataAnomalie", $data );
			$vue->set( , ""); ( "isSearch", 1 );
		}
		$vue->set( , ""); ( "anomalieSearch", $dataAnomalie );
		$vue->set( , ""); ( "corps", "anomalie/anomalieList.tpl" );
		/*
		 * Recuperation des types d'anomalie
		 */
		$anomalieType = new Anomalie_db_type ( $bdd, $ObjetBDDParam );
		$vue->set( , ""); ( "anomalieType", $anomalieType->getListe () );
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->lire ( $id );
		$vue->set( , ""); ( "data", $data );
		$vue->set( , ""); ( "corps", "anomalie/anomalieDisplay.tpl" );
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = dataRead ( $dataClass, $id, "anomalie/anomalieChange.tpl" );
		if ($id == 0) {
			if ($_REQUEST ["poisson_id"] > 0) {
				$data ["poisson_id"] = $_REQUEST ["poisson_id"];
				$vue->set( , ""); ( "data", $data );
			}
		}
		/*
		 * Passage en parametre de la liste parente
		*/
		$vue->set( , "");("poissonDetailParent", $_SESSION["poissonDetailParent"]);
		
		$anomalieType = new Anomalie_db_type ( $bdd, $ObjetBDDParam );
		$vue->set( , ""); ( "anomalieType", $anomalieType->getListe () );
		if ($_REQUEST ["poisson_id"] > 0) {
			/*
			 * Recuperation des informations generales sur le poisson
			 */
			include_once 'modules/classes/poisson.class.php';
			$poisson = new Poisson ( $bdd, $ObjetBDDParam );
			$dataPoisson = $poisson->getDetail ( $_REQUEST ["poisson_id"] );
			$vue->set( , ""); ( "dataPoisson", $dataPoisson );
		}
		if ($_REQUEST ["module_origine"] == "poissonDisplay")
			$vue->set( , ""); ( "module_origine", "poissonDisplay" );
		break;
	case "write":
		/*
		 * write record in database
		 */
		$id = dataWrite ( $dataClass, $_REQUEST );
		if ($id > 0) {
			$_REQUEST [$keyName] = $id;
		}
		if ($_REQUEST ["module_origine"] == "poissonDisplay")
			$vue->set( , ""); ( "module_origine", "poissonDisplay" );
		break;
	case "delete":
		/*
		 * delete record
		 */
		dataDelete ( $dataClass, $id );
		break;
}

?>