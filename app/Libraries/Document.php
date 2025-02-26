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
 *  Creation 7 avr. 2014
 */
require_once 'modules/classes/documentSturio.class.php';
require_once 'modules/document/documentFunctions.php';
$this->dataclass = new DocumentSturio;
$keyName = "document_id";
$this->id = $_REQUEST[$keyName];
$vars = array("moduleParent", "parentType", "parentIdName", "parent_id", "document_limit", "document_offset");


	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$this->dataRead( $this->id, "document/documentChange.tpl");
		foreach ($vars as $var) {
			$this->vue->set($_REQUEST[$var], $var);
		}
		}
	   function changeData() {
		$this->dataRead( $this->id, "document/documentChangeData.tpl");
		foreach ($vars as $var) {
			$this->vue->set($_REQUEST[$var], $var);
		}
		$this->vue->set($_REQUEST["parent_id"], $_REQUEST["parentIdName"]);
		}
	   function writeData() {
		/*
		 * Retour au module initial
		 */
		$this->dataclass->writeData($_REQUEST);
		$module_coderetour = 1;
		$t_module["retourok"] = $_REQUEST['moduleParent'];
		$_REQUEST[$_REQUEST["parentIdName"]] = $_REQUEST["parent_id"];
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
		if (!empty($_REQUEST["parentType"])) {
			/*
			 * Preparation de files
			 */
			try {
				$files = formatFiles();
				foreach ($files as $file) {
					$this->id = $this->dataclass->ecrire($file, $_REQUEST["document_description"], $_REQUEST["document_date_creation"]);
					if ($this->id > 0) {
						$_REQUEST[$keyName] = $this->id;
						/**
						 * Ecriture de l'enregistrement en table liee
						 */
						require_once "modules/classes/documentLie.class.php";
						$documentLie = new DocumentLie($bdd, $ObjetBDDParam, $_REQUEST["parentType"]);
						$data = array(
							"document_id" => $this->id,
							$_REQUEST["parentIdName"] => $_REQUEST["parent_id"]
						);
						$documentLie->ecrire($data);
					}
				}
			} catch (DocumentException $e) {
				$this->message->set($e->getMessage(), true);
			}
			$log->setLog($_SESSION["login"], get_class($this->dataclass) . "-write", $this->id);
		}
		/*
		 * Retour au module initial
		 */
		$module_coderetour = 1;
		$t_module["retourok"] = $_REQUEST['moduleParent'];
		$_REQUEST[$_REQUEST["parentIdName"]] = $_REQUEST["parent_id"];
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
		/*
		 * Retour au module initial
		*/
		$t_module["retoursuppr"] = $_REQUEST['moduleParent'];
		$t_module["retourok"] = $_REQUEST['moduleParent'];
		$t_module["retourko"] = $_REQUEST['moduleParent'];
		$_REQUEST[$_REQUEST["parentIdName"]] = $_REQUEST["parent_id"];
		}
	   function get() {
		/*
		 * Envoie vers le navigateur le document
		 */
		$_REQUEST["attached"] = 1 ? $attached = true : $attached = false;
		$this->dataclass->documentSent($this->id, $_REQUEST["phototype"], $attached);
		}
}
