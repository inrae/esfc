<?php

/**
 * ORM de la table mortalite_type
 *
 * @author quinton
 *        
 */
class Mortalite_type extends ObjetBDD
{
    /**
     * Constructeur de la classe
     *
     * @param
     *            instance ADODB $bdd
     * @param array $param
     */
    function __construct($bdd, $param = array())
    {
        $this->table = "mortalite_type";
        $this->colonnes = array(
            "mortalite_type_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "mortalite_type_libelle" => array(
                "type" => 0,
                "requis" => 1
            )
        );
        parent::__construct($bdd, $param);
    }
}
