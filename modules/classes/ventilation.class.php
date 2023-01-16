<?php
/**
 * ORM de gestion de la table ventilation
 *
 * @author quinton
 *        
 */
class Ventilation extends ObjetBDD
{

    /**
     * Constructeur de la classe
     *
     * @param
     *            instance ADODB $bdd
     * @param array $param
     */
    private $sql = "select * from ventilation";

    private $order = " order by ventilation_date desc";

    function __construct($bdd, $param = array())
    {
        $this->table = "ventilation";
        $this->colonnes = array(
            "ventilation_id" => array(
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
            "battement_nb" => array(
                "type" => 1,
                "requis" => 1
            ),
            "ventilation_date" => array(
                "type" => 3,
                "defaultValue" => "getDateHeure"
            ),
            "ventilation_commentaire" => array(
                "type" => 0
            )
        );
        parent::__construct($bdd, $param);
    }

    /**
     * Retourne la liste des releves pour un poisson
     *
     * @param int $poisson_id
     * @param
     *            int annee : annee de la campagne de reproduction, si requis
     * @return tableau
     */
    function getListByPoisson($poisson_id, $annee = 0)
    {
        if (is_numeric($poisson_id) && $poisson_id > 0) {
            $where = " where poisson_id = " . $poisson_id;
            if (is_numeric($annee) && $annee > 0) {
                $where .= " and extract(year from ventilation_date) = " . $annee;
            }
            return $this->getListeParam($this->sql . $where . $this->order);
        }
    }
}
