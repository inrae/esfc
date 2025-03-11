<?php

namespace App\Libraries;

use App\Models\Biopsie;
use App\Models\DosageSanguin;
use App\Models\Echographie;
use App\Models\Injection;
use App\Models\Morphologie;
use App\Models\Poisson;
use App\Models\PoissonCampagne as ModelsPoissonCampagne;
use App\Models\PoissonSequence;
use App\Models\PsEvenement;
use App\Models\ReproStatut;
use App\Models\SearchRepro;
use App\Models\Site;
use App\Models\Sperme;
use App\Models\Transfert;
use App\Models\Ventilation;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class PoissonCampagne extends PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	public $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsPoissonCampagne;
		$this->keyName = "poisson_campagne_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		}
		helper("esfc");
	}
	function list()
	{
		$this->vue = service('Smarty');
		if (isset($this->vue) && isset($_SESSION["sequence_id"])) {
			$this->vue->set($_SESSION["sequence_id"], "sequence_id");
		}
		setAnneesRepro($this->vue);
		/**
		 * Display the list of all records of the table
		 */
		$this->vue->htmlVars[] = "massex";
		$this->vue->htmlVars[] = "massey";
		if (!isset($_SESSION["searchRepro"])) {
			$_SESSION["searchRepro"] = new SearchRepro;
		}
		$_SESSION["searchRepro"]->setParam($_REQUEST);
		$dataSearch = $_SESSION["searchRepro"]->getParam();
		if ($_SESSION["searchRepro"]->isSearch() == 1) {
			$this->vue->set($this->dataclass->getListForDisplay($dataSearch), "data");
		}
		$this->vue->set($dataSearch, "dataSearch");
		$this->vue->set("repro/poissonCampagneList.tpl", "corps");
		/**
		 * Lecture de la liste des statuts
		 */
		$reproStatut = new ReproStatut;
		$this->vue->set($reproStatut->getListe(1), "dataReproStatut");
		/**
		 * Passage en parametre de la liste parente
		 */
		$_SESSION["poissonDetailParent"] = "poissonCampagneList";
		/**
		 * Site
		 */
		$site = new Site;
		$this->vue->set($site->getListe(2), "site");

		/**
		 * Affichage du graphique d'evolution de la masse
		 */
		if ($_REQUEST["graphique_id"] > 0) {
			$morphologie = new Morphologie;
			$date_from = ($_SESSION["annee"] - 5) . "-01-01";
			$date_to = $_SESSION["annee"] . "-12-31";
			$dataMorpho = $morphologie->getListMasseFromPoisson($_REQUEST["graphique_id"], $date_from, $date_to);
			/**
			 * Lecture des donnees du poisson
			 */
			$poisson = new Poisson;
			$dataPoisson = $poisson->lire($_REQUEST["graphique_id"]);
			$this->vue->set($_REQUEST["graphique_id"], "graphique_id");
			/**
			 * Preparation des donnees pour le graphique
			 */
			$x = "'x'";
			$y = "'data1'";
			foreach ($dataMorpho as $value) {
				$x .= ",'" . $value["morphologie_date"] . "'";
				$y .= "," . $value["masse"];
			}
			$this->vue->set($dataPoisson["prenom"] . " " . $dataPoisson["matricule"], "poisson_nom");
			$this->vue->set($x, "massex");
			$this->vue->set($y, "massey");
		}
		return $this->vue->send();
	}

	function display()
	{
		$this->vue = service('Smarty');
		if (isset($this->vue) && isset($_SESSION["sequence_id"])) {
			$this->vue->set($_SESSION["sequence_id"], "sequence_id");
		}
		setAnneesRepro($this->vue);
		/**
		 * Display the detail of the record
		 */
		$data = $this->dataclass->lire($this->id);
		$this->vue->set($data, "dataPoisson");
		/**
		 * Passage en parametre de la liste parente
		 */
		$this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
		/**
		 * Module de retour au poisson
		 */
		$_SESSION["poissonParent"] = "poissonCampagneDisplay";
		/**
		 * Lecture des tables liees
		 */
		$dosageSanguin = new DosageSanguin;
		$biopsie = new Biopsie;
		$poissonSequence = new PoissonSequence;
		$psEvenement = new PsEvenement;
		$echographie = new Echographie;
		$injection = new Injection;
		$sperme = new Sperme;
		$transfert = new Transfert;
		$ventilation = new Ventilation;

		$this->vue->set($dosages = $dosageSanguin->getListeFromPoissonCampagne($this->id), "dataSanguin");
		$this->vue->set($biopsies = $biopsie->getListeFromPoissonCampagne($this->id), "dataBiopsie");
		$this->vue->set($sequences = $poissonSequence->getListFromPoisson($this->id), "dataSequence");
		$this->vue->set($psEvenement->getListeEvenementFromPoisson($this->id), "dataPsEvenement");
		$this->vue->set($dataEcho = $echographie->getListByYear($data["poisson_id"], $_SESSION["annee"]), "dataEcho");
		$this->vue->set($injections = $injection->getListFromPoissonCampagne($this->id), "injections");
		$this->vue->set($spermes = $sperme->getListFromPoissonCampagne($this->id), "spermes");
		$this->vue->set($transfert->getListByPoisson($data["poisson_id"], $_SESSION["annee"]), "dataTransfert");
		$this->vue->set($ventilation->getListByPoisson($data["poisson_id"], $_SESSION["annee"]), "dataVentilation");
		if ($this->id > 0) {
			$this->vue->set($this->id, "poisson_campagne_id");
		}
		/**
		 * Recuperation des photos associees aux evenements
		 */
		$this->vue->set("poissonCampagneDisplay", "moduleParent");
		$this->vue->set("evenement", "parentType");
		$this->vue->set("poisson_campagne_id", "parentIdName");
		$this->vue->set($this->id, "parent_id");
		/**
		 * Generation de la liste des evenements issus des echographies
		 */
		$a_id = array();
		foreach ($dataEcho as $value) {
			$a_id[] = $value["evenement_id"];
		}
		$this->vue->set(getListeDocument("evenement", $a_id, $this->vue, $_REQUEST["document_limit"], $_REQUEST["document_offset"]), "dataDoc");
		$this->vue->set("repro/poissonCampagneDisplay.tpl", "corps");
		if (isset($_REQUEST["sequence_id"])) {
			$this->vue->set($_REQUEST["sequence_id"], "sequence_id");
		}
		/**
		 * Recherche des temperatures pour le graphique
		 */
		$dateMini = new \DateTime();
		$dateMaxi = new \DateTime("1967-01-01");
		for ($i = 1; $i < 3; $i++) {
			$datapf = $this->dataclass->getTemperatures($data["poisson_id"], $_SESSION["annee"], $i);
			$x = "'x" . $i . "'";
			if ($i == 1) {
				$y = "'" . _("constaté") . "'";
			} else {
				$y = "'" . _('prévu') . "'";
			}
			foreach ($datapf as $value) {
				$x .= ",'" . $value["pf_datetime"] . "'";
				$y .= "," . $value["pf_temperature"];
				$datetime = explode(" ", $value["pf_datetime"]);
				$d = \DateTime::createFromFormat("d/m/Y", $datetime[0]);
				if ($d < $dateMini)
					$dateMini = $d;
				if ($d > $dateMaxi)
					$dateMaxi = $d;
			}
			$this->vue->set($x, "pfx" . $i);
			$this->vue->set($y, "pfy" . $i);
			$this->vue->htmlVars[] = "pfx" . $i;
			$this->vue->htmlVars[] = "pfy" . $i;
		}
		$this->vue->set(1, "graphicsEnabled");
		/**
		 * Recherche des donnees pour les taux sanguins et les injections
		 */
		$e2y = "'E2'";
		$cay = "'Ca'";
		$e2x = "'x1'";
		$cax = "'x2'";
		$thx = "'x5'";
		$thy = "'Tx_Hematocrite'";
		$e2hy = "'E2_x_hema'";
		$cahy = "'Ca_x_hema'";
		$iy = "'Injections'";
		$ix = "'x3'";
		$expy = "'Expulsion'";
		$expx = "'x4'";
		$maxca = 0;
		$opix = "'x1'";
		$opiy = "'Tx OPI'";
		$t50x = "'x2'";
		$t50y = "'T50'";
		$diamx = "'x3'";
		$diamy = "'Diam moyen'";
		foreach ($dosages as $key => $value) {
			if ($value["tx_e2"] > 0) {
				$e2x .= ",'" . $value["dosage_sanguin_date"] . "'";
				$e2y .= "," . $value["tx_e2"];
			}
			if ($value["tx_calcium"] > 0) {
				$cax .= ",'" . $value["dosage_sanguin_date"] . "'";
				$cay .= "," . $value["tx_calcium"];
				if ($value["tx_calcium"] > $maxca) {
					$maxca = $value["tx_calcium"];
				}
			}
			/**
			 * Ajout du taux d'hematocrite, et calcul des courbes corrigees de E2 et Ca
			 */
			if ($value["tx_hematocrite"] > 0) {
				$thx .= ",'" . $value["dosage_sanguin_date"] . "'";
				$thy .= "," . $value["tx_hematocrite"];
				if ($value["tx_calcium"] > 0) {
					$cahy .= "," . ($value["tx_calcium"] / 100 * $value["tx_hematocrite"]);
				}
				if ($value["tx_e2"] > 0) {
					$e2hy .= "," . ($value["tx_e2"] / 100 * $value["tx_hematocrite"]);
				}
			}
			$d = \DateTime::createFromFormat("d/m/Y", $value["dosage_sanguin_date"]);
			if ($d < $dateMini) {
				$dateMini = $d;
			}
			if ($d > $dateMaxi) {
				$dateMaxi = $d;
			}
		}
		if ($maxca == 0) {
			$maxca = 1;
		}
		/**
		 * Recuperation des injections
		 */
		foreach ($injections as $key => $value) {
			$datetime = explode(" ", $value["injection_date"]);
			$ix .= ",'" . $datetime[0] . "'";
			$iy .= "," . $maxca;
			$d = \DateTime::createFromFormat("d/m/Y", $datetime[0]);
			if ($d < $dateMini) {
				$dateMini = $d;
			}
			if ($d > $dateMaxi) {
				$dateMaxi = $d;
			}
		}
		/**
		 * Recuperation des expulsions
		 */
		if ($data["sexe_libelle_court"] == "f") {
			foreach ($sequences as $key => $value) {
				if (strlen($value["ovocyte_expulsion_date"]) > 0) {
					$datetime = explode(" ", $value["ovocyte_expulsion_date"]);
					$d = \DateTime::createFromFormat("d/m/Y", $datetime[0]);
					$expx .= ",'" . $datetime[0] . "'";
					$expy .= "," . $maxca;
				}
			}
			/**
			 * Recherche des donnees concernant les biopsies
			 */

			foreach ($biopsies as $value) {
				if (strlen($value["biopsie_date"]) > 0) {
					$datetime = explode(" ", $value["biopsie_date"]);
					$d = \DateTime::createFromFormat("d/m/Y", $datetime[0]);
					if ($d < $dateMini) {
						$dateMini = $d;
					}
					if ($d > $dateMaxi) {
						$dateMaxi = $d;
					}
					if ($value["tx_opi"] > 0) {
						$opix .= ",'" . $datetime[0] . "'";
						$opiy .= "," . $value["tx_opi"];
					}
					if (strlen($value["ringer_t50"]) > 0) {
						$duree = explode(":", $value["ringer_t50"]);
						$dureeCalc = $duree[0] + ($duree[1] / 60);
						if ($dureeCalc > 0) {
							$t50x .= ",'" . $datetime[0] . "'";
							$t50y .= "," . $dureeCalc;
						}
					}
					if ($value["diam_moyen"] > 0) {
						$diamx .= ",'" . $datetime[0] . "'";
						$diamy .= "," . $value["diam_moyen"];
					}
				}
			}
		} else {
			foreach ($spermes as $value) {
				$datetime = explode(" ", $value["sperme_date"]);
				$expx .= ",'" . $datetime[0] . "'";
				$expy .= "," . $maxca;
				$d = \DateTime::createFromFormat("d/m/Y", $datetime[0]);
				if ($d < $dateMini) {
					$dateMini = $d;
				}
				if ($d > $dateMaxi) {
					$dateMaxi = $d;
				}
			}
		}
		$graphVars = array(
			"e2x",
			"e2y",
			"cax",
			"cay",
			"thx",
			"thy",
			"e2hy",
			"cahy",
			"ix",
			"iy",
			"expx",
			"expy",
			"opix",
			"opiy",
			"t50x",
			"t50y",
			"diamx",
			"diamy"
		);
		foreach ($graphVars as $gv) {
			$this->vue->set($$gv, $gv);
			$this->vue->htmlVars[] = $gv;
		}
		/**
		 * Ajout de 3 jours aux bornes des graphiques
		 */
		$interval = new \DateInterval("P1D");
		date_sub($dateMini, $interval);
		date_add($dateMaxi, $interval);
		$this->vue->set(date_format($dateMini, 'd/m/Y'), "dateMini");
		$this->vue->set(date_format($dateMaxi, 'd/m/Y'), "dateMaxi");
		$this->vue->htmlVars[] = "dateMini";
		$this->vue->htmlVars[] = "dateMaxi";
		return $this->vue->send();
	}

	function change()
	{
		$this->vue = service('Smarty');
		$this->dataRead($this->id, "repro/poissonCampagneChange.tpl", $_REQUEST["poisson_id"]);
		/**
		 * Lecture des informations concernant le poisson
		 */
		$poisson = new Poisson;

		$this->vue->set($poisson->getDetail($_REQUEST["poisson_id"]), "dataPoisson");
		/**
		 * Lecture de la table des statuts
		 */
		$reproStatut = new ReproStatut;
		$this->vue->set($reproStatut->getListe(1), "reproStatut");
		/**
		 * Calcul des annees de campagne potentielles
		 */
		$anneeCourante = date('Y');
		$annees = array();
		for ($i = $anneeCourante; $i > 1995; $i--) {
			$annees[] = $i;
		}
		$this->vue->set($annees, "annees");
		/**
		 * Passage en parametre de la liste parente
		 */
		$this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
		$this->vue->set($_SESSION["poissonParent"], "poissonParent");
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
			if (is_array($this->id)) {
				$nb = 0;
				foreach ($this->id as $value) {
					if ($value > 0) {
						$this->dataclass->supprimer($value);
						$nb++;
					}
				}
				$this->message->set(sprintf(_("%s poissons déselectionnés"), $nb));
			} else {
				$this->dataDelete($this->id);
			}
			return true;
		} catch (PpciException $e) {
			return false;
		}
	}
	function campagneInit()
	{
		$this->vue = service('Smarty');
		/**
		 * Affiche la fenêtre d'intialisation de la campagne
		 */
		$anneeCourante = date("Y");
		$annees = array();
		for ($i = $anneeCourante - 3; $i <= $anneeCourante; $i++) {
			$annees[]["annee"] = $i;
		}
		$this->vue->set($annees, "annees");
		$this->vue->set("repro/campagneInit.tpl", "corps");
		return $this->vue->send();
	}
	function init()
	{
		$nb = $this->dataclass->initCampagne($_REQUEST["annee"]);
		$this->message->set(sprintf(_("%s poisson(s) ajouté(s)"), $nb));
		return true;
	}
	function changeStatut()
	{
		if ($_REQUEST["repro_statut_id"] > 0) {
			try {
				if (is_array($this->id)) {
					$nb = 0;
					foreach ($this->id as $key => $value) {
						if ($value > 0) {
							$this->dataclass->changeStatut($value, $_REQUEST["repro_statut_id"]);
							$nb++;
						}
					}
				} else {
					if ($this->dataclass->changeStatut($this->id, $_REQUEST["repro_statut_id"]) > 0) {
						$nb = 1;
					}
				}
				$this->message->set(sprintf(_("%s statuts modifiés"), $nb));
				return true;
			} catch (PpciException) {
				return false;
			}
		}
	}
	function recalcul()
	{
		/**
		 * Recalcul des taux de croissance
		 */
		$this->dataclass->initCampagnePoisson($_REQUEST["poisson_id"], $_REQUEST["annee"]);
		return true;
	}
}
