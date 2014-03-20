<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 19 mars 2014
 */
include_once 'modules/classes/aliment.class.php';
$dataClass = new Aliment ( $bdd, $ObjetBDDParam );
$keyName = "aliment_id";
$id = $_REQUEST [$keyName];
switch ($t_module ["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		$smarty->assign ( "data", $dataClass->getListe ( 2 ) );
		$smarty->assign ( "corps", "aliment/alimentList.tpl" );
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->lire ( $id );
		$smarty->assign ( "data", $data );
		$smarty->assign ( "corps", "example/exampleDisplay.tpl" );
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead ( $dataClass, $id, "aliment/alimentChange.tpl" );
		/*
		 * Recuperation des types d'aliment
		 */
		$alimentType = new AlimentType ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "alimentType", $alimentType->getListe ( 1 ) );
		/*
		 * Recuperation des categories
		 */
		$categorie = new Categorie ( $bdd, $ObjetBDDParam );
		$dataCategorie = $categorie->getListe ( 2 );
		/*
		 * Recuperation des categories actuellement associees
		 */
		$alimentCategorie = new AlimentCategorie ( $bdd, $ObjetBDDParam );
		$dataAC = $alimentCategorie->getListeFromAliment ( $id );
		/*
		 * Assignation de la valeur recuperee aux categories
		 */
		foreach ( $dataCategorie as $key => $value ) {
			foreach ( $dataAC as $key1 => $value1 ) {
				if ($value1 ["categorie_id"] == $value ["categorie_id"])
					$dataCategorie [$key] ["checked"] = 1;
			}
		}
		$smarty->assign ( "categorie", $dataCategorie );
		break;
	case "write":
		/*
		 * write record in database
		 */
		$id = dataWrite ( $dataClass, $_REQUEST );
		if ($id > 0) {
			$_REQUEST [$keyName] = $id;
		}
		break;
	case "delete":
		/*
		 * delete record
		 */
		dataDelete ( $dataClass, $id );
		break;
}

?>