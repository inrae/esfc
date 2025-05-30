<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * Table de determination de la parente
 * @author quinton
 *
 */
class Parente extends PpciModel
{
    function __construct()
    {
        $this->table = "parente";
        $this->fields = array(
            "parente_id" => array(
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
                "requis" => 1
            ),
            "determination_parente_id" => array(
                "type" => 1,
                "requis" => 1
            ),
            "parente_date" => array(
                "type" => 2,
                "requis" => 1
            ),
            "parente_commentaire" => array(
                "type" => 0
            )
        );
        parent::__construct();
    }
    function write($data): int
    {
        if (strlen($data["parente_id"]) == 0) {
            $data["parente_id"] = 0;
        }
        return parent::write($data);
    }
    function getListByPoisson(int $poisson_id)
    {
        $sql = "SELECT parente_id, parente.poisson_id, parente_date, parente_commentaire,
					determination_parente_libelle, evenement_type_libelle, parente.evenement_id
					from parente
					left outer join determination_parente using (determination_parente_id)
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					where parente.poisson_id = :id: order by parente_date desc";
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
        $sql = "SELECT * from parente where evenement_id = :id:";
        return $this->lireParamAsPrepared($sql, array("id" => $evenement_id));
    }
}
