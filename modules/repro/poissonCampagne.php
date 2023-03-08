<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 5 mars 2015
 */
include_once 'modules/classes/poissonRepro.class.php';
$dataClass = new PoissonCampagne($bdd, $ObjetBDDParam);
$keyName = "poisson_campagne_id";
$id = $_REQUEST[$keyName];
/*
 * Prepositionnement de l'annee
 */
include "modules/repro/setAnnee.php";

if (isset($_SESSION["sequence_id"]))
	$vue->set( , "");("sequence_id", $_SESSION["sequence_id"]);

if (isset($_REQUEST["annee"]) && !($_REQUEST["annee"] > 0)) {
	$_REQUEST['annee'] = "";
}

switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		$searchRepro->setParam($_REQUEST);
		$dataSearch = $searchRepro->getParam();
		if ($searchRepro->isSearch() == 1) {
			$vue->set( , "");("data", $dataClass->getListForDisplay($dataSearch));
		}
		$vue->set( , "");("dataSearch", $dataSearch);
		//$vue->set( , ""); ( "annees", $dataClass->getAnnees () );
		$vue->set( , "");("corps", "repro/poissonCampagneList.tpl");
		/*
		 * Lecture de la liste des statuts
		 */
		$reproStatut = new ReproStatut($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataReproStatut", $reproStatut->getListe(1));
		/*
		 * Passage en parametre de la liste parente
		 */
		$_SESSION["poissonDetailParent"] = "poissonCampagneList";
		/**
		 * Site
		 */
		require_once 'modules/classes/site.class.php';
		$site = new Site($bdd, $ObjetBDDParam);
		$vue->set( , "");("site", $site->getListe(2));
		
		/*
		 * Affichage du graphique d'evolution de la masse
		 */
		if ($_REQUEST["graphique_id"] > 0) {
			require_once 'modules/classes/poisson.class.php';
			$morphologie = new Morphologie($bdd, $ObjetBDDParam);
			$date_from = ($_SESSION["annee"] - 5) . "-01-01";
			$date_to = $_SESSION["annee"] . "-12-31";
			$dataMorpho = $morphologie->getListMasseFromPoisson($_REQUEST["graphique_id"], $date_from, $date_to);
			/*
			 * Lecture des donnees du poisson
			 */
			$poisson = new Poisson($bdd, $ObjetBDDParam);
			$dataPoisson = $poisson->lire($_REQUEST["graphique_id"]);
			/*
			 * Preparation des donnees pour le graphique
			 */
			$x = "'x'";
			$y = "'data1'";
			foreach ($dataMorpho as $key => $value) {
				$x .= ",'" . $value["morphologie_date"] . "'";
				$y .= "," . $value["masse"];
			}
			//printr ( $x );
			//printr ( $y );
			$vue->set( , "");("poisson_nom", $dataPoisson["prenom"] . " " . $dataPoisson["matricule"]);
			$vue->set( , "");("massex", $x);
			$vue->set( , "");("massey", $y);
		}
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->lire($id);
		$vue->set( , "");("dataPoisson", $data);
		/*
		 * Passage en parametre de la liste parente
		 */
		$vue->set( , "");("poissonDetailParent", $_SESSION["poissonDetailParent"]);
		/*
		 * Module de retour au poisson
		 */
		$_SESSION["poissonParent"] = "poissonCampagneDisplay";
		/*
		 * Lecture des tables liees
		 */
		require_once 'modules/classes/dosageSanguin.class.php';
		require_once 'modules/classes/biopsie.class.php';
		require_once 'modules/classes/sequence.class.php';
		require_once 'modules/classes/poisson.class.php';
		require_once 'modules/classes/injection.class.php';
		require_once 'modules/classes/sperme.class.php';
		require_once 'modules/classes/documentSturio.class.php';
		$dosageSanguin = new DosageSanguin($bdd, $ObjetBDDParam);
		$biopsie = new Biopsie($bdd, $ObjetBDDParam);
		$poissonSequence = new PoissonSequence($bdd, $ObjetBDDParam);
		$psEvenement = new PsEvenement($bdd, $ObjetBDDParam);
		$echographie = new Echographie($bdd, $ObjetBDDParam);
		$injection = new Injection($bdd, $ObjetBDDParam);
		$sperme = new Sperme($bdd, $ObjetBDDParam);
		$transfert = new Transfert($bdd, $ObjetBDDParam);
		$ventilation = new Ventilation($bdd, $ObjetBDDParam);
		$dosages = $dosageSanguin->getListeFromPoissonCampagne($id);
		$injections = $injection->getListFromPoissonCampagne($id);
		$sequences = $poissonSequence->getListFromPoisson($id);
		$spermes = $sperme->getListFromPoissonCampagne($id);
		$biopsies = $biopsie->getListeFromPoissonCampagne($id);
		$transferts = $transfert->getListByPoisson($data["poisson_id"], $_SESSION["annee"]);
		$ventilations = $ventilation->getListByPoisson($data["poisson_id"], $_SESSION["annee"]);

		$vue->set( , "");("dataSanguin", $dosages);
		$vue->set( , "");("dataBiopsie", $biopsies);
		$vue->set( , "");("dataSequence", $sequences);
		$vue->set( , "");("dataPsEvenement", $psEvenement->getListeEvenementFromPoisson($id));
		$dataEcho = $echographie->getListByYear($data["poisson_id"], $_SESSION["annee"]);
		$vue->set( , "");("dataEcho", $dataEcho);
		$vue->set( , "");("injections", $injections);
		$vue->set( , "");("spermes", $spermes);
		$vue->set( , "");("dataTransfert", $transferts);
		$vue->set( , "");("dataVentilation", $ventilations);
		if (is_numeric($id))
			$vue->set( , "");("poisson_campagne_id", $id);
		
		/*
		 * Recuperation des photos associees aux evenements
		 */
		$vue->set( , "");("moduleParent", "poissonCampagneDisplay");
		$vue->set( , "");("parentType", "evenement");
		$vue->set( , "");("parentIdName", "poisson_campagne_id");
		$vue->set( , "");("parent_id", $id);
		/*
		 * Generation de la liste des evenements issus des echographies
		 */
		$a_id = array();
		foreach ($dataEcho as $key => $value) {
			$a_id[] = $value["evenement_id"];
		}
		require_once 'modules/document/documentFunctions.php';
		$vue->set( , "");("dataDoc", getListeDocument("evenement", $a_id, $_REQUEST["document_limit"], $_REQUEST["document_offset"]));

		$vue->set( , "");("corps", "repro/poissonCampagneDisplay.tpl");
		if (isset($_REQUEST["sequence_id"]))
			$vue->set( , "");("sequence_id", $_REQUEST["sequence_id"]);
			/*
		 * Recherche des temperatures pour le graphique
		 */
		$dateMini = new DateTime();
		$dateMaxi = new DateTime("1967-01-01");
		// if ($_REQUEST ["graphicsEnabled"] == 1) {
		for ($i = 1; $i < 3; $i++) {
			$datapf = $dataClass->getTemperatures($data["poisson_id"], $_SESSION["annee"], $i);
			$x = "'x" . $i . "'";
			if ($i == 1) {
				$y = "'constaté'";
			} else
				$y = "'prévu'";
			foreach ($datapf as $key => $value) {
				$x .= ",'" . $value["pf_datetime"] . "'";
				$y .= "," . $value["pf_temperature"];
				$datetime = explode(" ", $value["pf_datetime"]);
				$d = DateTime::createFromFormat("d/m/Y", $datetime[0]);
				if ($d < $dateMini)
					$dateMini = $d;
				if ($d > $dateMaxi)
					$dateMaxi = $d;
			}
			$vue->set( , "");("pfx" . $i, $x);
			$vue->set( , "");("pfy" . $i, $y);
		}
		$vue->set( , "");("graphicsEnabled", 1);
		// }
		/*
		 * Recherche des donnees pour les taux sanguins et les injections
		 */
		$e2y = "'E2'";
		$cay = "'Ca'";
		$e2x = "'x1'";
		$cax = "'x2'";
		$thx = "'x5'";
		$thy = "'Tx_Hematocrite'";
		$e2hy = "'E2_x_hema'";
		$cahy = "'Ca_x_hema'";
		$iy = "'Injections'";
		$ix = "'x3'";
		$expy = "'Expulsion'";
		$expx = "'x4'";
		$maxca = 0;
		$opix = "'x1'";
		$opiy = "'Tx OPI'";
		$t50x = "'x2'";
		$t50y = "'T50'";
		$diamx = "'x3'";
		$diamy = "'Diam moyen'";
		foreach ($dosages as $key => $value) {
			if ($value["tx_e2"] > 0) {
				$e2x .= ",'" . $value["dosage_sanguin_date"] . "'";
				$e2y .= "," . $value["tx_e2"];
			}
			if ($value["tx_calcium"] > 0) {
				$cax .= ",'" . $value["dosage_sanguin_date"] . "'";
				$cay .= "," . $value["tx_calcium"];
				if ($value["tx_calcium"] > $maxca)
					$maxca = $value["tx_calcium"];
			}
			/*
			 * Ajout du taux d'hematocrite, et calcul des courbes corrigees de E2 et Ca
			 */
			if ($value["tx_hematocrite"] > 0) {
				$thx .= ",'" . $value["dosage_sanguin_date"] . "'";
				$thy .= "," . $value["tx_hematocrite"];
				if ($value["tx_calcium"] > 0) {
					$cahy .= "," . ($value["tx_calcium"] / 100 * $value["tx_hematocrite"]);
				}
				if ($value["tx_e2"] > 0) {
					$e2hy .= "," . ($value["tx_e2"] / 100 * $value["tx_hematocrite"]);
				}
			}
			$d = DateTime::createFromFormat("d/m/Y", $value["dosage_sanguin_date"]);
			if ($d < $dateMini)
				$dateMini = $d;
			if ($d > $dateMaxi)
				$dateMaxi = $d;
		}
		if ($maxca == 0)
			$maxca = 1;
			/*
		 * Recuperation des injections
		 */
		foreach ($injections as $key => $value) {
			$datetime = explode(" ", $value["injection_date"]);
			$ix .= ",'" . $datetime[0] . "'";
			$iy .= "," . $maxca;
			$d = DateTime::createFromFormat("d/m/Y", $datetime[0]);
			if ($d < $dateMini)
				$dateMini = $d;
			if ($d > $dateMaxi)
				$dateMaxi = $d;
		}
		/*
		 * Recuperation des expulsions
		 */
		if ($data["sexe_libelle_court"] == "f") {
			foreach ($sequences as $key => $value) {
				if (strlen($value["ovocyte_expulsion_date"]) > 0) {
					$datetime = explode(" ", $value["ovocyte_expulsion_date"]);
					$d = DateTime::createFromFormat("d/m/Y", $datetime[0]);
					$expx .= ",'" . $datetime[0] . "'";
					$expy .= "," . $maxca;
				}
			}
			/*
			 * Recherche des donnees concernant les biopsies
			 */

			foreach ($biopsies as $key => $value) {
				if (strlen($value["biopsie_date"]) > 0) {
					$datetime = explode(" ", $value["biopsie_date"]);
					$d = DateTime::createFromFormat("d/m/Y", $datetime[0]);
					if ($d < $dateMini)
						$dateMini = $d;
					if ($d > $dateMaxi)
						$dateMaxi = $d;
					if ($value["tx_opi"] > 0) {
						$opix .= ",'" . $datetime[0] . "'";
						$opiy .= "," . $value["tx_opi"];
					}
					if (strlen($value["ringer_t50"]) > 0) {
						$duree = explode(":", $value["ringer_t50"]);
						$dureeCalc = $duree[0] + ($duree[1] / 60);
						if ($dureeCalc > 0) {
							$t50x .= ",'" . $datetime[0] . "'";
							$t50y .= "," . $dureeCalc;
						}
					}
					if ($value["diam_moyen"] > 0) {
						$diamx .= ",'" . $datetime[0] . "'";
						$diamy .= "," . $value["diam_moyen"];
					}
				}
			}
		} else {
			foreach ($spermes as $key => $value) {
				$datetime = explode(" ", $value["sperme_date"]);
				$expx .= ",'" . $datetime[0] . "'";
				$expy .= "," . $maxca;
				$d = DateTime::createFromFormat("d/m/Y", $datetime[0]);
				if ($d < $dateMini)
					$dateMini = $d;
				if ($d > $dateMaxi)
					$dateMaxi = $d;
			}
		}

		$vue->set( , "");("e2x", $e2x);
		$vue->set( , "");("e2y", $e2y);
		$vue->set( , "");("cax", $cax);
		$vue->set( , "");("cay", $cay);
		$vue->set( , "");("thx", $thx);
		$vue->set( , "");("thy", $thy);
		$vue->set( , "");("e2hy", $e2hy);
		$vue->set( , "");("cahy", $cahy);
		$vue->set( , "");("ix", $ix);
		$vue->set( , "");("iy", $iy);
		$vue->set( , "");("expx", $expx);
		$vue->set( , "");("expy", $expy);
		$vue->set( , "");("opix", $opix);
		$vue->set( , "");("opiy", $opiy);
		$vue->set( , "");("t50x", $t50x);
		$vue->set( , "");("t50y", $t50y);
		$vue->set( , "");("diamx", $diamx);
		$vue->set( , "");("diamy", $diamy);
		/*
		 * Ajout de 3 jours aux bornes des graphiques
		 */
		$interval = new DateInterval("P1D");
		date_sub($dateMini, $interval);
		date_add($dateMaxi, $interval);
		$vue->set( , "");("dateMini", date_format($dateMini, 'd/m/Y'));
		$vue->set( , "");("dateMaxi", date_format($dateMaxi, 'd/m/Y'));

		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead($dataClass, $id, "repro/poissonCampagneChange.tpl", $_REQUEST["poisson_id"]);
		/*
		 * Lecture des informations concernant le poisson
		 */
		require_once 'modules/classes/poisson.class.php';
		$poisson = new Poisson($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataPoisson", $poisson->getDetail($_REQUEST["poisson_id"]));
		/*
		 * Lecture de la table des statuts
		 */
		$reproStatut = new ReproStatut($bdd, $ObjetBDDParam);
		$vue->set( , "");("reproStatut", $reproStatut->getListe(1));
		/*
		 * Calcul des annees de campagne potentielles
		 */
		$anneeCourante = date('Y');
		for ($i = $anneeCourante; $i > 1995; $i--) {
			$annees[]["annee"] = $i;
		}
		$vue->set( , "");("annees", $annees);
		/*
		 * Passage en parametre de la liste parente
		 */
		$vue->set( , "");("poissonDetailParent", $_SESSION["poissonDetailParent"]);
		$vue->set( , "");("poissonParent", $_SESSION["poissonParent"]);
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
		if (is_array($id)) {
			$nb = 0;
			foreach ($id as $key => $value) {
				if (is_numeric($value) && $value > 0) {
					$ret = $dataClass->supprimer($value);
					if ($ret > 0) {
						$nb++;
						$log->setLog($_SESSION["login"], get_class($dataClass) . "-delete", $id);
					} else
						$message->set( $dataClass->getErrorData()) . "<br>";
				}
			}
			$module_coderetour = 2;
			$message->set( $nb . " poissons déselectionnés";
		} else
			dataDelete($dataClass, $id);
		break;
	case "campagneInit":
		/*
		 * Affiche la fenêtre d'intialisation de la campagne
		 */
		$anneeCourante = date("Y");
		$annees = array();
		for ($i = $anneeCourante - 3; $i <= $anneeCourante; $i++) {
			$annees[]["annee"] = $i;
		}
		$vue->set( , "");("annees", $annees);
		$vue->set( , "");("corps", "repro/campagneInit.tpl");

		break;
	case "init":
		$nb = $dataClass->initCampagne($_REQUEST["annee"]);
		$message->set(  $nb . " poisson(s) ajouté(s)";
		$module_coderetour = 1;
		break;
	case "changeStatut":
		if ($_REQUEST["repro_statut_id"] > 0) {
			if (is_array($id)) {
				$nb = 0;
				foreach ($id as $key => $value) {
					if (is_numeric($value) && $value > 0) {
						$ret = $dataClass->changeStatut($value, $_REQUEST["repro_statut_id"]);
						if ($ret > 0) {
							$nb++;
							$log->setLog($_SESSION["login"], get_class($dataClass) . "-delete", $id);
						} else
							$message->set( $dataClass->getErrorData()) . "<br>";
					}
				}
			} else {
				if ($dataClass->changeStatut($id, $_REQUEST["repro_statut_id"]) > 0)
					$nb = 1;
			}
			$message->set( $nb . " statuts modifiés";
		}
		$module_coderetour = 1;
		break;
	case "recalcul":
		/*
		 * Recalcul des taux de croissance
		 */
		$dataClass->initCampagnePoisson($_REQUEST["poisson_id"], $_REQUEST["annee"]);
		$module_coderetour = 1;
		break;
}

?>