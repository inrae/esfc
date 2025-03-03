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
 *  Creation 11 mars 2015
 */
require_once 'modules/classes/profilThermique.class.php';
$this->dataclass = new ProfilThermique($bdd,$ObjetBDDParam);
$keyName = "profil_thermique_id";
$this->id = $_REQUEST[$keyName];

	function display(){
$this->vue=service('Smarty');
		/**
		 * Display the detail of the record
		 */
		$this->vue->set( $this->dataclass->lire($this->id), "data");
		$this->vue->set("repro/profilThermiqueChange.tpl" , "corps");
		}
	   function new() {
		$this->id = 0;
	function change(){
$this->vue=service('Smarty');
		$data = $this->dataRead( $this->id, "repro/profilThermiqueChange.tpl", $_REQUEST["bassin_campagne_id"]);
		/**
		 * Recuperation des donnees du bassin
		 */
		require_once 'modules/classes/bassinCampagne.class.php';
		$bassinCampagne = new BassinCampagne;
		$dataBassinCampagne = $bassinCampagne->lire($data["bassin_campagne_id"]);
		require_once "modules/classes/bassin.class.php";
		$bassin = new Bassin;
		$this->vue->set( $dataBassinCampagne, "dataBassinCampagne");
		$this->vue->set( $bassin->lire($dataBassinCampagne["bassin_id"]), "dataBassin");
		/**
		 * Recuperation des donnees de temperature deja existantes
		 */
		$profilThermiques = $this->dataclass->getListFromBassinCampagne($data["bassin_campagne_id"]);
		$this->vue->set( $profilThermiques, "profilThermiques");
		/**
		 * Assignation des valeurs par defaut en prenant en reference la derniere valeur entree
		 */
		$nbProfil = count($profilThermiques);
		if ($nbProfil > 0 && $this->id == 0) {
			$data["pf_datetime"] =  $profilThermiques[$nbProfil - 1]["pf_datetime"];
			$this->vue->set($data , "data");			
		}
		$this->vue->set($_SESSION["bassinParentModule"] , "bassinParentModule");
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
