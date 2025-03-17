<?php

namespace App\Libraries;

use App\Models\Categorie;
use App\Models\Devenir as ModelsDevenir;
use App\Models\DevenirType;
use App\Models\Lot;
use App\Models\SortieLieu;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Devenir extends PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	public $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsDevenir;
		$this->keyName = "devenir_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		}
		helper("esfc");
	}
	function list()
	{
		$this->vue = service('Smarty');
		if ($_REQUEST["annee"] > 0) {
			$_SESSION["annee"] = $_REQUEST["annee"];
		}
		if (!isset($_SESSION["annee"])) {
			$_SESSION["annee"] = date("Y");
		}
		$this->vue->set($this->dataclass->getListeFull($_SESSION["annee"]), "dataDevenir");
		$this->vue->set("repro/devenirCampagneList.tpl", "corps");
		setAnneesRepro($this->vue);
		return $this->vue->send();
	}
	function change()
	{
		$this->vue = service('Smarty');
		$data = $this->dataRead($this->id, "repro/devenirChange.tpl", $_REQUEST["lot_id"]);
		$this->vue->set($_REQUEST["devenirOrigine"], "devenirOrigine");
		/**
		 * Lecture des tables de parametres
		 */
		$categorie = new Categorie;
		$this->vue->set($categorie->getListe(1), "categories");
		$sortie = new SortieLieu;
		$this->vue->set($sortie->getListe(2), "sorties");
		$devenirType = new DevenirType;
		$this->vue->set($devenirType->getListe(1), "devenirType");
		/**
		 * Lecture du lot
		 */
		if ($data["lot_id"] > 0) {
			$lot = new Lot;
			$this->vue->set($lot->getDetail($data["lot_id"]), "dataLot");
		}
		/**
		 * Recuperation de la liste des devenirs parents potentiels
		 */
		if ($data["lot_id"] > 0) {
			$lotId = $data["lot_id"];
			$annee = 0;
		} else {
			$lotId = 0;
			$annee = $_SESSION["annee"];
		}
		$parents = $this->dataclass->getParentsPotentiels($data["devenir_id"], $lotId, $annee);
		$this->vue->set($parents, "devenirParent");
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
