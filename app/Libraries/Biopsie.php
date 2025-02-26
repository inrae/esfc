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
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 6 mars 2015
 */
require_once 'modules/classes/biopsie.class.php';
$this->dataclass = new Biopsie;
$keyName = "biopsie_id";
$this->id = $_REQUEST[$keyName];
if (isset($this->vue)) {
	if (isset($_SESSION["sequence_id"])) {
		$this->vue->set($_SESSION["sequence_id"], "sequence_id");
	}
	$this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
}
	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		require_once 'modules/classes/poissonCampagne.class.php';
		$poissonCampagne = new poissonCampagne;
		$data = $this->dataRead( $this->id, "repro/biopsieChange.tpl", $_REQUEST["poisson_campagne_id"]);
		$this->vue->set($poissonCampagne->lire($data["poisson_campagne_id"]), "dataPoisson");
		/*
		 * Recuperation des methodes de calcul
		 */
		require_once "modules/classes/biopsieTechniqueCalcul.class.php";
		$biopsieTechniqueCalcul = new BiopsieTechniqueCalcul;
		$this->vue->set($biopsieTechniqueCalcul->getListe(1), "techniqueCalcul");
		/*
		 * Gestion des documents associes
		 */
		$this->vue->set("biopsieChange", "moduleParent");
		$this->vue->set("biopsie", "parentType");
		$this->vue->set("biopsie_id", "parentIdName");
		$this->vue->set($this->id, "parent_id");
		require_once 'modules/document/documentFunctions.php';
		$this->vue->set(getListeDocument("biopsie", $this->id, $_REQUEST["document_limit"], $_REQUEST["document_offset"]), "dataDoc");
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
		 * Traitement des photos a importer
		 */
		if ($this->id > 0 && !empty($_FILES["documentName"])) {
			/*
			 * Preparation de files
			 */
			$files = array();
			$fdata = $_FILES['documentName'];
			if (is_array($fdata['name'])) {
				for ($i = 0; $i < count($fdata['name']); ++$i) {
					$files[] = array(
						'name' => $fdata['name'][$i],
						'type' => $fdata['type'][$i],
						'tmp_name' => $fdata['tmp_name'][$i],
						'error' => $fdata['error'][$i],
						'size' => $fdata['size'][$i]
					);
				}
			} else {
				$files[] = $fdata;
			}
			if ($files[0]["error"] == 0) {
				require_once "modules/classes/documentSturio.class.php";
				$documentSturio = new DocumentSturio;
				require_once "modules/classes/documentLie.class.php";
				$documentLie = new DocumentLie($bdd, $ObjetBDDParam, 'biopsie');
				foreach ($files as $file) {
					$document_id = $documentSturio->ecrire($file, _("Calcul du diamètre moyen de l'ovocyte - ") . $_REQUEST["biopsie_date"]);
					if ($document_id > 0) {
						/*
					 * Ecriture de l'enregistrement en table liee
					 */
						$data = array(
							"document_id" => $document_id,
							"biopsie_id" => $this->id
						);
						$documentLie->ecrire($data);
						/*
					 * Ajout de l'information pour le poisson
					 */
						$documentPoisson = new DocumentLie($bdd, $ObjetBDDParam, "poisson");
						$data["poisson_id"] = $this->dataclass->getPoissonId($this->id);
						$documentPoisson->ecrire($data);
					}
				}
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
