<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 13 mars 2015
 */
include_once 'modules/classes/lot.class.php';
$dataClass = new Lot($bdd,$ObjetBDDParam);
$keyName = "lot_id";
$id = $_REQUEST[$keyName];
if ($_REQUEST["annee"] > 0)
	$_SESSION["annee"] = $_REQUEST["annee"];
if (! isset ( $_SESSION ["annee"] ))
	$_SESSION ["annee"] = date ( 'Y' );
$smarty->assign ( "annee", $_SESSION ["annee"] );

switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */

		require_once 'modules/classes/poissonRepro.class.php';
		$poissonCampagne = new PoissonCampagne($bdd, $ObjetBDDParam);
		$smarty->assign ( "annees", $poissonCampagne->getAnnees () );
		$smarty->assign("lots", $dataClass->getLotByAnnee($_SESSION["annee"]));
		$smarty->assign("corps", "repro/lotList.tpl");
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->getDetail($id);
		$smarty->assign("dataLot", $data);
		$smarty->assign("corps", "repro/lotDisplay.tpl");
		/*
		 * Recuperation de la liste des mesures
		 */
		$lotMesure = new LotMesure($bdd, $ObjetBDDParam);
		$smarty->assign("dataMesure", $lotMesure->getListFromLot($id));
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead($dataClass, $id, "repro/lotChange.tpl", $_REQUEST["sequence_id"]);
		/*
		 * Lecture de la liste des sequences
		 */
		require_once 'modules/classes/croisement.class.php';
		$croisement = new Croisement($bdd, $ObjetBDDParam);
		$smarty->assign("croisements", $croisement->getListFromAnnee($_SESSION["annee"]));
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