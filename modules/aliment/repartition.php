<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 21 mars 2014
 */
include_once 'modules/classes/aliment.class.php';
$dataClass = new Repartition($bdd,$ObjetBDDParam);
$keyName = "repartition_id";
$id = $_REQUEST[$keyName];
switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		/*
		 * Gestion des variables de recherche
		*/
		$searchRepartition->setParam ( $_REQUEST );
		$dataSearch = $searchRepartition->getParam ();
		if ($_REQUEST["next"] > 0 ) {
			$dataSearch["offset"] = $dataSearch["offset"] + $dataSearch["limit"];
			$searchRepartition->setParam("offset",$dataSearch["offset"]);
		}
		if ($_REQUEST["previous"] > 0) {
			$dataSearch["offset"] = $dataSearch["offset"] - $dataSearch["limit"];
			if ($dataSearch["offset"] < 0) $dataSearch["offset"] = 0;
			$searchRepartition->setParam("offset",$dataSearch["offset"]);
		}
		if ($searchRepartition->isSearch () == 1) {
			$smarty->assign ( "isSearch", 1 );
			$dataList = $dataClass->getListSearch ( $dataSearch );
			/*
			 * Preparation de la creation ex-nihilo d'une repartition
			 */
			$jour = date ("w");
			$jour_array = array (0=>1, 1=>0, 2=>6, 3=>5, 4=>4, 5=>3, 6=>2);
			$data = array();
			$date = new DateTime();
			$date->add(new DateInterval('P'. $jour_array[$jour].'D'));
			$data["date_debut_periode"] = $date->format('d/m/Y');
			$date->add(new DateInterval('P6D'));
			$data["date_fin_periode"] = $date->format ('d/m/Y');
			$data["repartition_id"] = 0;
			$data["lundi"] = 1;
			$data["mardi"] = 1;
			$data["mercredi"] = 1;
			$data["jeudi"] = 1;
			$data["vendredi"] = 1;
			$data["samedi"] = 1;
			$data["dimanche"] = 1;
			$smarty->assign("data", $data);
		}
		$smarty->assign ( "repartitionSearch", $dataSearch );
		$smarty->assign("dataList", $dataList);
		$smarty->assign("corps", "aliment/repartitionList.tpl");
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
		$data = dataRead($dataClass, $id, "aliment/repartitionChange.tpl");
		/*
		 * Recherche de la categorie
		*/
		$categorie = new Categorie ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "categorie", $categorie->getListe ( 2 ) );
		/*
		 * Recuperation des bassins associes et des distributions
		 */
		if ($data["categorie_id"] > 0) {
			$distribution = new Distribution($bdd, $ObjetBDDParam);
			$dataBassin = $distribution->getFromRepartitionWithBassin($id, $data["categorie_id"]);
			$smarty->assign ("dataBassin", $dataBassin);
			/*
			 * Recuperation des modèles de distribution actifs
			 */
			$template = new RepartTemplate($bdd, $ObjetBDDParam);
			$smarty->assign("dataTemplate", $template->getListActifFromCategorie($data["categorie_id"]));
		}
		break;
	case "create":
		/*
		 * Creation d'une repartition vierge
		 */
		$id = dataWrite($dataClass, $_REQUEST);
		if ($id > 0) {
			$_REQUEST[$keyName] = $id;
		}
		break;
	case "duplicate":
		/*
		 * Creation d'une nouvelle repartition a partir d'une existante
		 */
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