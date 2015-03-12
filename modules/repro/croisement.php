<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 12 mars 2015
 */
 
include_once 'modules/classes/croisement.class.php';
$dataClass = new Croisement($bdd,$ObjetBDDParam);
$keyName = "croisement_id";
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
			$smarty->assign ( "data", $data );
			$smarty->assign ("isSearch", 1);
		}
		$smarty->assign ("exampleSearch", $dataSearch);
		$smarty->assign("data", $dataClass->getListe());
		$smarty->assign("corps", "example/exampleList.tpl");
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->lire($id);
		$smarty->assign("data", $data);
		$smarty->assign("corps", "example/exampleDisplay.tpl");
		break;
	case "change":
		require_once 'modules/classes/sequence.class.php';
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = dataRead($dataClass, $id, "repro/croisementChange.tpl", $_REQUEST["sequence_id"]);
		/*
		 * Lecture de la table des qualites de croisement
		 */
		$croisementQualite = new CroisementQualite($bdd, $ObjetBDDParam);
		$smarty->assign("croisementQualite", $croisementQualite->getListe(1));
		/*
		 * Lecture des poissons rattaches
		 */
		if ($id > 0) {
			$smarty->assign("poissonSequence", $dataClass->getListAllPoisson($id), $data["sequence_id"]);
		} else {
			$poissonSequence = new PoissonSequence($bdd, $objetBDDParam);
			$smarty->assign ("poissonSequence", $poissonSequence->getListFromSequence($data["sequence_id"]));
		}
		/*
		 * Lecture de la sequence
		 */
		$sequence = new Sequence($bdd, $ObjetBDDParam);
		$smarty->assign("dataSequence", $sequence->lire($data["sequence_id"]));
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