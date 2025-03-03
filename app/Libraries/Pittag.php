<?php

namespace App\Libraries;

use App\Models\Pittag as ModelsPittag;
use App\Models\Pittag_type;
use App\Models\PittagType;
use App\Models\Poisson;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Pittag extends PpciLibrary
{
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    public $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsPittag;
        $this->keyName = "pittag_id";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }
    function change()
    {
        $this->vue = service('Smarty');
        $this->dataRead($this->id, "poisson/pittagChange.tpl", $_REQUEST["poisson_id"]);
        /**
         * Recuperation de la liste des types de pittag
         */
        $pittagType = new PittagType;
        $this->vue->set($pittagType->getListe(), "pittagType");
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
