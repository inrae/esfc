<?php

/**
 * Created : 28 oct. 2016
 * Creator : quinton
 * Encoding : UTF-8
 * Copyright 2016 - All rights reserved
 */
require_once 'modules/classes/spermeCongelation.class.php';
$dataClass = new SpermeCongelation($bdd, $ObjetBDDParam);
$keyName = "sperme_congelation_id";
$id = $_REQUEST[$keyName];
/*
 * Passage en parametre de la liste parente
 */
if (isset($vue)) {
    $vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
}
switch ($t_module["param"]) {
    case "list":
        isset($_COOKIE["annee"]) ? $year = $_COOKIE["annee"] : $year = 0;
        $vue->set($dataClass->getAllCongelations($year), "spermes");
        $vue->set("repro/spermeCongelationListAll.tpl", "corps");
        $vue->set($year, "annee");
        require_once "modules/classes/poissonCampagne.class.php";
        $pc = new PoissonCampagne($bdd, $ObjetBDDParam);
        $vue->set($pc->getAnnees(), "annees");
        break;
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
        require_once "modules/classes/spermeDilueur.class.php";
        $dilueur = new SpermeDilueur($bdd, $ObjetBDDParam);
        $vue->set($dilueur->getListe(2), "spermeDilueur");
        /*
         * Recherche des conservateurs
         */
        require_once "modules/classes/spermeConservateur.class.php";
        $conservateur = new SpermeConservateur($bdd, $ObjetBDDParam);
        $vue->set($conservateur->getListe(2), "spermeConservateur");

        /*
         * Recherche des emplacements de conservation
         */
        require_once "modules/classes/spermeFreezingPlace.class.php";
        $freezingPlace = new SpermeFreezingPlace($bdd, $ObjetBDDParam);
        $vue->set($freezingPlace->getListFromParent($id, 1), "place");

        /*
         * Recherche des mesures de temperature
         */
        require_once "modules/classes/spermeFreezingMeasure.class.php";
        $freezingMeasure = new SpermeFreezingMeasure($bdd, $ObjetBDDParam);
        $dataMeasure = $freezingMeasure->getListFromParent($id, 1);
        $vue->set($dataMeasure, "freezingMeasure");
        /*
         * Preparation des donnees pour le graphique
         */

        $x = "'x'";
        $y = "'Température'";
        foreach ($dataMeasure as $key => $value) {
            $x .= ",'" . $value["measure_date"] . "'";
            $y .= "," . $value["measure_temp"];
        }
        $vue->set($x, "mx");
        $vue->set($y, "my");
        $vue->htmlVars[] = "mx";
        $vue->htmlVars[] = "my";
        /*
         * Donnees du poisson
         */
        require_once 'modules/classes/poissonCampagne.class.php';
        $poissonCampagne = new PoissonCampagne($bdd, $ObjetBDDParam);
        $vue->set($poissonCampagne->lire($_REQUEST["poisson_campagne_id"]), "dataPoisson");

        /*
         * Recherche des mesures de qualite rattachees
         */
        require_once "modules/classes/spermeMesure.class.php";
        $sm = new SpermeMesure($bdd, $ObjetBDDParam);
        $vue->set($sm->getListFromCongelation($id), "dataMesure");

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
    case "generateVisotube":
        $data = $dataClass->lire($id);
        $nbPaillettesStockees = 0;
        $visotubeRadical = $data["matricule"] . "-" . $data["sperme_data"] . "-";
        $visotubeNumber = 0;
        $visotube = array(
            "login" => $_SESSION["CSlogin"],
            "token" => $_SESSION["CSpassword"],
            "collection_name" => $_SESSION["CSCollectionName"],
            "sample_type_name" => $_SESSION["CSSampleTypeName"]
        );
        $url = $_SESSION["CSAddress"] . "/" . $_SESSION["CSApiCreateUrl"];
        $module_coderetour = 1;
        while ($nbPaillettesStockees < $data["nb_paillette"]) {
            $visotube["identifier"] = $visotubeRadical . ($visotubeNumber + $_POST["firstNumber"]);
            $visotubeNumber++;
            $nbPaillettes = $data["nb_paillette"] - $nbPaillettesStockees;
            if ($nbPaillettes > $_POST["paillettesNb"]) {
                $nbPaillettes = $_POST["paillettesNb"];
            }
            $visotube["multiple_value"] = $nbPaillettes;
            $nbPaillettesStockees += $nbPaillettes;
            $result_json = apiCall("POST", $url, '', $visotube);
            $result = json_decode($result_json, true);
            if ($result["error_code"] != 200) {
                $message->set(_("La création du visotube a échoué"), true);
                $message->set($result["error_code"], $result["error_message"]);
                $module_coderetour = -1;
            }
            break;
        }
}
