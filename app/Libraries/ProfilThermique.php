<?php

namespace App\Libraries;

use App\Models\Bassin;
use App\Models\BassinCampagne;
use App\Models\ProfilThermique as ModelsProfilThermique;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class ProfilThermique extends PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	public $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsProfilThermique;
		$this->keyName = "profil_thermique_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		}
	}
	function display()
	{
		$this->vue = service('Smarty');
		/**
		 * Display the detail of the record
		 */
		$this->vue->set($this->dataclass->lire($this->id), "data");
		$this->vue->set("repro/profilThermiqueChange.tpl", "corps");
		return $this->vue->send();
	}
	function new()
	{
		$this->id = 0;
		return $this->change();
	}
	function change()
	{
		$this->vue = service('Smarty');
		$data = $this->dataRead($this->id, "repro/profilThermiqueChange.tpl", $_REQUEST["bassin_campagne_id"]);
		/**
		 * Recuperation des donnees du bassin
		 */
		$bassinCampagne = new BassinCampagne;
		$dataBassinCampagne = $bassinCampagne->lire($data["bassin_campagne_id"]);
		$bassin = new Bassin;
		$this->vue->set($dataBassinCampagne, "dataBassinCampagne");
		$this->vue->set($bassin->lire($dataBassinCampagne["bassin_id"]), "dataBassin");
		/**
		 * Recuperation des donnees de temperature deja existantes
		 */
		$profilThermiques = $this->dataclass->getListFromBassinCampagne($data["bassin_campagne_id"]);
		$this->vue->set($profilThermiques, "profilThermiques");
		/**
		 * Assignation des valeurs par defaut en prenant en reference la derniere valeur entree
		 */
		$nbProfil = count($profilThermiques);
		if ($nbProfil > 0 && $this->id == 0) {
			$data["pf_datetime"] =  $profilThermiques[$nbProfil - 1]["pf_datetime"];
			$this->vue->set($data, "data");
		}
		$this->vue->set($_SESSION["bassinParentModule"], "bassinParentModule");
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
