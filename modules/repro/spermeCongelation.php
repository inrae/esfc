<?php
/**
 * Created : 28 oct. 2016
 * Creator : quinton
 * Encoding : UTF-8
 * Copyright 2016 - All rights reserved
 */
include_once 'modules/classes/sperme.class.php';
$dataClass = new SpermeCongelation($bdd, $ObjetBDDParam);
$keyName = "sperme_congelation_id";
$id = $_REQUEST[$keyName];
/*
 * Passage en parametre de la liste parente
 */
$vue->set( , ""); ( "poissonDetailParent", $_SESSION ["poissonDetailParent"] );

switch ($t_module["param"]) {
    case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead($dataClass, $id, "repro/spermeCongelationChange.tpl", $_REQUEST["sperme_id"]);
        /*
         * Recherche des dilueurs
         */
        $dilueur = new SpermeDilueur($bdd, $ObjetBDDParam);
        $vue->set( , "");("spermeDilueur", $dilueur->getListe(2));
        /*
         * Recherche des conservateurs
         */
        $conservateur = new SpermeConservateur($bdd, $ObjetBDDParam);
        $vue->set( , "");("spermeConservateur", $conservateur->getListe(2));
        
        /*
         * Recherche des emplacements de conservation
         */
        $freezingPlace = new SpermeFreezingPlace($bdd, $ObjetBDDParam);
        $vue->set( , "");("place", $freezingPlace->getListFromParent($id, 1));
        
        /*
         * Recherche des mesures de temperature
         */
        $freezingMeasure = new SpermeFreezingMeasure($bdd, $ObjetBDDParam);
        $dataMeasure = $freezingMeasure->getListFromParent($id, 1);
        $vue->set( , "");("freezingMeasure", $dataMeasure );
        /*
         * Preparation des donnees pour le graphique
         */
        
        $x = "'x'";
        $y = "'Température'";
        foreach ( $dataMeasure as $key => $value ) {
            $x .= ",'" . $value ["measure_date"] . "'";
            $y .= "," . $value ["measure_temp"];
        }
        $vue->set( , "");("mx", $x);
        $vue->set( , "");("my", $y);
        /*
         * Donnees du poisson
         */
        require_once 'modules/classes/poissonRepro.class.php';
        $poissonCampagne = new PoissonCampagne($bdd, $ObjetBDDParam);
        $vue->set( , "");("dataPoisson", $poissonCampagne->lire($_REQUEST["poisson_campagne_id"]));
        
        /*
         * Recherche des mesures de qualite rattachees
         */
        $sm = new SpermeMesure($bdd, $ObjetBDDParam);
        $vue->set( , "");("dataMesure", $sm->getListFromCongelation($id));
        
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
}

?>