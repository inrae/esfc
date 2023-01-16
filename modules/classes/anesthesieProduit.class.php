<?php
/**
 * ORM de la table anesthesie_produit
 *
 * @author quinton
 *        
 */
class Anesthesie_produit extends ObjetBDD
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
        $this->table = "anesthesie_produit";
        $this->colonnes = array(
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
        parent::__construct($bdd, $param);
    }

    function getListeActif($actif = -1)
    {
        $sql = "select *
				from " . $this->table;
        if ($actif > - 1 && is_numeric($actif)) {
            $where = " where anesthesie_produit_actif = " . $actif;
        } else {
            $where = "";
        }
        $order = " order by anesthesie_produit_libelle";
        return $this->getListeParam($sql . $where . $order);
    }
}
