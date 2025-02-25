<?php

namespace App\Models;

class SearchPoisson extends SearchParam
{
    public $searchByEvent;
    function __construct()
    {
        $this->param = array(
            "statut" => 1,
            "sexe" => "",
            "texte" => "",
            "categorie" => 1,
            "displayCumulTemp" => 0,
            "dateDebutTemp" => date("d/m/") . (date("Y") - 1),
            "dateFinTemp" => date("d/m/Y"),
            "site_id" => $_SESSION["site_id"],
            "dateFromEvent" => date("d/m/") . (date("Y") - 1),
            "dateToEvent" => date("d/m/Y"),
            "eventSearch" => "",
            "bassin_id" => 0,
            "cohorte" => ""
        );
        $this->paramNum = array(
            "statut",
            "categorie",
            "sexe",
            "displayCumulTemp",
            "site_id",
            "bassin_id"
        );
        $this->searchByEvent = array(
            "morphologie" => _("Morphologie"),
            "mortalite" => _("Mortalite"),
            "parente" => _("Détermination des parents"),
            "gender_SELECTion" => _("Détermination du sexe"),
            "pathologie" => _("Pathologie"),
            "echographie" => _("Échographie"),
            "dosage_sanguin" => _("Dosage sanguin"),
            "anesthesie" => _("Anesthésie"),
            "genetique" => _("Génétique"),
            "transfert" => _("Transfert")
        );
        asort($this->searchByEvent);

        parent::__construct();
    }

    function getSearchByEvent()
    {
        return $this->searchByEvent;
    }
}
