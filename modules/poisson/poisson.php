<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 25 févr. 2014
 */
include_once 'modules/classes/poisson.class.php';
$dataClass = new Poisson($bdd, $ObjetBDDParam);
$keyName = "poisson_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
	case "list":
		include "modules/poisson/poissonSearch.php";
		if ($_SESSION["searchPoisson"]->isSearch() == 1) {
			$data = $dataClass->getListeSearch($dataSearch);
			$vue->set($data, "data");
		}
		$_SESSION["poissonDetailParent"] = "poissonList";
		$vue->set("poisson/poissonList.tpl", "corps");
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->getDetail($id);
		$vue->set($data, "dataPoisson");
		/*
		 * Passage en parametre de la liste parente
		 */
		$vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
		$classes = array(
			"evenement",
			"categorie",
			"poissonStatut",
			"morphologie",
			"genderSelection",
			"pathologie",
			"pittag",
			"transfert",
			"mortalite",
			"cohorte",
			"sortie",
			"echographie",
			"anesthesie",
			"ventilation",
			"poissonCampagne",
			"dosageSanguin",
			"genetique",
			"parente",
			"lot",
			"vieModele",
			"sexe",
			"pittagType",
			"anomalie",
			"parentPoisson"
		);
		foreach ($classes as $classe) {
			require_once "modules/classes/$classe.class.php";
		}
		/*
		 * Recuperation des morphologies
		 */
		$morphologie = new Morphologie($bdd, $ObjetBDDParam);
		$vue->set($morphologie->getListeByPoisson($id), "dataMorpho");
		/*
		 * Recuperation des événements
		 */
		$evenement = new Evenement($bdd, $ObjetBDDParam);
		$vue->set($evenement->getEvenementByPoisson($id), "dataEvenement");
		/*
		 * Recuperation du sexage
		 */
		$gender_selection = new Gender_selection($bdd, $ObjetBDDParam);
		$vue->set($gender_selection->getListByPoisson($id), "dataGender");
		/*
		 * Recuperation des pathologies
		 */
		$pathologie = new Pathologie($bdd, $ObjetBDDParam);
		$vue->set($pathologie->getListByPoisson($id), "dataPatho");
		/*
		 * Recuperation des pittag
		 */
		$pittag = new Pittag($bdd, $ObjetBDDParam);
		$vue->set($pittag->getListByPoisson($id), "dataPittag");
		/*
		 * Recuperation des transferts
		 */
		$transfert = new Transfert($bdd, $ObjetBDDParam);
		$vue->set($transfert->getListByPoisson($id), "dataTransfert");
		/*
		 * Recuperation des mortalites
		 */
		$mortalite = new Mortalite($bdd, $ObjetBDDParam);
		$vue->set($mortalite->getListByPoisson($id), "dataMortalite");
		/*
		 * Recuperation des cohortes
		*/
		$cohorte = new Cohorte($bdd, $ObjetBDDParam);
		$vue->set($cohorte->getListByPoisson($id), "dataCohorte");
		/*
		 * Recuperation des parents
		 */
		$parent = new ParentPoisson($bdd, $ObjetBDDParam);
		$vue->set($parent->getListParent($id), "dataParent");
		/*
		 * Recuperation des anomalies
		 */
		$anomalie = new Anomalie_db($bdd, $ObjetBDDParam);
		$vue->set($anomalie->getListByPoisson($id), "dataAnomalie");
		/*
		 * Recuperation des sorties
		 */
		$sortie = new Sortie($bdd, $ObjetBDDParam);
		$vue->set($sortie->getListByPoisson($id), "dataSortie");
		/*
		 * Recuperation des echographies
		 */
		$echographie = new Echographie($bdd, $ObjetBDDParam);
		$vue->set($echographie->getListByPoisson($id), "dataEcho");
		/*
		 * Recuperation des anesthesies
		 */
		$anesthesie = new Anesthesie($bdd, $ObjetBDDParam);
		$vue->set($anesthesie->getListByPoisson($id), "dataAnesthesie");
		/*
		 * Recuperation des mesures de ventilation
		 */
		$ventilation = new Ventilation($bdd, $ObjetBDDParam);
		$vue->set($ventilation->getListByPoisson($id), "dataVentilation");
		/*
		 * Recuperation des campagnes de reproduction
		 */
		$poissonCampagne = new PoissonCampagne($bdd, $ObjetBDDParam);
		$vue->set($poissonCampagne->getListFromPoisson($id), "dataRepro");
		/*
		 * Recuperation des dosages sanguins
		 */
		$dosageSanguin = new DosageSanguin($bdd, $ObjetBDDParam);
		$vue->set($dosageSanguin->getListeFromPoisson($id), "dataDosageSanguin");

		/*
		 * Recuperation des prelevements genetiques
		 */
		$genetique = new Genetique($bdd, $ObjetBDDParam);
		$vue->set($genetique->getListByPoisson($id), "dataGenetique");

		/*
		 * Recuperation des determinations de parente
		 */
		$parente = new Parente($bdd, $ObjetBDDParam);
		$vue->set($parente->getListByPoisson($id), "dataParente");

		/*
		 * Gestion des documents associes
		*/
		$vue->set("poissonDisplay", "moduleParent");
		$vue->set("poisson", "parentType");
		$vue->set("poisson_id", "parentIdName");
		$vue->set($id, "parent_id");
		require_once 'modules/document/documentFunctions.php';
		$vue->set(getListeDocument("poisson", $id, $_REQUEST["document_limit"], $_REQUEST["document_offset"]), "dataDoc");
		/*
		 * Affichage
		 */
		$vue->set("poisson/poissonDisplay.tpl", "corps");
		/*
		 * Module de retour au poisson
		 */
		$_SESSION["poissonParent"] = "poissonDisplay";
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$classes = array(
			"poissonStatut",
			"sexe",
			"categorie",
			"vieModele",
			"pittagType",
			"pittag"
		);
		foreach ($classes as $classe) {
			require_once "modules/classes/$classe.class.php";
		}
		$data = dataRead($dataClass, $id, "poisson/poissonChange.tpl");
		$sexe = new Sexe($bdd, $ObjetBDDParam);
		$vue->set($sexe->getListe(1), "sexe");
		$poissonStatut = new Poisson_statut($bdd, $ObjetBDDParam);
		$vue->set($poissonStatut->getListe(1), "poissonStatut");
		$categorie = new Categorie($bdd, $ObjetBDDParam);
		$vue->set($categorie->getListe(1), "categorie");

		/*
		 * Modeles de marquages VIE, pour creation a partir des juveniles
		 */
		$vieModele = new VieModele($bdd, $ObjetBDDParam);
		$vue->set($vieModele->getAllModeles(), "modeles");
		/*
		 * Passage en parametre de la liste parente
		*/
		$vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");

		/*
		 * Recuperation de la liste des types de pittag
		*/
		$pittagType = new Pittag_type($bdd, $ObjetBDDParam);
		$vue->set($pittagType->getListe(2), "pittagType");
		/*
		 * Recuperation du dernier pittag connu
		 */
		$pittag = new Pittag($bdd, $ObjetBDDParam);
		$vue->set($pittag->getListByPoisson($id, 1), "dataPittag");
		break;
	case "write":
		/*
		 * write record in database
		 */
		$id = dataWrite($dataClass, $_REQUEST);
		if ($id > 0) {
			$_REQUEST[$keyName] = $id;
			/*
			 * Ecriture du pittag
			 */
			if (!empty($_REQUEST["pittag_valeur"])) {
				require_once "modules/classes/pittag.class.php";
				$pittag = new Pittag($bdd, $ObjetBDDParam);
				$idPittag = $pittag->ecrire($_REQUEST);
				if (!$idPittag > 0) {
					$module_coderetour = -1;
					$message->set($pittag->getErrorData(), true);
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
	case "getListeAjaxJson":
		/*
		 * retourne la liste des poissons a partir du libelle fourni
		 * au format JSON, en mode Ajax
		 */
		if (!empty($_REQUEST["libelle"])) {
			$vue->set($dataClass->getListPoissonFromName($_REQUEST["libelle"]));
		}
		break;
}
