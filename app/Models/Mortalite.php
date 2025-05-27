<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table mortalite
 *
 * @author quinton
 *        
 */
class Mortalite extends PpciModel
{
    public Poisson $poisson;


    function __construct()
    {
        $this->table = "mortalite";
        $this->fields = array(
            "mortalite_id" => array(
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
            "mortalite_type_id" => array(
                "type" => 1,
                "requis" => 1
            ),
            "mortalite_date" => array(
                "type" => 2
            ),
            "mortalite_commentaire" => array(
                "type" => 0
            ),
            "evenement_id" => array(
                "type" => 1
            )
        );
        parent::__construct();
    }

    /**
     * Surcharge de la fonction ecrire
     * pour mettre a jour le statut du poisson
     * (non-PHPdoc)
     *
     * @see ObjetBDD::ecrire()
     */
    function write($data): int
    {
        if (strlen($data["mortalite_id"]) == 0) {
            $data["mortalite_id"] = 0;
        }
        $mortalite_id = parent::write($data);
        if ($mortalite_id > 0 && $data["poisson_id"] > 0) {
            /*
             * Lecture du poisson
             */
            if (!isset($this->poisson)) {
                $this->poisson = new Poisson;
            }
            $dataPoisson = $this->poisson->lire($data["poisson_id"]);
            if ($dataPoisson["poisson_id"] > 0 && $dataPoisson["poisson_statut_id"] == 1) {
                /*
                 * Mise a niveau du statut : le poisson est mort
                 */
                $dataPoisson["poisson_statut_id"] = 2;
                $this->poisson->ecrire($dataPoisson);
            }
        }
        return $mortalite_id;
    }

    /**
     * Retourne la liste des mortalites pour un poisson
     *
     * @param int $poisson_id
     * @return array
     */
    function getListByPoisson(int $poisson_id)
    {
        $sql = "SELECT mortalite_id, mortalite.poisson_id, mortalite_date, mortalite_commentaire,
					mortalite_type_libelle, evenement_type_libelle, mortalite.evenement_id
					from mortalite 
					left outer join mortalite_type using (mortalite_type_id)
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					where mortalite.poisson_id = :id: order by mortalite_date desc";
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
        $sql = "SELECT * from mortalite where evenement_id = :id:";
        return $this->lireParamAsPrepared($sql, array("id" => $evenement_id));
    }
    /**
     * Get the cumulative mortality by type on the last year
     *
     * @param integer $type: 1 : by category, 2 - by cohort
     * @param string $lastDate : last date of the period
     * @param string $duration : duration of the search of mortality
     * @return array
     */
    function getCumulativeMortality(int $type = 1, string $lastDate = '', string $duration = "1 year"): array
    {
        if (empty($lastDate)) {
            $lastDate = date("Y-m-d");
        }
        if ($type == 1) {
            $col = "categorie_libelle";
        } else {
            $col = "cohorte";
        }
        $sql = "with req as (
            SELECT $col, mortalite_date, row_number() over (order by mortalite_date) as nombre_cumule
            from mortalite
            join poisson using (poisson_id)
            join categorie using (categorie_id)
            where mortalite_date >= (date(:lastdate:) - interval '$duration')
            )
            SELECT distinct $col as typology, mortalite_date, max(nombre_cumule) over (partition by $col, mortalite_date) as nombre_cumule
            from req
            order by $col, mortalite_date";

        $param = array(
            "lastdate" => $lastDate
        );
        return $this->getListeParamAsPrepared($sql, $param);
    }
}
