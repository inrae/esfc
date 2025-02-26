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
 *  Creation 20 mars 2014
 */
require_once 'modules/classes/repartTemplate.class.php';
$this->dataclass = new RepartTemplate;
$keyName = "repart_template_id";
$this->id = $_REQUEST[$keyName];
	function list(){
$this->vue=service('Smarty');
		/*
		 * Display the list of all records of the table
		 */
		/*
		 * Gestion des variables de recherche
		 */
		if (!isset($_SESSION["searchRepartTemplate"])) {
			$_SESSION["searchRepartTemplate"] = new SearchRepartTemplate();
		}
		$_SESSION["searchRepartTemplate"]->setParam($_REQUEST);
		$dataSearch = $_SESSION["searchRepartTemplate"]->getParam();
		if ($_SESSION["searchRepartTemplate"]->isSearch() == 1) {
			$this->vue->set(1, "isSearch");
			$data = $this->dataclass->getListSearch($dataSearch);
		} else {
			$data = array();
		}
		$this->vue->set($dataSearch, "repartTemplateSearch");
		$this->vue->set($data, "data");
		$this->vue->set("aliment/repartTemplateList.tpl", "corps");
		/*
		 * Recherche de la categorie
		 */
		require_once "modules/classes/categorie.class.php";
		$categorie = new Categorie;
		$this->vue->set($categorie->getListe(2), "categorie");
		}
	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = $this->dataRead(, $this->id, "aliment/repartTemplateChange.tpl");
		/*
		 * Lecture des categories
		 */
		require_once "modules/classes/categorie.class.php";
		$categorie = new Categorie;
		$this->vue->set($categorie->getListe(2), "categorie");
		/*
		 * Recuperation des aliments associés
		 */
		if ($data["categorie_id"] > 0 && $this->id > 0) {
			require_once "modules/classes/repartAliment.class.php";
			$repartAliment = new RepartAliment;
			$this->vue->set($repartAliment->getFromTemplateWithAliment($this->id, $data["categorie_id"]), "dataAliment");
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
			 * Preparation des aliments
			 */
			$data = array();
			foreach ($_REQUEST as $key=>$value) {
				if (preg_match('/[0-9]+$/', $key, $val)) {
					$pos = strrpos($key, "_");
					$nom = substr($key, 0, $pos);
					$data[$val[0]][$nom] = $value;
				}
			}
			/*
			 * Mise en table
			 */
			require_once "modules/classes/repartAliment.class.php";
			$repartAliment = new RepartAliment;
			$error = 0;
			foreach ($data as  $value) {
				if ($value["repart_aliment_id"] > 0 || $value["repart_alim_taux"] > 0) {
					$value["repart_template_id"] = $this->id;
					$this->idRepart = $repartAliment->ecrire($value);
					if (!$this->idRepart > 0) {
						$error = 1;
						$this->message->set($repartAliment->getErrorData());
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
}
