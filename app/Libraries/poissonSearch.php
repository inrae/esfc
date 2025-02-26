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
 *  Creation 25 févr. 2014
 *  code permettant de preparer l'affichage de la fenetre de recherche des poissons
 *  a utiliser avec la commande : require "modules/poisson/poissonSearch.php"
 */
/*
 * Gestion des variables de recherche
 */
if (!isset($_SESSION["searchPoisson"])) {
	$_SESSION["searchPoisson"] = new SearchPoisson();
}
$this->vue->set($_SESSION["searchPoisson"]->getSearchByEvent(), "eventSearchs");
$_SESSION["searchPoisson"]->setParam($_REQUEST);
$dataSearch = $_SESSION["searchPoisson"]->getParam();
if ($_SESSION["searchPoisson"]->isSearch() == 1) {
	$this->vue->set(1, "isSearch");
}
$this->vue->set($dataSearch, "poissonSearch");
/*
 * Integration des tables necessaires pour la  recherche
 */
require_once "modules/classes/sexe.class.php";
$sexe = new Sexe;
$this->vue->set($sexe->getListe(1), "sexe");
require_once "modules/classes/poissonStatut.class.php";
$poisson_statut = new Poisson_statut;
$this->vue->set($poisson_statut->getListe(1), "statut");
require_once "modules/classes/categorie.class.php";
$categorie = new Categorie;
$this->vue->set($categorie->getListe(1), "categorie");
require_once 'modules/classes/site.class.php';
$site = new Site;
$this->vue->set($site->getListe(2), "site");
require_once "modules/classes/bassin.class.php";
$bassin = new Bassin;
$dataSearch["site_id"] > 0 ? $site_id = $dataSearch["site_id"] : $site_id = 0;
$this->vue->set($bassin->getListBassin($site_id), "bassins");
$this->vue->set($this->dataclass->getListCohortes(),"cohortes");
