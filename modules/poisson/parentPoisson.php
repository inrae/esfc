<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 19 mars 2014
 */
include_once 'modules/classes/poisson.class.php';
$dataClass = new Parent_poisson($bdd,$ObjetBDDParam);
$keyName = "parent_poisson_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		/*
		 * $searchExample must be defined into modules/beforesession.inc.php :
		 * include_once 'modules/classes/searchParam.class.php';
		 * and into modules/common.inc.php :
		 * if (!isset($_SESSION["searchExample"])) {
		 * $searchExample = new SearchExample();
		 *	$_SESSION["searchExample"] = $searchExample;
		 *	} else {
		 *	$searchExample = $_SESSION["searchExample"];
		 *	}
		 * and, also, into modules/classes/searchParam.class.php...
		 */
		$searchExample->setParam ( $_REQUEST );
		$dataSearch = $searchExample->getParam ();
		if ($searchExample->isSearch () == 1) {
			$data = $dataClass->getListeSearch ( $dataExample );
			$vue->set( , ""); ( "data", $data );
			$vue->set( , ""); ("isSearch", 1);
		}
		$vue->set( , ""); ("exampleSearch", $dataSearch);
		$vue->set( , "");("data", $dataClass->getListe());
		$vue->set( , "");("corps", "example/exampleList.tpl");
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->lire($id);
		$vue->set( , "");("data", $data);
		$vue->set( , "");("corps", "example/exampleDisplay.tpl");
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		/*
		 * Passage en parametre de la liste parente
		*/
		$vue->set( , "");("poissonDetailParent", $_SESSION["poissonDetailParent"]);
		dataRead($dataClass, $id, "poisson/parentPoissonChange.tpl", $_REQUEST["poisson_id"]);
		if ($id > 0) {
			/*
			 * Recuperation des donnees avec le poisson parent
			 */
			$vue->set( , "");("data", $dataClass->lireAvecParent($id));
		}
		/*
		 * Lecture du poisson
		*/
		$poisson = new Poisson($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataPoisson", $poisson->getDetail($_REQUEST["poisson_id"]));
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