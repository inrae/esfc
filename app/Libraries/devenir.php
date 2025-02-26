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
 * @date : 1 févr. 2016
 * @encoding : UTF-8
 * (c) 2016 - All rights reserved
 */
require_once 'modules/classes/devenir.class.php';
$this->dataclass = new Devenir;
$keyName = "devenir_id";
$this->id = $_REQUEST[$keyName];

	function list(){
$this->vue=service('Smarty');
		require "modules/repro/setAnnee.php";
		$this->vue->set($this->dataclass->getListeFull($_SESSION["annee"]), "dataDevenir");
		$this->vue->set("repro/devenirCampagneList.tpl", "corps");
		}
	function change(){
$this->vue=service('Smarty');
		$data = $this->dataRead(, $this->id, "repro/devenirChange.tpl", $_REQUEST["lot_id"]);
		$this->vue->set($_REQUEST["devenirOrigine"], "devenirOrigine");
		/*
		 * Lecture des tables de parametres
		 */
		require_once 'modules/classes/categorie.class.php';
		$categorie = new Categorie;
		$this->vue->set($categorie->getListe(1), "categories");
		require_once 'modules/classes/sortieLieu.class.php';
		$sortie = new SortieLieu;
		$this->vue->set($sortie->getListe(2), "sorties");
		require_once "modules/classes/devenirType.class.php";
		$devenirType = new DevenirType;
		$this->vue->set($devenirType->getListe(1), "devenirType");
		/*
		 * Lecture du lot
		 */
		if ($data["lot_id"] > 0) {
			require_once 'modules/classes/lot.class.php';
			$lot = new Lot;
			$this->vue->set($lot->getDetail($data["lot_id"]), "dataLot");
		}
		/*
		 * Recuperation de la liste des devenirs parents potentiels
		 */
		if ($data["lot_id"] > 0) {
			$lotId = $data["lot_id"];
			$annee = 0;
		} else {
			$lotId = 0;
			$annee = $_SESSION["annee"];
		}
		$parents = $this->dataclass->getParentsPotentiels($data["devenir_id"], $lotId, $annee);
		$this->vue->set($parents, "devenirParent");
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
