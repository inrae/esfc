<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 21 mars 2014
 */
require_once 'modules/classes/repartition.class.php';
$dataClass = new Repartition($bdd, $ObjetBDDParam);
$keyName = "repartition_id";
$id = $_REQUEST[$keyName];
switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		/*
		 * Gestion des variables de recherche
		 */
		if (!isset($_SESSION["searchRepartition"])) {
			$_SESSION["searchRepartition"] = new SearchRepartition();
		}
		$_SESSION["searchRepartition"]->setParam($_REQUEST);
		$dataSearch = $_SESSION["searchRepartition"]->getParam();
		if ($_REQUEST["next"] > 0) {
			$dataSearch["offset"] = $dataSearch["offset"] + $dataSearch["limit"];
			$_SESSION["searchRepartition"]->setParam("offset", $dataSearch["offset"]);
		}
		if ($_REQUEST["previous"] > 0) {
			$dataSearch["offset"] = $dataSearch["offset"] - $dataSearch["limit"];
			if ($dataSearch["offset"] < 0)
				$dataSearch["offset"] = 0;
			$_SESSION["searchRepartition"]->setParam("offset", $dataSearch["offset"]);
		}
		if ($_SESSION["searchRepartition"]->isSearch() == 1) {
			$vue->set(1, "isSearch");
			$dataList = $dataClass->getListSearch($dataSearch);
			/*
			 * Preparation de la creation ex-nihilo d'une repartition
			 */
			$jour = date("w");
			$jour_array = array(
				0 => 1,
				1 => 0,
				2 => 6,
				3 => 5,
				4 => 4,
				5 => 3,
				6 => 2
			);
			$data = array();
			$date = new DateTime();
			$date->add(new DateInterval('P' . $jour_array[$jour] . 'D'));
			$data["date_debut_periode"] = $date->format('d/m/Y');
			$date->add(new DateInterval('P6D'));
			$data["date_fin_periode"] = $date->format('d/m/Y');
			$data["repartition_id"] = 0;
			$data["lundi"] = 1;
			$data["mardi"] = 1;
			$data["mercredi"] = 1;
			$data["jeudi"] = 1;
			$data["vendredi"] = 1;
			$data["samedi"] = 1;
			$data["dimanche"] = 1;
			$vue->set($data, "data");
		}
		$vue->set($dataSearch, "repartitionSearch");
		$vue->set($dataList, "dataList");
		require_once 'modules/classes/site.class.php';
		$site = new Site($bdd, $ObjetBDDParam);
		$vue->set($site->getListe(2), "site");
		$vue->set("aliment/repartitionList.tpl", "corps");
		/*
		 * Recherche de la categorie
		 */
		require_once "modules/classes/categorie.class.php";
		$categorie = new Categorie($bdd, $ObjetBDDParam);
		$vue->set($categorie->getListeSansLot(), "categorie");
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = dataRead($dataClass, $id, "aliment/repartitionChange.tpl");
		/*
		 * Recherche de la categorie
		 */
		require_once "modules/classes/categorie.class.php";
		$categorie = new Categorie($bdd, $ObjetBDDParam);
		$vue->set($categorie->getListe(2), "categorie");
		require_once 'modules/classes/site.class.php';
		$site = new Site($bdd, $ObjetBDDParam);
		$vue->set($site->getListe(2), "site");
		/*
		 * Recuperation des bassins associes et des distributions
		 */
		if ($data["categorie_id"] > 0) {
			require_once "modules/classes/distribution.class.php";
			$distribution = new Distribution($bdd, $ObjetBDDParam);
			$vue->set($distribution->getFromRepartitionWithBassin($id, $data["categorie_id"], $data["site_id"]), "dataBassin");
			/*
			 * Recuperation des modèles de distribution actifs
			 */
			require_once "modules/classes/repartTemplate.class.php";
			$template = new RepartTemplate($bdd, $ObjetBDDParam);
			$vue->set($template->getListActifFromCategorie($data["categorie_id"]), "dataTemplate");
		}
		break;
	case "create":
		/*
		 * Creation d'une repartition vierge
		 */
		$id = dataWrite($dataClass, $_REQUEST);
		if ($id > 0) {
			$_REQUEST[$keyName] = $id;
		}
		break;
	case "duplicate":
		/*
		 * Creation d'une nouvelle repartition a partir d'une existante
		 */
		if ($id > 0) {
			$ret = $dataClass->duplicate($id);
			if ($ret > 0) {
				$module_coderetour = 1;
				$_REQUEST[$keyName] = $ret;
			} else {
				$message->set(_("Erreur lors de la création d'une nouvelle distribution"), true);
				$message->set($dataClass->getErrorData(1));
				$module_coderetour = -1;
			}
		}
		break;
	case "write":
		/*
		 * write record in database
		 */
		$id = dataWrite($dataClass, $_REQUEST);
		if ($id > 0) {
			$_REQUEST[$keyName] = $id;
			/*
			 * Preparation des informations concernant les bassins
			 */
			$data = array();
			foreach ($_REQUEST as $key => $value) {
				if (preg_match('/[0-9]+$/', $key, $val)) {
					$pos = strrpos($key, "_");
					$nom = substr($key, 0, $pos);
					$data[$val[0]][$nom] = $value;
				}
			}
			/*
			 * Mise en table des données de bassins
			 */
			require_once "modules/classes/distribution.class.php";
			$distribution = new Distribution($bdd, $ObjetBDDParam);
			$error = 0;
			foreach ($data as $key => $value) {
				if ($value["distribution_id"] > 0 || $value["total_distribue"] > 0) {
					$value["repartition_id"] = $id;
					$idDistrib = $distribution->ecrire($value);
					if (!$idDistrib > 0) {
						$error = 1;
						$message->set($distribution->getErrorData(1));
					}
				}
			}
			if ($error == 1) {
				$message->set(_("Problème lors de l'enregistrement"), true);
				$module_coderetour = -1;
			}
		}
		break;
	case "delete":
		/*
		 * delete record
		 */
		dataDelete($dataClass, $id);
		break;
	case "print":
		/*
		 * Imprime le tableau de répartition
		 */
		if ($id > 0) {
			require_once 'modules/classes/tableauRepartition.class.php';
			$data = $dataClass->lire($id);
			require_once "modules/classes/distribution.class.php";
			$distribution = new Distribution($bdd, $ObjetBDDParam);
			/*
			 * Recuperation de la liste des aliments utilises
			 */
			if ($data["categorie_id"] == 1)
				$dataAliment = $distribution->getListeAlimentFromRepartition($id);
			elseif ($data["categorie_id"] == 2)
				$dataAliment = $distribution->getListeAlimentFromRepartition($id, "juvenile");
			/*
			 * Recuperation des distributions prevues
			 */
			$dataDistrib = $distribution->calculDistribution($id);
			if ($data["categorie_id"] == 1) {
				$tableau = new RepartitionAdulte();
			} elseif ($data["categorie_id"] == 2) {
				$tableau = new RepartitionJuvenile();
			}
			$tableau->setData($data, $dataDistrib, $dataAliment);
			$tableau->exec();
		}
		break;
	case "resteChange":
		$vue->set($data = $dataClass->lireWithCategorie($id), "data");
		$vue->set("aliment/repartitionResteChange.tpl", "corps");
		/*
		 * preparation de la saisie des restes
		 */
		require_once "modules/classes/distribution.class.php";
		$distribution = new Distribution($bdd, $ObjetBDDParam);
		$dataBassin = $distribution->getFromRepartition($id);

		/*
		 * Preparation du tableau de dates
		 */
		$dateDebut = DateTime::createFromFormat('d/m/Y', $data['date_debut_periode']);
		$dateFin = DateTime::createFromFormat('d/m/Y', $data["date_fin_periode"]);
		$dateDiff = date_diff($dateDebut, $dateFin, true);
		$nbJour = $dateDiff->format("%a");
		$jour = array(
			0 => "dim",
			1 => "lun",
			2 => "mar",
			3 => "mer",
			4 => "jeu",
			5 => "ven",
			6 => "sam"
		);
		$total_distribue = 0;
		for ($i = 0; $i <= $nbJour; $i++) {
			$dateArray[$i]["libelle"] = $jour[$dateDebut->format("w")];
			$dateArray[$i]["numJour"] = $i;
			/*
			 * Calcul du total distribue
			 */
			$dateDebut->add(new DateInterval('P1D'));
		}
		$vue->set($dateArray, "dateArray");
		$vue->set($nbJour + 1, "nbJour");
		/*
		 * Mise en forme des donnees
		 */
		foreach ($dataBassin as $key => $value) {
			$dataReste = explode("+", $value["reste_zone_calcul"]);
			$i = 0;
			for ($i = 0; $i <= $nbJour; $i++) {
				// foreach ($dataReste as $key1 => $value1) {
				$dataBassin[$key]["reste"][$i] = $dataReste[$i];
			}
		}
		$vue->set($dataBassin, "dataBassin");
		break;
	case "resteWrite":
		/*
		 * Ecriture de la saisie des restes
		 */
		if ($id > 0) {
			/*
			 * Traitement de chaque distribution
			 */
			/*
			 * Preparation des informations concernant les bassins
			*/
			$data = array();
			foreach ($_REQUEST as $key => $value) {
				if (preg_match('/[0-9]+$/', $key, $val)) {
					$pos = strrpos($key, "_");
					$nom = substr($key, 0, $pos);
					$data[$val[0]][$nom] = $value;
				}
			}
			require_once "modules/classes/distribution.class.php";
			$distribution = new Distribution($bdd, $ObjetBDDParam);
			/*
			 * Traitement de chaque bassin
			 */
			foreach ($data as $key => $value) {
				$value["date_debut_periode"] = $_REQUEST["date_debut_periode"];
				$value["date_fin_periode"] = $_REQUEST["date_fin_periode"];
				$value["repartition_id"] = $_REQUEST["repartition_id"];
				/*
				 * On divise le total_distribue par le nombre de jours
				 */
				/*if ($_REQUEST ["nbJour"] > 0) {
					$value ["total_distribue"] = $value ["total_distribue"] / $_REQUEST ["nbJour"];
				}*/
				$idDistrib = $distribution->ecrireReste($value);
				if (!$idDistrib > 0) {
					$error = 1;
					$message->set($distribution->getErrorData(1));
				}
			}
			/*
			 * Traitement des erreurs potentielles
			 */
			if ($error == 1) {
				$message->set(_("Problème lors de l'enregistrement"), true);
				$module_coderetour = -1;
			} else {

				$message->set(_("Opération effectuée"));
				$module_coderetour = 1;
				$log->setLog($_SESSION["login"], get_class($dataClass) . "-write", $id);
			}
		}
		break;
}
