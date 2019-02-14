<?php
/**
 * ORM de gestion de la table sonde
 */
class Sonde extends ObjetBDD
{
    /**
     * Constructeur
     *
     * @param PDO $bdd
     * @param array $param
     */
    function __construct($bdd, $param = array())
    {
        $this->table = "sonde";
        $this->colonnes = array(
            "sonde_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "sonde_name" => array("requis" => 1),
            "sonde_param" => array("type" => 0)
        );
        parent::__construct($bdd, $param);
    }
}
?>