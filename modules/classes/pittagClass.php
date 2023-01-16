<?php
/**
 * ORM de gestion de la table pittag
 *
 * @author quinton
 *        
 */
class Pittag extends ObjetBDD
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
        $this->table = "pittag";
        $this->id_auto = "1";
        $this->colonnes = array(
            "pittag_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "poisson_id" => array(
                "type" => 1,
                "requis" => 1,
                "parentAttrib" => 1
            ),
            "pittag_date_pose" => array(
                "type" => 2
            ),
            "pittag_type_id" => array(
                "type" => 1
            ),
            "pittag_valeur" => array(
                "type" => 0
            ),
            "pittag_commentaire" => array(
                "type" => 0
            )
        );
        if (! is_array($param))
            $param = array();
        $param["fullDescription"] = 1;
        parent::__construct($bdd, $param);
    }

    /**
     * Retourne la liste des pittag attribués à un poisson
     *
     * @param int $poisson_id
     * @param int $limit
     * @return array
     */
    function getListByPoisson($poisson_id, $limit = 0)
    {
        if ($poisson_id > 0 && is_numeric($poisson_id)) {
            $sql = "select pittag_id, poisson_id, pittag_date_pose, pittag_valeur, pittag_type_libelle,
					pittag_commentaire
					from pittag
					left outer join pittag_type using (pittag_type_id)
					where poisson_id = " . $poisson_id . " order by pittag_date_pose desc, pittag_id desc";
            if ($limit > 0 && is_numeric($limit)) {
                $sql .= " limit " . $limit;
            }
            if ($limit == 1) {
                return $this->lireParam($sql);
            } else {
                return $this->getListeParam($sql);
            }
        }
    }
}
