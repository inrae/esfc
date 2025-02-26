<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table sperme_aspect
 *
 * @author quinton
 *        
 */
class SpermeAspect extends PpciModel
{

    function __construct()
    {
        $this->table = "sperme_aspect";
        $this->fields = array(
            "sperme_aspect_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "sperme_aspect_libelle" => array(
                "type" => 0,
                "requis" => 1
            )
        );
        parent::__construct();
    }
}
