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
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 10 mars 2015
 */

require_once 'modules/classes/psEvenement.class.php';
$this->dataclass = new PsEvenement;
$keyName = "ps_evenement_id";
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
		$dataPsEvenement = $this->dataclass->lire($this->id, true, $_REQUEST["poisson_sequence_id"]);
		/*
		 * Affectation des donnees a smarty
		 */
		$this->vue->set($dataPsEvenement, "dataPsEvenement");
		$this->vue->set($this->id, "ps_evenement_id");
		$module_coderetour = 1;
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