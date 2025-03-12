<?php

namespace App\Libraries;

use App\Models\PoissonCampagne;
use App\Models\SpermeCongelation as ModelsSpermeCongelation;
use App\Models\SpermeConservateur;
use App\Models\SpermeDilueur;
use App\Models\SpermeFreezingMeasure;
use App\Models\SpermeFreezingPlace;
use App\Models\SpermeMesure;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class SpermeCongelation extends PpciLibrary
{
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    public $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsSpermeCongelation;
        $this->keyName = "sperme_congelation_id";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
        helper("esfc");
    }
    function list()
    {
        $this->vue = service('Smarty');
        isset($_COOKIE["annee"]) ? $year = $_COOKIE["annee"] : $year = 0;
        $this->vue->set($this->dataclass->getAllCongelations($year), "spermes");
        $this->vue->set("repro/spermeCongelationListAll.tpl", "corps");
        $this->vue->set($year, "annee");
        $pc = new PoissonCampagne;
        $this->vue->set($pc->getAnnees(), "annees");
        /**
         * Search the visotubes from Collec-Science
         */
        $search = array(
            "login" => $_SESSION["dbparams"]["CSLogin"],
            "token" => $_SESSION["dbparams"]["CSToken"],
            "collection_id" => $_SESSION["dbparams"]["CSCollectionId"]
        );
        if ($year > 0) {
            $search["name"] = $year;
        }
        $url = $_SESSION["dbparams"]["CSAddress"] . "/" . $_SESSION["dbparams"]["CSApiConsultUrl"];
        $this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
        try {
            /**
             * @var String
             */
            $result_json = apiCall("POST", $url, $_SESSION["dbparams"]["CSCertificatePath"], $search, $_SESSION["dbparams"]["CSDebugMode"]);
            $result = json_decode($result_json, true);
            if (isset($result["error_code"])) {
                throw new PpciException($result["error_message"]);
            }
            $this->vue->set($result, "visotubes");
        } catch (PpciException $e) {
            $this->message->set(_("La récupération des informations en provenance de Collec-Science a échoué. Si le problème persiste, contactez l'administrateur de l'application"), true);
            $this->message->set($e->getMessage(), true);
        }
        return $this->vue->send();
    }
    function change()
    {
        $this->vue = service('Smarty');
        /**
         * open the form to modify the record
         * If is a new record, generate a new record with default value :
         * $_REQUEST["idParent"] contains the identifiant of the parent record
         */
        $data = $this->dataRead($this->id, "repro/spermeCongelationChange.tpl", $_REQUEST["sperme_id"]);
        /**
         * Recherche des dilueurs
         */
        $dilueur = new SpermeDilueur;
        $this->vue->set($dilueur->getListe(2), "spermeDilueur");
        /**
         * Recherche des conservateurs
         */
        $conservateur = new SpermeConservateur;
        $this->vue->set($conservateur->getListe(2), "spermeConservateur");

        /**
         * Recherche des emplacements de conservation
         */
        $freezingPlace = new SpermeFreezingPlace;
        $this->vue->set($freezingPlace->getListFromParent($this->id, 1), "place");

        /**
         * Recherche des mesures de temperature
         */
        $freezingMeasure = new SpermeFreezingMeasure;
        $dataMeasure = $freezingMeasure->getListFromParent($this->id, 1);
        $this->vue->set($dataMeasure, "freezingMeasure");
        /**
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
        /**
         * Donnees du poisson
         */
        $poissonCampagne = new PoissonCampagne;
        $this->vue->set($poissonCampagne->lire($_REQUEST["poisson_campagne_id"]), "dataPoisson");

        /**
         * Recherche des mesures de qualite rattachees
         */
        $sm = new SpermeMesure;
        $this->vue->set($sm->getListFromCongelation($this->id), "dataMesure");

        /**
         * Recherche des echantillons depuis Collec-Science
         */
        $search = array(
            "login" => $_SESSION["dbparams"]["CSLogin"],
            "token" => $_SESSION["dbparams"]["CSToken"],
            "collection_id" => $_SESSION["dbparams"]["CSCollectionId"],
            /*"sample_type_id" => $_SESSION["CSSampleTypeName"],*/
            "name" => $data["matricule"] . "-" . $data["congelation_date_label"]
        );
        $url = $_SESSION["dbparams"]["CSAddress"] . "/" . $_SESSION["dbparams"]["CSApiConsultUrl"];
        try {
            /**
             * @var String
             */
            $result_json = apiCall("POST", $url, $_SESSION["dbparams"]["CSCertificatePath"], $search, $_SESSION["dbparams"]["CSDebugMode"]);
            $result = json_decode($result_json, true);
            if (isset($result["error_code"])) {
                throw new PpciException($result["error_message"]);
            }
            $this->vue->set($result, "visotubes");
        } catch (PpciException $e) {
            $this->message->set(_("La récupération des informations en provenance de Collec-Science a échoué. Si le problème persiste, contactez l'administrateur de l'application"), true);
            $this->message->set($e->getMessage(), true);
        }
        $this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
        return $this->vue->send();
    }
    function write()
    {
        try {
            $this->id = $this->dataWrite($_REQUEST);
            $_REQUEST[$this->keyName] = $this->id;
            return true;
        } catch (PpciException $e) {
            return false;
        }
    }
    function delete()
    {
        /**
         * delete record
         */
        try {
            $this->dataDelete($this->id);
            return true;
        } catch (PpciException $e) {
            return false;
        }
    }
    function generateVisotube()
    {
        $data = $this->dataclass->lire($this->id, $_POST["sperme_id"]);
        $nbPaillettesStockees = 0;
        $visotubeRadical = $data["matricule"] . "-" . $data["congelation_date_label"] . "-";
        $visotubeNumber = 0;
        $visotube = array(
            "login" => $_SESSION["dbparams"]["CSLogin"],
            "token" => $_SESSION["dbparams"]["CSToken"],
            "collection_name" => $_SESSION["dbparams"]["CSCollectionName"],
            "sample_type_name" => $_SESSION["dbparams"]["CSSampleTypeName"],
            /*"md_instance" => $_SESSION["CSInstanceName"]*/
        );
        $url = $_SESSION["dbparams"]["CSAddress"] . "/" . $_SESSION["dbparams"]["CSApiCreateUrl"];
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
                    $result_json = apiCall("POST", $url, $_SESSION["dbparams"]["CSCertificatePath"], $visotube, $_SESSION["dbparams"]["CSDebugMode"]);
                    $result = json_decode($result_json, true);
                    if ($result["error_code"] != 200) {
                        $this->message->set(_("La création du visotube a échoué"), true);
                        $this->message->set($result["error_code"] . " : " . $result["error_message"]);
                        return false;
                    }
                } else {
                    $this->message->set(_("Le nombre de paillettes à stocker n'est pas suffisant pour remplir tous les visotubes demandés"));
                }
            }
            if ($visotubeNumber < $_POST["visotubesNb"]) {
                $this->message->set(_("Tous les visotubes demandés n'ont pas pu être créés"));
            }
            $this->message->set(sprintf(_("%s visotubes créés"), $visotubeNumber));
            return true;
        } catch (PpciException $e) {
            $this->message->set($e->getMessage(), true);
            return false;
        }
    }
}
