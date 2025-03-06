<?php

namespace App\Libraries;

use App\Models\Poisson;
use App\Models\Ventilation as ModelsVentilation;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Ventilation extends PpciLibrary
{
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    public $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsVentilation;
        $this->keyName = "ventilation_id";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }
    function change()
    {
        $this->vue = service('Smarty');
        $data = $this->dataRead($this->id, "poisson/ventilationChange.tpl", $_REQUEST["poisson_id"]);
        /**
         * Lecture du poisson
         */
        $poisson = new Poisson;
        $this->vue->set($poisson->getDetail($_REQUEST["poisson_id"]), "dataPoisson");
        if (isset($_REQUEST["poisson_campagne_id"]) && is_numeric($_REQUEST["poisson_campagne_id"])) {
            $this->vue->set($_REQUEST["poisson_campagne_id"], "poisson_campagne_id");
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
}
