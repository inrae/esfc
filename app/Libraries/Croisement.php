<?php

namespace App\Libraries;

use App\Models\Croisement as ModelsCroisement;
use App\Models\CroisementQualite;
use App\Models\PoissonCampagne;
use App\Models\PoissonSequence;
use App\Models\Sequence;
use App\Models\SpermeUtilise;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Croisement extends PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	public $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsCroisement;
		$this->keyName = "croisement_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		}
	}
	function list()
	{
		$this->vue = service('Smarty');
		isset($_COOKIE["annee"]) ? $year = $_COOKIE["annee"] : $year = 0;
		$this->vue->set($this->dataclass->getListCroisements($year), "croisements");
		$this->vue->set("repro/croisementListAll.tpl", "corps");
		$this->vue->set($year, "annee");
		$pc = new PoissonCampagne;
		$this->vue->set($pc->getAnnees(), "annees");
		return $this->vue->send();
	}
	function display()
	{
		$this->vue = service('Smarty');
		/**
		 * Display the detail of the record
		 */
		$data = $this->dataclass->getDetail($this->id);
		$this->vue->set($data, "data");
		/**
		 * Lecture de la sequence
		 */
		$sequence = new Sequence;
		$this->vue->set($sequence->lire($data["sequence_id"]), "dataSequence");
		/**
		 * Recherche des spermes utilises
		 */

		$spermeUtilise = new SpermeUtilise;
		$this->vue->set($spermeUtilise->getListFromCroisement($this->id), "spermesUtilises");

		$this->vue->set("repro/croisementDisplay.tpl", "corps");
		return $this->vue->send();
	}
	function change()
	{
		$this->vue = service('Smarty');

		$data = $this->dataRead($this->id, "repro/croisementChange.tpl", $_REQUEST["sequence_id"]);
		/**
		 * Lecture de la table des qualites de croisement
		 */
		$croisementQualite = new CroisementQualite;
		$this->vue->set($croisementQualite->getListe(1), "croisementQualite");
		/**
		 * Lecture des poissons rattaches
		 */
		if ($this->id > 0) {
			$this->vue->set($this->dataclass->getListAllPoisson($this->id, $data["sequence_id"]), "poissonSequence");
		} else {
			$poissonSequence = new PoissonSequence;
			$this->vue->set($poissonSequence->getListFromSequence($data["sequence_id"]), "poissonSequence");
		}
		/**
		 * Lecture de la sequence
		 */
		$sequence = new Sequence;
		$this->vue->set($sequence->lire($data["sequence_id"]), "dataSequence");
		return $this->vue->send();
	}
	function write()
	{
		try {
			$this->id = $this->dataWrite($_REQUEST);
			$_REQUEST[$this->keyName] = $this->id;
			return true;
		} catch (PpciException $e) {
			return false;
		}

		/**
		 * write record in database
		 */
		$this->id = $this->dataWrite($_REQUEST);
		if ($this->id > 0) {
			$_REQUEST[$keyName] = $this->id;
			/**
			 * Mise a jour du statut dans poisson_sequence
			 */
			$poissonSequence = new PoissonSequence;
			foreach ($_REQUEST["poisson_campagne_id"] as $key => $value) {
				$poissonSequence->updateStatutFromPoissonCampagne($value, $_REQUEST["sequence_id"], 5);
			}
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
