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
 *  Creation 4 mars 2014
 *  Code integre dans chaque page necessitant de recuperer les parametres associes a un bassin (selection, modification, etc.)
 */
require_once 'modules/classes/bassinType.class.php';
$bassin_type = new Bassin_type;
$this->vue->set( $bassin_type->getListe(2) , "bassin_type");
require_once "modules/classes/bassinUsage.class.php";
$bassin_usage = new Bassin_usage;
$this->vue->set( $bassin_usage->getListe(2), "bassin_usage");
require_once "modules/classes/bassinZone.class.php";
$bassin_zone = new Bassin_zone;
$this->vue->set($bassin_zone->getListe(2) , "bassin_zone");
require_once "modules/classes/circuitEau.class.php";
$circuit_eau = new CircuitEau;
$this->vue->set($circuit_eau->getListe(2) , "circuit_eau");
