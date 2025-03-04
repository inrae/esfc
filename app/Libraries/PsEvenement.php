<?php

namespace App\Libraries;

use App\Models\PsEvenement as ModelsPsEvenement;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class PsEvenement extends PpciLibrary
{
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    public $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsPsEvenement;
        $this->keyName = "ps_evenement_id";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }
    function change()
    {
        $this->vue = service('Smarty');
        if (isset($_SESSION["sequence_id"])) {
            $this->vue->set($_SESSION["sequence_id"], "sequence_id");
        }
        $this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
        $dataPsEvenement = $this->dataclass->lire($this->id, true, $_REQUEST["poisson_sequence_id"]);
        /**
         * Affectation des donnees a smarty
         */
        $this->vue->set($dataPsEvenement, "dataPsEvenement");
        $this->vue->set($this->id, "ps_evenement_id");
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
