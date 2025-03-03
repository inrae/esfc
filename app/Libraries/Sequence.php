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
 *  Creation 5 mars 2015
 */
require_once 'modules/classes/sequence.class.php';
$this->dataclass = new Sequence;
$keyName = "sequence_id";
$this->id = $_REQUEST[$keyName];

/**
 * Prepositionnement de l'annee
*/
require "modules/repro/setAnnee.php";
	function list(){
$this->vue=service('Smarty');
		$this->vue->set($this->dataclass->getListeByYear($_SESSION["annee"], $_REQUEST["site_id"]), "data");
		$this->vue->set("repro/sequenceList.tpl", "corps");
		/**
		 * Recuperation des donnees concernant les bassins
		 */
		require_once 'modules/classes/bassinCampagne.class.php';
		$bassinCampagne = new BassinCampagne;
		$this->vue->set($bassinCampagne->getListFromAnnee($_SESSION['annee'], $_REQUEST["site_id"]), "bassins");
		$_SESSION["bassinParentModule"] = "sequenceList";
		require_once 'modules/classes/site.class.php';
		$site = new Site;
		$this->vue->set($site->getListe(2), "site");

		}
	function display(){
$this->vue=service('Smarty');
		/**
		 * Display the detail of the record
		 */
		$this->vue->set($this->dataclass->lire($this->id), "dataSequence");
		$this->vue->set("repro/sequenceDisplay.tpl", "corps");
		require_once "modules/classes/poissonSequence.class.php";
		$poissonSequence = new PoissonSequence;
		$this->vue->set($poissonSequence->getListFromSequence($this->id), "dataPoissons");
		$_SESSION["poissonDetailParent"] = "sequenceDisplay";
		$_SESSION["sequence_id"] = $this->id;
		/**
		 * Préparation des croisements
		 */
		require_once 'modules/classes/croisement.class.php';
		$croisement = new Croisement;
		$croisements = $croisement->getListFromSequence($this->id);
		/**
		 * Recuperation du nombre de larves comptees
		 */
		require_once 'modules/classes/lot.class.php';
		$lot = new Lot;
		foreach ($croisements as $key => $value) {
			$totalLot = $lot->getNbLarveFromCroisement($value["croisement_id"]);
			$croisements[$key]["total_larve_compte"] = $totalLot["total_larve_compte"];
		}
		$this->vue->set($croisements, "croisements");
		/**
		 * Preparation des lots
		 */
		$this->vue->set($lot->getLotBySequence($this->id), "lots");
		}
	function change(){
$this->vue=service('Smarty');
		$data = $this->dataRead( $this->id, "repro/sequenceChange.tpl");
		if ($this->id == 0) {
			/**
			 * Positionnement correct de la session par rapport à l'année courante
			 */
			$data["annee"] = $_SESSION["annee"];
			$this->vue->set($data, "data");
		}
		require_once 'modules/classes/site.class.php';
		$site = new Site;
		$this->vue->set($site->getListe(2), "site");
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
