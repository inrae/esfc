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
    public $keyName;

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
 * @author : quinton
 * @date : 16 mars 2016
 * @encoding : UTF-8
 * (c) 2016 - All rights reserved
 */
require_once 'modules/classes/spermeCaracteristique.class.php';
$this->dataclass = new SpermeCaracteristique;
$keyName = "sperme_caracteristique_id";
$this->id = $_REQUEST[$keyName];
	function list(){
$this->vue=service('Smarty');
		/**
		 * Display the list of all records of the table
		 */
		$this->vue->set($this->dataclass->getListe(2), "data");
		$this->vue->set("parametre/spermeCaracteristiqueList.tpl", "corps");
		}
	function change(){
$this->vue=service('Smarty');
		$this->dataRead( $this->id, "parametre/spermeCaracteristiqueChange.tpl");
		}
	    function write() {
    try {
                        $this->id = $this->dataWrite($_REQUEST);
            $_REQUEST[$this->keyName] = $this->id;
            return true;
        } catch (PpciException $e) {
            return false;
        }
}
	   function delete() {
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
