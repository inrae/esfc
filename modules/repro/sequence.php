<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 5 mars 2015
 */
require_once 'modules/classes/sequence.class.php';
$dataClass = new Sequence($bdd, $ObjetBDDParam);
$keyName = "sequence_id";
$id = $_REQUEST[$keyName];

/*
 * Prepositionnement de l'annee
*/
require "modules/repro/setAnnee.php";
switch ($t_module["param"]) {
	case "list":
		$vue->set($dataClass->getListeByYear($_SESSION["annee"], $_REQUEST["site_id"]), "data");
		$vue->set("repro/sequenceList.tpl", "corps");
		/*
		 * Recuperation des donnees concernant les bassins
		 */
		require_once 'modules/classes/bassinCampagne.class.php';
		$bassinCampagne = new BassinCampagne($bdd, $ObjetBDDParam);
		$vue->set($bassinCampagne->getListFromAnnee($_SESSION['annee'], $_REQUEST["site_id"]), "bassins");
		$_SESSION["bassinParentModule"] = "sequenceList";
		require_once 'modules/classes/site.class.php';
		$site = new Site($bdd, $ObjetBDDParam);
		$vue->set($site->getListe(2), "site");

		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$vue->set($dataClass->lire($id), "dataSequence");
		$vue->set("repro/sequenceDisplay.tpl", "corps");
		require_once "modules/classes/poissonSequence.class.php";
		$poissonSequence = new PoissonSequence($bdd, $ObjetBDDParam);
		$vue->set($poissonSequence->getListFromSequence($id), "dataPoissons");
		$_SESSION["poissonDetailParent"] = "sequenceDisplay";
		$_SESSION["sequence_id"] = $id;
		/*
		 * Préparation des croisements
		 */
		require_once 'modules/classes/croisement.class.php';
		$croisement = new Croisement($bdd, $ObjetBDDParam);
		$croisements = $croisement->getListFromSequence($id);
		/*
		 * Recuperation du nombre de larves comptees
		 */
		require_once 'modules/classes/lot.class.php';
		$lot = new Lot($bdd, $ObjetBDDParam);
		foreach ($croisements as $key => $value) {
			$totalLot = $lot->getNbLarveFromCroisement($value["croisement_id"]);
			$croisements[$key]["total_larve_compte"] = $totalLot["total_larve_compte"];
		}
		$vue->set($croisements, "croisements");
		/*
		 * Preparation des lots
		 */
		$vue->set($lot->getLotBySequence($id), "lots");
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = dataRead($dataClass, $id, "repro/sequenceChange.tpl", $_REQUEST["idParent"]);
		if ($id == 0) {
			/*
			 * Positionnement correct de la session par rapport à l'année courante
			 */
			$data["annee"] = $_SESSION["annee"];
			$vue->set($data, "data");
		}
		require_once 'modules/classes/site.class.php';
		$site = new Site($bdd, $ObjetBDDParam);
		$vue->set($site->getListe(2), "site");
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
