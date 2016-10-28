<?php
/**
 * Created : 28 oct. 2016
 * Creator : quinton
 * Encoding : UTF-8
 * Copyright 2016 - All rights reserved
 */
include_once 'modules/classes/sperme.class.php';
$dataClass = new SpermeCongelation ( $bdd, $ObjetBDDParam );
$keyName = "sperme_congelation_id";
$id = $_REQUEST [$keyName];

switch ($t_module ["param"]) {
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead ( $dataClass, $id, "repro/spermeCongelationChange.tpl", $_REQUEST ["sperme_id"] );
		/*
		 * Recherche des dilueurs
		 */
		$dilueur = new SpermeDilueur($bdd, $ObjetBDDParam);
		$smarty->assign("spermeDilueur", $dilueur->getListe(2));

		/*
		 * Donnees du poisson
		 */
		require_once 'modules/classes/poissonRepro.class.php';
		$poissonCampagne = new PoissonCampagne ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "dataPoisson", $poissonCampagne->lire ( $_REQUEST ["poisson_campagne_id"] ) );
		
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