<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 10 mars 2015
 */
 
include_once 'modules/classes/bassinCampagne.class.php';
$dataClass = new BassinCampagne($bdd,$ObjetBDDParam);
$keyName = "bassin_campagne_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->lire($id);
		$vue->set( , "");("dataBassinCampagne", $data);
		$vue->set( , "");("corps", "repro/bassinCampagneDisplay.tpl");
		/*
		 * Recuperation des donnees du profil thermique
		 */
		$profilThermique = new ProfilThermique($bdd, $ObjetBDDParam);
		$vue->set( , "");("profilThermiques", $profilThermique->getListFromBassinCampagne($id));
		/*
		 * Calcul des donnees pour le graphique
		 */
		
		for ($i=1;$i<3;$i++){
			$datapf = $profilThermique->getValuesFromBassinCampagne($id, $_SESSION["annee"], $i);
			$x = "'x".$i."'";
			if ($i == 1) {
				$y = "'constaté'";
			} else $y = "'prévu'";
			foreach ($datapf as $key => $value) {
				$x.=",'".$value["pf_datetime"]."'";
				$y .= ",".$value["pf_temperature"];
			}
			$vue->set( , "");("pfx".$i, $x);
			$vue->set( , "");("pfy".$i, $y);
		}
		/*
		 * Donnes de salinite
		 */
		$salinite = new Salinite($bdd, $ObjetBDDParam);
		$vue->set( , "");("salinites", $salinite->getListFromBassinCampagne($id));
		/*
		 * Calcul des donnees pour le graphique
		 */
		for ($i=1;$i<3;$i++){
			$datapf = $salinite->getValuesFromBassinCampagne($id, $_SESSION["annee"], $i);
			
			$x = "'x".$i."'";
			if ($i == 1) {
				$y = "'constaté'";
			} else $y = "'prévu'";
			foreach ($datapf as $key => $value) {
				$x.=",'".$value["salinite_datetime"]."'";
				$y .= ",".$value["salinite_tx"];
			}
			$vue->set( , "");("sx".$i, $x);
			$vue->set( , "");("sy".$i, $y);
		}
		/*
		 * Recuperation des donnees du bassin
		 */	
		require_once 'modules/classes/bassin.class.php';
		$bassin = new Bassin($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataBassin", $bassin->lire($data["bassin_id"]));
		/*
		 * Recuperation de la liste des poissons presents
		 */
		include_once 'modules/classes/poisson.class.php';
		$transfert = new Transfert($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataPoisson", $transfert->getListPoissonPresentByBassin($data["bassin_id"]));
		/*
		 * Calcul de la date du jour
		 */
		$vue->set( , "");("dateJour", date(("d/m/Y")));
		/*
		 * Recuperation des evenements
		*/
		$bassinEvenement = new BassinEvenement($bdd, $ObjetBDDParam);
		$vue->set( , "");("dataBassinEvnt", $bassinEvenement->getListeByBassin($data["bassin_id"]));
		$vue->set( , "");("bassinParentModule", $_SESSION["bassinParentModule"]);
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead($dataClass, $id, "example/exampleChange.tpl", $_REQUEST["idParent"]);
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
			$message->set(  $nb." bassin(s) ajouté(s) à la campagne de reproduction";
		}
		$module_coderetour = 1;
}
?>