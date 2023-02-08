<?php

class Site extends ObjetBDD
{

    function __construct($bdd, $param = null)
    {
        $this->table = "site";
        $this->colonnes = array(
            "site_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "site_name" => array("requis" => 1)
        );
        parent::__construct($bdd, $param);
    }
}
