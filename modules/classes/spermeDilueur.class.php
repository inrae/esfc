<?php
/**
 * ORM de gestion de la table sperme_dilueur
 *
 * @author quinton
 *        
 */
class SpermeDilueur extends ObjetBDD
{

    function __construct($bdd, $param = array())
    {
        $this->table = "sperme_dilueur";
        $this->colonnes = array(
            "sperme_dilueur_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "sperme_dilueur_libelle" => array(
                "type" => 0,
                "requis" => 1
            )
        );
        parent::__construct($bdd, $param);
    }
}
