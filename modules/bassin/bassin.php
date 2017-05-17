<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 4 mars 2014
 */
require_once 'modules/bassin/bassin.functions.php';

include_once 'modules/classes/bassin.class.php';
$dataClass = new Bassin ( $bdd, $ObjetBDDParam );
$keyName = "bassin_id";
if (isset ( $_REQUEST [$keyName] )) {
	$id = $_REQUEST [$keyName];
} elseif (isset ( $_SESSION ["bassin_id"] )) {
	$id = $_SESSION ["bassin_id"];
} else
	$id = - 1;

switch ($t_module ["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		include "modules/bassin/bassinSearch.php";
		if ($searchBassin->isSearch () == 1) {
			$data = $dataClass->getListeSearch ( $dataSearch );
			$smarty->assign ( "data", $data );
		}
		/*
		 * Preparation des dates pour la generation du recapitulatif des aliments
		 */
		! isset ( $_REQUEST ["dateFin"] ) ? $dateFin = date ( "d/m/Y" ) : $dateFin = $_REQUEST ["dateFin"];
		! isset ( $_REQUEST ["dateDebut"] ) ? $dateDebut = date ( "d/m/" ) . (date ( "Y" ) - 1) : $dateDebut = $_REQUEST ["dateDebut"];
		$smarty->assign ( "dateDebut", $dateDebut );
		$smarty->assign ( "dateFin", $dateFin );
		$smarty->assign ( "corps", "bassin/bassinList.tpl" );
		$_SESSION ["bassinParentModule"] = "bassinList";
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->getDetail ( $id );
		$smarty->assign ( "dataBassin", $data );
		/*
		 * Recuperation de la liste des poissons presents
		 */
		include_once 'modules/classes/poisson.class.php';
		$transfert = new Transfert ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "dataPoisson", $transfert->getListPoissonPresentByBassin ( $id ) );
		/*
		 * Recuperation des evenements
		 */
		$bassinEvenement = new BassinEvenement ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "dataBassinEvnt", $bassinEvenement->getListeByBassin ( $id ) );
		/*
		 * Recuperation des aliments consommés sur la période déterminée
		 */
		include_once 'modules/classes/aliment.class.php';
		$distribQuotidien = new DistribQuotidien ( $bdd, $ObjetBDDParam );
		/*
		 * Dates de recherche
		 */
		$searchAlimentation->setParam ( $_REQUEST );
		$param = $searchAlimentation->getParam ();
		$smarty->assign ( "searchAlim", $param );
		$smarty->assign ( "dataAlim", $distribQuotidien->getListeConsommation ( $id, $param ["date_debut"], $param ["date_fin"] ) );
		$smarty->assign ( "alimentListe", $distribQuotidien->alimentListe );
		/*
		 * Gestion des documents associes
		 */
		$smarty->assign ( "moduleParent", "bassinDisplay" );
		$smarty->assign ( "parentType", "bassin" );
		$smarty->assign ( "parentIdName", "bassin_id" );
		$smarty->assign ( "parent_id", $id );
		require_once 'modules/document/documentFunctions.php';
		$smarty->assign ( "dataDoc", getListeDocument ( "bassin", $id, $_REQUEST["document_limit"], $_REQUEST["document_offset"] ) );
		/*
		 * Affichage
		 */
		$smarty->assign ( "corps", "bassin/bassinDisplay.tpl" );
		$smarty->assign ( "bassinParentModule", $_SESSION ["bassinParentModule"] );
		$_SESSION ["poissonDetailParent"] = "bassinDisplay";
		$_SESSION ["bassin_id"] = $id;
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead ( $dataClass, $id, "bassin/bassinChange.tpl" );
		/*
		 * Integration des tables de parametres
		 */
		include 'modules/bassin/bassinParamAssocie.php';
		$smarty->assign ( "bassinParentModule", $_SESSION ["bassinParentModule"] );
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
	case "calculMasseAjax" :
		include_once 'modules/classes/poisson.class.php';
		if ($_REQUEST ["bassin_id"] > 0) {
			$masse = $dataClass->calculMasse ( $_REQUEST ["bassin_id"] );
			$masseJson = '{"0": {"val": "' . $masse . '" } }';
			echo $masseJson;
		}
		break;
	case "recapAlim" :
		$data = $dataClass->getRecapAlim ( $_REQUEST, $searchBassin->getParam () );
		ob_clean();
		download_send_headers("sturio_bassin_alim_recap_" . date("Y-m-d") . ".csv");
		echo array2csv($data);
		die();
		break;
}
?>