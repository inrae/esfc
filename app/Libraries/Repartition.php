<?php

namespace App\Libraries;

use App\Models\Categorie;
use App\Models\Distribution;
use App\Models\Repartition as ModelsRepartition;
use App\Models\RepartitionAdulte;
use App\Models\RepartitionJuvenile;
use App\Models\RepartTemplate;
use App\Models\SearchRepartition;
use App\Models\Site;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Repartition extends PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	public $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsRepartition;
		$this->keyName = "repartition_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		}
	}
	function list()
	{
		$this->vue = service('Smarty');
		/**
		 * Gestion des variables de recherche
		 */
		if (!isset($_SESSION["searchRepartition"])) {
			$_SESSION["searchRepartition"] = new SearchRepartition;
		}
		$_SESSION["searchRepartition"]->setParam($_REQUEST);
		$dataSearch = $_SESSION["searchRepartition"]->getParam();
		if ($_REQUEST["next"] > 0) {
			$dataSearch["offset"] = $dataSearch["offset"] + $dataSearch["limit"];
			$_SESSION["searchRepartition"]->setParam("offset", $dataSearch["offset"]);
		}
		if ($_REQUEST["previous"] > 0) {
			$dataSearch["offset"] = $dataSearch["offset"] - $dataSearch["limit"];
			if ($dataSearch["offset"] < 0)
				$dataSearch["offset"] = 0;
			$_SESSION["searchRepartition"]->setParam("offset", $dataSearch["offset"]);
		}
		if ($_SESSION["searchRepartition"]->isSearch() == 1) {
			$this->vue->set(1, "isSearch");
			$dataList = $this->dataclass->getListSearch($dataSearch);
			/**
			 * Preparation de la creation ex-nihilo d'une repartition
			 */
			$jour = date("w");
			$jour_array = array(
				0 => 1,
				1 => 0,
				2 => 6,
				3 => 5,
				4 => 4,
				5 => 3,
				6 => 2
			);
			$data = array();
			$date = new \DateTime();
			$date->add(new \DateInterval('P' . $jour_array[$jour] . 'D'));
			$data["date_debut_periode"] = $date->format('d/m/Y');
			$date->add(new \DateInterval('P6D'));
			$data["date_fin_periode"] = $date->format('d/m/Y');
			$data["repartition_id"] = 0;
			$data["lundi"] = 1;
			$data["mardi"] = 1;
			$data["mercredi"] = 1;
			$data["jeudi"] = 1;
			$data["vendredi"] = 1;
			$data["samedi"] = 1;
			$data["dimanche"] = 1;
			$this->vue->set($data, "data");
		}
		$this->vue->set($dataSearch, "repartitionSearch");
		$this->vue->set($dataList, "dataList");
		$site = new Site;
		$this->vue->set($site->getListe(2), "site");
		$this->vue->set("aliment/repartitionList.tpl", "corps");
		/**
		 * Recherche de la categorie
		 */
		$categorie = new Categorie;
		$this->vue->set($categorie->getListeSansLot(), "categorie");
		return $this->vue->send();
	}
	function change()
	{
		$this->vue = service('Smarty');
		$data = $this->dataRead($this->id, "aliment/repartitionChange.tpl");
		if (empty($data["site_id"])) {
			$data["site_id"] = 1;
		}
		/**
		 * Recherche de la categorie
		 */
		$categorie = new Categorie;
		$this->vue->set($categorie->getListe(2), "categorie");
		$site = new Site;
		$this->vue->set($site->getListe(2), "site");
		/**
		 * Recuperation des bassins associes et des distributions
		 */
		if ($data["categorie_id"] > 0) {
			$distribution = new Distribution;
			$this->vue->set($distribution->getFromRepartitionWithBassin($this->id, $data["categorie_id"], $data["site_id"]), "dataBassin");
			/**
			 * Recuperation des modèles de distribution actifs
			 */
			$template = new RepartTemplate;
			$this->vue->set($template->getListActifFromCategorie($data["categorie_id"]), "dataTemplate");
			return $this->vue->send();
		}
	}
	function create()
	{
		/**
		 * Creation d'une repartition vierge
		 */
		try {
			$this->id = $this->dataWrite($_REQUEST);
			$_REQUEST[$this->keyName] = $this->id;
			return true;
		} catch (PpciException) {
			return false;
		}
	}
	function duplicate()
	{
		/**
		 * Creation d'une nouvelle repartition a partir d'une existante
		 */
		if ($this->id > 0) {
			try {
				$_REQUEST[$this->keyName] = $this->dataclass->duplicate($this->id);
				return true;
			} catch (PpciException) {
				$this->message->set(_("Erreur lors de la création d'une nouvelle distribution"), true);
				return false;
			}
		} else {
			return false;
		}
	}
	function write()
	{
		try {
			/**
			 * write record in database
			 */
			$this->id = $this->dataWrite($_REQUEST);
			$_REQUEST[$this->keyName] = $this->id;
			/**
			 * Preparation des informations concernant les bassins
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
			 * Mise en table des données de bassins
			 */
			$distribution = new Distribution;
			foreach ($data as $key => $value) {
				if ($value["distribution_id"] > 0 || $value["total_distribue"] > 0) {
					$value["repartition_id"] = $this->id;
					$distribution->ecrire($value);
				}
			}
		} catch (PpciException) {
			$this->message->set(_("Problème lors de l'enregistrement"), true);
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
	function print()
	{
		/**
		 * Imprime le tableau de répartition
		 */
		if ($this->id > 0) {
			$data = $this->dataclass->lire($this->id);
			$distribution = new Distribution;
			/**
			 * Recuperation de la liste des aliments utilises
			 */
			if ($data["categorie_id"] == 1)
				$dataAliment = $distribution->getListeAlimentFromRepartition($this->id);
			elseif ($data["categorie_id"] == 2)
				$dataAliment = $distribution->getListeAlimentFromRepartition($this->id, "juvenile");
			/**
			 * Recuperation des distributions prevues
			 */
			$dataDistrib = $distribution->calculDistribution($this->id);
			if ($data["categorie_id"] == 1) {
				$tableau = new RepartitionAdulte;
			} elseif ($data["categorie_id"] == 2) {
				$tableau = new RepartitionJuvenile;
			}
			$tableau->setData($data, $dataDistrib, $dataAliment);
			$tableau->exec();
		}
	}
	function resteChange()
	{
		$this->vue=service('Smarty');
		$this->vue->set($data = $this->dataclass->readWithCategorie($this->id), "data");
		$this->vue->set("aliment/repartitionResteChange.tpl", "corps");
		/**
		 * preparation de la saisie des restes
		 */
		$distribution = new Distribution;
		$dataBassin = $distribution->getFromRepartition($this->id);

		/**
		 * Preparation du tableau de dates
		 */
		$dateDebut = \DateTime::createFromFormat('d/m/Y', $data['date_debut_periode']);
		$dateFin = \DateTime::createFromFormat('d/m/Y', $data["date_fin_periode"]);
		$dateDiff = date_diff($dateDebut, $dateFin, true);
		$nbJour = $dateDiff->format("%a");
		$jour = array(
			0 => "dim",
			1 => "lun",
			2 => "mar",
			3 => "mer",
			4 => "jeu",
			5 => "ven",
			6 => "sam"
		);
		for ($i = 0; $i <= $nbJour; $i++) {
			$dateArray[$i]["libelle"] = $jour[$dateDebut->format("w")];
			$dateArray[$i]["numJour"] = $i;
			/**
			 * Calcul du total distribue
			 */
			$dateDebut->add(new \DateInterval('P1D'));
		}
		$this->vue->set($dateArray, "dateArray");
		$this->vue->set($nbJour + 1, "nbJour");
		/**
		 * Mise en forme des donnees
		 */
		foreach ($dataBassin as $key => $value) {
			$dataReste = explode("+", $value["reste_zone_calcul"]);
			$i = 0;
			for ($i = 0; $i <= $nbJour; $i++) {
				// foreach ($dataReste as $key1 => $value1) {
				$dataBassin[$key]["reste"][$i] = $dataReste[$i];
			}
		}
		$this->vue->set($dataBassin, "dataBassin");
		return $this->vue->send();
	}
	function resteWrite()
	{
		/**
		 * Ecriture de la saisie des restes
		 */
		if ($this->id > 0) {
			try {
				/**
				 * Traitement de chaque distribution
				 */
				/**
				 * Preparation des informations concernant les bassins
				 */
				$data = array();
				foreach ($_REQUEST as $key => $value) {
					if (preg_match('/[0-9]+$/', $key, $val)) {
						$pos = strrpos($key, "_");
						$nom = substr($key, 0, $pos);
						$data[$val[0]][$nom] = $value;
					}
				}
				$distribution = new Distribution;
				$distribution->disableMandatoryField("repart_template_id");
				/**
				 * Traitement de chaque bassin
				 */
				foreach ($data as $key => $value) {
					$value["date_debut_periode"] = $_REQUEST["date_debut_periode"];
					$value["date_fin_periode"] = $_REQUEST["date_fin_periode"];
					$value["repartition_id"] = $_REQUEST["repartition_id"];
					$distribution->writeReste($value);
				}
				$this->message->set(_("Opération effectuée"));
				$this->log->setLog($_SESSION["login"], get_class($this->dataclass) . "-write", $this->id);
				return true;
			} catch (PpciException $e) {
				$this->message->set($e->getMessage(), true);
				return false;
			}
		} else {
			return false;
		}
	}
}
