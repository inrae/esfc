<?php

namespace App\Libraries;

use App\Models\PoissonCampagne;
use App\Models\Sperme;
use App\Models\SpermeCaracteristique;
use App\Models\SpermeMesure as ModelsSpermeMesure;
use App\Models\SpermeQualite;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class SpermeMesure extends PpciLibrary
{
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    public $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsSpermeMesure;
        $this->keyName = "sperme_mesure_id";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }
    function change()
    {
        $this->vue = service('Smarty');
        /**
         * open the form to modify the record
         * If is a new record, generate a new record with default value :
         * $_REQUEST["idParent"] contains the identifiant of the parent record
         */
        $data = $this->dataRead($this->id, "repro/spermeMesureChange.tpl", $_REQUEST["sperme_id"]);
        if (isset($_REQUEST["sperme_congelation_id"])) {
            $data["sperme_congelation_id"] = $_REQUEST["sperme_congelation_id"];
            $this->vue->set($data, "data");
        }
        /**
         * Recuperation des donnees du sperme
         */
        $sperme = new Sperme;
        $dataSperme =  $sperme->lire($_REQUEST["sperme_id"]);
        $this->vue->set($dataSperme, "dataSperme");
        $poissonCampagne = new PoissonCampagne;
        $this->vue->set($poissonCampagne->lire($dataSperme["poisson_campagne_id"]), "dataPoisson");
        $this->vue->set($poissonCampagne->getListSequence($dataSperme["poisson_campagne_id"], $_SESSION["annee"]), "sequences");
        $qualite = new SpermeQualite;
        $this->vue->set($qualite->getListe(1), "spermeQualite");
        $caract = new SpermeCaracteristique;
        $this->vue->set($caract->getFromSperme($_REQUEST["sperme_id"]), "spermeCaract");
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

        /**
         * write record in database
         */
        $this->id = $this->dataWrite($_REQUEST);
        if ($this->id > 0) {
            $_REQUEST[$keyName] = $this->id;
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
}
