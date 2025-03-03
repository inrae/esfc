<?php

namespace App\Libraries;

use App\Models\AlimJuv;
use App\Models\BassinLot;
use App\Models\Croisement;
use App\Models\Devenir;
use App\Models\Lot as ModelsLot;
use App\Models\LotMesure;
use App\Models\PoissonSequence;
use App\Models\Sequence;
use App\Models\Site;
use App\Models\VieModele;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Lot extends PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	public $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsLot;
		$this->keyName = "lot_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		}
		helper("esfc");
	}
	function list()
	{
		$this->vue = service('Smarty');
		/**
		 * Display the list of all records of the table
		 */
		if (!isset($_SESSION["alimJuv"])) {
			$_SESSION["alimJuv"] = new AlimJuv;
		}
		$this->vue->set($this->dataclass->getLotByAnnee($_SESSION["annee"]), "lots");
		$this->vue->set("repro/lotSearch.tpl", "corps");
		$this->vue->set($_SESSION["alimJuv"]->getParam(), "dataAlim");
		/**
		 * Site
		 */
		$site = new Site;
		$this->vue->set($site->getListe(2), "site");
		setAnneesRepro($this->vue);
		return $this->vue->send();
	}
	function display()
	{
		$this->vue = service('Smarty');
		/**
		 * Display the detail of the record
		 */
		$data = $this->dataclass->getDetail($this->id);
		$this->vue->set($data, "dataLot");
		$this->vue->set("repro/lotDisplay.tpl", "corps");
		/**
		 * Recuperation de la liste des mesures
		 */
		$lotMesure = new LotMesure;
		$this->vue->set($lotMesure->getListFromLot($this->id), "dataMesure");
		/**
		 * Recuperation de la liste des bassins
		 */
		$bassinLot = new BassinLot;
		$this->vue->set($bassinLot->getListeFromLot($this->id), "bassinLot");
		/**
		 * Lecture des devenirs d'un lot
		 */
		$devenir = new Devenir;
		$this->vue->set($devenir->getListFromLot($this->id), "dataDevenir");
		$this->vue->set("lot", "devenirOrigine");
		/**
		 * Lecture des lots dérivés
		 */
		$this->vue->set($this->dataclass->getDerivatedLots($this->id), "lots");
		setAnneesRepro($this->vue);
		return $this->vue->send();
	}
	function change()
	{
		$this->vue = service('Smarty');
		/**
		 * Lecture de la liste des croisements
		 */
		$croisement = new Croisement;
		$croisements = $croisement->getListFromAnnee($_SESSION["annee"]);
		if (empty($croisements)) {
			return false;
			$this->message->set(
				sprintf(
					_("Aucun croisement n'a été enregistré pour l'année %s, la création d'un lot n'est pas possible"),
					$_SESSION["annee"]
				),
				true
			);
		} else {
			$this->dataRead($this->id, "repro/lotChange.tpl");
			if (isset($_REQUEST["sequence_id"])) {
				$sequence = new Sequence;
				$this->vue->set($sequence->lire($_REQUEST["sequence_id"]), "sequence");
			}
			$this->vue->set($croisements, "croisements");
			/**
			 * Lecture de la liste des marquages VIE
			 */
			$vieModele = new VieModele;
			$this->vue->set($vieModele->getModelesFromAnnee($_SESSION["annee"]), "modeles");
			setAnneesRepro($this->vue);
			return $this->vue->send();
		}
	}
	function write()
	{
		try {
			$this->id = $this->dataWrite($_REQUEST);
			$_REQUEST[$this->keyName] = $this->id;
			if ($_REQUEST["nb_larve_initial"] > 0) {
				/**
				 * Mise a jour du statut des poissons
				 */
				$poissonSequence = new PoissonSequence;
				$croisement = new Croisement;
				$dataCroisement = $croisement->lire($_REQUEST["croisement_id"]);
				$poissons = $croisement->getPoissonsFromCroisement($_REQUEST["croisement_id"]);
				foreach ($poissons as $value) {
					$poissonSequence->updateStatutFromPoissonCampagne($value["poisson_campagne_id"], $dataCroisement["sequence_id"], 6);
				}
			}
			return true;
		} catch (PpciException $e) {
			return false;
		}
	}
	function delete()
	{
		/**
		 * delete record
		 */
		$db = $this->dataclass->db;
		$db->transBegin();
		try {
			$this->dataDelete($this->id, true);
			$this->message->set(_("Suppression effectuée"));
			$db->transCommit();
			return true;
		} catch (PpciException $e) {
			$db->transRollback();
			$this->message->set($e->getMessage(), true);
			return false;
		}
	}
}
