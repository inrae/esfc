<?php
class SpermeCaract extends ObjetBDD
{

    function __construct($bdd, $param = array())
    {
        $this->table = "sperme_caract";
        $this->colonnes = array(
            "sperme_id" => array(
                "type" => 1,
                "requis" => 1
            ),
            "sperme_caracteristique_id" => array(
                "type" => 1,
                "requis" => 1
            )
        );
        parent::__construct($bdd, $param);
    }
}
