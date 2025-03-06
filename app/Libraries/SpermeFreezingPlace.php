<?php

namespace App\Libraries;

use App\Models\PoissonCampagne;
use App\Models\SpermeCongelation;
use App\Models\SpermeFreezingPlace as ModelsSpermeFreezingPlace;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class SpermeFreezingPlace extends PpciLibrary
{
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    public $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsSpermeFreezingPlace;
        $this->keyName = "sperme_freezing_place_id";
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
        $this->dataRead($this->id, "repro/spermeFreezingPlaceChange.tpl", $_REQUEST["sperme_congelation_id"]);
        $spermeCongelation = new SpermeCongelation;
        $this->vue->set($spermeCongelation->lire($_REQUEST["sperme_congelation_id"]), "dataCongelation");
        /**
         * Donnees du poisson
         */
        $poissonCampagne = new PoissonCampagne;
        $this->vue->set($poissonCampagne->lire($_REQUEST["poisson_campagne_id"]), "dataPoisson");
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
}
