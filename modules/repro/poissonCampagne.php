<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 5 mars 2015
 */
include_once 'modules/classes/poissonRepro.class.php';
$dataClass = new PoissonCampagne ( $bdd, $ObjetBDDParam );
$keyName = "poisson_campagne_id";
$id = $_REQUEST [$keyName];
/*
 * Prepositionnement de l'annee
 */
include "modules/repro/setAnnee.php";

if (isset ( $_SESSION ["sequence_id"] ))
	$smarty->assign ( "sequence_id", $_SESSION ["sequence_id"] );

if (isset ($_REQUEST["annee"]) && !($_REQUEST["annee"] > 0 )  ) {
	$_REQUEST['annee'] = "";
}

switch ($t_module ["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		$searchRepro->setParam ( $_REQUEST );
		$dataSearch = $searchRepro->getParam ();
		if ($searchRepro->isSearch () == 1) {
			$smarty->assign ( "data", $dataClass->getListForDisplay ( $dataSearch ) );
		}
		$smarty->assign ( "dataSearch", $dataSearch );
		$smarty->assign ( "annees", $dataClass->getAnnees () );
		$smarty->assign ( "corps", "repro/poissonCampagneList.tpl" );
		/*
		 * Lecture de la liste des statuts
		 */
		$reproStatut = new ReproStatut ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "dataReproStatut", $reproStatut->getListe ( 1 ) );
		/*
		 * Passage en parametre de la liste parente
		 */
		$_SESSION ["poissonDetailParent"] = "poissonCampagneList";
		
		/*
		 * Affichage du graphique d'evolution de la masse
		 */
		if ($_REQUEST ["graphique_id"] > 0) {
			require_once 'modules/classes/poisson.class.php';
			$morphologie = new Morphologie ( $bdd, $ObjetBDDParam );
			$date_from = ($_SESSION ["annee"] - 5) . "-01-01";
			$date_to = $_SESSION ["annee"] . "-12-31";
			$dataMorpho = $morphologie->getListMasseFromPoisson ( $_REQUEST ["graphique_id"], $date_from, $date_to );
			/*
			 * Lecture des donnees du poisson
			 */
			$poisson = new Poisson ( $bdd, $ObjetBDDParam );
			$dataPoisson = $poisson->lire ( $_REQUEST ["graphique_id"] );
			/*
			 * Preparation des donnees pour le graphique
			 */
			$x = "'x'";
			$y = "'data1'";
			foreach ( $dataMorpho as $key => $value ) {
				$x .= ",'" . $value ["morphologie_date"] . "'";
				$y .= "," . $value ["masse"];
			}
			//printr ( $x );
			//printr ( $y );
			$smarty->assign ( "poisson_nom", $dataPoisson ["prenom"] . " " . $dataPoisson ["matricule"] );
			$smarty->assign ( "massex", $x );
			$smarty->assign ( "massey", $y );
		}
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->lire ( $id );
		$smarty->assign ( "dataPoisson", $data );
		/*
		 * Passage en parametre de la liste parente
		 */
		$smarty->assign ( "poissonDetailParent", $_SESSION ["poissonDetailParent"] );
		/*
		 * Module de retour au poisson
		 */
		$_SESSION ["poissonParent"] = "poissonCampagneDisplay";
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
		$dosageSanguin = new DosageSanguin ( $bdd, $ObjetBDDParam );
		$biopsie = new Biopsie ( $bdd, $ObjetBDDParam );
		$poissonSequence = new PoissonSequence ( $bdd, $ObjetBDDParam );
		$psEvenement = new PsEvenement ( $bdd, $ObjetBDDParam );
		$echographie = new Echographie ( $bdd, $ObjetBDDParam );
		$injection = new Injection ( $bdd, $ObjetBDDParam );
		$sperme = new Sperme ( $bdd, $ObjetBDDParam );
		$transfert = new Transfert($bdd, $ObjetBDDParam);
		$ventilation = new Ventilation($bdd, $ObjetBDDParam);
		$dosages = $dosageSanguin->getListeFromPoissonCampagne ( $id );
		$injections = $injection->getListFromPoissonCampagne ( $id );
		$sequences = $poissonSequence->getListFromPoisson ( $id );
		$spermes = $sperme->getListFromPoissonCampagne ( $id );
		$biopsies = $biopsie->getListeFromPoissonCampagne ( $id );
		$transferts = $transfert->getListByPoisson($data["poisson_id"], $_SESSION["annee"]);
		$ventilations = $ventilation->getListByPoisson($data["poisson_id"], $_SESSION["annee"]);
		
		$smarty->assign ( "dataSanguin", $dosages );
		$smarty->assign ( "dataBiopsie", $biopsies );
		$smarty->assign ( "dataSequence", $sequences );
		$smarty->assign ( "dataPsEvenement", $psEvenement->getListeEvenementFromPoisson ( $id ) );
		$dataEcho = $echographie->getListByYear ( $data ["poisson_id"], $_SESSION ["annee"] );
		$smarty->assign ( "dataEcho", $dataEcho );
		$smarty->assign ( "injections", $injections );
		$smarty->assign ( "spermes", $spermes );
		$smarty->assign ("dataTransfert", $transferts);
		$smarty->assign ("dataVentilation", $ventilations);
		if (is_numeric($id))
			$smarty->assign("poisson_campagne_id", $id);
		
		/*
		 * Recuperation des photos associees aux evenements
		 */
		$smarty->assign ( "moduleParent", "poissonCampagneDisplay" );
		$smarty->assign ( "parentType", "evenement" );
		$smarty->assign ( "parentIdName", "poisson_campagne_id" );
		$smarty->assign ( "parent_id", $id );
		/*
		 * Generation de la liste des evenements issus des echographies
		 */
		$a_id = array();
		foreach ($dataEcho as $key=> $value) {
			$a_id[] = $value["evenement_id"];
		}
		require_once 'modules/document/documentFunctions.php';
		$smarty->assign ( "dataDoc", getListeDocument ( "evenement", $a_id, $_REQUEST["document_limit"], $_REQUEST["document_offset"] ) );		
		
		$smarty->assign ( "corps", "repro/poissonCampagneDisplay.tpl" );
		if (isset ( $_REQUEST ["sequence_id"] ))
			$smarty->assign ( "sequence_id", $_REQUEST ["sequence_id"] );
			/*
		 * Recherche des temperatures pour le graphique
		 */
		$dateMini = new DateTime ();
		$dateMaxi = new DateTime ( "1967-01-01" );
		// if ($_REQUEST ["graphicsEnabled"] == 1) {
		for($i = 1; $i < 3; $i ++) {
			$datapf = $dataClass->getTemperatures ( $data ["poisson_id"], $_SESSION ["annee"], $i );
			$x = "'x" . $i . "'";
			if ($i == 1) {
				$y = "'constaté'";
			} else
				$y = "'prévu'";
			foreach ( $datapf as $key => $value ) {
				$x .= ",'" . $value ["pf_datetime"] . "'";
				$y .= "," . $value ["pf_temperature"];
				$datetime = explode ( " ", $value ["pf_datetime"] );
				$d = DateTime::createFromFormat ( "d/m/Y", $datetime [0] );
				if ($d < $dateMini)
					$dateMini = $d;
				if ($d > $dateMaxi)
					$dateMaxi = $d;
			}
			$smarty->assign ( "pfx" . $i, $x );
			$smarty->assign ( "pfy" . $i, $y );
		}
		$smarty->assign ( "graphicsEnabled", 1 );
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
		$e2hy ="'E2_x_hema'";
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
		foreach ( $dosages as $key => $value ) {
			if ($value ["tx_e2"] > 0) {
				$e2x .= ",'" . $value ["dosage_sanguin_date"] . "'";
				$e2y .= "," . $value ["tx_e2"];
			}
			if ($value ["tx_calcium"] > 0) {
				$cax .= ",'" . $value ["dosage_sanguin_date"] . "'";
				$cay .= "," . $value ["tx_calcium"];
				if ($value ["tx_calcium"] > $maxca)
					$maxca = $value ["tx_calcium"];
			}
			/*
			 * Ajout du taux d'hematocrite, et calcul des courbes corrigees de E2 et Ca
			 */
			if ($value["tx_hematocrite"] > 0) {
				$thx .=",'".$value["dosage_sanguin_date"]."'";
				$thy .= ",".$value["tx_hematocrite"];
				if ($value ["tx_calcium"] > 0) {
					$cahy .= ",".($value["tx_calcium"] / 100 * $value["tx_hematocrite"]);
				}
				if ($value ["tx_e2"] > 0) {
					$e2hy .= ",".($value["tx_e2"] / 100 * $value["tx_hematocrite"]);
				}			
			}
			$d = DateTime::createFromFormat ( "d/m/Y", $value ["dosage_sanguin_date"] );
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
		foreach ( $injections as $key => $value ) {
			$datetime = explode ( " ", $value ["injection_date"] );
			$ix .= ",'" . $datetime [0] . "'";
			$iy .= "," . $maxca;
			$d = DateTime::createFromFormat ( "d/m/Y", $datetime [0] );
			if ($d < $dateMini)
				$dateMini = $d;
			if ($d > $dateMaxi)
				$dateMaxi = $d;
		}
		/*
		 * Recuperation des expulsions
		 */
		if ($data ["sexe_libelle_court"] == "f") {
			foreach ( $sequences as $key => $value ) {
				if (strlen ( $value ["ovocyte_expulsion_date"] ) > 0) {
					$datetime = explode ( " ", $value ["ovocyte_expulsion_date"] );
					$d = DateTime::createFromFormat ( "d/m/Y", $datetime [0] );
					$expx .= ",'" . $datetime [0] . "'";
					$expy .= "," . $maxca;
				}
			}
			/*
			 * Recherche des donnees concernant les biopsies
			 */
			
			foreach ( $biopsies as $key => $value ) {
				if (strlen ( $value ["biopsie_date"] ) > 0) {
					$datetime = explode ( " ", $value ["biopsie_date"] );
					$d = DateTime::createFromFormat ( "d/m/Y", $datetime [0] );
					if ($d < $dateMini)
						$dateMini = $d;
					if ($d > $dateMaxi)
						$dateMaxi = $d;
					if ($value ["tx_opi"] > 0) {
						$opix .= ",'" . $datetime [0] . "'";
						$opiy .= "," . $value ["tx_opi"];
					}
					if (strlen ( $value ["ringer_t50"] ) > 0) {
						$duree = explode ( ":", $value ["ringer_t50"] );
						$dureeCalc = $duree [0] + ($duree [1] / 60);
						if ($dureeCalc > 0) {
							$t50x .= ",'" . $datetime [0] . "'";
							$t50y .= "," . $dureeCalc;
						}
					}
					if ($value["diam_moyen"] > 0) {
						$diamx .= ",'" . $datetime [0] . "'";
						$diamy .= "," .$value["diam_moyen"];
					}
				}
			}
		} else {
			foreach ( $spermes as $key => $value ) {
				$datetime = explode ( " ", $value ["sperme_date"] );
				$expx .= ",'" . $datetime [0] . "'";
				$expy .= "," . $maxca;
				$d = DateTime::createFromFormat ( "d/m/Y", $datetime [0] );
				if ($d < $dateMini)
					$dateMini = $d;
				if ($d > $dateMaxi)
					$dateMaxi = $d;
			}
		}
		
		$smarty->assign ( "e2x", $e2x );
		$smarty->assign ( "e2y", $e2y );
		$smarty->assign ( "cax", $cax );
		$smarty->assign ( "cay", $cay );
		$smarty->assign ("thx", $thx);
		$smarty->assign("thy", $thy);
		$smarty->assign ("e2hy",$e2hy);
		$smarty->assign ("cahy", $cahy);
		$smarty->assign ( "ix", $ix );
		$smarty->assign ( "iy", $iy );
		$smarty->assign ( "expx", $expx );
		$smarty->assign ( "expy", $expy );
		$smarty->assign ( "opix", $opix );
		$smarty->assign ( "opiy", $opiy );
		$smarty->assign ( "t50x", $t50x );
		$smarty->assign ( "t50y", $t50y );
		$smarty->assign ( "diamx", $diamx);
		$smarty->assign ( "diamy", $diamy);
		/*
		 * Ajout de 3 jours aux bornes des graphiques
		 */
		$interval = new DateInterval ( "P1D" );
		date_sub ( $dateMini, $interval );
		date_add ( $dateMaxi, $interval );
		$smarty->assign ( "dateMini", date_format ( $dateMini, 'd/m/Y' ) );
		$smarty->assign ( "dateMaxi", date_format ( $dateMaxi, 'd/m/Y' ) );
		
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead ( $dataClass, $id, "repro/poissonCampagneChange.tpl", $_REQUEST ["poisson_id"] );
		/*
		 * Lecture des informations concernant le poisson
		 */
		require_once 'modules/classes/poisson.class.php';
		$poisson = new Poisson ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "dataPoisson", $poisson->getDetail ( $_REQUEST ["poisson_id"] ) );
		/*
		 * Lecture de la table des statuts
		 */
		$reproStatut = new ReproStatut ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "reproStatut", $reproStatut->getListe ( 1 ) );
		/*
		 * Calcul des annees de campagne potentielles
		 */
		$anneeCourante = date ( 'Y' );
		for($i = $anneeCourante; $i > 1995; $i --) {
			$annees [] ["annee"] = $i;
		}
		$smarty->assign ( "annees", $annees );
		/*
		 * Passage en parametre de la liste parente
		 */
		$smarty->assign ( "poissonDetailParent", $_SESSION ["poissonDetailParent"] );
		$smarty->assign ("poissonParent", $_SESSION["poissonParent"]);
		break;
	case "write":
		/*
		 * write record in database
		 */
		$id = dataWrite ( $dataClass, $_REQUEST );
		if ($id > 0) {
			$_REQUEST [$keyName] = $id;
		}
		break;
	case "delete":
		/*
		 * delete record
		 */
		if (is_array ( $id )) {
			$nb = 0;
			foreach ( $id as $key => $value ) {
				if (is_numeric ( $value ) && $value > 0) {
					$ret = $dataClass->supprimer ( $value );
					if ($ret > 0) {
						$nb ++;
						$log->setLog ( $_SESSION ["login"], get_class ( $dataClass ) . "-delete", $id );
					} else
						$message .= formatErrorData ( $dataClass->getErrorData () ) . "<br>";
				}
			}
			$module_coderetour = 2;
			$message .= $nb . " poissons déselectionnés";
		} else
			dataDelete ( $dataClass, $id );
		break;
	case "campagneInit":
		/*
		 * Affiche la fenêtre d'intialisation de la campagne
		 */
		$anneeCourante = date ( "Y" );
		$annees = array ();
		for($i = $anneeCourante - 3; $i <= $anneeCourante; $i ++) {
			$annees [] ["annee"] = $i;
		}
		$smarty->assign ( "annees", $annees );
		$smarty->assign ( "corps", "repro/campagneInit.tpl" );
		
		break;
	case "init" :
		$nb = $dataClass->initCampagne ( $_REQUEST ["annee"] );
		$message = $nb . " poisson(s) ajouté(s)";
		$module_coderetour = 1;
		break;
	case "changeStatut" :
		if ($_REQUEST ["repro_statut_id"] > 0) {
			if (is_array ( $id )) {
				$nb = 0;
				foreach ( $id as $key => $value ) {
					if (is_numeric ( $value ) && $value > 0) {
						$ret = $dataClass->changeStatut ( $value, $_REQUEST ["repro_statut_id"] );
						if ($ret > 0) {
							$nb ++;
							$log->setLog ( $_SESSION ["login"], get_class ( $dataClass ) . "-delete", $id );
						} else
							$message .= formatErrorData ( $dataClass->getErrorData () ) . "<br>";
					}
				}
			} else {
				if ($dataClass->changeStatut ( $id, $_REQUEST ["repro_statut_id"] ) > 0)
					$nb = 1;
			}
			$message .= $nb . " statuts modifiés";
		}
		$module_coderetour = 1;
		break;
}

?>