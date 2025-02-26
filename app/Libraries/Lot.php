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
 *  Creation 13 mars 2015
 */
require_once 'modules/classes/lot.class.php';
$this->dataclass = new Lot;
$keyName = "lot_id";
$this->id = $_REQUEST[$keyName];

require "modules/repro/setAnnee.php";
	function list(){
$this->vue=service('Smarty');
		/*
		 * Display the list of all records of the table
		 */
		if (!isset($_SESSION["alimJuv"])) {
			$_SESSION["alimJuv"] = new AlimJuv();
		}
		$this->vue->set($this->dataclass->getLotByAnnee($_SESSION["annee"]), "lots");
		$this->vue->set("repro/lotSearch.tpl", "corps");
		$this->vue->set($_SESSION["alimJuv"]->getParam(), "dataAlim");
		/**
		 * Site
		 */
		require_once 'modules/classes/site.class.php';
		$site = new Site;
		$this->vue->set($site->getListe(2), "site");
		}
	function display(){
$this->vue=service('Smarty');
		/*
		 * Display the detail of the record
		 */
		$data = $this->dataclass->getDetail($this->id);
		$this->vue->set($data, "dataLot");
		$this->vue->set("repro/lotDisplay.tpl", "corps");
		/*
		 * Recuperation de la liste des mesures
		 */
		require_once "modules/classes/lotMesure.class.php";
		$lotMesure = new LotMesure;
		$this->vue->set($lotMesure->getListFromLot($this->id), "dataMesure");
		/*
		 * Recuperation de la liste des bassins
		 */
		require_once 'modules/classes/bassinLot.class.php';
		$bassinLot = new BassinLot;
		$this->vue->set($bassinLot->getListeFromLot($this->id), "bassinLot");
		/*
		 * Lecture des devenirs d'un lot
		 */
		require_once 'modules/classes/devenir.class.php';
		$devenir = new Devenir;
		$this->vue->set($devenir->getListFromLot($this->id), "dataDevenir");
		$this->vue->set("lot", "devenirOrigine");
		/**
		 * Lecture des lots dérivés
		 */
		$this->vue->set($this->dataclass->getDerivatedLots($this->id), "lots");
		}
	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		/*
		 * Lecture de la liste des croisements
		 */
		require_once 'modules/classes/croisement.class.php';
		$croisement = new Croisement;
		$croisements = $croisement->getListFromAnnee($_SESSION["annee"]);
		if (empty($croisements)) {
			$module_coderetour = -1;
			$this->message->set(
				sprintf(
					_("Aucun croisement n'a été enregistré pour l'année %s, la création d'un lot n'est pas possible"),
					$_SESSION["annee"]
				),
				true
			);
		} else {
			$this->dataRead( $this->id, "repro/lotChange.tpl");
			if (isset($_REQUEST["sequence_id"])) {
				require_once "modules/classes/sequence.class.php";
				$sequence = new Sequence;
				$this->vue->set($sequence->lire($_REQUEST["sequence_id"]), "sequence");
			}
			$this->vue->set($croisements, "croisements");
			/*
			 * Lecture de la liste des marquages VIE
			 */
			require_once "modules/classes/vieModele.class.php";
			$vieModele = new VieModele;
			$this->vue->set($vieModele->getModelesFromAnnee($_SESSION["annee"]), "modeles");
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
			if ($_REQUEST["nb_larve_initial"] > 0) {
				/*
				 * Mise a jour du statut des poissons
				 */
				require_once 'modules/classes/poissonSequence.class.php';
				$poissonSequence = new PoissonSequence;
				require_once "modules/classes/croisement.class.php";
				$croisement = new Croisement;
				$dataCroisement = $croisement->lire($_REQUEST["croisement_id"]);
				$poissons = $croisement->getPoissonsFromCroisement($_REQUEST["croisement_id"]);
				foreach ($poissons as $key => $value) {
					$poissonSequence->updateStatutFromPoissonCampagne($value["poisson_campagne_id"], $dataCroisement["sequence_id"], 6);
				}
			}
		}
		}
	   function delete() {
		/*
		 * delete record
		 */
		$bdd->beginTransaction();
		try {
			$this->dataDelete( $this->id, true);
			$module_coderetour = 1;
			$this->message->set(_("Suppression effectuée"));
			$bdd->commit();
		} catch (Exception $e) {
			$bdd->rollback();
			$module_coderetour = -1;
			$this->message->set($e->getMessage(), true);
		}

		}
}