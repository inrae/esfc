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
 *  Creation 11 mars 2015
 */

require_once 'modules/classes/echographie.class.php';
$this->dataclass = new Echographie;
$keyName = "echographie_id";
$this->id = $_REQUEST[$keyName];
if (isset($_SESSION["sequence_id"]))
	$this->vue->set($_SESSION["sequence_id"], "sequence_id");
$this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		require_once 'modules/classes/poissonCampagne.class.php';
		$poissonCampagne = new PoissonCampagne;
		$data = $this->dataRead( $this->id, "repro/echographieChange.tpl", $_REQUEST["poisson_id"]);
		$this->vue->set($poissonCampagne->lire($_REQUEST["poisson_campagne_id"]), "dataPoisson");
		/*
		 * Tables des stades
		 */
		require_once 'modules/classes/stadeGonade.class.php';
		require_once 'modules/classes/stadeOeuf.class.php';
		$stadeGonade = new StadeGonade;
		$stadeOeuf = new StadeOeuf;
		$this->vue->set($stadeGonade->getListe(1), "gonades");
		$this->vue->set($stadeOeuf->getListe(1), "oeufs");
		/*
		 * Gestion des documents associes
		 */
		$this->vue->set("echographieChange", "moduleParent");
		$this->vue->set("echographie", "parentType");
		$this->vue->set("echographie_id", "parentIdName");
		$this->vue->set($this->id, "parent_id");
		require_once "modules/classes/documentSturio.class.php";
		require_once 'modules/document/documentFunctions.php';
		$this->vue->set(getListeDocument("echographie", $this->id, $_REQUEST["document_limit"], $_REQUEST["document_offset"]), "dataDoc");

		}
	    function write() {
    try {
                        $this->id = $this->dataWrite($_REQUEST);
            $_REQUEST[$this->keyName] = $this->id;
            return true;
        } catch (PpciException $e) {
            return false;
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
