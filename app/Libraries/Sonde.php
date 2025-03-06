<?php

namespace App\Libraries;

use App\Models\Sonde as ModelsSonde;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Sonde extends PpciLibrary
{
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    public $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsSonde;
        $this->keyName = "sonde_id";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
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
    function import()
    {
        $this->vue = service('Smarty');
        $this->vue->set('bassin/sondeImport.tpl', "corps");
        $this->vue->set($this->dataclass->getListe(2), "sondes");
        return $this->vue->send();
    }
    function importExec()
    {
        $files = formatFiles("sondeFileName");
        try {
            $result = $this->dataclass->importData($_REQUEST["sonde_id"], $files);

            $this->message->set($result . " analyses d'eau créées");
            return true;
        } catch (PpciException $e) {
            $this->message->set("Echec d'importation des données ", true);
            $this->message->set($e->getMessage());
            return false;
        }
    }
}
