<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 20 mars 2014
 */
include_once 'modules/classes/aliment.class.php';
$dataClass = new RepartTemplate ( $bdd, $ObjetBDDParam );
$keyName = "repart_template_id";
$id = $_REQUEST [$keyName];
switch ($t_module ["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		/*
		 * Gestion des variables de recherche
		 */
		$searchRepartTemplate->setParam ( $_REQUEST );
		$dataSearch = $searchRepartTemplate->getParam ();
		if ($searchRepartTemplate->isSearch () == 1) {
			$smarty->assign ( "isSearch", 1 );
			$data = $dataClass->getListSearch ( $dataSearch );
		}
		$smarty->assign ( "repartTemplateSearch", $dataSearch );
		$smarty->assign ( "data", $data );
		$smarty->assign ( "corps", "aliment/repartTemplateList.tpl" );
		/*
		 * Recherche de la categorie
		 */
		$categorie = new Categorie ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "categorie", $categorie->getListe ( 2 ) );
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
		$data = dataRead ( $dataClass, $id, "aliment/repartTemplateChange.tpl" );
		/*
		 * Lecture des categories
		 */
		$categorie = new Categorie ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "categorie", $categorie->getListe ( 2 ) );
		/*
		 * Recuperation des aliments associés
		 */
		if ($data ["categorie_id"] > 0 && $id > 0) {
			$repartAliment = new RepartAliment ( $bdd, $ObjetBDDParam );
			$smarty->assign ( "dataAliment", $repartAliment->getFromTemplateWithAliment ( $id, $data ["categorie_id"] ) );
		}
		break;
	case "write":
		/*
		 * write record in database
		 */
		$id = dataWrite ( $dataClass, $_REQUEST );
		if ($id > 0) {
			$_REQUEST [$keyName] = $id;
			/*
			 * Preparation des aliments
			 */
			$data = array ();
			foreach ( $_REQUEST as $key => $value ) {
				if (preg_match ( '/[0-9]+$/', $key, $val )) {
					$pos = strrpos ( $key, "_" );
					$nom = substr ( $key, 0, $pos );
					$data [$val [0]] [$nom] = $value;
				}
			}
			/*
			 * Mise en table
			 */
			$repartAliment = new RepartAliment ( $bdd, $ObjetBDDParam );
			$error = 0;
			foreach ( $data as $key => $value ) {
				if ($value ["repart_aliment_id"] > 0 || $value ["repart_alim_taux"] > 0) {
					$value ["repart_template_id"] = $id;
					$idRepart = $repartAliment->ecrire ( $value );
					if (! $idRepart > 0) {
						$error = 1;
						$message .= formatErrorData ( $repartAliment->getErrorData () );
					}
				}
			}
			if ($error == 1) {
				$message .= $LANG ["message"] [12];
				$module_coderetour = - 1;
			}
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