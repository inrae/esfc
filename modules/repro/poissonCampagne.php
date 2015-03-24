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
if (isset ( $_REQUEST ["annee"] ))
	$_SESSION ["annee"] = $_REQUEST ["annee"];

if (! isset ( $_SESSION ["annee"] ))
	$_SESSION ["annee"] = date ( 'Y' );
$smarty->assign ( "annee", $_SESSION ["annee"] );

if (isset ( $_SESSION ["sequence_id"] ))
	$smarty->assign ( "sequence_id", $_SESSION ["sequence_id"] );

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
		if ($_REQUEST["graphique_id"] > 0) {
			require_once 'modules/classes/poisson.class.php';
			$morphologie = new Morphologie($bdd, $ObjetBDDParam);
			$date_from = ($_SESSION["annee"] - 5)."-01-01";
			$date_to = $_SESSION["annee"]."-12-31";
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
			foreach ($dataMorpho as $key=>$value) {
				$x .= ",'".$value["morphologie_date"]."'";
				$y .= ",".$value["masse"];
			}
			printr($x);
			printr($y);
			$smarty->assign("poisson_nom", $dataPoisson["prenom"]." ".$dataPoisson["matricule"]);
			$smarty->assign("massex", $x);
			$smarty->assign("massey", $y);
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
		 * Lecture des tables liees
		 */
		require_once 'modules/classes/dosageSanguin.class.php';
		require_once 'modules/classes/biopsie.class.php';
		require_once 'modules/classes/sequence.class.php';
		require_once 'modules/classes/poisson.class.php';
		require_once 'modules/classes/injection.class.php';
		$dosageSanguin = new DosageSanguin ( $bdd, $ObjetBDDParam );
		$biopsie = new Biopsie ( $bdd, $ObjetBDDParam );
		$poissonSequence = new PoissonSequence ( $bdd, $ObjetBDDParam );
		$psEvenement = new PsEvenement ( $bdd, $ObjetBDDParam );
		$echographie = new Echographie ( $bdd, $ObjetBDDParam );
		$injection = new Injection ( $bdd, $ObjetBDDParam );
		$dosages = $dosageSanguin->getListeFromPoissonCampagne ( $id );
		
		$smarty->assign ( "dataSanguin", $dosages );
		$smarty->assign ( "dataBiopsie", $biopsie->getListeFromPoissonCampagne ( $id ) );
		$smarty->assign ( "dataSequence", $poissonSequence->getListFromPoisson ( $id ) );
		$smarty->assign ( "dataPsEvenement", $psEvenement->getListeEvenementFromPoisson ( $id ) );
		$smarty->assign ( "dataEcho", $echographie->getListByYear ( $data ["poisson_id"], $_SESSION ["annee"] ) );
		$smarty->assign ( "injections", $injection->getListFromPoissonCampagne ( $id ) );
		
		$smarty->assign ( "corps", "repro/poissonCampagneDisplay.tpl" );
		if (isset ( $_REQUEST ["sequence_id"] ))
			$smarty->assign ( "sequence_id", $_REQUEST ["sequence_id"] );
			/*
		 * Recherche des temperatures pour le graphique
		 */
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
			}
			$smarty->assign ( "pfx" . $i, $x );
			$smarty->assign ( "pfy" . $i, $y );
		}
		$smarty->assign ( "graphicsEnabled", 1 );
		// }
		/*
		 * Recherche des donnees pour les taux sanguins
		 */
		$e2y = "'E2'";
		$cay = "'Ca'";
		$e2x = "'x1'";
		$cax = "'x2'";
		foreach ($dosages as $key => $value) {
			if ($value["tx_e2"] > 0) {
				$e2x .= ",'".$value["dosage_sanguin_date"]. "'";
				$e2y .= "," .$value["tx_e2"];
			}
			if ($value["tx_calcium"] > 0) {
				$cax .= ",'".$value["dosage_sanguin_date"]. "'";
				$cay .= "," .$value["tx_calcium"];
			}
		}
		$smarty->assign("e2x", $e2x);
		$smarty->assign("e2y", $e2y);
		$smarty->assign("cax", $cax);
		$smarty->assign("cay", $cay);
		
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