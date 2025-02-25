<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table ventilation
 *
 * @author quinton
 *        
 */
class Genetique extends PpciModel
{


    private $sql = "SELECT * from genetique g
			left outer join nageoire using (nageoire_id)
			join evenement using (evenement_id)
			left outer join evenement_type using (evenement_type_id)";

    private $order = " order by genetique_date desc";

    function __construct()
    {
        $this->table = "genetique";
        $this->fields = array(
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
                "defaultValue" => getdate()
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
        parent::__construct();
    }

    /**
     * Retourne la liste des releves pour un poisson
     *
     * @param int $poisson_id
     * @param
     *            int annee : annee de la campagne de reproduction, si requis
     * @return array
     */
    function getListByPoisson(int $poisson_id, int $annee = 0)
    {
        $param = array("poisson_id" => $poisson_id);
        $where = " where g.poisson_id = :poisson_id:";
        if ($annee > 0) {
            $where .= " and extract(year from genetique_date) = :annee:";
            $param["annee"] = $annee;
        }
        return $this->getListeParamAsPrepared($this->sql . $where . $this->order, $param);
    }

    /**
     * Retrouve le prelevement attache a l'evenement
     *
     * @param int $evenement_id
     * @return array
     */
    function getDataByEvenement(int $evenement_id)
    {
        $where = " where evenement_id = :id: ";
        return $this->lireParamAsPrepared($this->sql . $where, array("id" => $evenement_id));
    }
}
