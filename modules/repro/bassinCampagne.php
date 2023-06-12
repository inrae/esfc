<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 10 mars 2015
 */

require_once 'modules/classes/bassinCampagne.class.php';
$dataClass = new BassinCampagne($bdd, $ObjetBDDParam);
$keyName = "bassin_campagne_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->lire($id);
		$vue->set($data, "dataBassinCampagne");
		$vue->set("repro/bassinCampagneDisplay.tpl", "corps");
		/*
		 * Recuperation des donnees du profil thermique
		 */
		require_once "modules/classes/profilThermique.class.php";
		$profilThermique = new ProfilThermique($bdd, $ObjetBDDParam);
		$vue->set($profilThermique->getListFromBassinCampagne($id), "profilThermiques");
		/*
		 * Calcul des donnees pour le graphique
		 */

		for ($i = 1; $i < 3; $i++) {
			$datapf = $profilThermique->getValuesFromBassinCampagne($id, $_SESSION["annee"], $i);
			$x = "'x" . $i . "'";
			if ($i == 1) {
				$y = "'constaté'";
			} else $y = "'prévu'";
			foreach ($datapf as $key => $value) {
				$x .= ",'" . $value["pf_datetime"] . "'";
				$y .= "," . $value["pf_temperature"];
			}
			$vue->set($x, "pfx" . $i);
			$vue->set($y, "pfy" . $i);
		}
		/*
		 * Donnes de salinite
		 */
		require_once "modules/classes/salinite.class.php";
		$salinite = new Salinite($bdd, $ObjetBDDParam);
		$vue->set($salinite->getListFromBassinCampagne($id), "salinites");
		/*
		 * Calcul des donnees pour le graphique
		 */
		for ($i = 1; $i < 3; $i++) {
			$datapf = $salinite->getValuesFromBassinCampagne($id, $_SESSION["annee"], $i);

			$x = "'x" . $i . "'";
			if ($i == 1) {
				$y = "'constaté'";
			} else $y = "'prévu'";
			foreach ($datapf as $key => $value) {
				$x .= ",'" . $value["salinite_datetime"] . "'";
				$y .= "," . $value["salinite_tx"];
			}
			$vue->set($x, "sx" . $i);
			$vue->set($y, "sy" . $i);
		}
		/*
		 * Recuperation des donnees du bassin
		 */
		require_once 'modules/classes/bassin.class.php';
		$bassin = new Bassin($bdd, $ObjetBDDParam);
		$vue->set($bassin->lire($data["bassin_id"]), "dataBassin");
		/*
		 * Recuperation de la liste des poissons presents
		 */
		require_once 'modules/classes/transfert.class.php';
		$transfert = new Transfert($bdd, $ObjetBDDParam);
		$vue->set($transfert->getListPoissonPresentByBassin($data["bassin_id"]), "dataPoisson");
		/*
		 * Calcul de la date du jour
		 */
		$vue->set(date("d/m/Y"), "dateJour");
		/*
		 * Recuperation des evenements
		*/
		require_once "modules/classes/bassinEvenement.class.php";
		$bassinEvenement = new BassinEvenement($bdd, $ObjetBDDParam);
		$vue->set($bassinEvenement->getListeByBassin($data["bassin_id"]), "dataBassinEvnt");
		$vue->set($_SESSION["bassinParentModule"], "bassinParentModule");
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
	case "init":
		/*
		 * Initialisation des bassins pour la campagne
		 */
		if ($_REQUEST["annee"] > 0) {
			$nb = $dataClass->initCampagne($_REQUEST["annee"]);
			$message->set(sprintf(_("%s bassin(s) ajouté(s) à la campagne de reproduction"), $nb));
		}
		$module_coderetour = 1;
}
