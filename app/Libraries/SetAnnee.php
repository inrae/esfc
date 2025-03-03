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
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 1 avr. 2015
 *  
 *  Initialise l'annee ou recupere l'annee saisie pour utilisation dans les modules de repro
 */
if ($_REQUEST["annee"] > 0) {
	$_SESSION["annee"] = $_REQUEST["annee"];
}

if (!isset($_SESSION["annees"])) {
	require_once 'modules/classes/poissonCampagne.class.php';
	$poissonCampagne = new PoissonCampagne;
	$annees = $poissonCampagne->getAnnees();
	$thisannee = date('Y');
	if ($annees[0] < $thisannee) {
		$annees[] = $thisannee;
		arsort($annees);
	}
	$_SESSION["annees"] = $annees;
	if (!isset($_SESSION["annee"])) {
		$_SESSION["annee"] = $thisannee;
	}
}
if (isset($this->vue)) {
	$this->vue->set($_SESSION["annees"], "annees");
	$this->vue->set($_SESSION["annee"], "annee");
}
