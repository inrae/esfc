<?php
/**
 * ORM de la table evenement_type
 *
 * @author quinton
 *        
 */
class Evenement_type extends ObjetBDD
{

    /**
     * Constructeur de la classe
     *
     * @param PDO $bdd
     * @param array $param
     */
    function __construct($bdd, $param = array())
    {
        $this->table = "evenement_type";
        $this->colonnes = array(
            "evenement_type_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "evenement_type_libelle" => array(
                "type" => 0,
                "requis" => 1
            ),
            "evenement_type_actif" => array(
                "type" => 1,
                "requis" => 1,
                "defaultValue" => 1
            )
        );
        parent::__construct($bdd, $param);
    }
}