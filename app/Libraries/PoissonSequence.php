<?php

namespace App\Libraries;

use App\Models\PoissonCampagne;
use App\Models\PoissonSequence as ModelsPoissonSequence;
use App\Models\PsEvenement;
use App\Models\PsStatut;
use App\Models\Sequence;
use App\Models\Sperme;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class PoissonSequence extends PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	public $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsPoissonSequence;
		$this->keyName = "poisson_sequence_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		}
	}

	function change()
	{
		$this->vue = service('Smarty');
		$data = $this->dataRead($this->id, "repro/poissonSequenceChange.tpl", $_REQUEST["poisson_campagne_id"]);
		$poissonCampagne = new PoissonCampagne;
		$this->vue->set($poissonCampagne->lire($data["poisson_campagne_id"]), "dataPoisson");
		$psEvenement = new PsEvenement;
		$this->vue->set($psEvenement->getListeFromPoissonSequence($this->id), "evenements");
		/**
		 * Recherche les donnees concernant la production de sperme
		 */
		$sperme = new Sperme;
		$dataSperme = $sperme->readFromSequence($data["poisson_campagne_id"], $data["sequence_id"]);
		foreach ($dataSperme as $key => $value)
			$data[$key] = $value;
		$this->vue->set($data, "data");
		helper("esfc");
		initSpermeChange($this->vue,$dataSperme["sperme_id"]);
		/**
		 * Recuperation de la liste des sequences
		 */
		$sequence = new Sequence;
		$this->vue->set($sequence->getListeByYear($_SESSION['annee'], 0, $data["sequence_id"]), "sequences");
		/**
		 * Recuperation des statuts
		 */
		$psStatut = new PsStatut;
		$this->vue->set($psStatut->getListe(1), "statuts");
		/**
		 * Passage en parametre de la liste parente
		 */
		$this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
		if (isset($_REQUEST["sequence_id"])) {
			$this->vue->set($_REQUEST["sequence_id"], "sequence_id");
		}
		return $this->vue->send();
	}
	function write()
	{
		try {
			$this->id = $this->dataWrite($_REQUEST);
			$_REQUEST[$this->keyName] = $this->id;
			if (strlen($_REQUEST["sperme_date"]) > 0 || $_REQUEST["sperme_id"] > 0) {
				$sperme = new Sperme;
				$sperme->write($_REQUEST);
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
		try {
			$this->dataDelete($this->id);
			return true;
		} catch (PpciException $e) {
			return false;
		}
	}
}
