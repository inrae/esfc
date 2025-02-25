<?php

namespace App\Models;

class SearchRepartition extends SearchParam
{
    function __construct()
    {
        $annee_prec = date('Y') - 1;
        $this->param = array(
            "categorie_id" => 0,
            "date_reference" => date('d/m/') . $annee_prec,
            "offset" => 0,
            "limit" => 10,
            "site_id" => $_SESSION["site_id"]
        );
        $this->paramNum = array(
            "categorie_id",
            "offset",
            "limit",
            "site_id"
        );
        parent::__construct();
    }
}
