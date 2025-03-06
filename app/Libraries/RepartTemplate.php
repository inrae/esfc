<?php

namespace App\Libraries;

use App\Models\Categorie;
use App\Models\RepartAliment;
use App\Models\RepartTemplate as ModelsRepartTemplate;
use App\Models\SearchRepartTemplate;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class RepartTemplate extends PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	public $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsRepartTemplate;
		$this->keyName = "repart_template_id";
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
		/**
		 * Gestion des variables de recherche
		 */
		if (!isset($_SESSION["searchRepartTemplate"])) {
			$_SESSION["searchRepartTemplate"] = new SearchRepartTemplate;
		}
		$_SESSION["searchRepartTemplate"]->setParam($_REQUEST);
		$dataSearch = $_SESSION["searchRepartTemplate"]->getParam();
		if ($_SESSION["searchRepartTemplate"]->isSearch() == 1) {
			$this->vue->set(1, "isSearch");
			$data = $this->dataclass->getListSearch($dataSearch);
		} else {
			$data = array();
		}
		$this->vue->set($dataSearch, "repartTemplateSearch");
		$this->vue->set($data, "data");
		$this->vue->set("aliment/repartTemplateList.tpl", "corps");
		/**
		 * Recherche de la categorie
		 */
		$categorie = new Categorie;
		$this->vue->set($categorie->getListe(2), "categorie");
		return $this->vue->send();
	}
	function change()
	{
		$this->vue = service('Smarty');
		$data = $this->dataRead($this->id, "aliment/repartTemplateChange.tpl");
		/**
		 * Lecture des categories
		 */
		$categorie = new Categorie;
		$this->vue->set($categorie->getListe(2), "categorie");
		/**
		 * Recuperation des aliments associés
		 */
		if ($data["categorie_id"] > 0 && $this->id > 0) {
			$repartAliment = new RepartAliment;
			$this->vue->set($repartAliment->getFromTemplateWithAliment($this->id, $data["categorie_id"]), "dataAliment");
		}
		return $this->vue->send();
	}
	function write()
	{
		try {
			$this->id = $this->dataWrite($_REQUEST);
			$_REQUEST[$this->keyName] = $this->id;
			/**
			 * Preparation des aliments
			 */
			$data = array();
			foreach ($_REQUEST as $key => $value) {
				if (preg_match('/[0-9]+$/', $key, $val)) {
					$pos = strrpos($key, "_");
					$nom = substr($key, 0, $pos);
					$data[$val[0]][$nom] = $value;
				}
			}
			/**
			 * Mise en table
			 */
			$repartAliment = new RepartAliment;
			foreach ($data as  $value) {
				if ($value["repart_aliment_id"] > 0 || $value["repart_alim_taux"] > 0) {
					$value["repart_template_id"] = $this->id;
					$repartAliment->ecrire($value);
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
		try {
			$this->dataDelete($this->id);
			return true;
		} catch (PpciException $e) {
			return false;
		}
	}
}
