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
 *  Creation 3 mars 2014
 *  code permettant de preparer l'affichage de la fenetre de recherche des bassins
 *  a utiliser avec la commande : require "modules/bassin/bassinSearch.php"
 */
/*
 * Gestion des variables de recherche
*/
if(!isset($_SESSION["searchBassin"])) {
	$_SESSION["searchBassin"] = new SearchBassin();
}
$_SESSION["searchBassin"]->setParam ( $_REQUEST );
$dataSearch = $_SESSION["searchBassin"]->getParam ();
if ($_SESSION["searchBassin"]->isSearch () == 1) {
	$this->vue->set(1 , "isSearch"); 
}
$this->vue->set( $dataSearch, "bassinSearch"); 
/*
 * Integration des tables necessaires pour la  recherche
*/
require 'modules/bassin/bassinParamAssocie.php';
$_SESSION["bassinParentModule"] = "bassinListniv2";
require_once 'modules/classes/site.class.php';
