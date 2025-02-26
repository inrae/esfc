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
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 2 avr. 2014
 */
require_once 'modules/classes/bassinEvenement.class.php';
$this->dataclass = new BassinEvenement;
$keyName = "bassin_evenement_id";
$this->id = $_REQUEST[$keyName];
	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$this->dataRead(, $this->id, "bassin/bassinEvenementChange.tpl", $_REQUEST["bassin_id"]);
		/*
		 * Lecture des types d'événements
		 */
		require_once "modules/classes/bassinEvenementType.class.php";
		$bassinEvenementType = new BassinEvenementType;
		$this->vue->set($bassinEvenementType->getListe(1), "dataEvntType");

		/*
		 * Lecture du bassin
		 */
		require_once "modules/classes/bassin.class.php";
		$bassin = new Bassin;
		$this->vue->set($bassin->getDetail($_REQUEST["bassin_id"]), "dataBassin");
		$this->vue->set($_SESSION["bassinParentModule"], "bassinParentModule");
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
