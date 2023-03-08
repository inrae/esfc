<?php
/**
 * Created : 1 août 2017
 * Creator : quinton
 * Encoding : UTF-8
 * Copyright 2017 - All rights reserved
 */
require_once 'modules/classes/sperme.class.php';
$dataClass = new SpermeMesure($bdd,$ObjetBDDParam);
$keyName = "sperme_mesure_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
    case "change":
        /*
         * open the form to modify the record
         * If is a new record, generate a new record with default value :
         * $_REQUEST["idParent"] contains the identifiant of the parent record
         */
        $data = dataRead($dataClass, $id, "repro/spermeMesureChange.tpl", $_REQUEST["sperme_id"]);
        if (isset($_REQUEST["sperme_congelation_id"])) {
            $data["sperme_congelation_id"] = $_REQUEST["sperme_congelation_id"];
            $vue->set( , "");("data", $data);
        }
       /*
         * Recuperation des donnees du sperme
         */
        $sperme = new Sperme($bdd, $ObjetBDDParam);
        $dataSperme =  $sperme->lire($_REQUEST["sperme_id"]);
        $vue->set( , "");("dataSperme",$dataSperme);
        
        require_once 'modules/classes/poissonRepro.class.php';
        $poissonCampagne = new PoissonCampagne($bdd, $ObjetBDDParam);
        $vue->set( , "");("dataPoisson", $poissonCampagne->lire($dataSperme["poisson_campagne_id"]));
        $vue->set( , ""); ("sequences", $poissonCampagne->getListSequence($_REQUEST["poisson_campagne_id"], $_SESSION["annee"]));
        
        $qualite = new SpermeQualite($bdd, $ObjetBDDParam);
        $vue->set( , "");("spermeQualite", $qualite->getListe(1));
        $caract = new SpermeCaracteristique($bdd, $ObjetBDDParam);
        $vue->set( , "");("spermeCaract", $caract->getFromSperme($sperme_id));
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