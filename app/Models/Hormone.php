<?php

namespace App\Models;

use Ppci\Models\PpciModel;

class Hormone extends PpciModel
{
    function __construct()
    {
        $this->table = "hormone";
        $this->fields = array(
            "hormone_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "hormone_nom" => array(
                "type" => 0,
                "requis" => 1
            ),
            "hormone_unite" => array(
                "type" => 0
            )
        );
        parent::__construct();
    }
}
