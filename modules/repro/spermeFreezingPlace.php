<?php
/**
 * Created : 3 juil. 2017
 * Creator : quinton
 * Encoding : UTF-8
 * Copyright 2017 - All rights reserved
 */
include_once 'modules/classes/sperme.class.php';
$dataClass = new SpermeFreezingPlace($bdd, $ObjetBDDParam);
$keyName = "sperme_freezing_place_id";
$id = $_REQUEST[$keyName];
/*
 * Passage en parametre de la liste parente
 */
$smarty->assign("poissonDetailParent", $_SESSION["poissonDetailParent"]);

switch ($t_module["param"]) {
    case "change":
        /*
         * open the form to modify the record
         * If is a new record, generate a new record with default value :
         * $_REQUEST["idParent"] contains the identifiant of the parent record
         */
        dataRead($dataClass, $id, "repro/spermeFreezingPlaceChange.tpl", $_REQUEST["sperme_congelation_id"]);
        $spermeCongelation = new SpermeCongelation($bdd, $ObjetBDDParam);
        $dataCongelation = $spermeCongelation->lire($_REQUEST["sperme_congelation_id"]);
        $smarty->assign("dataCongelation", $dataCongelation);
        /*
         * Donnees du poisson
         */
        require_once 'modules/classes/poissonRepro.class.php';
        $poissonCampagne = new PoissonCampagne($bdd, $ObjetBDDParam);
        $smarty->assign("dataPoisson", $poissonCampagne->lire($_REQUEST["poisson_campagne_id"]));
        
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