<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table pathologie
 *
 * @author quinton
 *        
 */
class Pathologie extends PpciModel
{


    function __construct()
    {

        $this->table = "pathologie";
        $this->fields = array(
            "pathologie_id" => array(
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
            "pathologie_type_id" => array(
                "type" => 1,
                "requis" => 1
            ),
            "pathologie_date" => array(
                "type" => 2
            ),
            "pathologie_commentaire" => array(
                "type" => 0
            ),
            "evenement_id" => array(
                "type" => 1
            ),
            "pathologie_valeur" => array(
                "type" => 1
            )
        );
        parent::__construct();
    }

    /**
     * Retourne la liste des pathologies pour un poisson
     *
     * @param int $poisson_id
     * @return array
     */
    function getListByPoisson(int $poisson_id)
    {
        $sql = "select pathologie_id, patho.poisson_id, pathologie_date, pathologie_commentaire,
					pathologie_type_libelle, evenement_type_libelle, patho.evenement_id
					from pathologie patho
					left outer join pathologie_type using (pathologie_type_id)
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					where patho.poisson_id = :id: order by pathologie_date desc";
        return $this->getListeParamAsPrepared($sql, array("id" => $poisson_id));
    }

    /**
     * Lit un enregistrement à partir de l'événement
     *
     * @param int $evenement_id
     * @return array
     */
    function getDataByEvenement(int $evenement_id)
    {
        $sql = "select * from pathologie where evenement_id = :id:";
        return $this->lireParamAsPrepared($sql, array("id" => $evenement_id));
    }
}
