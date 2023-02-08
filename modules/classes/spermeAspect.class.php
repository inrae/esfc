<?php
/**
 * ORM de gestion de la table sperme_aspect
 *
 * @author quinton
 *        
 */
class SpermeAspect extends ObjetBDD
{

    function __construct($bdd, $param = array())
    {
        $this->table = "sperme_aspect";
        $this->colonnes = array(
            "sperme_aspect_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "sperme_aspect_libelle" => array(
                "type" => 0,
                "requis" => 1
            )
        );
        parent::__construct($bdd, $param);
    }
}
