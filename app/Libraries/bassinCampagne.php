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
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 10 mars 2015
 */

require_once 'modules/classes/bassinCampagne.class.php';
$this->dataclass = new BassinCampagne;
$keyName = "bassin_campagne_id";
$this->id = $_REQUEST[$keyName];

	function display(){
$this->vue=service('Smarty');
		/*
		 * Display the detail of the record
		 */
		$data = $this->dataclass->lire($this->id);
		$this->vue->set($data, "dataBassinCampagne");
		$this->vue->set("repro/bassinCampagneDisplay.tpl", "corps");
		/*
		 * Recuperation des donnees du profil thermique
		 */
		require_once "modules/classes/profilThermique.class.php";
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
		require_once "modules/classes/salinite.class.php";
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
		require_once 'modules/classes/bassin.class.php';
		$bassin = new Bassin;
		$this->vue->set($bassin->lire($data["bassin_id"]), "dataBassin");
		/*
		 * Recuperation de la liste des poissons presents
		 */
		require_once 'modules/classes/transfert.class.php';
		$transfert = new Transfert;
		$this->vue->set($transfert->getListPoissonPresentByBassin($data["bassin_id"]), "dataPoisson");
		/*
		 * Calcul de la date du jour
		 */
		$this->vue->set(date("d/m/Y"), "dateJour");
		/*
		 * Recuperation des evenements
		*/
		require_once "modules/classes/bassinEvenement.class.php";
		$bassinEvenement = new BassinEvenement;
		$this->vue->set($bassinEvenement->getListeByBassin($data["bassin_id"]), "dataBassinEvnt");
		$this->vue->set($_SESSION["bassinParentModule"], "bassinParentModule");
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
	   function init() {
		/*
		 * Initialisation des bassins pour la campagne
		 */
		if ($_REQUEST["annee"] > 0) {
			$nb = $this->dataclass->initCampagne($_REQUEST["annee"]);
			$this->message->set(sprintf(_("%s bassin(s) ajouté(s) à la campagne de reproduction"), $nb));
		}
		$module_coderetour = 1;
}
