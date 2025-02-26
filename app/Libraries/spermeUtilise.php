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
 * @date : 17 mars 2016
 * @encoding : UTF-8
 * (c) 2016 - All rights reserved
 */
require_once 'modules/classes/spermeUtilise.class.php';
$this->dataclass = new SpermeUtilise;
$keyName = "sperme_utilise_id";
$this->id = $_REQUEST[$keyName];
if (isset($this->vue)) {
	$this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
}

	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$this->dataRead(, $this->id, "repro/spermeUtiliseChange.tpl", $_REQUEST["croisement_id"]);
		/*
		 * Recuperation du croisement
		 */
		require_once 'modules/classes/croisement.class.php';
		$croisement = new Croisement;
		$croisementData = $croisement->getDetail($_REQUEST["croisement_id"]);
		$this->vue->set($croisementData, "croisementData");
		/*
		 * Lecture de la sequence
		 */
		require_once "modules/classes/sequence.class.php";
		$sequence = new Sequence;
		$this->vue->set($sequence->lire($croisementData["sequence_id"]), "dataSequence");
		/*
		 * Recuperation de la liste des spermes potentiels
		 */
		require_once "modules/classes/sperme.class.php";
		$sperme = new Sperme;
		$this->vue->set($sperme->getListPotentielFromCroisement($_REQUEST["croisement_id"]), "spermes");
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
