<?php
/**
 * ORM de la table pathologie_type
 *
 * @author quinton
 *        
 */
class Pathologie_type extends ObjetBDD
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
        $this->param = $param;
        $this->table = "pathologie_type";
        $this->id_auto = "1";
        $this->colonnes = array(
            "pathologie_type_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "pathologie_type_libelle" => array(
                "type" => 0,
                "requis" => 1
            ),
            "pathologie_type_libelle_court" => array(
                "type" => 0
            )
        );
        parent::__construct($bdd, $param);
    }
}
