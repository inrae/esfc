<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 5 mars 2015
 */
include_once 'modules/classes/sequence.class.php';
include_once 'modules/classes/poissonRepro.class.php';
$dataClass = new Sequence($bdd,$ObjetBDDParam);
$keyName = "sequence_id";
$id = $_REQUEST[$keyName];

/*
 * Prepositionnement de l'annee
*/
if (isset($_REQUEST["annee"]))
	$_SESSION["annee"] = $_REQUEST["annee"];

if (!isset($_SESSION["annee"])) {
	$poissonCampagne = new poissonCampagne($bdd, $ObjetBDDParam);
	$annees = $poissonCampagne->getAnnees();
	if (is_array($annees)) {
		$_SESSION["annee"] = $annees[0]["annee"]; 
	} else
		$_SESSION["annee"] = date ('Y');
}
$smarty->assign("annee", $_SESSION["annee"]);

switch ($t_module["param"]) {
	case "list":
		$poissonCampagne = new poissonCampagne($bdd, $ObjetBDDParam);
		$smarty->assign("annees", $poissonCampagne->getAnnees());
		$smarty->assign("data", $dataClass->getListeByYear($_SESSION["annee"]));
		$smarty->assign("corps", "repro/sequenceList.tpl");
		/*
		 * Recuperation des donnees concernant les bassins
		 */
		require_once 'modules/classes/bassinCampagne.class.php';
		$bassinCampagne = new BassinCampagne($bdd, $ObjetBDDParam);
		$smarty->assign("bassins", $bassinCampagne->getListFromAnnee($_SESSION['annee']));
		$_SESSION["bassinParentModule"] = "sequenceList";
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->lire($id);
		$smarty->assign("dataSequence", $data);
		$smarty->assign("corps", "repro/sequenceDisplay.tpl");
		$poissonSequence = new PoissonSequence($bdd, $ObjetBDDParam);
		$smarty->assign("dataPoissons", $poissonSequence->getListFromSequence($id));
		$_SESSION["poissonDetailParent"] = "sequenceDisplay";
		$_SESSION["sequence_id"] = $id;
		require_once 'modules/classes/croisement.class.php';
		$croisement = new Croisement($bdd, $ObjetBDDParam);
		$smarty->assign("croisements", $croisement->getListFromSequence($id));
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data=dataRead($dataClass, $id, "repro/sequenceChange.tpl", $_REQUEST["idParent"]);
		if($id==0) {
			/*
			 * Positionnement correct de la session par rapport à l'année courante
			 */
			$data["annee"] = $_SESSION["annee"];
			$smarty->assign("data", $data);
		}
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