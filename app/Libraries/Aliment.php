<?php

namespace App\Libraries;

use App\Models\Aliment as ModelsAliment;
use App\Models\AlimentCategorie;
use App\Models\AlimentType;
use App\Models\Categorie;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Aliment extends PpciLibrary
{
	/**
	 * @var ModelsAliment
	 */
	protected PpciModel $dataclass;
	public $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsAliment;
		$this->keyName = "aliment_id";
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
		$this->vue->set($this->dataclass->getListe(2), "data");
		$this->vue->set("aliment/alimentList.tpl", "corps");
		return $this->vue->send();
	}
	function change()
	{
		$this->vue = service('Smarty');
		$this->dataRead( $this->id, "aliment/alimentChange.tpl");
		/**
		 * Recuperation des types d'aliment
		 */
		$alimentType = new AlimentType;
		$this->vue->set($alimentType->getListe(1), "alimentType");
		/**
		 * Recuperation des categories
		 */
		$categorie = new Categorie;
		$dataCategorie = $categorie->getListe(2);
		/**
		 * Recuperation des categories actuellement associees
		 */
		$alimentCategorie = new AlimentCategorie;
		$dataAC = $alimentCategorie->getListeFromAliment($this->id);
		/**
		 * Assignation de la valeur recuperee aux categories
		 */
		foreach ($dataCategorie as $key => $value) {
			foreach ($dataAC as $key1 => $value1) {
				if ($value1["categorie_id"] == $value["categorie_id"])
					$dataCategorie[$key]["checked"] = 1;
			}
		}
		$this->vue->set($dataCategorie, "categorie");
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
			return $this->list();
		} catch (PpciException) {
			return $this->change();
		}
	}
}
