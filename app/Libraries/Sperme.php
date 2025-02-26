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
 *  Creation 25 mars 2015
 */

require_once 'modules/classes/sperme.class.php';
$this->dataclass = new Sperme;
$keyName = "sperme_id";
$this->id = $_REQUEST[$keyName];
/*
 * Passage en parametre de la liste parente
 */
if (isset($this->vue)) {
	$this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
}

	function display(){
$this->vue=service('Smarty');
		/*
		 * Display the detail of the record
		 */
		$this->vue->set($this->dataclass->lire($this->id), "data");
		/*
		 * Recherche des caracteristiques particulieres
		 */
		require_once "modules/classes/spermeCaracteristique.class.php";
		$caract = new SpermeCaracteristique;
		$this->vue->set($caract->getFromSperme($this->id), "spermeCaract");
		/*
		 * Recherche des mesures effectuees
		 */
		require_once "modules/classes/spermeMesure.class.php";
		$mesure = new SpermeMesure;
		$this->vue->set($mesure->getListFromSperme($this->id), "dataMesure");
		$this->vue->set("repro/spermeDisplay.tpl", "corps");
		}
	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		require_once 'modules/classes/poissonCampagne.class.php';
		$poissonCampagne = new PoissonCampagne;
		$this->vue->set($poissonCampagne->lire($_REQUEST["poisson_campagne_id"]), "dataPoisson");
		$sequences = $poissonCampagne->getListSequence($_REQUEST["poisson_campagne_id"], $_SESSION["annee"]);
		if (empty($sequences)) {
			$module_coderetour = -1;
			$this->message->set(_("Le poisson n'est rattaché à aucune séquence, la saisie d'un prélèvement de sperme n'est pas possible"), true);
		} else {
			$this->vue->set($sequences, "sequences");
			$data = $this->dataRead( $this->id, "repro/spermeChange.tpl", $_REQUEST["poisson_campagne_id"]);
			require_once 'modules/repro/spermeFunction.php';
			initSpermeChange($this->id);
			/*
			 * Donnees du poisson
			 */
			if (!isset($_REQUEST["poisson_campagne_id"])) {
				$_REQUEST["poisson_campagne_id"] = $data["poisson_campagne_id"];
			}
		}
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
			 * Mise a jour du statut du poisson_sequence
			 */
			require_once 'modules/classes/poissonSequence.class.php';
			$poissonSequence = new PoissonSequence;
			$poissonSequence->updateStatutFromPoissonCampagne($_REQUEST["poisson_campagne_id"], $_REQUEST["sequence_id"], 4);
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