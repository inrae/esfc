<?php

namespace App\Libraries;

use App\Models\Bassin;
use App\Models\Categorie;
use App\Models\CreateFishFromBatch;
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
	 * @var ModelsDevenir
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
		/**
		 * Liste des bassins
		 */
		$bassin = new Bassin;
		$this->vue->set($bassin->getListFromCategorie(3, 1), "bassins");
		return $this->vue->send();
	}
	function write()
	{
		$db = $this->dataclass->db;
		try {
			$this->id = $this->dataWrite($_REQUEST);
			$_REQUEST[$this->keyName] = $this->id;
			/**
			 * Creation of fish, if csv file is furnished
			 */
			$fileError = $_FILES["poissons"]["error"];

			if ($fileError != 4) {
				if ($fileError != 0) {
					throw new PpciException(_("Le fichier contenant la liste des poissons n'a pas été correctement chargé vers le serveur"));
				}
				$createFish = new CreateFishFromBatch;
				$createFish->initFile($_FILES["poissons"]["tmp_name"], $_POST["separator"], $_POST["utf8_encode"]);
				$db->transBegin();
				$ddevenir = $this->dataclass->read($this->id);
				$nb = $createFish->createFish($ddevenir, $_POST["bassin_destination"]);
				$this->message->set(sprintf(_("%1s poissons créés. Poisson_id de %2s à %3s"), $nb, $createFish->poissonIdMin, $createFish->poissonIdMax));
				$this->log->setLog($_SESSION["login"],"devenirWrite","$nb fishes created between ". $createFish->poissonIdMin ." and ". $createFish->poissonIdMax);
				$db->transCommit();
			}
			return true;
		} catch (PpciException $e) {
			if ($db->transEnabled) {
				$db->transRollback();
			}
			$this->message->set($e->getMessage(), true);
			$this->message->setSyslog(($e->getMessage()));
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
