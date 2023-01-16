<?php
/**
 * ORM de la table cohorte_type
 *
 * @author quinton
 *        
 */
class Cohorte_type extends ObjetBDD
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
        $this->table = "cohorte_type";
        $this->id_auto = 1;
        $this->colonnes = array(
            "cohorte_type_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "cohorte_type_libelle" => array(
                "type" => 0,
                "requis" => 1
            )
        );
        parent::__construct($bdd, $param);
    }
}
