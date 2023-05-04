<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 13 mars 2015
 */
include_once 'modules/classes/lot.class.php';
$dataClass = new Lot($bdd, $ObjetBDDParam);
$keyName = "lot_id";
$id = $_REQUEST[$keyName];

include "modules/repro/setAnnee.php";

switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */

		require_once 'modules/classes/poissonCampagne.class.php';
		$poissonCampagne = new PoissonCampagne($bdd, $ObjetBDDParam);
		$vue->set($poissonCampagne->getAnnees(), "annees");
		$vue->set($dataClass->getLotByAnnee($_SESSION["annee"]), "lots");
		$vue->set("repro/lotSearch.tpl", "corps");
		$vue->set($alimJuv->getParam(), "dataAlim");
		/**
		 * Site
		 */
		require_once 'modules/classes/site.class.php';
		$site = new Site($bdd, $ObjetBDDParam);
		$vue->set($site->getListe(2), "site");
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->getDetail($id);
		$vue->set($data, "dataLot");
		$vue->set("repro/lotDisplay.tpl", "corps");
		/*
		 * Recuperation de la liste des mesures
		 */
		require_once "modules/classes/lotMesure.class.php";
		$lotMesure = new LotMesure($bdd, $ObjetBDDParam);
		$vue->set($lotMesure->getListFromLot($id), "dataMesure");
		/*
		 * Recuperation de la liste des bassins
		 */
		require_once 'modules/classes/bassinLot.class.php';
		$bassinLot = new BassinLot($bdd, $ObjetBDDParam);
		$vue->set($bassinLot->getListeFromLot($id), "bassinLot");
		/*
		 * Lecture des devenirs d'un lot
		 */
		require_once 'modules/classes/devenir.class.php';
		$devenir = new Devenir($bdd, $ObjetBDDParam);
		$vue->set($devenir->getListFromLot($id), "dataDevenir");
		$vue->set("lot", "devenirOrigine");

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
		$vue->set($croisement->getListFromAnnee($_SESSION["annee"]), "croisements");
		/*
		 * Lecture de la liste des marquages VIE
		 */
		require_once "modules/classes/vieModele.class.php";
		$vieModele = new VieModele($bdd, $ObjetBDDParam);
		$vue->set($vieModele->getModelesFromAnnee($_SESSION["annee"]), "modeles");
		break;
	case "write":
		/*
		 * write record in database
		 */
		$id = dataWrite($dataClass, $_REQUEST);
		if ($id > 0) {
			$_REQUEST[$keyName] = $id;
			if ($_REQUEST["nb_larve_initial"] > 0) {
				/*
				 * Mise a jour du statut des poissons
				 */
				require_once 'modules/classes/poissonSequence.class.php';
				$poissonSequence = new PoissonSequence($bdd, $objetBDDParam);
				require_once "modules/classes/croisement.class.php";
				$croisement = new Croisement($bdd, $ObjetBDDParam);
				$dataCroisement = $croisement->lire($_REQUEST["croisement_id"]);
				$poissons = $croisement->getPoissonsFromCroisement($_REQUEST["croisement_id"]);
				foreach ($poissons as $key => $value) {
					$poissonSequence->updateStatutFromPoissonCampagne($value["poisson_campagne_id"], $dataCroisement["sequence_id"], 6);
				}
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
