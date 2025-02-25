<?php

namespace App\Models;

class SearchRepro extends SearchParam
{
    function __construct()
    {
        $this->param = array(
            "annee" => date('Y'),
            "repro_statut_id" => 2,
            "site_id" => $_SESSION["site_id"]
        );
        $this->paramNum = array(
            "annee",
            "repro_statut_id",
            "site_id"
        );
        parent::__construct();
    }
}
