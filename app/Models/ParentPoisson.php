<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table parent_poisson
 *
 * @author quinton
 *        
 */
class ParentPoisson extends PpciModel
{


    function __construct()
    {
        $this->table = "parent_poisson";
        $this->fields = array(
            "parent_poisson_id" => array(
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
            "parent_id" => array(
                "type" => 1,
                "requis" => 1
            )
        );
        parent::__construct();
    }

    /**
     * Retourne la liste des poissons parents
     *
     * @param int $poisson_id
     * @return array
     */
    function getListParent(int $poisson_id)
    {
        $sql = "SELECT parent_poisson_id, par.poisson_id, parent_id, matricule, pittag_valeur, prenom, sexe_libelle, cohorte
					from parent_poisson par
					join poisson pois on (par.parent_id = pois.poisson_id)
					left outer join sexe using (sexe_id)
					left outer join v_pittag_by_poisson pit on (pois.poisson_id = pit.poisson_id)
					where par.poisson_id = :id: order by matricule, pittag_valeur, prenom ";
        return $this->getListeParamAsPrepared($sql, array("id" => $poisson_id));
    }

    /**
     * Retourne les parents
     *
     * @param int $id
     * @return array
     */
    function readAvecParent($id)
    {
        $sql = "SELECT parent_poisson_id, parent_poisson.poisson_id, parent_id,
				matricule, prenom, pittag_valeur
				from parent_poisson
				join poisson on (parent_poisson.parent_id = poisson.poisson_id)
				left outer join v_pittag_by_poisson pit on (poisson.poisson_id = pit.poisson_id)
				where parent_poisson_id = :id:";
        return $this->lireParamAsPrepared($sql, array("id" => $id));
    }

    /**
     * Retourne la liste des enfants attaches a un parent
     *
     * @param int $parent_id
     * @return array
     */
    function readEnfant(int $parent_id)
    {
        $sql = "SELECT parent_poisson_id, parent_poisson.poisson_id, parent_id,
				matricule, prenom, pittag_valeur
				from parent_poisson
				join poisson on (parent_poisson.poisson_id = poisson.poisson_id)
				left outer join v_pittag_by_poisson pit on (poisson.poisson_id = pit.poisson_id)
				where parent_id = :id:";
        return $this->getListeParamAsPrepared($sql, array("id" => $parent_id));
    }
}
