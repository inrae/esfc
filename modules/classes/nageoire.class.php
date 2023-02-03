<?php
/**
 * ORM de gestion de la table nageoire
 *
 * @author quinton
 *        
 */
class Nageoire extends ObjetBDD
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
        $this->table = "nageoire";
        $this->colonnes = array(
            "nageoire_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "nageoire_libelle" => array(
                "type" => 0,
                "requis" => 1
            )
        );
        parent::__construct($bdd, $param);
    }
}
