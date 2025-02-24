<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * Table de parametres
 * methodes de determination de la parente
 * @author quinton
 *
 */
class DeterminationParente extends PpciModel
{
    function __construct()
    {
        $this->table = "determination_parente";
        $this->fields = array(
            "determination_parente_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "determination_parente_libelle" => array(
                "type" => 0,
                "requis" => 1
            )
        );
        parent::__construct();
    }
}
