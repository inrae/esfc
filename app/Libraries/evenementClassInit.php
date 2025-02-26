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
$classes = array(
    "evenement" => array(
        "name" => "evenement.class.php",
        "classname" => "Evenement"
    ),
    "morphologie" => array(
        "name" => "morphologie.class.php",
        "classname" => "Morphologie"
    ),
    "gender_selection" => array(
        "name" => "genderSelection.class.php",
        "classname" => "GenderSelection"
    ), "pathologie" => array(
        "name" => "pathologie.class.php",
        "classname" => "Pathologie"
    ), "pittag" => array(
        "name" => "pittag.class.php",
        "classname" => "Pittag"
    ), "transfert" => array(
        "name" => "transfert.class.php",
        "classname" => "Transfert"
    ), "mortalite" => array(
        "name" => "mortalite.class.php",
        "classname" => "Mortalite"
    ), "cohorte" => array(
        "name" => "cohorte.class.php",
        "classname" => "Cohorte"
    ), "sortie" => array(
        "name" => "sortie.class.php",
        "classname" => "Sortie"
    ), "echographie" => array(
        "name" => "echographie.class.php",
        "classname" => "Echographie"
    ),
    "anesthesie" => array(
        "name" => "anesthesie.class.php",
        "classname" => "Anesthesie"
    ), "ventilation" => array(
        "name" => "ventilation.class.php",
        "classname" => "Ventilation"
    ), "poissonCampagne" => array(
        "name" => "poissonCampagne.class.php",
        "classname" => "PoissonCampagne"
    ), "dosageSanguin" => array(
        "name" => "dosageSanguin.class.php",
        "classname" => "DosageSanguin"
    ), "genetique" => array(
        "name" => "genetique.class.php",
        "classname" => "Genetique"
    ), "parente" => array(
        "name" => "parente.class.php",
        "classname" => "Parente"
    )
);

foreach ($classes as $classe => $value) {
    require_once "modules/classes/" . $value["name"];
    $$classe =  new $value["classname"];
}
