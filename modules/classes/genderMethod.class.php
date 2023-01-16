<?php
/**
 * ORM de la table gender_methode
 *
 * @author quinton
 *        
 */
class Gender_methode extends ObjetBDD
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
        $this->table = "gender_methode";
        $this->id_auto = 1;
        $this->colonnes = array(
            "gender_methode_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "gender_methode_libelle" => array(
                "type" => 0,
                "requis" => 1
            )
        );
        parent::__construct($bdd, $param);
    }
}
