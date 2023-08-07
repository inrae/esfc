<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 11 mars 2014
 */
require_once 'modules/classes/analyseEau.class.php';
$dataClass = new AnalyseEau($bdd, $ObjetBDDParam);
$keyName = "analyse_eau_id";
$id = $_REQUEST[$keyName];
if (!isset($_SESSION["searchCircuitEau"])) {
	$_SESSION["searchCircuitEau"] = new SearchCircuitEau();
}
switch ($t_module["param"]) {

	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = dataRead($dataClass, $id, "bassin/analyseEauChange.tpl", $_REQUEST["circuit_eau_id"]);
		/*
		 * Lecture des donnees concernant le circuit d'eau
		 */
		require_once "modules/classes/circuitEau.class.php";
		$circuitEau = new CircuitEau($bdd, $ObjetBDDParam);
		$vue->set($circuitEau->lire($_REQUEST["circuit_eau_id"]) , "dataCircuitEau");
		/*
		 * Lecture des laboratoires
		 */
		require_once "modules/classes/laboratoireAnalyse.class.php";
		$laboratoireAnalyse = new LaboratoireAnalyse($bdd, $ObjetBDDParam);
		$vue->set( $laboratoireAnalyse->getListeActif(), "laboratoire");
		/*
		 * Forcage de la date de reference (date de recherche) si creation d'un nouvel enregistrement
		 */
		if ($id == 0) {
			$dataSearch = $_SESSION["searchCircuitEau"]->getParam();
			$data["analyse_eau_date"] = $dataSearch["analyse_date"];
			$vue->set( $data, "data");
		}
		$vue->set( $_REQUEST["origine"], "origine");
		/*
		 * Recuperation des analyses de metaux
		 */
		$dataMetal = array();
		if ($id > 0) {
			require_once "modules/classes/analyseMetal.class.php";
			$analyseMetal = new AnalyseMetal($bdd, $ObjetBDDParam);
			$dataMetal = $analyseMetal->getListeFromAnalyse($id);
		}
		/*
		 * Recuperation de la liste des metaux non analyses, mais actifs
		 */
		require_once "modules/classes/metal.class.php";
		$metal = new Metal($bdd, $ObjetBDDParam);
		$newMetal = $metal->getListActifInconnu($dataMetal);
		foreach ($newMetal as $value) {
			$dataMetal[] = array(
				"metal_id" => $value["metal_id"],
				"metal_nom" => $value["metal_nom"],
				"metal_unite" => $value["metal_unite"]
			);
		}
		$vue->set($dataMetal , "dataMetal");
		break;
	case "write":
		/*
		 * write record in database
		 */
		$id = dataWrite($dataClass, $_REQUEST);
		if ($id > 0) {
			/*
			 * Ecriture des donnees concernant les analyses de metaux
			 */
			require_once "modules/classes/analyseMetal.class.php";
			$analyseMetal = new AnalyseMetal($bdd, $ObjetBDDParam);
			$analyseMetal->ecrireGlobal($_REQUEST, $id);
			$_REQUEST[$keyName] = $id;
		}
		break;
	case "delete":
		/*
		 * delete record
		 */
		dataDelete($dataClass, $id);
		break;
	case "graph":
		/**
		 * Visualisation sous forme de graphique des analyses d'eau
		 */
		require_once "modules/classes/circuitEau.class.php";
		$circuitEau = new CircuitEau($bdd, $ObjetBDDParam);
		if ($_REQUEST["circuit_eau_id"] == 0) {
			$circuits = $circuitEau->getListeSearch(array("circuit_eau_actif" => 1, "site_id" => $_SESSION["site_id"]));
		} else {
			$circuits[] = $circuitEau->lire($_REQUEST["circuit_eau_id"]);
		}
		/**
		 * Preparation des donnees
		 */
		if (isset($_REQUEST["date_from"]) && isset($_REQUEST["date_to"])) {
			$max = date_create_from_format("d/m/Y", $_REQUEST["date_from"]);
			$min = date_create_from_format("d/m/Y", $_REQUEST["date_to"]);
			$graph = array("bindto" => "#graph");
			$graph["axis"]["x"] = array(
				"type" => "timeseries",
				"tick" => array(
					"format" => "%d/%m/%Y %H:%M:%S",
					/*"fit" => "true",*/
					"rotate" => 45,
					/*"count" => 30*/
				),
				"min" => $_REQUEST["date_from"] . " 00:00:00",
				"max" => $_REQUEST["date_to"] . " 23:59:59"
			);
			$graph["axis"]["y"] = array("min" => 0);
			$graph["data"]["xFormat"] = "%d/%m/%Y %H:%M:%S";
			$i = 1;
			foreach ($circuits as $circuit) {
				$serie = array();
				$dates = array();
				$serie[] = $circuit["circuit_eau_libelle"];
				$dates[] = "x" . $i;
				$data = $dataClass->getValFromDatesCircuit($circuit["circuit_eau_id"], $_REQUEST["date_from"], $_REQUEST["date_to"], $_REQUEST["attribut"]);
				foreach ($data as $val) {
					if (strlen($val[$_REQUEST["attribut"]] > 0)) {
						$dates[] = $val["analyse_eau_date"];
						$serie[] = $val[$_REQUEST["attribut"]];
						$ldate = date_create_from_format("d/m/Y h:i:s", $val["analyse_eau_date"]);
						if ($ldate) {
							if ($ldate < $min) {
								$min = $ldate;
							}
							if ($ldate > $max) {
								$max = $ldate;
							}
						}
					}
				}
				if (count($dates) > 1) {
					$graph["data"]["xs"][$circuit["circuit_eau_libelle"]] = "x" . $i;
					$graph["data"]["types"][$circuit["circuit_eau_libelle"]] = "line";
					$graph["data"]["columns"][] = $dates;
					$graph["data"]["columns"][] = $serie;
				}
				$i++;
			}
			$graph["axis"]["x"]["min"] = $min->format("d/m/Y") . " 00:00:00";
			$graph["axis"]["x"]["max"] = $max->format("d/m/Y") . " 23:59:59";
			$vue->set( base64_encode(json_encode($graph, JSON_NUMERIC_CHECK | JSON_UNESCAPED_SLASHES)), "graph");
		}
		/**
		 * Reaffectation des valeurs par defaut
		 */
		if (!isset($_REQUEST["date_from"])) {
			$date_to = date("d/m/Y");
			$date_from = date("d/m/Y", strtotime('-1 month', time()));
			$vue->set( $date_from, "date_from");
			$vue->set( $date_to, "date_to");
			$vue->set( "temperature", "attribut");
		} else {
			$vue->set( $_REQUEST["date_from"], "date_from");
			$vue->set( $_REQUEST["date_to"], "date_to");
			$vue->set($_REQUEST["attribut"] , "attribut");
		}
		$attributs = array(
			"temperature" => _("Température"),
			"o2_pc" => _("% O2"),
			"salinite" => _("Salinité"),
			"ph" => _("pH"),
			"nh4" => _("Oxyde d'ammoniac NH4+"),
			'n_nh4' => _("Azote ammoniacal N-NH4"),
			"no2" => _("Oxyde nitrite NO2"),
			"n_no2" => _("Ion nitrite N-NO2"),
			"no3" => _("Oxyde nitrate NO3"),
			"n_no3" => _("Ion nitrate N-NO3")
		);
		$vue->set($attributs , "attributs");
		$vue->set("bassin/analyseGraph.tpl" , "corps");
		/**
		 * recherche des circuits d'eau
		 */
		$vue->set($_REQUEST["circuit_eau_id"] , "circuit_eau_id");
		$vue->set( $circuitEau->getListeSearch(array("site_id"=>$_SESSION["site_id"])), "circuits");

		require_once 'modules/classes/site.class.php';
		$site = new Site($bdd, $ObjetBDDParam);
		$vue->set( $site->getListe(2), "site");
		break;
}
