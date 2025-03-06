<?php

namespace App\Libraries;

use App\Models\Bassin;
use App\Models\BassinCampagne;
use App\Models\Salinite as ModelsSalinite;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Salinite extends PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	public $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsSalinite;
		$this->keyName = "salinite_id";
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
		$this->vue->set("repro/saliniteChange.tpl", "corps");
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
		$data = $this->dataRead($this->id, "repro/saliniteChange.tpl", $_REQUEST["bassin_campagne_id"]);
		/**
		 * Recuperation des donnees du bassin
		 */
		$bassinCampagne = new BassinCampagne;
		$bassin = new Bassin;
		$dataBassinCampagne = $bassinCampagne->lire($data["bassin_campagne_id"]);
		$this->vue->set($dataBassinCampagne, "dataBassinCampagne");
		$this->vue->set($bassin->lire($dataBassinCampagne["bassin_id"]), "dataBassin");
		/**
		 * Recuperation des donnees de salinite deja existantes
		 */
		$salinites = $this->dataclass->getListFromBassinCampagne($data["bassin_campagne_id"]);
		$this->vue->set($salinites, "salinites");
		/**
		 * Assignation des valeurs par defaut en prenant en reference la derniere valeur entree
		 */
		$nbProfil = count($salinites);
		if ($nbProfil > 0 && $this->id == 0) {
			$data["salinite_datetime"] = $salinites[$nbProfil - 1]["salinite_datetime"];
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
