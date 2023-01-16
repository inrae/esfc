<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 25 mars 2015
 */
 
include_once 'modules/classes/sperme.class.php';
$dataClass = new Sperme($bdd,$ObjetBDDParam);
$keyName = "sperme_id";
$id = $_REQUEST[$keyName];
/*
 * Passage en parametre de la liste parente
 */
$smarty->assign ( "poissonDetailParent", $_SESSION ["poissonDetailParent"] );

switch ($t_module["param"]) {
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->lire($id);
		$smarty->assign("data", $data);
		/*
		 * Recherche des caracteristiques particulieres
		 */
		$caract = new SpermeCaracteristique($bdd, $ObjetBDDParam);
		$smarty->assign("spermeCaract", $caract->getFromSperme($id));
		/*
		 * Recherche des mesures effectuees
		 */
		$mesure = new SpermeMesure($bdd, $ObjetBDDParam);
		$smarty->assign("dataMesure", $mesure->getListFromSperme($id));
		$smarty->assign("corps", "repro/spermeDisplay.tpl");
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = dataRead($dataClass, $id, "repro/spermeChange.tpl", $_REQUEST["poisson_campagne_id"]);
		require_once 'modules/repro/spermeFunction.php';
		initSpermeChange($id);
		/*
		 * Donnees du poisson
		 */
		if (!isset($_REQUEST["poisson_campagne_id"]))
		    $_REQUEST["poisson_campagne_id"] = $data["poisson_campagne_id"];
		require_once 'modules/classes/poissonRepro.class.php';
		$poissonCampagne = new PoissonCampagne($bdd, $ObjetBDDParam);
		$smarty->assign("dataPoisson", $poissonCampagne->lire($_REQUEST["poisson_campagne_id"]));
		$smarty->assign ("sequences", $poissonCampagne->getListSequence($_REQUEST["poisson_campagne_id"], $_SESSION["annee"]));
		
		break;
	case "write":
		/*
		 * write record in database
		 */
		$id = dataWrite($dataClass, $_REQUEST);
		if ($id > 0) {
			$_REQUEST[$keyName] = $id;
			/*
			 * Mise a jour du statut du poisson_sequence
			 */
			require_once 'modules/classes/sequence.class.php';
			$poissonSequence = new PoissonSequence($bdd, $ObjetBDDParam);
			$poissonSequence->updateStatutFromPoissonCampagne($_REQUEST["poisson_campagne_id"], $_REQUEST["sequence_id"], 4);
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