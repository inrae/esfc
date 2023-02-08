<?php
class SortieLieu extends ObjetBDD
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
        $this->table = "sortie_lieu";
        $this->colonnes = array(
            "sortie_lieu_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "localisation" => array(
                "type" => 0,
                "requis" => 1
            ),
            "longitude_dd" => array(
                "type" => 1
            ),
            "latitude_dd" => array(
                "type" => 1
            ),
            "point_geom" => array(
                "type" => 4
            ),
            "actif" => array(
                "type" => 1
            ),
            "poisson_statut_id" => array(
                "type" => 1,
                "defaultValue" => 4
            )
        );
        $param["srid"] = 4326;
        parent::__construct($bdd, $param);
    }

    /**
     * Retourne la liste des lieux de sortie, actifs ou non
     *
     * @param int $actif
     *            [-1 | 0 | 1]
     * @return array
     */
    function getListeActif(int $actif = -1)
    {
        $sql = "select sortie_lieu_id, localisation, longitude_dd, latitude_dd,
				actif, poisson_statut_id, poisson_statut_libelle
				from sortie_lieu
				left outer join poisson_statut using (poisson_statut_id)
				";
        $param = array();
        if ($actif > -1) {
            $where = " where actif = :actif";
            $param["actif"] = $actif;
        } else {
            $where = "";
        }
        $order = " order by localisation";
        return $this->getListeParamAsPrepared($sql . $where . $order, $param);
    }

    /**
     * Surcharge de la fonction ecrire pour rajouter le point geographique
     * (non-PHPdoc)
     *
     * @see ObjetBDD::ecrire()
     */
    function ecrire($data)
    {
        /*
         * Preparation du point geometrique
         */
        if (strlen($data["longitude_dd"]) > 0 && strlen($data["latitude_dd"]) > 0) {
            $data["point_geom"] = "POINT(" . $data["longitude_dd"] . " " . $data["latitude_dd"] . ")";
        }
        return parent::ecrire($data);
    }
}
