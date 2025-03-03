<?php

namespace App\Libraries;

use App\Models\Bassin as ModelsBassin;
use App\Models\BassinEvenement;
use App\Models\DistribQuotidien;
use App\Models\Evenement;
use App\Models\Evenement_type;
use App\Models\SearchAlimentation;
use App\Models\SearchBassin;
use App\Models\Site;
use App\Models\Transfert;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Bassin extends PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	public $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsBassin;
		$this->keyName = "bassin_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		} elseif (isset($_SESSION["bassin_id"])) {
			$this->id = $_SESSION["bassin_id"];
		} else {
			$this->id = -1;
		}
		if (!isset ($_SESSION["searchBassin"])) {
			$_SESSION["searchBassin"] = new SearchBassin;
		}
		$_SESSION["bassinParentModule"] = "bassinListniv2";
		helper("esfc");
	}
	function list()
	{
		$this->vue = service('Smarty');
		/**
		 * Display the list of all records of the table
		 */
		$_SESSION["searchBassin"]->setParam($_REQUEST);
		if ($_SESSION["searchBassin"]->isSearch() == 1) {
			$this->vue->set($this->dataclass->getListeSearch($_SESSION["searchBassin"]->getParam()), "data");
		}
		/**
		 * Preparation des dates pour la generation du recapitulatif des aliments
		 */
		!isset($_REQUEST["dateFin"]) ? $dateFin = date("d/m/Y") : $dateFin = $_REQUEST["dateFin"];
		!isset($_REQUEST["dateDebut"]) ? $dateDebut = date("d/m/") . (date("Y") - 1) : $dateDebut = $_REQUEST["dateDebut"];
		$this->vue->set($dateDebut, "dateDebut");
		$this->vue->set($dateFin, "dateFin");
		$this->vue->set("bassin/bassinList.tpl", "corps");
		$_SESSION["bassinParentModule"] = "bassinList";
		$site = new Site;
		$this->vue->set($site->getListe(2), "site");
		return $this->vue->send();
	}
	function display()
	{
		$this->vue = service('Smarty');
		/**
		 * Display the detail of the record
		 */
		$data = $this->dataclass->getDetail($this->id);
		$this->vue->set($data, "dataBassin");
		/**
		 * Recuperation de la liste des poissons presents
		 */
		$transfert = new Transfert;
		$this->vue->set($transfert->getListPoissonPresentByBassin($this->id), "dataPoisson");
		/**
		 * Recuperation des evenements
		 */
		$bassinEvenement = new BassinEvenement;
		$this->vue->set($bassinEvenement->getListeByBassin($this->id), "dataBassinEvnt");
		/**
		 * Recuperation des aliments consommés sur la période déterminée
		 */
		$distribQuotidien = new DistribQuotidien;
		/**
		 * Dates de recherche
		 */
		if (!isset($_SESSION["searchAlimentation"])) {
			$_SESSION["searchAlimentation"] = new SearchAlimentation;
		}
		$_SESSION["searchAlimentation"]->setParam($_REQUEST);
		$param = $_SESSION["searchAlimentation"]->getParam();
		$this->vue->set($param, "searchAlim");
		$this->vue->set($distribQuotidien->getListeConsommation($this->id, $param["date_debut"], $param["date_fin"]), "dataAlim");
		$this->vue->set($distribQuotidien->alimentListe, "alimentListe");
		/**
		 * Gestion des documents associes
		 */
		$this->vue->set("bassinDisplay", "moduleParent");
		$this->vue->set("bassin", "parentType");
		$this->vue->set("bassin_id", "parentIdName");
		$this->vue->set($this->id, "parent_id");
		$this->vue->set(getListeDocument("bassin", $this->id, $this->vue, $_REQUEST["document_limit"], $_REQUEST["document_offset"]), "dataDoc");
		/**
		 * Ajout des informations pour le transfert des poissons
		 */
		$eventType = new Evenement_type;
		$this->vue->set($eventType->getListe("evenement_type_actif desc, evenement_type_libelle"), "evntType");
		$data["site_id"] > 0 ? $siteId = $data["site_id"] : $siteId = 0;
		$this->vue->set($this->dataclass->getListBassin($siteId, 1), "bassinListActif");
		$this->vue->set(date($_SESSION["date"]["maskdate"]), "currentDate");
		/**
		 * Affichage
		 */
		$this->vue->set("bassin/bassinDisplay.tpl", "corps");
		$this->vue->set($_SESSION["bassinParentModule"], "bassinParentModule");
		$_SESSION["poissonDetailParent"] = "bassinDisplay";
		$_SESSION["bassin_id"] = $this->id;
		return $this->vue->send();
	}
	function change()
	{
		$this->vue = service('Smarty');
		$this->dataRead($this->id, "bassin/bassinChange.tpl");
		/**
		 * Integration des tables de parametres
		 */
		bassinParamAssocie($this->vue);
		$this->vue->set($_SESSION["bassinParentModule"], "bassinParentModule");
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
	function calculMasseAjax()
	{
		$this->vue = service ("AjaxView");
		if ($_REQUEST["bassin_id"] > 0) {
			$masse = $this->dataclass->calculMasse($_REQUEST["bassin_id"]);
			$this->vue->set(array("val" => $masse));
		}
		return $this->vue->send();
	}
	function recapAlim()
	{
		$this->vue=service('Smarty');
		$this->vue->set($this->dataclass->getRecapAlim($_REQUEST, $_SESSION["searchBassin"]->getParam()));
		return $this->vue->send();
	}
	function bassinPoissonTransfert()
	{
		$event = new Evenement;
		$transfert = new Transfert;
		$db = $this->dataclass->db;
		try {
			$db->transBegin();
			$nb = 0;
			$data = [
				"evenement_id" => 0,
				"evenement_type_id" => $_POST["evenement_type_id"],
				"evenement_date" => $_POST["evenement_date"],
				"commentaire" => $_REQUEST["commentaire"],
				"bassin_origine" => $_POST["bassin_origine"],
				"bassin_destination" => $_POST["bassin_destination"],
				"transfert_date" => $_POST["evenement_date"],
				"transfert_id" => 0
			];
			foreach ($_POST["poissons"] as $poisson_id) {
				$data["poisson_id"] = $poisson_id;
				$data["evenement_id"] = $event->ecrire($data);
				$transfert->ecrire($data);
				$data["evenement_id"] = 0;
				$nb++;
			}
			$db->transCommit();
			$this->message->set(sprintf(_("%s poissons transférés"), $nb));
			return true;
		} catch (PpciException $e) {
			$db->transRollback();
			$this->message->set("{t}Une erreur est survenue pendant le transfert des poissons", true);
			$this->message->set($e->getMessage());
			$this->message->setSyslog($e->getMessage());
			return false;
		}
	}
}
