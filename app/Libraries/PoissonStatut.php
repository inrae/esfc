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
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 18 févr. 2014
 */
require_once 'modules/classes/poissonStatut.class.php';
$this->dataclass = new Poisson_statut;
$keyName = "poisson_statut_id";
$this->id = $_REQUEST[$keyName];
	function list(){
$this->vue=service('Smarty');
		/**
		 * Display the list of all records of the table
		 */
		$this->vue->set($this->dataclass->getListe(1), "data");
		$this->vue->set("parametre/poissonStatutList.tpl", "corps");
		}
	function change(){
$this->vue=service('Smarty');
		$this->dataRead( $this->id, "parametre/poissonStatutChange.tpl");
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
