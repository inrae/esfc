<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table echographie
 *
 * @author quinton
 *        
 */
class Echographie extends PpciModel
{

    public function __construct()
    {
        $this->table = "echographie";
        $this->fields = array(
            "echographie_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "evenement_id" => array(
                "type" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "poisson_id" => array(
                "type" => 1,
                "parentAttrib" => 1,
                "requis" => 1
            ),
            "echographie_date" => array(
                "type" => 2,
                "requis" => 1,
                "defaultValue" => "getDateJour"
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
        parent::__construct();
    }
    function write($data): int
    {
        if (strlen($data["echographie_id"]) == 0) {
            $data["echographie_id"] = 0;
        }
        return parent::write($data);
    }

    /**
     * Retourne la liste des echographies realisees pour un poisson
     *
     * @param int $poisson_id
     * @return array
     */
    function getListByPoisson(int $poisson_id)
    {
        $sql = "SELECT echographie_id, evenement_id, e.poisson_id, 
					echographie_date, echographie_commentaire, 
					cliche_nb, cliche_ref, stade_oeuf_libelle, stade_gonade_libelle,
					evenement_type_libelle
					from echographie e
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					left outer join stade_oeuf using (stade_oeuf_id)
					left outer join stade_gonade using (stade_gonade_id)
					where e.poisson_id = :id:
					order by echographie_date desc";
        return $this->getListeParamAsPrepared($sql, array("id" => $poisson_id));
    }

    /**
     * Retourne une echographie a partir du numero d'evenement
     *
     * @param int $evenement_id
     * @return array
     */
    function getDataByEvenement(int $evenement_id)
    {

        $sql = "SELECT * from echographie 
				where evenement_id = :id:";
        return $this->lireParamAsPrepared($sql, array("id" => $evenement_id));
    }

    /**
     * Retourne la liste des echographies pour l'annee consideree
     *
     * @param int $poisson_id
     * @param int $annee
     * @return array
     */
    function getListByYear(int $poisson_id, int $annee)
    {
        $sql = "SELECT echographie_id, evenement_id, e.poisson_id, 
					echographie_date, echographie_commentaire, 
					cliche_nb, cliche_ref, stade_oeuf_libelle, stade_gonade_libelle,
					evenement_type_libelle
                from echographie e
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id) 
					left outer join stade_oeuf using (stade_oeuf_id)
					left outer join stade_gonade using (stade_gonade_id)
                where extract(year from echographie_date) = :annee:
					and e.poisson_id = :poisson_id:
                order by echographie_date desc";
        return $this->getListeParamAsPrepared($sql, array(
            "annee" => $annee,
            "poisson_id" => $poisson_id
        ));
    }
}
