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
 *  Creation 17 mars 2014
 */
require_once 'modules/classes/anomalie.class.php';
$this->dataclass = new Anomalie_db;
$keyName = "anomalie_db_id";
$this->id = $_REQUEST[$keyName];
	function list(){
$this->vue=service('Smarty');
		/*
		 * Display the list of all records of the table
		 */
		if (!isset($_SESSION["searchAnomalie"])) {
			$_SESSION["searchAnomalie"] = new SearchAnomalie();
		}
		$_SESSION["searchAnomalie"]->setParam($_REQUEST);
		$dataAnomalie = $_SESSION["searchAnomalie"]->getParam();
		if ($_SESSION["searchAnomalie"]->isSearch() == 1) {
			$this->vue->set($this->dataclass->getListeSearch($dataAnomalie), "dataAnomalie");
			$this->vue->set(1, "isSearch");
		}
		$this->vue->set($dataAnomalie, "anomalieSearch");
		$this->vue->set("anomalie/anomalieList.tpl", "corps");
		/*
		 * Recuperation des types d'anomalie
		 */
		require_once "modules/classes/anomalie_db_type.class.php";
		$anomalieType = new Anomalie_db_type;
		$this->vue->set($anomalieType->getListe(), "anomalieType");
		}
	function display(){
$this->vue=service('Smarty');
		/*
		 * Display the detail of the record
		 */
		$this->vue->set($this->dataclass->lire($this->id), "data");
		$this->vue->set("anomalie/anomalieDisplay.tpl", "corps");
		}
	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = $this->dataRead(, $this->id, "anomalie/anomalieChange.tpl");
		if ($_REQUEST["poisson_id"] > 0) {
			test();
			/**
			 * Recuperation des informations generales sur le poisson
			 */
			require_once 'modules/classes/poisson.class.php';
			$poisson = new Poisson;
			$this->vue->set($dataPoisson = $poisson->getDetail($_REQUEST["poisson_id"]), "dataPoisson");
		}
		if ($this->id == 0) {
			if ($_REQUEST["poisson_id"] > 0) {
				$data["poisson_id"] = $dataPoisson["poisson_id"];
				$data["matricule"] = $dataPoisson["matricule"];
				$data["prenom"] = $dataPoisson["prenom"];
				$data["pittag_valeur"] = $dataPoisson["pittag_valeur"];
			}
		}
		/*
		 * Passage en parametre de la liste parente
		*/
		$this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
		require_once "modules/classes/anomalie_db_type.class.php";
		$anomalieType = new Anomalie_db_type;
		$this->vue->set($anomalieType->getListe(), "anomalieType");
		if ($_REQUEST["module_origine"] == "poissonDisplay") {
			$this->vue->set("poissonDisplay", "module_origine");
		}
		$this->vue->set($data, "data");
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
		if ($_REQUEST["module_origine"] == "poissonDisplay") {
			$this->vue->set("poissonDisplay", "module_origine");
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
