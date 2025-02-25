<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table pittag
 *
 * @author quinton
 *        
 */
class Pittag extends PpciModel
{
    public Poisson $poisson;


    function __construct()
    {
        $this->table = "pittag";
        $this->fields = array(
            "pittag_id" => array(
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
            "pittag_date_pose" => array(
                "type" => 2
            ),
            "pittag_type_id" => array(
                "type" => 1
            ),
            "pittag_valeur" => array(
                "type" => 0
            ),
            "pittag_commentaire" => array(
                "type" => 0
            )
        );
        parent::__construct();
    }

    /**
     * Retourne la liste des pittag attribués à un poisson
     *
     * @param int $poisson_id
     * @param int $limit
     * @return array
     */
    function getListByPoisson(int $poisson_id, int $limit = 0)
    {
        $param = array("poisson_id" => $poisson_id);
        $sql = "SELECT pittag_id, poisson_id, pittag_date_pose, pittag_valeur, pittag_type_libelle,
					pittag_type_id, pittag_commentaire
					from pittag
					left outer join pittag_type using (pittag_type_id)
					where poisson_id = :poisson_id: order by pittag_date_pose desc, pittag_id desc";
        if ($limit > 0 && is_numeric($limit)) {
            $sql .= " limit " . $limit;
        }
        if ($limit == 1) {
            return $this->lireParamAsPrepared($sql, $param);
        } else {
            return $this->getListeParamAsPrepared($sql, $param);
        }
    }
    /**
     * surround to set the matricule with the most recent pittag
     *
     * @param array $data
     * @return integer
     */
    function write($data): int
    {
        $id = parent::write($data);
        /**
         * Search it the pittag is the most recent
         */
        $param = array("poisson_id" => $data["poisson_id"]);
        $sql = "SELECT pittag_id, pittag_date_pose, pittag_valeur, matricule
                from pittag
                join poisson using (poisson_id)
                where poisson_id = :poisson_id:
                order by pittag_date_pose desc limit 1";
        $last = $this->lireParamAsPrepared($sql, $param);
        if ($last["pittag_id"] != $last["matricule"]) {
            if (!isset($this->poisson)) {
                $this->poisson = new Poisson;
            }
            $dpoisson = $this->poisson->lire($data["poisson_id"]);
            if ($dpoisson["poisson_id"] > 0) {
                $dpoisson["matricule"] = $last["pittag_valeur"];
                $this->poisson->ecrire($dpoisson);
            }
        }
        return $id;
    }
}
