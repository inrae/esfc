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

		require_once 'modules/classes/poissonRepro.class.php';
		$poissonCampagne = new PoissonCampagne($bdd, $ObjetBDDParam);
		$vue->set( , "");("annees", $poissonCampagne->getAnnees());
		$vue->set( , "");("lots", $dataClass->getLotByAnnee($_SESSION["annee"]));
		$vue->set( , "");("corps", "repro/lotSearch.tpl");
		$vue->set( , "");("dataAlim", $alimJuv->getParam());
		/**
		 * Site
		 */
		require_once 'modules/classes/site.class.php';
		$site = new Site($bdd, $ObjetBDDParam);
		$vue->set( , "");("site", $site->getListe(2));
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->getDetail($id);
		$vue->set( , "");("dataLot", $data);
		$vue->set( , "");("corps", "repro/lotDisplay.tpl");
		/*
		 * Recuperation de la liste des mesures
		 */
		$lotMesure = new LotMesure($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataMesure", $lotMesure->getListFromLot($id));
		/*
		 * Recuperation de la liste des bassins
		 */
		require_once 'modules/classes/bassin.class.php';
		$bassinLot = new BassinLot($bdd, $ObjetBDDParam);
		$vue->set( , "");("bassinLot", $bassinLot->getListeFromLot($id));
		/*
		 * Lecture des devenirs d'un lot
		 */
		require_once 'modules/classes/devenir.class.php';
		$devenir = new Devenir($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataDevenir", $devenir->getListFromLot($id));
		$vue->set( , "");("devenirOrigine", "lot");

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
		$vue->set( , "");("croisements", $croisement->getListFromAnnee($_SESSION["annee"]));
		/*
		 * Lecture de la liste des marquages VIE
		 */
		$vieModele = new VieModele($bdd, $ObjetBDDParam);
		$vue->set( , "");("modeles", $vieModele->getModelesFromAnnee($_SESSION["annee"]));
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
				require_once 'modules/classes/sequence.class.php';
				$poissonSequence = new PoissonSequence($bdd, $objetBDDParam);
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

?>