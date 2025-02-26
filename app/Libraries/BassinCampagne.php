<?php

namespace App\Libraries;

use App\Models\Bassin;
use App\Models\BassinCampagne as ModelsBassinCampagne;
use App\Models\BassinEvenement;
use App\Models\ProfilThermique;
use App\Models\Salinite;
use App\Models\Transfert;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class BassinCampagne extends  PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	private $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsBassinCampagne;
		$this->keyName = "bassin_campagne_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		}
	}
	function display()
	{
		$this->vue = service('Smarty');
		/*
		 * Display the detail of the record
		 */
		$data = $this->dataclass->lire($this->id);
		$this->vue->set($data, "dataBassinCampagne");
		$this->vue->set("repro/bassinCampagneDisplay.tpl", "corps");
		/*
		 * Recuperation des donnees du profil thermique
		 */
		$profilThermique = new ProfilThermique;
		$this->vue->set($profilThermique->getListFromBassinCampagne($this->id), "profilThermiques");
		/*
		 * Calcul des donnees pour le graphique
		 */

		for ($i = 1; $i < 3; $i++) {
			$datapf = $profilThermique->getValuesFromBassinCampagne($this->id, $_SESSION["annee"], $i);
			$x = "'x" . $i . "'";
			if ($i == 1) {
				$y = "'constaté'";
			} else $y = "'prévu'";
			foreach ($datapf as $key => $value) {
				$x .= ",'" . $value["pf_datetime"] . "'";
				$y .= "," . $value["pf_temperature"];
			}
			$this->vue->set($x, "pfx" . $i);
			$this->vue->set($y, "pfy" . $i);
		}
		/*
		 * Donnes de salinite
		 */
		$salinite = new Salinite;
		$this->vue->set($salinite->getListFromBassinCampagne($this->id), "salinites");
		/*
		 * Calcul des donnees pour le graphique
		 */
		for ($i = 1; $i < 3; $i++) {
			$datapf = $salinite->getValuesFromBassinCampagne($this->id, $_SESSION["annee"], $i);

			$x = "'x" . $i . "'";
			if ($i == 1) {
				$y = "'constaté'";
			} else $y = "'prévu'";
			foreach ($datapf as $key => $value) {
				$x .= ",'" . $value["salinite_datetime"] . "'";
				$y .= "," . $value["salinite_tx"];
			}
			$this->vue->set($x, "sx" . $i);
			$this->vue->set($y, "sy" . $i);
		}
		/*
		 * Recuperation des donnees du bassin
		 */
		$bassin = new Bassin;
		$this->vue->set($bassin->lire($data["bassin_id"]), "dataBassin");
		/*
		 * Recuperation de la liste des poissons presents
		 */
		$transfert = new Transfert;
		$this->vue->set($transfert->getListPoissonPresentByBassin($data["bassin_id"]), "dataPoisson");
		/*
		 * Calcul de la date du jour
		 */
		$this->vue->set(date("d/m/Y"), "dateJour");
		/*
		 * Recuperation des evenements
		*/
		$bassinEvenement = new BassinEvenement;
		$this->vue->set($bassinEvenement->getListeByBassin($data["bassin_id"]), "dataBassinEvnt");
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
		/*
		 * delete record
		 */
		try {
			$this->dataDelete($this->id);
			return true;
		} catch (PpciException $e) {
			return false;
		}
	}
	function init()
	{
		/*
		 * Initialisation des bassins pour la campagne
		 */
		if ($_REQUEST["annee"] > 0) {
			$nb = $this->dataclass->initCampagne($_REQUEST["annee"]);
			$this->message->set(sprintf(_("%s bassin(s) ajouté(s) à la campagne de reproduction"), $nb));
		}
	}
}
