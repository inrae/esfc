<?php 
namespace App\Models;
use Ppci\Models\PpciModel;
class SpermeFreezingPlace extends PpciModel
{

    function __construct()
    {
        $this->table = "sperme_freezing_place";
        // Definition des formats des colonnes, et des controles a leur appliquer
        $this->fields = array(
            "sperme_freezing_place_id" => array(
                "type" => 1,
                "requis" => 1,
                "key" => 1,
                "defaultValue" => 0
            ),
            "sperme_congelation_id" => array(
                "type" => 1,
                "requis" => 1,
                "parentAttrib" => 1
            ),
            "cuve_libelle" => array(
                "type" => 0
            ),
            "canister_numero" => array(
                "type" => 0
            ),
            "position_canister" => array(
                "type" => 1,
                "defaultValue" => 1
            ),
            "nb_visotube" => array(
                "type" => 1
            )
        );
        parent::__construct();
    }
}
