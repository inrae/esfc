<?php
/**
 * Table de parametres
 * methodes de determination de la parente
 * @author quinton
 *
 */
class DeterminationParente extends ObjetBDD
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
        $this->table = "determination_parente";
        $this->colonnes = array(
            "determination_parente_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "determination_parente_libelle" => array(
                "type" => 0,
                "requis" => 1
            )
        );
            parent::__construct($bdd, $param);
    }
}
