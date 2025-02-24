<?php 
namespace App\Models;
use Ppci\Models\PpciModel;
/**
 * ORM de gestion de la table ventilation
 *
 * @author quinton
 *        
 */
class Ventilation extends PpciModel
{

    
    private $sql = "select * from ventilation";

    private $order = " order by ventilation_date desc";

    function __construct()
    {
        $this->table = "ventilation";
        $this->fields = array(
            "ventilation_id" => array(
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
            "battement_nb" => array(
                "type" => 1,
                "requis" => 1
            ),
            "ventilation_date" => array(
                "type" => 3,
                "defaultValue" => "getDateHeure"
            ),
            "ventilation_commentaire" => array(
                "type" => 0
            )
        );
        parent::__construct();
    }

    /**
     * Retourne la liste des releves pour un poisson
     *
     * @param int $poisson_id
     * @param int annee : annee de la campagne de reproduction, si requis
     * @return array
     */
    function getListByPoisson(int $poisson_id, int $annee = 0)
    {

            $where = " where poisson_id = :poisson_id";
            $param = array("poisson_id"=>$poisson_id);
            if ( $annee > 0) {
                $where .= " and extract(year from ventilation_date) = :annee";
                $param["annee"] = $annee;
            }
            return $this->getListeParamAsPrepared($this->sql . $where . $this->order, $param);
    }
}
