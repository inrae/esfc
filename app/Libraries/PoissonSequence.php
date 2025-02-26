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
 *  Creation 9 mars 2015
 */
require_once 'modules/classes/poissonSequence.class.php';
$this->dataclass = new PoissonSequence;
$keyName = "poisson_sequence_id";
$this->id = $_REQUEST[$keyName];

	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = $this->dataRead( $this->id, "repro/poissonSequenceChange.tpl", $_REQUEST["poisson_campagne_id"]);
		require_once "modules/classes/poissonCampagne.class.php";
		$poissonCampagne = new PoissonCampagne;
		$this->vue->set($poissonCampagne->lire($data["poisson_campagne_id"]), "dataPoisson");
		require_once "modules/classes/psEvenement.class.php";
		$psEvenement = new PsEvenement;
		$this->vue->set($psEvenement->getListeFromPoissonSequence($this->id), "evenements");
		/*
		 * Recherche les donnees concernant la production de sperme
		 */
		require_once 'modules/classes/sperme.class.php';
		$sperme = new Sperme;
		$dataSperme = $sperme->lireFromSequence($data["poisson_campagne_id"], $data["sequence_id"]);
		foreach ($dataSperme as $key => $value)
			$data[$key] = $value;
		$this->vue->set($data, "data");
		require_once 'modules/repro/spermeFunction.php';
		initSpermeChange($dataSperme["sperme_id"]);

		/*
		 * Recuperation de la liste des sequences
		 */
		require_once "modules/classes/sequence.class.php";
		$sequence = new Sequence;
		$this->vue->set($sequence->getListeByYear($_SESSION['annee']), "sequences");
		/*
		 * Recuperation des statuts
		 */
		require_once "modules/classes/psStatut.class.php";
		$psStatut = new PsStatut;
		$this->vue->set($psStatut->getListe(1), "statuts");
		/*
		 * Passage en parametre de la liste parente
		 */
		$this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
		if (isset($_REQUEST["sequence_id"])) {
			$this->vue->set($_REQUEST["sequence_id"], "sequence_id");
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
		require_once 'modules/classes/sperme.class.php';
		$this->id = dataWrite($this->dataclass, $_REQUEST);
		if ($this->id > 0) {
			$_REQUEST[$keyName] = $this->id;
			if (strlen($_REQUEST["sperme_date"]) > 0 || $_REQUEST["sperme_id"] > 0) {
				require_once "modules/classes/sperme.class.php";
				$sperme = new Sperme;
				dataWrite($sperme, $_REQUEST);
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
