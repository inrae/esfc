<?php 
namespace App\Libraries;

use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class  extends PpciLibrary { 
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    private $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ;
        $this->keyName = "";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }

/**
 * Created : 28 oct. 2016
 * Creator : quinton
 * Encoding : UTF-8
 * Copyright 2016 - All rights reserved
 */
require_once 'modules/classes/spermeCongelation.class.php';
$this->dataclass = new SpermeCongelation;
$keyName = "sperme_congelation_id";
$this->id = $_REQUEST[$keyName];
/*
 * Passage en parametre de la liste parente
 */
if (isset ($this->vue)) {
    $this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
}
    function list(){
$this->vue=service('Smarty');
        isset ($_COOKIE["annee"]) ? $year = $_COOKIE["annee"] : $year = 0;
        $this->vue->set($this->dataclass->getAllCongelations($year), "spermes");
        $this->vue->set("repro/spermeCongelationListAll.tpl", "corps");
        $this->vue->set($year, "annee");
        require_once "modules/classes/poissonCampagne.class.php";
        $pc = new PoissonCampagne;
        $this->vue->set($pc->getAnnees(), "annees");
        /**
         * Search the visotubes from Collec-Science
         */
        $search = array(
            "login" => $_SESSION["CSLogin"],
            "token" => $_SESSION["CSToken"],
            "collection_id" => $_SESSION["CSCollectionId"]
        );
        if ($year > 0) {
            $search ["name"] = $year;
        }
        $url = $_SESSION["CSAddress"] . "/" . $_SESSION["CSApiConsultUrl"];
        try {
            /**
             * @var String
             */
            $result_json = apiCall("POST", $url, $_SESSION["CSCertificatePath"], $search, $_SESSION["CSDebugMode"]);
            $result = json_decode($result_json, true);
            $this->vue->set($result, "visotubes");
        } catch (ApiCurlException $e) {
            $this->message->set(_("La récupération des informations en provenance de Collec-Science a échoué. Si le problème persiste, contactez l'administrateur de l'application"), true);
            $this->message->set($e->getMessage(), true);
        }
        }
    function change(){
$this->vue=service('Smarty');
        /*
         * open the form to modify the record
         * If is a new record, generate a new record with default value :
         * $_REQUEST["idParent"] contains the identifiant of the parent record
         */
        $data = $this->dataRead( $this->id, "repro/spermeCongelationChange.tpl", $_REQUEST["sperme_id"]);
        /*
         * Recherche des dilueurs
         */
        require_once "modules/classes/spermeDilueur.class.php";
        $dilueur = new SpermeDilueur;
        $this->vue->set($dilueur->getListe(2), "spermeDilueur");
        /*
         * Recherche des conservateurs
         */
        require_once "modules/classes/spermeConservateur.class.php";
        $conservateur = new SpermeConservateur;
        $this->vue->set($conservateur->getListe(2), "spermeConservateur");

        /*
         * Recherche des emplacements de conservation
         */
        require_once "modules/classes/spermeFreezingPlace.class.php";
        $freezingPlace = new SpermeFreezingPlace;
        $this->vue->set($freezingPlace->getListFromParent($this->id, 1), "place");

        /*
         * Recherche des mesures de temperature
         */
        require_once "modules/classes/spermeFreezingMeasure.class.php";
        $freezingMeasure = new SpermeFreezingMeasure;
        $dataMeasure = $freezingMeasure->getListFromParent($this->id, 1);
        $this->vue->set($dataMeasure, "freezingMeasure");
        /*
         * Preparation des donnees pour le graphique
         */

        $x = "'x'";
        $y = "'Température'";
        foreach ($dataMeasure as $key => $value) {
            $x .= ",'" . $value["measure_date"] . "'";
            $y .= "," . $value["measure_temp"];
        }
        $this->vue->set($x, "mx");
        $this->vue->set($y, "my");
        $this->vue->htmlVars[] = "mx";
        $this->vue->htmlVars[] = "my";
        /*
         * Donnees du poisson
         */
        require_once 'modules/classes/poissonCampagne.class.php';
        $poissonCampagne = new PoissonCampagne;
        $this->vue->set($poissonCampagne->lire($_REQUEST["poisson_campagne_id"]), "dataPoisson");

        /*
         * Recherche des mesures de qualite rattachees
         */
        require_once "modules/classes/spermeMesure.class.php";
        $sm = new SpermeMesure;
        $this->vue->set($sm->getListFromCongelation($this->id), "dataMesure");

        /**
         * Recherche des echantillons depuis Collec-Science
         */
        $search = array(
            "login" => $_SESSION["CSLogin"],
            "token" => $_SESSION["CSToken"],
            "collection_id" => $_SESSION["CSCollectionId"],
            /*"sample_type_id" => $_SESSION["CSSampleTypeName"],*/
            "name" => $data["matricule"] . "-" . $data["congelation_date_label"]
        );
        $url = $_SESSION["CSAddress"] . "/" . $_SESSION["CSApiConsultUrl"];
        try {
            /**
             * @var String
             */
            $result_json = apiCall("POST", $url, $_SESSION["CSCertificatePath"], $search, $_SESSION["CSDebugMode"]);
            $result = json_decode($result_json, true);
            $this->vue->set($result, "visotubes");
        } catch (ApiCurlException $e) {
            $this->message->set(_("La récupération des informations en provenance de Collec-Science a échoué. Si le problème persiste, contactez l'administrateur de l'application"), true);
            $this->message->set($e->getMessage(), true);
        }
        }
        function write() {
    try {
                        $this->id = $this->dataWrite($_REQUEST);
            $_REQUEST[$this->keyName] = $this->id;
            return true;
        } catch (PpciException $e) {
            return false;
        }
            
        /*
         * write record in database
         */
        $this->id = dataWrite($this->dataclass, $_REQUEST);
        if ($this->id > 0) {
            $_REQUEST[$keyName] = $this->id;
        }
        }
       function delete() {
        /*
         * delete record
         */
         try {
            $this->dataDelete($this->id);
            return true;
        } catch (PpciException $e) {
            return false;
        }
        }
       function generateVisotube() {
        $data = $this->dataclass->lire($this->id, $_POST["sperme_id"]);
        $nbPaillettesStockees = 0;
        $visotubeRadical = $data["matricule"] . "-" . $data["congelation_date_label"] . "-";
        $visotubeNumber = 0;
        $visotube = array(
            "login" => $_SESSION["CSLogin"],
            "token" => $_SESSION["CSToken"],
            "collection_name" => $_SESSION["CSCollectionName"],
            "sample_type_name" => $_SESSION["CSSampleTypeName"],
            /*"md_instance" => $_SESSION["CSInstanceName"]*/
        );
        $url = $_SESSION["CSAddress"] . "/" . $_SESSION["CSApiCreateUrl"];
        $module_coderetour = 1;
        try {
            for ($i = 1; $i <= $_POST["visotubesNb"]; $i++) {
                if ($nbPaillettesStockees < $_POST["totalPaillettesNb"]) {
                    $visotube["identifier"] = $visotubeRadical . ($visotubeNumber + $_POST["firstNumber"]);
                    $visotubeNumber++;
                    $nbPaillettes = $data["nb_paillette"] - $nbPaillettesStockees;
                    if ($nbPaillettes > $_POST["paillettesNb"]) {
                        $nbPaillettes = $_POST["paillettesNb"];
                    }
                    $visotube["multiple_value"] = $nbPaillettes;
                    $nbPaillettesStockees += $nbPaillettes;
                    /**
                     * @var String
                     */
                    $result_json = apiCall("POST", $url, $_SESSION["CSCertificatePath"], $visotube, $_SESSION["CSDebugMode"]);
                    $result = json_decode($result_json, true);
                    if ($result["error_code"] != 200) {
                        $this->message->set(_("La création du visotube a échoué"), true);
                        $this->message->set($result["error_code"] . " : " . $result["error_message"]);
                        $module_coderetour = -1;
                        }
                    }
                } else {
                    $this->message->set(_("Le nombre de paillettes à stocker n'est pas suffisant pour remplir tous les visotubes demandés"));
                    }
                }
            }
        } catch (ApiCurlException $e) {
            $this->message->set($e->getMessage(), true);
            $module_coderetour = -1;
        }
        if ($visotubeNumber < $_POST["visotubesNb"]) {
            $this->message->set(_("Tous les visotubes demandés n'ont pas pu être créés"));
        }
        $this->message->set(sprintf(_("%s visotubes créés"), $visotubeNumber));
        }
}
