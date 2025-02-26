<?php 
namespace App\Libraries;

use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class  extends PpciLibrary { 
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    private $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ;
        $this->keyName = "";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 25 févr. 2014
 */
require_once 'modules/classes/poisson.class.php';
$this->dataclass = new Poisson;
$keyName = "poisson_id";
$this->id = $_REQUEST[$keyName];

	function list(){
$this->vue=service('Smarty');
		require "modules/poisson/poissonSearch.php";
		if ($_SESSION["searchPoisson"]->isSearch() == 1) {
			$data = $this->dataclass->getListeSearch($dataSearch);
			$this->vue->set($data, "data");
		}
		$_SESSION["poissonDetailParent"] = "poissonList";
		$this->vue->set("poisson/poissonList.tpl", "corps");
		}
	function display(){
$this->vue=service('Smarty');
		/*
		 * Display the detail of the record
		 */
		$data = $this->dataclass->getDetail($this->id);
		$this->vue->set($data, "dataPoisson");
		/*
		 * Passage en parametre de la liste parente
		 */
		$this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
		$classes = array(
			"evenement",
			"categorie",
			"poissonStatut",
			"morphologie",
			"genderSelection",
			"pathologie",
			"pittag",
			"transfert",
			"mortalite",
			"cohorte",
			"sortie",
			"echographie",
			"anesthesie",
			"ventilation",
			"poissonCampagne",
			"dosageSanguin",
			"genetique",
			"parente",
			"lot",
			"vieModele",
			"sexe",
			"pittagType",
			"anomalie",
			"parentPoisson"
		);
		foreach ($classes as $classe) {
			require_once "modules/classes/$classe.class.php";
		}
		/*
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
		/*
		 * Recuperation des événements
		 */
		$evenement = new Evenement;
		$this->vue->set($evenement->getEvenementByPoisson($this->id), "dataEvenement");
		/*
		 * Recuperation du sexage
		 */
		$gender_selection = new GenderSelection;
		$this->vue->set($gender_selection->getListByPoisson($this->id), "dataGender");
		/*
		 * Recuperation des pathologies
		 */
		$pathologie = new Pathologie;
		$this->vue->set($pathologie->getListByPoisson($this->id), "dataPatho");
		/*
		 * Recuperation des pittag
		 */
		$pittag = new Pittag;
		$this->vue->set($pittag->getListByPoisson($this->id), "dataPittag");
		/*
		 * Recuperation des transferts
		 */
		$transfert = new Transfert;
		$this->vue->set($transfert->getListByPoisson($this->id), "dataTransfert");
		/*
		 * Recuperation des mortalites
		 */
		$mortalite = new Mortalite;
		$this->vue->set($mortalite->getListByPoisson($this->id), "dataMortalite");
		/*
		 * Recuperation des cohortes
		 */
		$cohorte = new Cohorte;
		$this->vue->set($cohorte->getListByPoisson($this->id), "dataCohorte");
		/*
		 * Recuperation des parents
		 */
		$parent = new ParentPoisson;
		$this->vue->set($parent->getListParent($this->id), "dataParent");
		/*
		 * Recuperation des anomalies
		 */
		$anomalie = new Anomalie_db;
		$this->vue->set($anomalie->getListByPoisson($this->id), "dataAnomalie");
		/*
		 * Recuperation des sorties
		 */
		$sortie = new Sortie;
		$this->vue->set($sortie->getListByPoisson($this->id), "dataSortie");
		/*
		 * Recuperation des echographies
		 */
		$echographie = new Echographie;
		$this->vue->set($echographie->getListByPoisson($this->id), "dataEcho");
		/*
		 * Recuperation des anesthesies
		 */
		$anesthesie = new Anesthesie;
		$this->vue->set($anesthesie->getListByPoisson($this->id), "dataAnesthesie");
		/*
		 * Recuperation des mesures de ventilation
		 */
		$ventilation = new Ventilation;
		$this->vue->set($ventilation->getListByPoisson($this->id), "dataVentilation");
		/*
		 * Recuperation des campagnes de reproduction
		 */
		$poissonCampagne = new PoissonCampagne;
		$this->vue->set($poissonCampagne->getListFromPoisson($this->id), "dataRepro");
		/*
		 * Recuperation des dosages sanguins
		 */
		$dosageSanguin = new DosageSanguin;
		$this->vue->set($dosageSanguin->getListeFromPoisson($this->id), "dataDosageSanguin");

		/*
		 * Recuperation des prelevements genetiques
		 */
		$genetique = new Genetique;
		$this->vue->set($genetique->getListByPoisson($this->id), "dataGenetique");

		/*
		 * Recuperation des determinations de parente
		 */
		$parente = new Parente;
		$this->vue->set($parente->getListByPoisson($this->id), "dataParente");

		/**
		 * Calcul du cumul de température sur l'année écoulée
		 */
		$dateStart = new DateTime();
		$dateStart->modify("-1 year");
		$this->vue->set(
			$this->dataclass->calcul_temperature($this->id, $dateStart->format($_SESSION["MASKDATE"]), date($_SESSION["MASKDATE"])),
			"cumulTemp"
		);

		/*
		 * Gestion des documents associes
		 */
		$this->vue->set("poissonDisplay", "moduleParent");
		$this->vue->set("poisson", "parentType");
		$this->vue->set("poisson_id", "parentIdName");
		$this->vue->set($this->id, "parent_id");
		require_once 'modules/document/documentFunctions.php';
		$this->vue->set(getListeDocument("poisson", $this->id, $_REQUEST["document_limit"], $_REQUEST["document_offset"]), "dataDoc");
		/*
		 * Affichage
		 */
		$this->vue->set("poisson/poissonDisplay.tpl", "corps");
		/*
		 * Module de retour au poisson
		 */
		$_SESSION["poissonParent"] = "poissonDisplay";
		}
	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$classes = array(
			"poissonStatut",
			"sexe",
			"categorie",
			"vieModele",
			"pittagType",
			"pittag"
		);
		foreach ($classes as $classe) {
			require_once "modules/classes/$classe.class.php";
		}
		$data = $this->dataRead( $this->id, "poisson/poissonChange.tpl");
		$sexe = new Sexe;
		$this->vue->set($sexe->getListe(1), "sexe");
		$poissonStatut = new Poisson_statut;
		$this->vue->set($poissonStatut->getListe(1), "poissonStatut");
		$categorie = new Categorie;
		$this->vue->set($categorie->getListe(1), "categorie");

		/*
		 * Modeles de marquages VIE, pour creation a partir des juveniles
		 */
		$vieModele = new VieModele;
		$this->vue->set($vieModele->getAllModeles(), "modeles");
		/*
		 * Passage en parametre de la liste parente
		 */
		$this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");

		/*
		 * Recuperation de la liste des types de pittag
		 */
		$pittagType = new Pittag_type;
		$this->vue->set($pittagType->getListe(2), "pittagType");
		/*
		 * Recuperation du dernier pittag connu
		 */
		$pittag = new Pittag;
		$this->vue->set($pittag->getListByPoisson($this->id, 1), "dataPittag");
		}
	    function write() {
    try {
                        $this->id = $this->dataWrite($_REQUEST);
            $_REQUEST[$this->keyName] = $this->id;
            return true;
        } catch (PpciException $e) {
            return false;
        }
            
		/*
		 * write record in database
		 */
		$this->id = dataWrite($this->dataclass, $_REQUEST);
		if ($this->id > 0) {
			$_REQUEST[$keyName] = $this->id;
			/*
			 * Ecriture du pittag
			 */
			if (!empty($_REQUEST["pittag_valeur"])) {
				require_once "modules/classes/pittag.class.php";
				$pittag = new Pittag;
				$this->idPittag = $pittag->ecrire($_REQUEST);
				if (!$this->idPittag > 0) {
					$module_coderetour = -1;
					$this->message->set($pittag->getErrorData(), true);
				}
			}
		}
		}
	   function delete() {
		/*
		 * delete record
		 */
		try {
			$bdd->beginTransaction();
			$ret = $this->dataDelete( $this->id, true);
			if ($ret) {
				$bdd->commit();
				$module_coderetour = 1;
			} else {
				$bdd->rollback();
				$this->message->set($this->dataclass->getErrorData(1), true);
			}
		} catch (Exception $e) {
			$module_coderetour = -1;
			$bdd->rollback();
		}
		}
	   function getListeAjaxJson() {
		/*
		 * retourne la liste des poissons a partir du libelle fourni
		 * au format JSON, en mode Ajax
		 */
		if (!empty($_REQUEST["libelle"])) {
			$this->vue->set($this->dataclass->getListPoissonFromName($_REQUEST["libelle"]));
		}
		}
	   function getPoissonFromTag() {
		if (!empty($_POST["newtag"])) {
			$poissonId = $this->dataclass->getPoissonIdFromTag($_POST["newtag"]);
			if ($poissonId > 0) {
				$_REQUEST["poisson_id"] = $poissonId;
				$module_coderetour = 1;
			} else {
				$this->message->set(sprintf(_("Aucun poisson ne correspond au pittag %s"), $_POST["newtag"]), true);
				$module_coderetour = -1;
			}
		}
		}
}
