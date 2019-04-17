<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 2 avr. 2014
 */
include_once 'modules/classes/bassin.class.php';
$dataClass = new BassinEvenement($bdd,$ObjetBDDParam);
$keyName = "bassin_evenement_id";
$id = $_REQUEST[$keyName];
switch ($t_module["param"]) {
	case "list":
		break;
	case "display":
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead($dataClass, $id, "bassin/bassinEvenementChange.tpl",$_REQUEST["bassin_id"]);
		/*
		 * Lecture des types d'événements
		 */
		$bassinEvenementType = new BassinEvenementType($bdd, $ObjetBDDParam);
		$smarty->assign("dataEvntType", $bassinEvenementType->getListe(1));
		/*
		 * Lecture du bassin
		 */
		$bassin = new Bassin($bdd, $ObjetBDDParam);
		$smarty->assign("dataBassin", $bassin->getDetail($_REQUEST["bassin_id"]));
		$smarty->assign("bassinParentModule", $_SESSION["bassinParentModule"]);
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