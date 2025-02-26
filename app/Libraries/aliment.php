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
 *  Creation 19 mars 2014
 */
require_once 'modules/classes/aliment.class.php';
$this->dataclass = new Aliment ( $bdd, $ObjetBDDParam );
$keyName = "aliment_id";
$this->id = $_REQUEST [$keyName];
switch ($t_module ["param"]) {
	function list(){
$this->vue=service('Smarty');
		/*
		 * Display the list of all records of the table
		 */
		$this->vue->set( $this->dataclass->getListe ( 2 ), "data");
		$this->vue->set( "aliment/alimentList.tpl", "corps"); 
		}
	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead ( $this->dataclass, $this->id, "aliment/alimentChange.tpl" );
		/*
		 * Recuperation des types d'aliment
		 */
		require_once "modules/classes/alimentType.class.php";
		$alimentType = new AlimentType ( $bdd, $ObjetBDDParam );
		$this->vue->set( $alimentType->getListe ( 1 ) , "alimentType");
		/*
		 * Recuperation des categories
		 */
		require_once "modules/classes/categorie.class.php";
		$categorie = new Categorie ( $bdd, $ObjetBDDParam );
		$dataCategorie = $categorie->getListe ( 2 );
		/*
		 * Recuperation des categories actuellement associees
		 */require_once "modules/classes/alimentCategorie.class.php";
		$alimentCategorie = new AlimentCategorie ( $bdd, $ObjetBDDParam );
		$dataAC = $alimentCategorie->getListeFromAliment ( $this->id );
		/*
		 * Assignation de la valeur recuperee aux categories
		 */
		foreach ( $dataCategorie as $key => $value ) {
			foreach ( $dataAC as $key1 => $value1 ) {
				if ($value1 ["categorie_id"] == $value ["categorie_id"])
					$dataCategorie [$key] ["checked"] = 1;
			}
		}
		$this->vue->set($dataCategorie , "categorie"); 
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
		$this->id = dataWrite ( $this->dataclass, $_REQUEST );
		if ($this->id > 0) {
			$_REQUEST [$keyName] = $this->id;
		}	
		}
	   function delete() {
		/*
		 * delete record
		 */
		dataDelete ( $this->dataclass, $this->id );
		}
}
