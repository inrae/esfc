<?php 
namespace App\Libraries;

use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class  extends PpciLibrary { 
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    private $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ;
        $this->keyName = "";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }

/**
 * Gestion de l'importation des données de sonde sur les circuits d'eau
 */
require_once 'modules/classes/sonde.class.php';
$this->dataclass = new Sonde;
$keyName = "sonde_id";
$this->id = $_REQUEST[$keyName];

        function write() {
    try {
                        $this->id = $this->dataWrite($_REQUEST);
            $_REQUEST[$this->keyName] = $this->id;
            return true;
        } catch (PpciException $e) {
            return false;
        }
            
        /*
         * write record in database
         */
        $this->id = dataWrite($this->dataclass, $_REQUEST);
        if ($this->id > 0) {
            $_REQUEST[$keyName] = $this->id;
        }
        }
       function delete() {
        /*
         * delete record
         */
         try {
            $this->dataDelete($this->id);
            return true;
        } catch (PpciException $e) {
            return false;
        }
        }
       function import() {
        $this->vue->set('bassin/sondeImport.tpl', "corps");
        $this->vue->set($this->dataclass->getListe(2), "sondes");
        }
       function importExec() {
        require_once 'modules/document/documentFunctions.php';
        $files = formatFiles("sondeFileName");
        try {
            $result = $this->dataclass->importData($_REQUEST["sonde_id"], $files);
            /*if (is_numeric($_REQUEST["sonde_id"])) {
                $this->vue->set($_REQUEST["sonde_id"], "sonde_id");
            }*/
            $this->message->set($result . " analyses d'eau créées");
            $module_coderetour = 1;
        } catch (Exception $e) {
            $this->message->set("Echec d'importation des données ", true);
            $this->message->set($e->getMessage());
            $module_coderetour = -1;
        }
        }
}
