<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de la table anesthesie_produit
 *
 * @author quinton
 *        
 */
class AnesthesieProduit extends PpciModel
{

    
    function __construct()
    {
        $this->table = "anesthesie_produit";
        $this->fields = array(
            "anesthesie_produit_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "anesthesie_produit_libelle" => array(
                "type" => 0,
                "requis" => 1
            ),
            "anesthesie_produit_actif" => array(
                "type" => 1,
                "requis" => 1,
                "defaultValue" => 1
            )
        );
        parent::__construct();
    }

    function getListeActif($actif = -1)
    {
        $sql = "SELECT * from anesthesie_produit";
        $data = array();
        if ($actif > -1) {
            $where = " where anesthesie_produit_actif = :actif: ";
            $data["actif"] = $actif;
        } else {
            $where = "";
        }
        $order = " order by anesthesie_produit_libelle";
        return $this->getListeParamAsPrepared($sql . $where . $order, $data);
    }
}
