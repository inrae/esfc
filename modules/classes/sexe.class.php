<?php
/**
 * ORM de la table sexe
 *
 * @author quinton
 *        
 */
class Sexe extends ObjetBDD
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
        $this->table = "sexe";
        $this->id_auto = "1";
        $this->colonnes = array(
            "sexe_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "sexe_libelle" => array(
                "type" => 0,
                "requis" => 1
            ),
            "sexe_libelle_court" => array(
                "type" => 0
            )
        );
        parent::__construct($bdd, $param);
    }
}
