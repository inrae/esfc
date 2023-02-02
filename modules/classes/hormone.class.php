<?php

class Hormone extends ObjetBDD
{
    function __construct($bdd, $param = array())
    {
        $this->table = "hormone";
        $this->colonnes = array(
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
        parent::__construct($bdd, $param);
    }
}
