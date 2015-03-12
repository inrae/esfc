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

if (isset($_SESSION["sequence_id"]))
	$smarty->assign("sequence_id", $_SESSION["sequence_id"]);

switch ($t_module ["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		$smarty->assign ( "annees", $dataClass->getAnnees () );
		$smarty->assign ( "data", $dataClass->getListForDisplay ( $_SESSION ["annee"] ) );
		$smarty->assign ( "corps", "repro/poissonCampagneList.tpl" );
		/*
		 * Passage en parametre de la liste parente
		 */
		$_SESSION ["poissonDetailParent"] = "poissonCampagneList";
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$smarty->assign ( "dataPoisson", $dataClass->lire ( $id ) );
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
		require_once 'modules/classes/echographie.class.php';
		$dosageSanguin = new DosageSanguin ( $bdd, $ObjetBDDParam );
		$biopsie = new Biopsie ( $bdd, $ObjetBDDParam );
		$poissonSequence = new PoissonSequence ( $bdd, $ObjetBDDParam );
		$psEvenement = new PsEvenement ( $bdd, $ObjetBDDParam );
		$echographie = new Echographie($bdd, $ObjetBDDParam);
		
		$smarty->assign ( "dataSanguin", $dosageSanguin->getListeFromPoissonCampagne ( $id ) );
		$smarty->assign ( "dataBiopsie", $biopsie->getListeFromPoissonCampagne ( $id ) );
		$smarty->assign ( "dataSequence", $poissonSequence->getListFromPoisson ( $id ) );
		$smarty->assign ( "dataPsEvenement", $psEvenement->getListeEvenementFromPoisson ( $id ) );
		$smarty->assign ( "echographies", $echographie->getListFromPoissonCampagne($id));
		
		$smarty->assign ( "corps", "repro/poissonCampagneDisplay.tpl" );
		if (isset ($_REQUEST["sequence_id"]))
			$smarty->assign("sequence_id", $_REQUEST["sequence_id"]);
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead ( $dataClass, $id, "repro/poissonCampagneChange.tpl", $_REQUEST ["idParent"] );
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
				if (is_numeric($value) && $value > 0) {
					$ret=$dataClass->supprimer($value);
				if ($ret > 0) {
					$nb ++;
					$log->setLog ( $_SESSION ["login"], get_class ( $dataClass ) . "-delete", $id );
				} else 
					$message.=formatErrorData($dataClass->getErrorData())."<br>";				
				}
			}
			$module_coderetour = 2;
			$message .= $nb." poissons déselectionnés";
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
	case "campagneInitExec" :
		$nb = $dataClass->initCampagne ( $_REQUEST ["annee"] );
		$message = $nb . " poisson(s) ajouté(s)";
		/*
		 * Generation des bassins
		 */
		require_once 'modules/classes/bassinCampagne.class.php';
		$bassinCampagne = new BassinCampagne ( $bdd, $ObjetBDDParam );
		$nb = $bassinCampagne->initCampagne ( $_REQUEST ["annee"] );
		$message .= "<br>" . $nb . " bassin(s) ajouté(s)";
		break;
}

?>