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
		/**
		 * Display the list of all records of the table
		 */
		$this->vue->set($this->dataclass->getModelesFromAnnee($_SESSION["annee"]), "data");
		$this->vue->set("repro/vieModeleList.tpl", "corps");
		/**
		 * Lecture des annees
		 */
		require_once 'modules/classes/poissonCampagne.class.php';
		$poissonCampagne = new PoissonCampagne;
		$this->vue->set($poissonCampagne->getAnnees(), "annees");
		}
	function change(){
$this->vue=service('Smarty');
		$data = $this->dataRead( $this->id, "repro/vieModeleChange.tpl");
		if ($this->id == 0) {
			$data["annee"] = $_SESSION["annee"];
			$this->vue->set($data, "data");
		}
		/**
		 * Recuperation des emplacements d'implantation des marques vie
		 */
		require_once "modules/classes/vieImplantation.class.php";
		$vieImplantation = new VieImplantation;
		$this->vue->set($vieImplantation->getListe(2), "implantations");

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
