<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de la table pathologie_type
 *
 * @author quinton
 *        
 */
class Pathologie_type extends PpciModel
{


    function __construct()
    {
        $this->table = "pathologie_type";
        $this->fields = array(
            "pathologie_type_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "pathologie_type_libelle" => array(
                "type" => 0,
                "requis" => 1
            ),
            "pathologie_type_libelle_court" => array(
                "type" => 0
            )
        );
        parent::__construct();
    }
}
