<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 9 mars 2015
 */
include_once 'modules/classes/poissonSequence.class.php';
$dataClass = new PoissonSequence($bdd, $ObjetBDDParam);
$keyName = "poisson_sequence_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = dataRead($dataClass, $id, "repro/poissonSequenceChange.tpl", $_REQUEST["poisson_campagne_id"]);
		require_once "modules/classes/poissonCampagne.class.php";
		$poissonCampagne = new PoissonCampagne($bdd, $ObjetBDDParam);
		$vue->set($poissonCampagne->lire($data["poisson_campagne_id"]), "dataPoisson");
		require_once "modules/classes/psEvenement.class.php";
		$psEvenement = new PsEvenement($bdd, $ObjetBDDParam);
		$vue->set($psEvenement->getListeFromPoissonSequence($id), "evenements");
		/*
		 * Recherche les donnees concernant la production de sperme
		 */
		require_once 'modules/classes/sperme.class.php';
		$sperme = new Sperme($bdd, $ObjetBDDParam);
		$dataSperme = $sperme->lireFromSequence($data["poisson_campagne_id"], $data["sequence_id"]);
		foreach ($dataSperme as $key => $value)
			$data[$key] = $value;
		$vue->set($data, "data");
		require_once 'modules/repro/spermeFunction.php';
		initSpermeChange($dataSperme["sperme_id"]);

		/*
		 * Recuperation de la liste des sequences
		 */
		require_once "modules/classes/sequence.class.php";
		$sequence = new Sequence($bdd, $ObjetBDDParam);
		$vue->set($sequence->getListeByYear($_SESSION['annee']), "sequences");
		/*
		 * Recuperation des statuts
		 */
		require_once "modules/classes/psStatut.class.php";
		$psStatut = new PsStatut($bdd, $ObjetBDDParam);
		$vue->set($psStatut->getListe(1), "statuts");
		/*
		 * Passage en parametre de la liste parente
		 */
		$vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
		if (isset($_REQUEST["sequence_id"])) {
			$vue->set($_REQUEST["sequence_id"], "sequence_id");
		}
		break;
	case "write":
		/*
		 * write record in database
		 */
		require_once 'modules/classes/sperme.class.php';
		$id = dataWrite($dataClass, $_REQUEST);
		if ($id > 0) {
			$_REQUEST[$keyName] = $id;
			if (strlen($_REQUEST["sperme_date"]) > 0 || $_REQUEST["sperme_id"] > 0) {
				require_once "modules/classes/sperme.class.php";
				$sperme = new Sperme($bdd, $ObjetBDDParam);
				dataWrite($sperme, $_REQUEST);
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
