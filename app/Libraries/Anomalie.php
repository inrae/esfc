<?php

namespace App\Libraries;

use App\Models\AnomalieDb;
use App\Models\AnomalieDbType;
use App\Models\Poisson;
use App\Models\SearchAnomalie;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Anomalie extends PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	public $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new AnomalieDb;
		$this->keyName = "anomalie_db_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		}
	}
	function list()
	{
		$this->vue = service('Smarty');
		/**
		 * Display the list of all records of the table
		 */
		if (!isset($_SESSION["searchAnomalie"])) {
			$_SESSION["searchAnomalie"] = new SearchAnomalie();
		}
		$_SESSION["searchAnomalie"]->setParam($_REQUEST);
		$dataAnomalie = $_SESSION["searchAnomalie"]->getParam();
		if ($_SESSION["searchAnomalie"]->isSearch() == 1) {
			$this->vue->set($this->dataclass->getListeSearch($dataAnomalie), "dataAnomalie");
			$this->vue->set(1, "isSearch");
		}
		$this->vue->set($dataAnomalie, "anomalieSearch");
		$this->vue->set("anomalie/anomalieList.tpl", "corps");
		/**
		 * Recuperation des types d'anomalie
		 */
		$anomalieType = new AnomalieDbType;
		$this->vue->set($anomalieType->getListe(), "anomalieType");
		return $this->vue->send();
	}
	function display()
	{
		$this->vue = service('Smarty');
		/**
		 * Display the detail of the record
		 */
		$this->vue->set($this->dataclass->lire($this->id), "data");
		$this->vue->set("anomalie/anomalieDisplay.tpl", "corps");
		return $this->vue->send();
	}
	function change()
	{
		$this->vue = service('Smarty');
		$data = $this->dataRead($this->id, "anomalie/anomalieChange.tpl");
		if ($_REQUEST["poisson_id"] > 0) {
			/**
			 * Recuperation des informations generales sur le poisson
			 */
			$poisson = new Poisson;
			$this->vue->set($dataPoisson = $poisson->getDetail($_REQUEST["poisson_id"]), "dataPoisson");
		}
		if ($this->id == 0) {
			if ($_REQUEST["poisson_id"] > 0) {
				$data["poisson_id"] = $dataPoisson["poisson_id"];
				$data["matricule"] = $dataPoisson["matricule"];
				$data["prenom"] = $dataPoisson["prenom"];
				$data["pittag_valeur"] = $dataPoisson["pittag_valeur"];
			}
		}
		/**
		 * Passage en parametre de la liste parente
		*/
		$this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
		$anomalieType = new AnomalieDbType;
		$this->vue->set($anomalieType->getListe(), "anomalieType");
		if ($_REQUEST["module_origine"] == "poissonDisplay") {
			$this->vue->set("poissonDisplay", "module_origine");
		}
		$this->vue->set($data, "data");
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
