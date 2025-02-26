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
 *  Creation 4 mars 2014
 */
require_once 'modules/classes/circuitEau.class.php';
$this->dataclass = new CircuitEau($bdd,$ObjetBDDParam);
$keyName = "circuit_eau_id";
$this->id = $_REQUEST[$keyName];
if (!isset($_SESSION["searchCircuitEau"])) {
	$_SESSION["searchCircuitEau"] = new SearchCircuitEau();
}

	function list(){
$this->vue=service('Smarty');
		/*
		 * Display the list of all records of the table
		 */
		$_SESSION["searchCircuitEau"]->setParam ( $_REQUEST );
		$dataSearch = $_SESSION["searchCircuitEau"]->getParam ();
		if ($_SESSION["searchCircuitEau"]->isSearch () == 1) {
			$this->vue->set(1 , "isSearch"); 
		}
		$this->vue->set($dataSearch , "circuitEauSearch"); 
		if ($_SESSION["searchCircuitEau"]->isSearch () == 1) {
			$this->vue->set( $this->dataclass->getListeSearch ( $dataSearch ), "data");
			/*
			 * Recuperation des donnees d'analyse
			 */
			if ($_REQUEST["circuit_eau_id"] > 0) {
				require_once "modules/classes/analyseEau.class.php";
				$analyseEau = new AnalyseEau;
				$this->vue->set($analyseEau->getDetailByCircuitEau($_REQUEST["circuit_eau_id"], $dataSearch["analyse_eau_date"]) , "dataAnalyse");
			}
		}
		$this->vue->set("bassin/circuitEauList.tpl" , "corps");
		require_once 'modules/classes/site.class.php';
		$site = new Site;
		$this->vue->set( $site->getListe(2), "site");
		$_SESSION["bassinParentModule"] = "circuitEauList";
		}
	function display(){
$this->vue=service('Smarty');
		/*
		 * Display the detail of the record
		 */
		$this->vue->set($this->dataclass->lire($this->id) , "data");
		/*
		 * Recuperation des dernieres analyses d'eau
		 */
		/*
		 * Traitement des valeurs next et previous, si fournies
		 */
		$_SESSION["searchCircuitEau"]->setParam($_REQUEST);
		$dataSearch = $_SESSION["searchCircuitEau"]->getParam ();
		if ($_REQUEST["next"] > 0 ) {
			$dataSearch["offset"] = $dataSearch["offset"] + $dataSearch["limit"];
			$_SESSION["searchCircuitEau"]->setParam("offset",$dataSearch["offset"]);
		}
		if ($_REQUEST["previous"] > 0) {
			$dataSearch["offset"] = $dataSearch["offset"] - $dataSearch["limit"];
			if ($dataSearch["offset"] < 0) $dataSearch["offset"] = 0;
			$_SESSION["searchCircuitEau"]->setParam("offset",$dataSearch["offset"]);
		}
		$this->vue->set($dataSearch , "dataSearch");
		require_once "modules/classes/analyseEau.class.php";
		$analyseEau = new AnalyseEau;
		$this->vue->set( $analyseEau->getDetailByCircuitEau($this->id, $dataSearch["analyse_date"], $dataSearch["limit"], $dataSearch["offset"]), "dataAnalyse");
		/*
		 * Recuperation des bassins associes
		 */
		require_once "modules/classes/bassin.class.php";
		$bassin = new Bassin;
		$this->vue->set($bassin->getListeByCircuitEau($this->id) , "dataBassin");
		/*
		 * Recuperation des evenements
		 */
		require_once "modules/classes/circuitEvenement.class.php";
		$circuitEvenement = new CircuitEvenement;
		$this->vue->set($circuitEvenement->getListeBycircuit($this->id) , "dataCircuitEvnt");
		/*
		 * Affichage
		*/
		$this->vue->set("bassin/circuitEauDisplay.tpl" , "corps");
		}
	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$this->dataRead(, $this->id, "bassin/circuitEauChange.tpl");
		require_once 'modules/classes/site.class.php';
		$site = new Site;
		$this->vue->set( $site->getListe(2), "site");
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
