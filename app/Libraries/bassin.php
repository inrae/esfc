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
 *  Creation 4 mars 2014
 */
require_once 'modules/classes/bassin.class.php';
$this->dataclass = new Bassin;
$keyName = "bassin_id";
if (isset($_REQUEST[$keyName])) {
	$this->id = $_REQUEST[$keyName];
} elseif (isset($_SESSION["bassin_id"])) {
	$this->id = $_SESSION["bassin_id"];
} else
	$this->id = -1;

	function list(){
$this->vue=service('Smarty');
		/*
		 * Display the list of all records of the table
		 */
		require "modules/bassin/bassinSearch.php";
		if ($_SESSION["searchBassin"]->isSearch() == 1) {
			$this->vue->set($this->dataclass->getListeSearch($dataSearch), "data");
		}
		/*
		 * Preparation des dates pour la generation du recapitulatif des aliments
		 */
		!isset($_REQUEST["dateFin"]) ? $dateFin = date("d/m/Y") : $dateFin = $_REQUEST["dateFin"];
		!isset($_REQUEST["dateDebut"]) ? $dateDebut = date("d/m/") . (date("Y") - 1) : $dateDebut = $_REQUEST["dateDebut"];
		$this->vue->set($dateDebut, "dateDebut");
		$this->vue->set($dateFin, "dateFin");
		$this->vue->set("bassin/bassinList.tpl", "corps");
		$_SESSION["bassinParentModule"] = "bassinList";
		require_once "modules/classes/site.class.php";
		$site = new Site;
		$this->vue->set($site->getListe(2), "site");
		}
	function display(){
$this->vue=service('Smarty');
		/*
		 * Display the detail of the record
		 */
		$data = $this->dataclass->getDetail($this->id);
		$this->vue->set($data, "dataBassin");
		/*
		 * Recuperation de la liste des poissons presents
		 */
		require_once 'modules/classes/transfert.class.php';
		$transfert = new Transfert;
		$this->vue->set($transfert->getListPoissonPresentByBassin($this->id), "dataPoisson");
		/*
		 * Recuperation des evenements
		 */
		require_once "modules/classes/bassinEvenement.class.php";
		$bassinEvenement = new BassinEvenement;
		$this->vue->set($bassinEvenement->getListeByBassin($this->id), "dataBassinEvnt");
		/*
		 * Recuperation des aliments consommés sur la période déterminée
		 */
		require_once 'modules/classes/distribQuotidien.class.php';
		$distribQuotidien = new DistribQuotidien;
		/*
		 * Dates de recherche
		 */
		if (!isset($_SESSION["searchAlimentation"])) {
			$_SESSION["searchAlimentation"] = new SearchAlimentation();
		}
		$_SESSION["searchAlimentation"]->setParam($_REQUEST);
		$param = $_SESSION["searchAlimentation"]->getParam();
		$this->vue->set($param, "searchAlim");
		$this->vue->set($distribQuotidien->getListeConsommation($this->id, $param["date_debut"], $param["date_fin"]), "dataAlim");
		$this->vue->set($distribQuotidien->alimentListe, "alimentListe");
		/*
		 * Gestion des documents associes
		 */
		$this->vue->set("bassinDisplay", "moduleParent");
		$this->vue->set("bassin", "parentType");
		$this->vue->set("bassin_id", "parentIdName");
		$this->vue->set($this->id, "parent_id");
		require_once 'modules/document/documentFunctions.php';
		$this->vue->set(getListeDocument("bassin", $this->id, $_REQUEST["document_limit"], $_REQUEST["document_offset"]), "dataDoc");
		/**
		 * Ajout des informations pour le transfert des poissons
		 */
		include_once "modules/classes/evenementType.class.php";
		$eventType = new Evenement_type;
		$this->vue->set($eventType->getListe("evenement_type_actif desc, evenement_type_libelle"), "evntType");
		$dataBassin["site_id"] > 0 ? $siteId = $dataBassin["site_id"] : $siteId = 0;
		$this->vue->set($this->dataclass->getListBassin($siteId, 1), "bassinListActif");
		$this->vue->set(date($_SESSION["MASKDATE"]), "currentDate");
		/*
		 * Affichage
		 */
		$this->vue->set("bassin/bassinDisplay.tpl", "corps");
		$this->vue->set($_SESSION["bassinParentModule"], "bassinParentModule");
		$_SESSION["poissonDetailParent"] = "bassinDisplay";
		$_SESSION["bassin_id"] = $this->id;
		}
	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$this->dataRead(, $this->id, "bassin/bassinChange.tpl");
		/*
		 * Integration des tables de parametres
		 */
		require 'modules/bassin/bassinParamAssocie.php';
		$this->vue->set($_SESSION["bassinParentModule"], "bassinParentModule");
		require_once 'modules/classes/site.class.php';
		$site = new Site;
		$this->vue->set($site->getListe(2), "site");
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
	   function calculMasseAjax() {
		require_once 'modules/classes/poisson.class.php';
		if ($_REQUEST["bassin_id"] > 0) {
			$masse = $this->dataclass->calculMasse($_REQUEST["bassin_id"]);
			$this->vue->set(array("val" => $masse));
		}
		}
	   function recapAlim() {
		$this->vue->set($this->dataclass->getRecapAlim($_REQUEST, $_SESSION["searchBassin"]->getParam()));
		}
	   function bassinPoissonTransfert() {
		include_once "modules/classes/evenement.class.php";
		include_once "modules/classes/transfert.class.php";
		$event = new Evenement;
		$transfert = new Transfert;
		try {
			$bdd->beginTransaction();
			$nb = 0;
			$data = [
				"evenement_id"=>0,
				"evenement_type_id"=>$_POST["evenement_type_id"],
				"evenement_date"=>$_POST["evenement_date"],
				"commentaire" => $_REQUEST["commentaire"],
				"bassin_origine" =>$_POST["bassin_origine"],
				"bassin_destination"=>$_POST["bassin_destination"],
				"transfert_date"=>$_POST["evenement_date"],
				"transfert_id"=>0
			];
		foreach($_POST["poissons"] as $poisson_id) {
			$data["poisson_id"] = $poisson_id;
			$data["evenement_id"] = $event->ecrire($data);
			$transfert->ecrire($data);
			$data["evenement_id"] = 0;
			$nb ++;
		}
		$bdd->commit();
		$this->message->set(sprintf(_("%s poissons transférés"), $nb));
		$module_coderetour = 1;
		} catch (Exception $e) {
			$bdd->rollback();
			$this->message->set("{t}Une erreur est survenue pendant le transfert des poissons", true);
			$this->message->set($e->getMessage());
			$this->message->setSyslog($e->getMessage());
			$module_coderetour = -1;
		}
		}
}
