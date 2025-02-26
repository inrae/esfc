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
 * @date : 15 mars 2016
 * @encoding : UTF-8
 * (c) 2016 - All rights reserved
 */
require_once 'modules/classes/bassin.class.php';
$this->dataclass = new CircuitEvenement($bdd,$ObjetBDDParam);
$keyName = "circuit_evenement_id";
$this->id = $_REQUEST[$keyName];
	function list(){
$this->vue=service('Smarty');
		}
	function display(){
$this->vue=service('Smarty');
		}
	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$this->dataRead(, $this->id, "bassin/circuitEvenementChange.tpl",$_REQUEST["circuit_eau_id"]);
		/*
		 * Lecture des types d'événements
		 */
		require_once "modules/classes/circuitEvenementType.class.php";
		$circuitEvenementType = new circuitEvenementType;
		$this->vue->set($circuitEvenementType->getListe(1) , "dataEvntType");
		/*
		 * Lecture du circuit d'eau
		 */
		require_once "modules/classes/circuitEau.class.php";
		$circuit = new CircuitEau;
		$this->vue->set($circuit->lire($_REQUEST["circuit_eau_id"]) , "dataCircuit");
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
