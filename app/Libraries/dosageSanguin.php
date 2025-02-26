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
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 6 mars 2015
 */

require_once 'modules/classes/dosageSanguin.class.php';
require_once 'modules/classes/poissonCampagne.class.php';
$this->dataclass = new DosageSanguin;
$keyName = "dosage_sanguin_id";
$this->id = $_REQUEST[$keyName];
if (isset($this->vue)) {
	if (isset($_SESSION["sequence_id"])) {
		$this->vue->set($_SESSION["sequence_id"], "sequence_id");
	}
	$this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
}
	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$poissonCampagne = new poissonCampagne;
		$data = $this->dataRead(, $this->id, "repro/dosageSanguinChange.tpl", $_REQUEST["poisson_campagne_id"]);
		$this->vue->set($poissonCampagne->lire($data["poisson_campagne_id"]), "dataPoisson");
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
