<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 11 mars 2015
 */
include_once 'modules/classes/bassinCampagne.class.php';
$dataClass = new ProfilThermique($bdd,$ObjetBDDParam);
$keyName = "profil_thermique_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->lire($id);
		$smarty->assign("data", $data);
		$smarty->assign("corps", "repro/profilThermiqueChange.tpl");
		break;
	case "new":
		$id = 0;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = dataRead($dataClass, $id, "repro/profilThermiqueChange.tpl", $_REQUEST["bassin_campagne_id"]);
		/*
		 * Recuperation des donnees du bassin
		 */
		require_once 'modules/classes/bassin.class.php';
		$bassinCampagne = new BassinCampagne($bdd, $ObjetBDDParam);
		$dataBassinCampagne = $bassinCampagne->lire($data["bassin_campagne_id"]);
		$bassin = new Bassin($bdd, $ObjetBDDParam);
		$smarty->assign("dataBassinCampagne", $dataBassinCampagne);
		$smarty->assign("dataBassin", $bassin->lire($dataBassinCampagne["bassin_id"]));
		/*
		 * Recuperation des donnees de temperature deja existantes
		 */
		$profilThermiques = $dataClass->getListFromBassinCampagne($data["bassin_campagne_id"]);
		$smarty->assign("profilThermiques", $profilThermiques );
		/*
		 * Assignation des valeurs par defaut en prenant en reference la derniere valeur entree
		 */
		$nbProfil = count($profilThermiques);
		if ($nbProfil > 0 && $id == 0) {
			$data["pf_datetime"] =  $profilThermiques[$nbProfil - 1]["pf_datetime"];
			//$data["profil_thermique_type_id"] = $profilThermiques[$nbProfil - 1]["profil_thermique_type_id"];
			$smarty->assign("data", $data);			
		}
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