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
 *  Creation 1 avr. 2015
 */
require_once 'modules/classes/vieModele.class.php';
$this->dataclass = new VieModele;
$keyName = "vie_modele_id";
$this->id = $_REQUEST[$keyName];

require "modules/repro/setAnnee.php";

	function list(){
$this->vue=service('Smarty');
		/*
		 * Display the list of all records of the table
		 */
		$this->vue->set($this->dataclass->getModelesFromAnnee($_SESSION["annee"]), "data");
		$this->vue->set("repro/vieModeleList.tpl", "corps");
		/*
		 * Lecture des annees
		 */
		require_once 'modules/classes/poissonCampagne.class.php';
		$poissonCampagne = new PoissonCampagne;
		$this->vue->set($poissonCampagne->getAnnees(), "annees");
		}
	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = $this->dataRead(, $this->id, "repro/vieModeleChange.tpl");
		if ($this->id == 0) {
			$data["annee"] = $_SESSION["annee"];
			$this->vue->set($data, "data");
		}
		/*
		 * Recuperation des emplacements d'implantation des marques vie
		 */
		require_once "modules/classes/vieImplantation.class.php";
		$vieImplantation = new VieImplantation;
		$this->vue->set($vieImplantation->getListe(2), "implantations");

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
