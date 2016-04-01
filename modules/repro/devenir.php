<?php
/**
 * @author : quinton
 * @date : 1 févr. 2016
 * @encoding : UTF-8
 * (c) 2016 - All rights reserved
 */
include_once 'modules/classes/devenir.class.php';
$dataClass = new Devenir ( $bdd, $ObjetBDDParam );
$keyName = "devenir_id";
$id = $_REQUEST [$keyName];

switch ($t_module ["param"]) {
	case "list" :
		include "modules/repro/setAnnee.php";
		$smarty->assign ( "dataDevenir", $dataClass->getListeFull ( $_SESSION ["annee"] ) );
		$smarty->assign ( "corps", "repro/devenirCampagneList.tpl" );
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = dataRead ( $dataClass, $id, "repro/devenirChange.tpl", $_REQUEST ["lot_id"] );
		$smarty->assign ( "devenirOrigine", $_REQUEST ["devenirOrigine"] );
		/*
		 * Lecture des tables de parametres
		 */
		require_once 'modules/classes/categorie.class.php';
		$categorie = new Categorie ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "categories", $categorie->getListe ( 1 ) );
		require_once 'modules/classes/poisson.class.php';
		$sortie = new SortieLieu ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "sorties", $sortie->getListe ( 2 ) );
		$devenirType = new DevenirType ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "devenirType", $devenirType->getListe ( 1 ) );
		/*
		 * Lecture du lot
		 */
		if ($data ["lot_id"] > 0) {
			require_once 'modules/classes/lot.class.php';
			$lot = new Lot ( $bdd, $ObjetBDDParam );
			$smarty->assign ( "dataLot", $lot->getDetail ( $data [lot_id] ) );
		}
		/*
		 * Recuperation de la liste des devenirs parents potentiels
		 */
		if ($data ["lot_id"] > 0) {
			$lotId = $data ["lot_id"];
			$annee = 0;
		} else {
			$lotId = 0;
			$annee = $_SESSION ["annee"];
		}
		$parents = $dataClass->getParentsPotentiels ( $data ["devenir_id"], $lotId, $annee );
		$smarty->assign("devenirParent", $parents);
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