<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 12 mars 2015
 */

require_once 'modules/classes/croisement.class.php';
$dataClass = new Croisement($bdd, $ObjetBDDParam);
$keyName = "croisement_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
	case "list":
		isset($_COOKIE["annee"]) ? $year = $_COOKIE["annee"]: $year = 0;
		$vue->set($dataClass->getListCroisements($year),"croisements");
		$vue->set("repro/croisementListAll.tpl", "corps");
		$vue->set($year, "annee");
		require_once "modules/classes/poissonCampagne.class.php";
		$pc = new PoissonCampagne($bdd, $ObjetBDDParam);
		$vue->set($pc->getAnnees(), "annees");
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->getDetail($id);
		$vue->set($data, "data");
		/*
		 * Lecture de la sequence
		 */
		require_once "modules/classes/sequence.class.php";
		$sequence = new Sequence($bdd, $ObjetBDDParam);
		$vue->set($sequence->lire($data["sequence_id"]), "dataSequence");

		/*
		 * Recherche des spermes utilises
		 */
		require_once 'modules/classes/spermeUtilise.class.php';
		$spermeUtilise = new SpermeUtilise($bdd, $ObjetBDDParam);
		$vue->set($spermeUtilise->getListFromCroisement($id), "spermesUtilises");

		$vue->set("repro/croisementDisplay.tpl", "corps");
		break;
	case "change":

		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = dataRead($dataClass, $id, "repro/croisementChange.tpl", $_REQUEST["sequence_id"]);
		/*
		 * Lecture de la table des qualites de croisement
		 */
		require_once "modules/classes/croisementQualite.class.php";
		$croisementQualite = new CroisementQualite($bdd, $ObjetBDDParam);
		$vue->set($croisementQualite->getListe(1), "croisementQualite");
		/*
		 * Lecture des poissons rattaches
		 */
		require_once 'modules/classes/poissonSequence.class.php';
		if ($id > 0) {
			$vue->set($dataClass->getListAllPoisson($id, $data["sequence_id"]), "poissonSequence");
		} else {
			$poissonSequence = new PoissonSequence($bdd, $objetBDDParam);
			$vue->set($poissonSequence->getListFromSequence($data["sequence_id"]), "poissonSequence");
		}
		/*
		 * Lecture de la sequence
		 */
		require_once "modules/classes/sequence.class.php";
		$sequence = new Sequence($bdd, $ObjetBDDParam);
		$vue->set($sequence->lire($data["sequence_id"]), "dataSequence");
		break;
	case "write":
		/*
		 * write record in database
		 */
		$id = dataWrite($dataClass, $_REQUEST);
		if ($id > 0) {
			$_REQUEST[$keyName] = $id;
			/*
			 * Mise a jour du statut dans poisson_sequence
			 */
			require_once "modules/classes/poissonSequence.class.php";
			$poissonSequence = new PoissonSequence($bdd, $objetBDDParam);
			foreach ($_REQUEST["poisson_campagne_id"] as $key => $value) {
				$poissonSequence->updateStatutFromPoissonCampagne($value, $_REQUEST["sequence_id"], 5);
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
