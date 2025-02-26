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
 *  Creation 11 mars 2014
 */
require_once 'modules/classes/analyseEau.class.php';
$this->dataclass = new AnalyseEau;
$keyName = "analyse_eau_id";
$this->id = $_REQUEST[$keyName];
if (!isset($_SESSION["searchCircuitEau"])) {
	$_SESSION["searchCircuitEau"] = new SearchCircuitEau();
}

	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = $this->dataRead(, $this->id, "bassin/analyseEauChange.tpl", $_REQUEST["circuit_eau_id"]);
		/*
		 * Lecture des donnees concernant le circuit d'eau
		 */
		require_once "modules/classes/circuitEau.class.php";
		$circuitEau = new CircuitEau;
		$this->vue->set($circuitEau->lire($_REQUEST["circuit_eau_id"]) , "dataCircuitEau");
		/*
		 * Lecture des laboratoires
		 */
		require_once "modules/classes/laboratoireAnalyse.class.php";
		$laboratoireAnalyse = new LaboratoireAnalyse;
		$this->vue->set( $laboratoireAnalyse->getListeActif(), "laboratoire");
		/*
		 * Forcage de la date de reference (date de recherche) si creation d'un nouvel enregistrement
		 */
		if ($this->id == 0) {
			$dataSearch = $_SESSION["searchCircuitEau"]->getParam();
			$data["analyse_eau_date"] = $dataSearch["analyse_date"];
			$this->vue->set( $data, "data");
		}
		$this->vue->set( $_REQUEST["origine"], "origine");
		/*
		 * Recuperation des analyses de metaux
		 */
		$dataMetal = array();
		if ($this->id > 0) {
			require_once "modules/classes/analyseMetal.class.php";
			$analyseMetal = new AnalyseMetal;
			$dataMetal = $analyseMetal->getListeFromAnalyse($this->id);
		}
		/*
		 * Recuperation de la liste des metaux non analyses, mais actifs
		 */
		require_once "modules/classes/metal.class.php";
		$metal = new Metal;
		$newMetal = $metal->getListActifInconnu($dataMetal);
		foreach ($newMetal as $value) {
			$dataMetal[] = array(
				"metal_id" => $value["metal_id"],
				"metal_nom" => $value["metal_nom"],
				"metal_unite" => $value["metal_unite"]
			);
		}
		$this->vue->set($dataMetal , "dataMetal");
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
			/*
			 * Ecriture des donnees concernant les analyses de metaux
			 */
			require_once "modules/classes/analyseMetal.class.php";
			$analyseMetal = new AnalyseMetal;
			$analyseMetal->ecrireGlobal($_REQUEST, $this->id);
			$_REQUEST[$keyName] = $this->id;
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
	   function graph() {
		/**
		 * Visualisation sous forme de graphique des analyses d'eau
		 */
		require_once "modules/classes/circuitEau.class.php";
		$circuitEau = new CircuitEau;
		if ($_REQUEST["circuit_eau_id"] == 0) {
			$circuits = $circuitEau->getListeSearch(array("circuit_eau_actif" => 1, "site_id" => $_SESSION["site_id"]));
		} else {
			$circuits[] = $circuitEau->lire($_REQUEST["circuit_eau_id"]);
		}
		/**
		 * Preparation des donnees
		 */
		if (isset($_REQUEST["date_from"]) && isset($_REQUEST["date_to"])) {
			$max = date_create_from_format("d/m/Y", $_REQUEST["date_from"]);
			$min = date_create_from_format("d/m/Y", $_REQUEST["date_to"]);
			$graph = array("bindto" => "#graph");
			$graph["axis"]["x"] = array(
				"type" => "timeseries",
				"tick" => array(
					"format" => "%d/%m/%Y %H:%M:%S",
					/*"fit" => "true",*/
					"rotate" => 45,
					/*"count" => 30*/
				),
				"min" => $_REQUEST["date_from"] . " 00:00:00",
				"max" => $_REQUEST["date_to"] . " 23:59:59"
			);
			$graph["axis"]["y"] = array("min" => 0);
			$graph["data"]["xFormat"] = "%d/%m/%Y %H:%M:%S";
			$i = 1;
			foreach ($circuits as $circuit) {
				$serie = array();
				$dates = array();
				$serie[] = $circuit["circuit_eau_libelle"];
				$dates[] = "x" . $i;
				$data = $this->dataclass->getValFromDatesCircuit($circuit["circuit_eau_id"], $_REQUEST["date_from"], $_REQUEST["date_to"], $_REQUEST["attribut"]);
				foreach ($data as $val) {
					if (strlen($val[$_REQUEST["attribut"]] > 0)) {
						$dates[] = $val["analyse_eau_date"];
						$serie[] = $val[$_REQUEST["attribut"]];
						$ldate = date_create_from_format("d/m/Y h:i:s", $val["analyse_eau_date"]);
						if ($ldate) {
							if ($ldate < $min) {
								$min = $ldate;
							}
							if ($ldate > $max) {
								$max = $ldate;
							}
						}
					}
				}
				if (count($dates) > 1) {
					$graph["data"]["xs"][$circuit["circuit_eau_libelle"]] = "x" . $i;
					$graph["data"]["types"][$circuit["circuit_eau_libelle"]] = "line";
					$graph["data"]["columns"][] = $dates;
					$graph["data"]["columns"][] = $serie;
				}
				$i++;
			}
			$graph["axis"]["x"]["min"] = $min->format("d/m/Y") . " 00:00:00";
			$graph["axis"]["x"]["max"] = $max->format("d/m/Y") . " 23:59:59";
			$this->vue->set( base64_encode(json_encode($graph, JSON_NUMERIC_CHECK | JSON_UNESCAPED_SLASHES)), "graph");
		}
		/**
		 * Reaffectation des valeurs par defaut
		 */
		if (!isset($_REQUEST["date_from"])) {
			$date_to = date("d/m/Y");
			$date_from = date("d/m/Y", strtotime('-1 month', time()));
			$this->vue->set( $date_from, "date_from");
			$this->vue->set( $date_to, "date_to");
			$this->vue->set( "temperature", "attribut");
		} else {
			$this->vue->set( $_REQUEST["date_from"], "date_from");
			$this->vue->set( $_REQUEST["date_to"], "date_to");
			$this->vue->set($_REQUEST["attribut"] , "attribut");
		}
		$attributs = array(
			"temperature" => _("Température"),
			"o2_pc" => _("% O2"),
			"salinite" => _("Salinité"),
			"ph" => _("pH"),
			"nh4" => _("Oxyde d'ammoniac NH4+"),
			'n_nh4' => _("Azote ammoniacal N-NH4"),
			"no2" => _("Oxyde nitrite NO2"),
			"n_no2" => _("Ion nitrite N-NO2"),
			"no3" => _("Oxyde nitrate NO3"),
			"n_no3" => _("Ion nitrate N-NO3")
		);
		$this->vue->set($attributs , "attributs");
		$this->vue->set("bassin/analyseGraph.tpl" , "corps");
		/**
		 * recherche des circuits d'eau
		 */
		$this->vue->set($_REQUEST["circuit_eau_id"] , "circuit_eau_id");
		$this->vue->set( $circuitEau->getListeSearch(array("site_id"=>$_SESSION["site_id"])), "circuits");

		require_once 'modules/classes/site.class.php';
		$site = new Site;
		$this->vue->set( $site->getListe(2), "site");
		}
}
