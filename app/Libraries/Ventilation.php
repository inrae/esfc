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
 * @date : 14 mars 2016
 * @encoding : UTF-8
 * (c) 2016 - All rights reserved
 */
require_once 'modules/classes/ventilation.class.php';
$this->dataclass = new Ventilation;
$keyName = "ventilation_id";
$this->id = $_REQUEST[$keyName];
/**
 * Passage en parametre de la liste parente
 */
if (isset ($this->vue)){
	$this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
}

	function change(){
$this->vue=service('Smarty');
		$data = $this->dataRead( $this->id, "poisson/ventilationChange.tpl", $_REQUEST["poisson_id"]);
		/**
		 * Lecture du poisson
		*/
		require_once "modules/classes/poisson.class.php";
		$poisson = new Poisson;
		$this->vue->set($poisson->getDetail($_REQUEST["poisson_id"]), "dataPoisson");
		if (isset($_REQUEST["poisson_campagne_id"]) && is_numeric($_REQUEST["poisson_campagne_id"]))
			$this->vue->set($_REQUEST["poisson_campagne_id"], "poisson_campagne_id");
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
