<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de la table cohorte_type
 *
 * @author quinton
 *        
 */
class Cohorte_type extends PpciModel
{

    
    function __construct()
    {
        $this->table = "cohorte_type";
        $this->fields = array(
            "cohorte_type_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "cohorte_type_libelle" => array(
                "type" => 0,
                "requis" => 1
            )
        );
        parent::__construct();
    }
}
