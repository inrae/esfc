<?php
/**
 * ORM de la table pittag_type
 *
 * @author quinton
 *        
 */
class Pittag_type extends ObjetBDD
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
        $this->table = "pittag_type";
        $this->colonnes = array(
            "pittag_type_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "pittag_type_libelle" => array(
                "type" => 0,
                "requis" => 1
            )
        );
        parent::__construct($bdd, $param);
    }
}
