<?php

namespace App\Libraries;

use App\Models\PoissonCampagne;
use App\Models\VieImplantation;
use App\Models\VieModele as ModelsVieModele;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class VieModele extends PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	public $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsVieModele;
		$this->keyName = "vie_modele_id";
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
		$this->vue->set($this->dataclass->getModelesFromAnnee($_SESSION["annee"]), "data");
		$this->vue->set("repro/vieModeleList.tpl", "corps");
		/**
		 * Lecture des annees
		 */
		$poissonCampagne = new PoissonCampagne;
		$this->vue->set($poissonCampagne->getAnnees(), "annees");
		setAnnee($this->vue);
		return $this->vue->send();
	}
	function change()
	{
		$this->vue = service('Smarty');
		$data = $this->dataRead($this->id, "repro/vieModeleChange.tpl");
		if ($this->id == 0) {
			$data["annee"] = $_SESSION["annee"];
			$this->vue->set($data, "data");
		}
		/**
		 * Recuperation des emplacements d'implantation des marques vie
		 */
		$vieImplantation = new VieImplantation;
		$this->vue->set($vieImplantation->getListe(2), "implantations");
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
