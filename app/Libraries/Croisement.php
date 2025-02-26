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
    private $keyName;

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
 *  Creation 12 mars 2015
 */

require_once 'modules/classes/croisement.class.php';
$this->dataclass = new Croisement;
$keyName = "croisement_id";
$this->id = $_REQUEST[$keyName];

	function list(){
$this->vue=service('Smarty');
		isset($_COOKIE["annee"]) ? $year = $_COOKIE["annee"]: $year = 0;
		$this->vue->set($this->dataclass->getListCroisements($year),"croisements");
		$this->vue->set("repro/croisementListAll.tpl", "corps");
		$this->vue->set($year, "annee");
		require_once "modules/classes/poissonCampagne.class.php";
		$pc = new PoissonCampagne;
		$this->vue->set($pc->getAnnees(), "annees");
		}
	function display(){
$this->vue=service('Smarty');
		/*
		 * Display the detail of the record
		 */
		$data = $this->dataclass->getDetail($this->id);
		$this->vue->set($data, "data");
		/*
		 * Lecture de la sequence
		 */
		require_once "modules/classes/sequence.class.php";
		$sequence = new Sequence;
		$this->vue->set($sequence->lire($data["sequence_id"]), "dataSequence");

		/*
		 * Recherche des spermes utilises
		 */
		require_once 'modules/classes/spermeUtilise.class.php';
		$spermeUtilise = new SpermeUtilise;
		$this->vue->set($spermeUtilise->getListFromCroisement($this->id), "spermesUtilises");

		$this->vue->set("repro/croisementDisplay.tpl", "corps");
		}
	function change(){
$this->vue=service('Smarty');

		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = $this->dataRead( $this->id, "repro/croisementChange.tpl", $_REQUEST["sequence_id"]);
		/*
		 * Lecture de la table des qualites de croisement
		 */
		require_once "modules/classes/croisementQualite.class.php";
		$croisementQualite = new CroisementQualite;
		$this->vue->set($croisementQualite->getListe(1), "croisementQualite");
		/*
		 * Lecture des poissons rattaches
		 */
		require_once 'modules/classes/poissonSequence.class.php';
		if ($this->id > 0) {
			$this->vue->set($this->dataclass->getListAllPoisson($this->id, $data["sequence_id"]), "poissonSequence");
		} else {
			$poissonSequence = new PoissonSequence;
			$this->vue->set($poissonSequence->getListFromSequence($data["sequence_id"]), "poissonSequence");
		}
		/*
		 * Lecture de la sequence
		 */
		require_once "modules/classes/sequence.class.php";
		$sequence = new Sequence;
		$this->vue->set($sequence->lire($data["sequence_id"]), "dataSequence");
		}
	    function write() {
    try {
                        $this->id = $this->dataWrite($_REQUEST);
            $_REQUEST[$this->keyName] = $this->id;
            return true;
        } catch (PpciException $e) {
            return false;
        }
            
		/*
		 * write record in database
		 */
		$this->id = dataWrite($this->dataclass, $_REQUEST);
		if ($this->id > 0) {
			$_REQUEST[$keyName] = $this->id;
			/*
			 * Mise a jour du statut dans poisson_sequence
			 */
			require_once "modules/classes/poissonSequence.class.php";
			$poissonSequence = new PoissonSequence;
			foreach ($_REQUEST["poisson_campagne_id"] as $key => $value) {
				$poissonSequence->updateStatutFromPoissonCampagne($value, $_REQUEST["sequence_id"], 5);
			}
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
