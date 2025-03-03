<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de la table pittag_type
 *
 * @author quinton
 *        
 */
class PittagType extends PpciModel
{


    function __construct()
    {
        $this->table = "pittag_type";
        $this->fields = array(
            "pittag_type_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "pittag_type_libelle" => array(
                "type" => 0,
                "requis" => 1
            )
        );
        parent::__construct();
    }
}
