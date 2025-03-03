<?php

namespace App\Libraries;

use App\Models\Anesthesie;
use App\Models\AnomalieDb;
use App\Models\Categorie;
use App\Models\Cohorte;
use App\Models\DosageSanguin;
use App\Models\Echographie;
use App\Models\Evenement;
use App\Models\GenderSelection;
use App\Models\Genetique;
use App\Models\Morphologie;
use App\Models\Mortalite;
use App\Models\Parente;
use App\Models\ParentPoisson;
use App\Models\Pathologie;
use App\Models\Pittag;
use App\Models\PittagType;
use App\Models\Poisson as ModelsPoisson;
use App\Models\PoissonCampagne;
use App\Models\PoissonStatut;
use App\Models\Sexe;
use App\Models\Sortie;
use App\Models\Transfert;
use App\Models\Ventilation;
use App\Models\VieModele;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Poisson extends PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	public $keyName;
	private $idPittag;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsPoisson;
		$this->keyName = "poisson_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		}
	}
	function list()
	{
		$this->vue = service('Smarty');
		require "modules/poisson/poissonSearch.php";
		if ($_SESSION["searchPoisson"]->isSearch() == 1) {
			$data = $this->dataclass->getListeSearch($dataSearch);
			$this->vue->set($data, "data");
		}
		$_SESSION["poissonDetailParent"] = "poissonList";
		$this->vue->set("poisson/poissonList.tpl", "corps");
		return $this->vue->send();
	}
	function display()
	{
		$this->vue = service('Smarty');
		/**
		 * Display the detail of the record
		 */
		$data = $this->dataclass->getDetail($this->id);
		$this->vue->set($data, "dataPoisson");
		/**
		 * Passage en parametre de la liste parente
		 */
		$this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
		/**
		 * Recuperation des morphologies
		 */
		$morphologie = new Morphologie;
		$this->vue->set($dmorpho = $morphologie->getListeByPoisson($this->id), "dataMorpho");
		/**
		 * Generation des donnees pour le graphique
		 */
		if (!empty($dmorpho)) {
			$dataGraph = $morphologie->generateGraphAsJson($dmorpho);
			$this->vue->set($dataGraph["data"], "dataMorphoGraph");
			$this->vue->set($dataGraph["maxweight"], "maxy");
			$this->vue->set($dataGraph["maxlength"], "maxy2");
			$this->vue->set($dataGraph["firstdate"], "firstdate");
			$this->vue->set($dataGraph["lastdate"], "lastdate");
			$this->vue->set($dataGraph["dateFormat"], "dateFormat");
			$this->vue->htmlVars[] = "dataMorphoGraph";
		}
		/**
		 * Recuperation des événements
		 */
		$evenement = new Evenement;
		$this->vue->set($evenement->getEvenementByPoisson($this->id), "dataEvenement");
		/**
		 * Recuperation du sexage
		 */
		$gender_selection = new GenderSelection;
		$this->vue->set($gender_selection->getListByPoisson($this->id), "dataGender");
		/**
		 * Recuperation des pathologies
		 */
		$pathologie = new Pathologie;
		$this->vue->set($pathologie->getListByPoisson($this->id), "dataPatho");
		/**
		 * Recuperation des pittag
		 */
		$pittag = new Pittag;
		$this->vue->set($pittag->getListByPoisson($this->id), "dataPittag");
		/**
		 * Recuperation des transferts
		 */
		$transfert = new Transfert;
		$this->vue->set($transfert->getListByPoisson($this->id), "dataTransfert");
		/**
		 * Recuperation des mortalites
		 */
		$mortalite = new Mortalite;
		$this->vue->set($mortalite->getListByPoisson($this->id), "dataMortalite");
		/**
		 * Recuperation des cohortes
		 */
		$cohorte = new Cohorte;
		$this->vue->set($cohorte->getListByPoisson($this->id), "dataCohorte");
		/**
		 * Recuperation des parents
		 */
		$parent = new ParentPoisson;
		$this->vue->set($parent->getListParent($this->id), "dataParent");
		/**
		 * Recuperation des anomalies
		 */
		$anomalie = new AnomalieDb;
		$this->vue->set($anomalie->getListByPoisson($this->id), "dataAnomalie");
		/**
		 * Recuperation des sorties
		 */
		$sortie = new Sortie;
		$this->vue->set($sortie->getListByPoisson($this->id), "dataSortie");
		/**
		 * Recuperation des echographies
		 */
		$echographie = new Echographie;
		$this->vue->set($echographie->getListByPoisson($this->id), "dataEcho");
		/**
		 * Recuperation des anesthesies
		 */
		$anesthesie = new Anesthesie;
		$this->vue->set($anesthesie->getListByPoisson($this->id), "dataAnesthesie");
		/**
		 * Recuperation des mesures de ventilation
		 */
		$ventilation = new Ventilation;
		$this->vue->set($ventilation->getListByPoisson($this->id), "dataVentilation");
		/**
		 * Recuperation des campagnes de reproduction
		 */
		$poissonCampagne = new PoissonCampagne;
		$this->vue->set($poissonCampagne->getListFromPoisson($this->id), "dataRepro");
		/**
		 * Recuperation des dosages sanguins
		 */
		$dosageSanguin = new DosageSanguin;
		$this->vue->set($dosageSanguin->getListeFromPoisson($this->id), "dataDosageSanguin");

		/**
		 * Recuperation des prelevements genetiques
		 */
		$genetique = new Genetique;
		$this->vue->set($genetique->getListByPoisson($this->id), "dataGenetique");

		/**
		 * Recuperation des determinations de parente
		 */
		$parente = new Parente;
		$this->vue->set($parente->getListByPoisson($this->id), "dataParente");

		/**
		 * Calcul du cumul de température sur l'année écoulée
		 */
		$dateStart = new \DateTime();
		$dateStart->modify("-1 year");
		$this->vue->set(
			$this->dataclass->calcul_temperature($this->id, $dateStart->format($_SESSION["MASKDATE"]), date($_SESSION["MASKDATE"])),
			"cumulTemp"
		);

		/**
		 * Gestion des documents associes
		 */
		$this->vue->set("poissonDisplay", "moduleParent");
		$this->vue->set("poisson", "parentType");
		$this->vue->set("poisson_id", "parentIdName");
		$this->vue->set($this->id, "parent_id");
		require_once 'modules/document/documentFunctions.php';
		$this->vue->set(getListeDocument("poisson", $this->id, $_REQUEST["document_limit"], $_REQUEST["document_offset"]), "dataDoc");
		/**
		 * Affichage
		 */
		$this->vue->set("poisson/poissonDisplay.tpl", "corps");
		/**
		 * Module de retour au poisson
		 */
		$_SESSION["poissonParent"] = "poissonDisplay";
		return $this->vue->send();
	}
	function change()
	{
		$this->vue = service('Smarty');
		$this->dataRead($this->id, "poisson/poissonChange.tpl");
		$sexe = new Sexe;
		$this->vue->set($sexe->getListe(1), "sexe");
		$poissonStatut = new PoissonStatut;
		$this->vue->set($poissonStatut->getListe(1), "poissonStatut");
		$categorie = new Categorie;
		$this->vue->set($categorie->getListe(1), "categorie");

		/**
		 * Modeles de marquages VIE, pour creation a partir des juveniles
		 */
		$vieModele = new VieModele;
		$this->vue->set($vieModele->getAllModeles(), "modeles");
		/**
		 * Passage en parametre de la liste parente
		 */
		$this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");

		/**
		 * Recuperation de la liste des types de pittag
		 */
		$pittagType = new PittagType;
		$this->vue->set($pittagType->getListe(2), "pittagType");
		/**
		 * Recuperation du dernier pittag connu
		 */
		$pittag = new Pittag;
		$this->vue->set($pittag->getListByPoisson($this->id, 1), "dataPittag");
		return $this->vue->send();
	}
	function write()
	{
		try {
			$this->id = $this->dataWrite($_REQUEST);
			$_REQUEST[$this->keyName] = $this->id;
			/**
			 * Ecriture du pittag
			 */
			if (!empty($_REQUEST["pittag_valeur"])) {
				$pittag = new Pittag;
				$this->idPittag = $pittag->ecrire($_REQUEST);
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
		$db = $this->dataclass->db;
		$db->transBegin();
		try {
			$this->dataDelete($this->id, true);
			$db->transCommit();
			return true;
		} catch (PpciException $e) {
			$db->transRollback();
			return false;
		}
	}
	function getListeAjaxJson()
	{
		/**
		 * retourne la liste des poissons a partir du libelle fourni
		 * au format JSON, en mode Ajax
		 */
		$this->vue = service("AjaxView");
		if (!empty($_REQUEST["libelle"])) {
			$this->vue->set($this->dataclass->getListPoissonFromName($_REQUEST["libelle"]));
		}
		return $this->vue->send();
	}
}
