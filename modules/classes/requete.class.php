<?php

/**
 * Created : 11 déc. 2017
 * Creator : quinton
 * Encoding : UTF-8
 * Copyright 2017 - All rights reserved
 */
/**
 * ORM de gestion de la table REQUETE
 * @author quinton
 *
 */
class Requete extends ObjetBDD
{
    function __construct($bdd, $param = null)
    {
        $this->table = "requete";
        $this->id_auto = 1;
        $this->colonnes = array(
            "requete_id" => array(
                "key" => 1,
                "type" => 1,
                "requis" => 1
            ),
            "creation_date" => array(
                "type" => 3,
                "defaultValue" => "getDateHeure",
                "requis" => 1
            ),
            "last_exec" => array(
                "type" => 3
            ),
            "title" => array(
                "requis" => 1
            ),
            "body" => array(
                "requis" => 1
            ),
            "login" => array(
                "requis" => 1,
                "defaultValue" => "getLogin"
            ),
            "datefields" => array(
                "type" => 0
            )
        );
        if (! is_array($param)) {
            $param == array();
        }
        parent::__construct($bdd, $param);
    }

    function ecrire($data)
    {
        /*
         * Suppression des contenus dangereux dans la commande SQL
         */
        $data["body"] = str_replace(";", "", $data["body"]);
        $data["body"] = str_replace("--", "", $data["body"]);
        return parent::ecrire($data);
    }

    /**
     * Lance l'execution d'une requete
     * 
     * @param int $requete_id
     * @return array
     */
    function exec($requete_id)
    {
        if ($requete_id > 0 && is_numeric($requete_id)) {
            $req = $this->lire($requete_id);
            if (strlen($req["body"]) > 0) {
                $sql = "SELECT " + $req["body"];
                /*
                 * Preparation des dates pour encodage
                 */
                $df = explode(",", $req["datefields"]);
                foreach ($df as $val) {
                    $this->colonnes[$val]["type"] = 3;
                }
                /*
                 * Ecriture de l'heure d'execution
                 */
                $req["last_exec"] = $this->getDateHeure();
                $this->ecrire($req);
                return $this->getListeParam($sql);
            }
        }
    }
}
?>