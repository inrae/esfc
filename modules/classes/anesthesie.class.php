<?php
/**
 * ORM de gestion de la table anesthesie
 *
 * @author quinton
 *        
 */
class Anesthesie extends ObjetBDD
{

    public function __construct($p_connection, $param = array())
    {
        $this->table = "anesthesie";
        $this->colonnes = array(
            "anesthesie_id" => array(
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
            "anesthesie_date" => array(
                "type" => 2,
                "requis" => 1
            ),
            "anesthesie_commentaire" => array(
                "type" => 0,
                "requis" => 1
            ),
            "anesthesie_produit_id" => array(
                "type" => 1,
                "requis" => 1
            ),
            "anesthesie_dosage" => array(
                "type" => 1
            )
        );       
        parent::__construct($p_connection, $param);
    }

    /**
     * Retourne une anesthésie a partir du numero d'evenement
     *
     * @param unknown $evenement_id
     * @return array|NULL
     */
    function getDataByEvenement($evenement_id)
    {
        if ($evenement_id > 0 && is_numeric($evenement_id)) {
            $sql = "select * from anesthesie
					natural join anesthesie_produit
				where evenement_id = " . $evenement_id;
            return $this->lireParam($sql);
        } else
            return null;
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
            $sql = "select anesthesie_id, evenement_id, e.poisson_id,
					anesthesie_date, anesthesie_commentaire,
					evenement_type_libelle,
					anesthesie_produit_libelle,
					anesthesie_dosage
					from anesthesie e
					natural join  evenement
					left outer join evenement_type using (evenement_type_id)
					natural join anesthesie_produit
					where e.poisson_id = " . $poisson_id . "
					order by anesthesie_date desc";
            return $this->getListeParam($sql);
        } else
            return null;
    }
}
