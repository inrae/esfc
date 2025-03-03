<?php

namespace App\Libraries;

use App\Models\Hormone;
use App\Models\Injection as ModelsInjection;
use App\Models\PoissonCampagne;
use App\Models\PoissonSequence;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Injection extends PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	public $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsInjection;
		$this->keyName = "injection_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		}
	}
	function change()
	{
		$this->vue = service('Smarty');
		$this->dataRead($this->id, "repro/injectionChange.tpl", $_REQUEST["poisson_campagne_id"]);
		/**
		 * Lecture des séquences
		 */
		$poissonCampagne = new PoissonCampagne;
		$this->vue->set($poissonCampagne->lire($_REQUEST["poisson_campagne_id"]), "dataPoisson");
		$this->vue->set($poissonCampagne->getListSequence($_REQUEST["poisson_campagne_id"], $_SESSION["annee"]), "sequences");
		/**
		 * Lecture des hormones
		 */
		$hormone = new Hormone;
		$this->vue->set($hormone->getListe(2), "hormones");
		return $this->vue->send();
	}
	function write()
	{
		try {
			$this->id = $this->dataWrite($_REQUEST);
			$_REQUEST[$this->keyName] = $this->id;
			$poissonSequence = new PoissonSequence;
			$poissonSequence->updateStatutFromPoissonCampagne($_REQUEST["poisson_campagne_id"], $_REQUEST["sequence_id"], 3);
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
