<?php

namespace App\Libraries;

use App\Models\ParentPoisson as ModelsParentPoisson;
use App\Models\Poisson;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class ParentPoisson extends PpciLibrary
{
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    public $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsParentPoisson;
        $this->keyName = "parent_poisson_id";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }
    function change()
    {
        $this->vue = service('Smarty');
        /**
         * Passage en parametre de la liste parente
         */
        $this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
        $this->dataRead($this->id, "poisson/parentPoissonChange.tpl", $_REQUEST["poisson_id"]);
        if ($this->id > 0) {
            /**
             * Recuperation des donnees avec le poisson parent
             */
            $this->vue->set($this->dataclass->lireAvecParent($this->id), "data");
        }
        /**
         * Lecture du poisson
         */
        $poisson = new Poisson;
        $this->vue->set($poisson->getDetail($_REQUEST["poisson_id"]), "dataPoisson");
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
