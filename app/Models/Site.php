<?php

namespace App\Models;

use Ppci\Models\PpciModel;

class Site extends PpciModel
{

    function __construct()
    {
        $this->table = "site";
        $this->fields = array(
            "site_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "site_name" => array("requis" => 1)
        );
        parent::__construct();
    }
}
