<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 4 mars 2014
 */
include_once 'modules/classes/bassin.class.php';
$dataClass = new Bassin($bdd,$ObjetBDDParam);
$keyName = "bassin_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		include "modules/bassin/bassinSearch.php";
		if ($searchBassin->isSearch () == 1) {
			$data = $dataClass->getListeSearch ( $dataSearch );
			$smarty->assign ( "data", $data );
		}
		$smarty->assign("corps", "bassin/bassinList.tpl");
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->getDetail($id);
		$smarty->assign("dataBassin", $data);
		/*
		 * Recuperation de la liste des poissons presents
		 */
		include_once 'modules/classes/poisson.class.php';
		$transfert = new Transfert($bdd, $ObjetBDDParam);
		$smarty->assign("dataPoisson", $transfert->getListPoissonPresentByBassin($id));
		/*
		 * Affichage
		*/
		$smarty->assign("corps", "bassin/bassinDisplay.tpl");
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead($dataClass, $id, "bassin/bassinChange.tpl");
		/*
		 * Integration des tables de parametres
		 */
		include 'modules/bassin/bassinParamAssocie.php';
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