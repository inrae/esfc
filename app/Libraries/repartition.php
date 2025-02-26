<?php 
namespace App\Libraries;

use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Xx extends PpciLibrary { 
    /**
     * @var xx
     */
    protected PpciModel $this->dataclass;
    private $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ;
        $keyName = "_id";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 21 mars 2014
 */
require_once 'modules/classes/repartition.class.php';
$this->dataclass = new Repartition;
$keyName = "repartition_id";
$this->id = $_REQUEST[$keyName];
	function list(){
$this->vue=service('Smarty');
		/*
		 * Display the list of all records of the table
		 */
		/*
		 * Gestion des variables de recherche
		 */
		if (!isset($_SESSION["searchRepartition"])) {
			$_SESSION["searchRepartition"] = new SearchRepartition();
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
			/*
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
			$date = new DateTime();
			$date->add(new DateInterval('P' . $jour_array[$jour] . 'D'));
			$data["date_debut_periode"] = $date->format('d/m/Y');
			$date->add(new DateInterval('P6D'));
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
		require_once 'modules/classes/site.class.php';
		$site = new Site;
		$this->vue->set($site->getListe(2), "site");
		$this->vue->set("aliment/repartitionList.tpl", "corps");
		/*
		 * Recherche de la categorie
		 */
		require_once "modules/classes/categorie.class.php";
		$categorie = new Categorie;
		$this->vue->set($categorie->getListeSansLot(), "categorie");
		}
	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = $this->dataRead(, $this->id, "aliment/repartitionChange.tpl");
		if (empty($data["site_id"])) {
			$data["site_id"] = 1;
		}
		/*
		 * Recherche de la categorie
		 */
		require_once "modules/classes/categorie.class.php";
		$categorie = new Categorie;
		$this->vue->set($categorie->getListe(2), "categorie");
		require_once 'modules/classes/site.class.php';
		$site = new Site;
		$this->vue->set($site->getListe(2), "site");
		/*
		 * Recuperation des bassins associes et des distributions
		 */
		if ($data["categorie_id"] > 0) {
			require_once "modules/classes/distribution.class.php";
			$distribution = new Distribution;
			$this->vue->set($distribution->getFromRepartitionWithBassin($this->id, $data["categorie_id"], $data["site_id"]), "dataBassin");
			/*
			 * Recuperation des modèles de distribution actifs
			 */
			require_once "modules/classes/repartTemplate.class.php";
			$template = new RepartTemplate;
			$this->vue->set($template->getListActifFromCategorie($data["categorie_id"]), "dataTemplate");
		}
		}
	   function create() {
		/*
		 * Creation d'une repartition vierge
		 */
		$this->id = dataWrite($this->dataclass, $_REQUEST);
		if ($this->id > 0) {
			$_REQUEST[$keyName] = $this->id;
		}
		}
	   function duplicate() {
		/*
		 * Creation d'une nouvelle repartition a partir d'une existante
		 */
		if ($this->id > 0) {
			$ret = $this->dataclass->duplicate($this->id);
			if ($ret > 0) {
				$module_coderetour = 1;
				$_REQUEST[$keyName] = $ret;
			} else {
				$this->message->set(_("Erreur lors de la création d'une nouvelle distribution"), true);
				$this->message->set($this->dataclass->getErrorData(1));
				$module_coderetour = -1;
			}
		}
		}
	    function write() {
    try {
            $this->id =  try {
            $this->id = $this->dataWrite($_REQUEST);
            $_REQUEST["_id"] = $this->id;
            return true;
        } catch (PpciException $e) {
            return false;
        }
            if ($this->id > 0) {
                $_REQUEST[$this->keyName] = $this->id;
                return true;
            } else {
                return false;
            }
        } catch (PpciException) {
            return false;
        }
    }
		/*
		 * write record in database
		 */
		$this->id = dataWrite($this->dataclass, $_REQUEST);
		if ($this->id > 0) {
			$_REQUEST[$keyName] = $this->id;
			/*
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
			/*
			 * Mise en table des données de bassins
			 */
			require_once "modules/classes/distribution.class.php";
			$distribution = new Distribution;
			$error = 0;
			foreach ($data as $key => $value) {
				if ($value["distribution_id"] > 0 || $value["total_distribue"] > 0) {
					$value["repartition_id"] = $this->id;
					$this->idDistrib = $distribution->ecrire($value);
					if (!$this->idDistrib > 0) {
						$error = 1;
						$this->message->set($distribution->getErrorData(1));
					}
				}
			}
			if ($error == 1) {
				$this->message->set(_("Problème lors de l'enregistrement"), true);
				$module_coderetour = -1;
			}
		}
		}
	   function delete() {
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
	   function print() {
		/*
		 * Imprime le tableau de répartition
		 */
		if ($this->id > 0) {
			require_once 'modules/classes/tableauRepartition.class.php';
			$data = $this->dataclass->lire($this->id);
			require_once "modules/classes/distribution.class.php";
			$distribution = new Distribution;
			/*
			 * Recuperation de la liste des aliments utilises
			 */
			if ($data["categorie_id"] == 1)
				$dataAliment = $distribution->getListeAlimentFromRepartition($this->id);
			elseif ($data["categorie_id"] == 2)
				$dataAliment = $distribution->getListeAlimentFromRepartition($this->id, "juvenile");
			/*
			 * Recuperation des distributions prevues
			 */
			$dataDistrib = $distribution->calculDistribution($this->id);
			if ($data["categorie_id"] == 1) {
				$tableau = new RepartitionAdulte();
			} elseif ($data["categorie_id"] == 2) {
				$tableau = new RepartitionJuvenile();
			}
			$tableau->setData($data, $dataDistrib, $dataAliment);
			$tableau->exec();
		}
		}
	   function resteChange() {
		$this->vue->set($data = $this->dataclass->lireWithCategorie($this->id), "data");
		$this->vue->set("aliment/repartitionResteChange.tpl", "corps");
		/*
		 * preparation de la saisie des restes
		 */
		require_once "modules/classes/distribution.class.php";
		$distribution = new Distribution;
		$dataBassin = $distribution->getFromRepartition($this->id);

		/*
		 * Preparation du tableau de dates
		 */
		$dateDebut = DateTime::createFromFormat('d/m/Y', $data['date_debut_periode']);
		$dateFin = DateTime::createFromFormat('d/m/Y', $data["date_fin_periode"]);
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
		$total_distribue = 0;
		for ($i = 0; $i <= $nbJour; $i++) {
			$dateArray[$i]["libelle"] = $jour[$dateDebut->format("w")];
			$dateArray[$i]["numJour"] = $i;
			/*
			 * Calcul du total distribue
			 */
			$dateDebut->add(new DateInterval('P1D'));
		}
		$this->vue->set($dateArray, "dateArray");
		$this->vue->set($nbJour + 1, "nbJour");
		/*
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
		}
	   function resteWrite() {
		/*
		 * Ecriture de la saisie des restes
		 */
		if ($this->id > 0) {
			/*
			 * Traitement de chaque distribution
			 */
			/*
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
			require_once "modules/classes/distribution.class.php";
			$distribution = new Distribution;
			/*
			 * Traitement de chaque bassin
			 */
			foreach ($data as $key => $value) {
				$value["date_debut_periode"] = $_REQUEST["date_debut_periode"];
				$value["date_fin_periode"] = $_REQUEST["date_fin_periode"];
				$value["repartition_id"] = $_REQUEST["repartition_id"];
				/*
				 * On divise le total_distribue par le nombre de jours
				 */
				/*if ($_REQUEST ["nbJour"] > 0) {
					$value ["total_distribue"] = $value ["total_distribue"] / $_REQUEST ["nbJour"];
				}*/
				$this->idDistrib = $distribution->ecrireReste($value);
				if (!$this->idDistrib > 0) {
					$error = 1;
					$this->message->set($distribution->getErrorData(1));
				}
			}
			/*
			 * Traitement des erreurs potentielles
			 */
			if ($error == 1) {
				$this->message->set(_("Problème lors de l'enregistrement"), true);
				$module_coderetour = -1;
			} else {

				$this->message->set(_("Opération effectuée"));
				$module_coderetour = 1;
				$log->setLog($_SESSION["login"], get_class($this->dataclass) . "-write", $this->id);
			}
		}
		}
}
