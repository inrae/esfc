<?php

namespace App\Libraries;

use App\Models\AnalyseEau;
use App\Models\Bassin;
use App\Models\CircuitEau as ModelsCircuitEau;
use App\Models\CircuitEvenement;
use App\Models\SearchCircuitEau;
use App\Models\Site;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class CircuitEau extends PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	public $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsCircuitEau;
		$this->keyName = "circuit_eau_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		}
		if (!isset($_SESSION["searchCircuitEau"])) {
			$_SESSION["searchCircuitEau"] = new SearchCircuitEau;
		}
	}

	function list()
	{
		$this->vue = service('Smarty');
		/**
		 * Display the list of all records of the table
		 */
		$_SESSION["searchCircuitEau"]->setParam($_REQUEST);
		$dataSearch = $_SESSION["searchCircuitEau"]->getParam();
		if ($_SESSION["searchCircuitEau"]->isSearch() == 1) {
			$this->vue->set(1, "isSearch");
		}
		$this->vue->set($dataSearch, "circuitEauSearch");
		if ($_SESSION["searchCircuitEau"]->isSearch() == 1) {
			$this->vue->set($this->dataclass->getListeSearch($dataSearch), "data");
			/**
			 * Recuperation des donnees d'analyse
			 */
			if ($_REQUEST["circuit_eau_id"] > 0) {
				$analyseEau = new AnalyseEau;
				$this->vue->set($analyseEau->getDetailByCircuitEau($_REQUEST["circuit_eau_id"], $dataSearch["analyse_eau_date"]), "dataAnalyse");
			}
		}
		$this->vue->set("bassin/circuitEauList.tpl", "corps");
		$site = new Site;
		$this->vue->set($site->getListe(2), "site");
		$_SESSION["bassinParentModule"] = "circuitEauList";
		return $this->vue->send();
	}
	function display()
	{
		$this->vue = service('Smarty');
		/**
		 * Display the detail of the record
		 */
		$this->vue->set($this->dataclass->lire($this->id), "data");
		/**
		 * Recuperation des dernieres analyses d'eau
		 */
		/**
		 * Traitement des valeurs next et previous, si fournies
		 */
		$_SESSION["searchCircuitEau"]->setParam($_REQUEST);
		$dataSearch = $_SESSION["searchCircuitEau"]->getParam();
		if ($_REQUEST["next"] > 0) {
			$dataSearch["offset"] = $dataSearch["offset"] + $dataSearch["limit"];
			$_SESSION["searchCircuitEau"]->setParam("offset", $dataSearch["offset"]);
		}
		if ($_REQUEST["previous"] > 0) {
			$dataSearch["offset"] = $dataSearch["offset"] - $dataSearch["limit"];
			if ($dataSearch["offset"] < 0) $dataSearch["offset"] = 0;
			$_SESSION["searchCircuitEau"]->setParam("offset", $dataSearch["offset"]);
		}
		$this->vue->set($dataSearch, "dataSearch");
		$analyseEau = new AnalyseEau;
		$this->vue->set($analyseEau->getDetailByCircuitEau($this->id, $dataSearch["analyse_date"], $dataSearch["limit"], $dataSearch["offset"]), "dataAnalyse");
		/**
		 * Recuperation des bassins associes
		 */
		$bassin = new Bassin;
		$this->vue->set($bassin->getListeByCircuitEau($this->id), "dataBassin");
		/**
		 * Recuperation des evenements
		 */
		$circuitEvenement = new CircuitEvenement;
		$this->vue->set($circuitEvenement->getListeBycircuit($this->id), "dataCircuitEvnt");
		/**
		 * Affichage
		*/
		$this->vue->set("bassin/circuitEauDisplay.tpl", "corps");
		return $this->vue->send();
	}
	function change()
	{
		$this->vue = service('Smarty');
		$this->dataRead($this->id, "bassin/circuitEauChange.tpl");
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
