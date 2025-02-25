<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de la table poisson_statut
 *
 * @author quinton
 *        
 */
class Poisson_statut extends PpciModel
{


    function __construct()
    {
        $this->table = "poisson_statut";
        $this->fields = array(
            "poisson_statut_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "poisson_statut_libelle" => array(
                "type" => 0,
                "requis" => 1
            )
        );
        parent::__construct();
    }
}
