<?php

namespace App\Libraries;

use App\Models\Lot;
use App\Models\LotMesure as ModelsLotMesure;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class LotMesure extends PpciLibrary
{
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    public $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsLotMesure;
        $this->keyName = "lot_mesure_id";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }
    function change()
    {
        $this->vue = service('Smarty');
        $data = $this->dataRead($this->id, "repro/lotMesureChange.tpl", $_REQUEST["lot_id"]);
        /**
         * Lecture du lot
         */
        $lot = new Lot;
        $this->vue->set($lot->getDetail($data["lot_id"]), "dataLot");
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
