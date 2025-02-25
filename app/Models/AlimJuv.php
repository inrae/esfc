<?php

namespace App\Models;

class AlimJuv extends SearchParam
{
    function __construct()
    {
        $this->param = array(
            "date_debut_alim" => date("d/m/Y"),
            "duree" => 1,
            "densite" => 1500
        );
        $this->paramNum = array(
            "duree",
            "densite"
        );
        parent::__construct();
    }
}
