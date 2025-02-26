<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table sperme_qualite
 *
 * @author quinton
 *        
 */
class SpermeQualite extends PpciModel
{

    function __construct()
    {
        $this->table = "sperme_qualite";
        $this->fields = array(
            "sperme_qualite_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "sperme_qualite_libelle" => array(
                "type" => 0,
                "requis" => 1
            )
        );
        parent::__construct();
    }
}
