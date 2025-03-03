<?php

namespace App\Libraries;

use App\Models\Bassin;
use App\Models\BassinLot as ModelsBassinLot;
use App\Models\Lot;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class BassinLot extends PpciLibrary
{
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    public $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsBassinLot;
        $this->keyName = "bassin_lot_id";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }

    function change()
    {
        $this->vue = service('Smarty');
        $data = $this->dataRead($this->id, "repro/bassinLotChange.tpl", $_REQUEST["lot_id"]);
        $bassin = new Bassin;
        $this->vue->set($bassin->getListe(1, 6), "bassins");
        $lot = new Lot;
        $this->vue->set($lot->getDetail($data["lot_id"]), "dataLot");
        $this->vue->send();
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
