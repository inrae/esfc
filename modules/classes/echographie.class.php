<?php
/**
 * ORM de gestion de la table echographie
 *
 * @author quinton
 *        
 */
class Echographie extends ObjetBDD
{

    public function __construct($p_connection, $param = array())
    {
        $this->table = "echographie";
        $this->colonnes = array(
            "echographie_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "evenement_id" => array(
                "type" => 1,
                "requis" => 1
            ),
            "poisson_id" => array(
                "type" => 1,
                "parentAttrib" => 1,
                "requis" => 1
            ),
            "echographie_date" => array(
                "type" => 2,
                "requis" => 1
            ),
            "echographie_commentaire" => array(
                "type" => 0
            ),
            "cliche_nb" => array(
                "type" => 1
            ),
            "cliche_ref" => array(
                "type" => 0
            ),
            "stade_gonade_id" => array(
                "type" => 1
            ),
            "stade_oeuf_id" => array(
                "type" => 1
            )
        );      
        parent::__construct($p_connection, $param);
    }

    /**
     * Retourne la liste des echographies realisees pour un poisson
     *
     * @param int $poisson_id
     * @return tableau
     */
    function getListByPoisson($poisson_id)
    {
        if ($poisson_id > 0 && is_numeric($poisson_id)) {
            $sql = "select echographie_id, evenement_id, e.poisson_id, 
					echographie_date, echographie_commentaire, 
					cliche_nb, cliche_ref, stade_oeuf_libelle, stade_gonade_libelle,
					evenement_type_libelle
					from echographie e
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					left outer join stade_oeuf using (stade_oeuf_id)
					left outer join stade_gonade using (stade_gonade_id)
					where e.poisson_id = " . $poisson_id . "
					order by echographie_date desc";
            return $this->getListeParam($sql);
        } else
            return null;
    }

    /**
     * Retourne une echographie a partir du numero d'evenement
     *
     * @param unknown $evenement_id
     * @return array|NULL
     */
    function getDataByEvenement($evenement_id)
    {
        if ($evenement_id > 0 && is_numeric($evenement_id)) {
            $sql = "select * from echographie 
				where evenement_id = " . $evenement_id;
            return $this->lireParam($sql);
        } else
            return null;
    }

    /**
     * Retourne la liste des echographies pour l'annee consideree
     *
     * @param int $poisson_id
     * @param int $annee
     * @return tableau|NULL
     */
    function getListByYear($poisson_id, $annee)
    {
        if ($annee > 0 && is_numeric($annee) && is_numeric($poisson_id)) {
            $sql = "select echographie_id, evenement_id, e.poisson_id, 
					echographie_date, echographie_commentaire, 
					cliche_nb, cliche_ref, stade_oeuf_libelle, stade_gonade_libelle,
					evenement_type_libelle
					from echographie e
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id) 
					left outer join stade_oeuf using (stade_oeuf_id)
					left outer join stade_gonade using (stade_gonade_id)
					where extract(year from echographie_date) = " . $annee . "
					and e.poisson_id = " . $poisson_id . " 
					order by echographie_date desc";
            return $this->getListeParam($sql);
        } else
            return null;
    }
}
