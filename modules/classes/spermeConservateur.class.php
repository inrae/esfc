<?php
class SpermeConservateur extends ObjetBDD
{

    function __construct($bdd, $param = array())
    {
        $this->table = "sperme_conservateur";
        // Definition des formats des colonnes, et des controles a leur appliquer
        $this->colonnes = array(
            "sperme_conservateur_id" => array(
                "type" => 1,
                "requis" => 1,
                "key" => 1,
                "defaultValue" => 0
            ),
            "sperme_conservateur_libelle" => array(
                "requis" => 1
            )
        );
        parent::__construct($bdd, $param);
    }
}
