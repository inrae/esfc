<?php

namespace App\Models;

class SearchBassin extends SearchParam
{
    function __construct()
    {
        $this->param = array(
            "bassin_type" => "",
            "bassin_usage" => "",
            "bassin_zone" => "",
            "circuit_eau" => "",
            "bassin_actif" => "",
            "bassin_nom" => "",
            "site_id" => $_SESSION["site_id"]
        );
        $this->paramNum = array(
            "bassin_type",
            "bassin_usage",
            "bassin_zone",
            "circuit_eau",
            "bassin_actif",
            "site_id"
        );
        parent::__construct();
    }
}
