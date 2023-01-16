<?php
/**
 * ORM de gestion de la table ventilation
 *
 * @author quinton
 *        
 */
class Genetique extends ObjetBDD
{

    /**
     * Constructeur de la classe
     *
     * @param
     *            instance ADODB $bdd
     * @param array $param
     */
    private $sql = "select * from genetique g
			left outer join nageoire using (nageoire_id)
			join evenement using (evenement_id)
			left outer join evenement_type using (evenement_type_id)";

    private $order = " order by genetique_date desc";

    function __construct($bdd, $param = array())
    {
        $this->table = "genetique";
        $this->colonnes = array(
            "genetique_id" => array(
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
            "nageoire_id" => array(
                "type" => 1
            ),
            "genetique_date" => array(
                "type" => 2,
                "defaultValue" => "getDate"
            ),
            "genetique_commentaire" => array(
                "type" => 0
            ),
            "genetique_reference" => array(
                "type" => 0,
                "requis" => 1
            ),
            "evenement_id" => array(
                "type" => 1,
                "requis" => 1
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
            $where = " where g.poisson_id = " . $poisson_id;
            if (is_numeric($annee) && $annee > 0) {
                $where .= " and extract(year from genetique_date) = " . $annee;
            }
            return $this->getListeParam($this->sql . $where . $this->order);
        }
    }

    /**
     * Retrouve le prelevement attache a l'evenement
     *
     * @param int $evenement_id
     * @return array|NULL
     */
    function getDataByEvenement($evenement_id)
    {
        if ($evenement_id > 0 && is_numeric($evenement_id)) {
            $where = " where evenement_id = " . $evenement_id;
            return $this->lireParam($this->sql . $where);
        } else
            return null;
    }
}
