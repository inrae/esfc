<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table anesthesie
 *
 * @author quinton
 *        
 */
class Anesthesie extends PpciModel
{

    public function __construct()
    {
        $this->table = "anesthesie";
        $this->fields = array(
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
        parent::__construct();
    }

    /**
     * Retourne une anesthésie a partir du numero d'evenement
     *
     * @param int $evenement_id
     * @return array
     */
    function getDataByEvenement($evenement_id)
    {
        $sql = "select * from anesthesie
					join anesthesie_produit using (anesthesie_produit_id)
				where evenement_id = :id:";
        return $this->lireParamAsPrepared($sql, array("id" => $evenement_id));
    }

    /**
     * Retourne la liste des anesthésies realisees pour un poisson
     *
     * @param int $poisson_id
     * @return array
     */
    function getListByPoisson(int $poisson_id): ?array
    {
        $sql = "select anesthesie_id, evenement_id, e.poisson_id,
                anesthesie_date, anesthesie_commentaire,
                evenement_type_libelle,
                anesthesie_produit_libelle,
                anesthesie_dosage
                from anesthesie e
                natural join  evenement
                left outer join evenement_type using (evenement_type_id)
                natural join anesthesie_produit
                where e.poisson_id = :id:
                order by anesthesie_date desc";
        return $this->getListeParamAsPrepared($sql, array("id" => $poisson_id));
    }
}
