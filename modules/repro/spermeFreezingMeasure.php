<?php

/**
 * Created : 3 juil. 2017
 * Creator : quinton
 * Encoding : UTF-8
 * Copyright 2017 - All rights reserved
 */ require_once 'modules/classes/spermeFreezingMeasure.class.php';
$dataClass = new SpermeFreezingMeasure($bdd, $ObjetBDDParam);
$keyName = "sperme_freezing_measure_id";
$id = $_REQUEST[$keyName];
/*
 * Passage en parametre de la liste parente
 */
$vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");

switch ($t_module["param"]) {
    case "change":
        /*
         * open the form to modify the record
         * If is a new record, generate a new record with default value :
         * $_REQUEST["idParent"] contains the identifiant of the parent record
         */
        dataRead($dataClass, $id, "repro/spermeFreezingMeasureChange.tpl", $_REQUEST["sperme_congelation_id"]);
        require_once "modules/classes/spermeCongelation.class.php";
        $spermeCongelation = new SpermeCongelation($bdd, $ObjetBDDParam);
        $vue->set($spermeCongelation->lire($_REQUEST["sperme_congelation_id"]), "dataCongelation");
        /* 
        * Donnees du poisson
         */
        require_once 'modules/classes/poissonCampagne.class.php';
        $poissonCampagne = new PoissonCampagne($bdd, $ObjetBDDParam);
        $vue->set($poissonCampagne->lire($_REQUEST["poisson_campagne_id"]), "dataPoisson");

        break;
    case "write":
        /*
         * write record in database
         */
        $id = dataWrite($dataClass, $_REQUEST);
        /*if ($id > 0) {
            $_REQUEST[$keyName] = $id;
        }*/
        break;
    case "delete":
        /*
         * delete record
         */
        dataDelete($dataClass, $id);
        break;
}
