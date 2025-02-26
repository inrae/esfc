<?php 
namespace App\Libraries;

use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Xx extends PpciLibrary { 
    /**
     * @var xx
     */
    protected PpciModel $this->dataclass;
    private $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ;
        $keyName = "_id";
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
/*
 * Passage en parametre de la liste parente
 */
if (isset ($this->vue)){
	$this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
}

	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = $this->dataRead(, $this->id, "poisson/ventilationChange.tpl", $_REQUEST["poisson_id"]);
		/*
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
            $this->id =  try {
            $this->id = $this->dataWrite($_REQUEST);
            $_REQUEST["_id"] = $this->id;
            return true;
        } catch (PpciException $e) {
            return false;
        }
            if ($this->id > 0) {
                $_REQUEST[$this->keyName] = $this->id;
                return true;
            } else {
                return false;
            }
        } catch (PpciException) {
            return false;
        }
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
}
