<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 6 mars 2015
 */
include_once 'modules/classes/biopsie.class.php';
require_once 'modules/classes/poissonRepro.class.php';
$dataClass = new Biopsie($bdd,$ObjetBDDParam);
$keyName = "biopsie_id";
$id = $_REQUEST[$keyName];
if (isset($_SESSION["sequence_id"]))
	$smarty->assign("sequence_id", $_SESSION["sequence_id"]);
$smarty->assign ( "poissonDetailParent", $_SESSION ["poissonDetailParent"] );
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
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$poissonCampagne = new poissonCampagne($bdd, $ObjetBDDParam);
		$data = dataRead($dataClass, $id, "repro/biopsieChange.tpl", $_REQUEST["poisson_campagne_id"]);
		$smarty->assign("dataPoisson", $poissonCampagne->lire($data["poisson_campagne_id"]));
		/*
		 * Recuperation des methodes de calcul
		 */
		$biopsieTechniqueCalcul = new BiopsieTechniqueCalcul($bdd, $ObjetBDDParam);
		$smarty->assign ("techniqueCalcul", $biopsieTechniqueCalcul->getListe(1));
		/*
		 * Gestion des documents associes
		 */
		$smarty->assign ( "moduleParent", "biopsieChange" );
		$smarty->assign ( "parentType", "biopsie" );
		$smarty->assign ( "parentIdName", "biopsie_id" );
		$smarty->assign ( "parent_id", $id );
		require_once 'modules/document/documentFunctions.php';
		$smarty->assign ( "dataDoc", getListeDocument ( "biopsie", $id, $_REQUEST["document_limit"], $_REQUEST["document_offset"] ) );
		
		break;
	case "write":
		/*
		 * write record in database
		 */
		$id = dataWrite($dataClass, $_REQUEST);
		if ($id > 0) {
			$_REQUEST[$keyName] = $id;
		}
		/*
		 * Traitement des photos a importer
		 */
		if ($id > 0 && isset($_FILES["documentName"])) {
			/*
			 * Preparation de files
			 */
			$files = array ();
			$fdata = $_FILES ['documentName'];
			if (is_array ( $fdata ['name'] )) {
				for($i = 0; $i < count ( $fdata ['name'] ); ++ $i) {
					$files [] = array (
							'name' => $fdata ['name'] [$i],
							'type' => $fdata ['type'] [$i],
							'tmp_name' => $fdata ['tmp_name'] [$i],
							'error' => $fdata ['error'] [$i],
							'size' => $fdata ['size'] [$i]
					);
				}
			} else
				$files [] = $fdata;
			$documentSturio = new DocumentSturio ( $bdd, $ObjetBDDParam );
			foreach ( $files as $file ) {
				$document_id = $documentSturio->ecrire ( $file, "Calcul du diamètre moyen de l'ovocyte - ".$_REQUEST["biopsie_date"] );
				if ($document_id > 0) {
					/*
					 * Ecriture de l'enregistrement en table liee
					 */
					$documentLie = new DocumentLie ( $bdd, $ObjetBDDParam, 'biopsie' );
					$data = array (
							"document_id" => $document_id,
							"biopsie_id" => $id
					);
					$documentLie->ecrire ( $data );
					/*
					 * Ajout de l'information pour le poisson
					 */
					$documentPoisson = new DocumentLie($bdd, $ObjetBDDParam, "poisson");
					$data["poisson_id"] = $dataClass->getPoissonId($id);
					$documentPoisson->ecrire($data);
				}
			}
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