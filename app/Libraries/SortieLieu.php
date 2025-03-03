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
    public $keyName;

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
 *  Creation 16 avr. 2014
 *  gestion de la table sortie_lieu
 */
require_once 'modules/classes/sortieLieu.class.php';
$this->dataclass = new SortieLieu;
$keyName = "sortie_lieu_id";
$this->id = $_REQUEST[$keyName];
	function list(){
$this->vue=service('Smarty');
		/**
		 * Display the list of all records of the table
		 */
		$this->vue->set($this->dataclass->getListeActif(), "data");
		$this->vue->set("parametre/sortieLieuList.tpl", "corps");
		}
	function change(){
$this->vue=service('Smarty');
		/**
		 * Lecture des statuts de poissons
		 */
		require_once "modules/classes/poissonStatut.class.php";
		$poissonStatut = new Poisson_statut;
		$this->vue->set($poissonStatut->getListe(1), "poissonStatut");
		$this->dataRead( $this->id, "parametre/sortieLieuChange.tpl");
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
		/**
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
