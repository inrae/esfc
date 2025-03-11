<?php

namespace App\Libraries;

use App\Models\BassinCampagne;
use App\Models\Croisement;
use App\Models\Lot;
use App\Models\PoissonSequence;
use App\Models\Sequence as ModelsSequence;
use App\Models\Site;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Sequence extends PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	public $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsSequence;
		$this->keyName = "sequence_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		}
		helper("esfc");
		setAnnee();
	}
	function list()
	{
		$this->vue = service('Smarty');
		$this->vue->set($this->dataclass->getListeByYear($_SESSION["annee"], $_REQUEST["site_id"]), "data");
		$this->vue->set("repro/sequenceList.tpl", "corps");
		/**
		 * Recuperation des donnees concernant les bassins
		 */
		$bassinCampagne = new BassinCampagne;
		$this->vue->set($bassinCampagne->getListFromAnnee($_SESSION['annee'], $_REQUEST["site_id"]), "bassins");
		$_SESSION["bassinParentModule"] = "sequenceList";
		$site = new Site;
		$this->vue->set($site->getListe(2), "site");
		$this->vue->set($_SESSION["annees"],"annees");
		return $this->vue->send();
	}
	function display()
	{
		$this->vue = service('Smarty');
		/**
		 * Display the detail of the record
		 */
		$this->vue->set($this->dataclass->lire($this->id), "dataSequence");
		$this->vue->set("repro/sequenceDisplay.tpl", "corps");
		$poissonSequence = new PoissonSequence;
		$this->vue->set($poissonSequence->getListFromSequence($this->id), "dataPoissons");
		$_SESSION["poissonDetailParent"] = "sequenceDisplay";
		$_SESSION["sequence_id"] = $this->id;
		/**
		 * Préparation des croisements
		 */
		$croisement = new Croisement;
		$croisements = $croisement->getListFromSequence($this->id);
		/**
		 * Recuperation du nombre de larves comptees
		 */
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
		return $this->vue->send();
	}
	function change()
	{
		$this->vue = service('Smarty');
		$data = $this->dataRead($this->id, "repro/sequenceChange.tpl");
		if ($this->id == 0) {
			/**
			 * Positionnement correct de la session par rapport à l'année courante
			 */
			$data["annee"] = $_SESSION["annee"];
			$this->vue->set($data, "data");
		}
		$site = new Site;
		$this->vue->set($site->getListe(2), "site");
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
