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
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 19 mars 2014
 */
require_once 'modules/classes/parentPoisson.class.php';
$this->dataclass = new ParentPoisson;
$keyName = "parent_poisson_id";
$this->id = $_REQUEST[$keyName];


	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		/*
		 * Passage en parametre de la liste parente
		*/
		$this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
		$this->dataRead( $this->id, "poisson/parentPoissonChange.tpl", $_REQUEST["poisson_id"]);
		if ($this->id > 0) {
			/*
			 * Recuperation des donnees avec le poisson parent
			 */
			$this->vue->set($this->dataclass->lireAvecParent($this->id), "data");
		}
		/*
		 * Lecture du poisson
		*/
		require_once "modules/classes/poisson.class.php";
		$poisson = new Poisson;
		$this->vue->set($poisson->getDetail($_REQUEST["poisson_id"]), "dataPoisson");
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
