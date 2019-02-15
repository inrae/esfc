<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 11 mars 2014
 */
include_once 'modules/classes/bassin.class.php';
$dataClass = new AnalyseEau($bdd, $ObjetBDDParam);
$keyName = "analyse_eau_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		/*
		 * $searchExample must be defined into modules/beforesession.inc.php :
		 * include_once 'modules/classes/searchParam.class.php';
		 * and into modules/common.inc.php :
		 * if (!isset($_SESSION["searchExample"])) {
		 * $searchExample = new SearchExample();
		 *	$_SESSION["searchExample"] = $searchExample;
		 *	} else {
		 *	$searchExample = $_SESSION["searchExample"];
		 *	}
		 * and, also, into modules/classes/searchParam.class.php...
		 */
		/*
		$searchExample->setParam ( $_REQUEST );
		$dataSearch = $searchExample->getParam ();
		if ($searchExample->isSearch () == 1) {
			$data = $dataClass->getListeSearch ( $dataExample );
			$smarty->assign ( "data", $data );
			$smarty->assign ("isSearch", 1);
		}
		$smarty->assign ("exampleSearch", $dataSearch);
		$smarty->assign("data", $dataClass->getListe());
		$smarty->assign("corps", "example/exampleList.tpl");
		 */
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		/*
		$data = $dataClass->lire($id);
		$smarty->assign("data", $data);
		$smarty->assign("corps", "example/exampleDisplay.tpl");
		 */
		break;
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
		$circuitEau = new Circuit_eau($bdd, $ObjetBDDParam);
		$smarty->assign("dataCircuitEau", $circuitEau->lire($_REQUEST["circuit_eau_id"]));
		/*
		 * Lecture des laboratoires
		 */
		$laboratoireAnalyse = new LaboratoireAnalyse($bdd, $ObjetBDDParam);
		$smarty->assign("laboratoire", $laboratoireAnalyse->getListeActif());
		/*
		 * Forcage de la date de reference (date de recherche) si creation d'un nouvel enregistrement
		 */
		if ($id == 0) {
			$dataSearch = $searchCircuitEau->getParam();
			$data["analyse_eau_date"] = $dataSearch["analyse_date"];
			$smarty->assign("data", $data);
		}
		$smarty->assign("origine", $_REQUEST["origine"]);
		/*
		 * Recuperation des analyses de metaux
		 */
		$dataMetal = array();
		if ($id > 0) {
			$analyseMetal = new AnalyseMetal($bdd, $ObjetBDDParam);
			$dataMetal = $analyseMetal->getListeFromAnalyse($id);
		}
		/*
		 * Recuperation de la liste des metaux non analyses, mais actifs
		 */
		$metal = new Metal($bdd, $ObjetBDDParam);
		$newMetal = $metal->getListActifInconnu($dataMetal);
		foreach ($newMetal as $key => $value) {
			$dataMetal[] = array(
				"metal_id" => $value["metal_id"],
				"metal_nom" => $value["metal_nom"],
				"metal_unite" => $value["metal_unite"]
			);
		}
		$smarty->assign("dataMetal", $dataMetal);
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
		$circuitEau = new Circuit_eau($bdd, $ObjetBDDParam);
		$circuits = $circuitEau->getListeSearch(array("circuit_eau_actif" => 1, "site_id" => $_SESSION["site_id"]));
		/**
		 * Preparation des donnees
		 */
		$max = date_create_from_format("d/m/Y",$_REQUEST["date_from"]);
		$min = date_create_from_format("d/m/Y", $_REQUEST["date_to"]);
		$graph = array("bindto" => "#graph");
		$graph["axis"]["x"] = array(
			"type" => "timeseries",
			"tick" => array(
				"format" => "%d/%m/%Y %H:%M:%S",
				"fit"=>"true",
				"rotate"=>90,
				"count"=>30
			),
			"min" => $_REQUEST["date_from"]." 00:00:00",
			"max" => $_REQUEST["date_to"]." 23:59:59"
		);
		$graph["axis"]["y"]= array("min"=>0);
		$graph["data"]["xFormat"] = "%d/%m/%Y %H:%M:%S";
		$i = 1;
		foreach ($circuits as $circuit) {
			$serie = array();
			$dates = array();
			$serie[] = $circuit["circuit_eau_libelle"];
			$dates[] = "x" . $i;
			//$dataClass->auto_date = 0;
			$data = $dataClass->getValFromDatesCircuit($circuit["circuit_eau_id"], $_REQUEST["date_from"], $_REQUEST["date_to"], $_REQUEST["attribut"]);
			foreach ($data as $val) {
				if (strlen($val[$_REQUEST["attribut"]] > 0)) {
					$dates[] = $val["analyse_eau_date"];
					$serie[] = $val[$_REQUEST["attribut"]];
					$ldate = date_create_from_format("d/m/Y H:I:s", $val["analyse_eau_date"]);
					if ($ldate < $min) {
						$min = $ldate;
					}
					if ($ldate > $max) {
						$max = $ldate;
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
		printr(date("d/m/Y",$min));
		printr(date("d/m/Y", $max));
		$graph["axis"]["x"]["min"] = date_format($min, "d/m/Y")." 00:00:00";
		$graph["axis"]["x"]["max"] = date_format($max, "d/m/Y")." 23:59:59";
		//printr($min::format( "d/m/Y"));
		$smarty->assign("graph", base64_encode(json_encode($graph, JSON_NUMERIC_CHECK | JSON_UNESCAPED_SLASHES)));
		/**
		 * Reaffectation des valeurs par defaut
		 */
		if (!isset($_REQUEST["date_from"])) {
			$date_to = date("d/m/Y");
			$date_from = date("d/m/Y", strtotime('-1 month', time()));
			$smarty->assign("date_from", $date_from);
			$smarty->assign("date_to", $date_to);
			$smarty->assign("attribut", "temperature");
		} else {
			$smarty->assign("date_from", $_REQUEST["date_from"]);
			$smarty->assign("date_to", $_REQUEST["date_to"]);
			$smarty->assign("attribut", $_REQUEST["attribut"]);
		}
		$attributs = array("temperature" => "Température", "o2_pc" => "% O2", "salinite" => "Salinité", "ph" => "pH");
		$smarty->assign("attributs", $attributs);
		$smarty->assign("corps", "bassin/analyseGraph.tpl");

		require_once 'modules/classes/site.class.php';
		$site = new Site($bdd, $ObjetBDDParam);
		$smarty->assign("site", $site->getListe(2));
		break;
}

?>