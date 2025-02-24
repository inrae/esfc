<?php 
namespace App\Models;
use Ppci\Models\PpciModel;
class SpermeFreezingMeasure extends PpciModel
{

    function __construct()
    {
        $this->table = "sperme_freezing_measure";
        // Definition des formats des colonnes, et des controles a leur appliquer
        $this->fields = array(
            "sperme_freezing_measure_id" => array(
                "type" => 1,
                "requis" => 1,
                "key" => 1,
                "defaultValue" => 0
            ),
            "sperme_congelation_id" => array(
                "type" => 1,
                "requis" => 1,
                "parentAttrib" => 1
            ),
            "measure_date" => array(
                "type" => 3,
                "requis" => 1,
                "defaultValue"=>"getdateheure"
            ),
            "measure_temp" => array(
                "type" => 0,
                "requis" => 1
            )
        );
        parent::__construct();
    }
    /**
     * Modification de la fonction de definition des colonnes par defaut,
     * pour recuperer le cas echeant l'heure de derniere mesure, augmentee
     * d'une minute
     * {@inheritDoc}
     * @see ObjetBDD::getDefaultValue()
     */
    function getDefaultValue($parentValue = 0): array
    {
        $data = parent::getDefaultValue($parentValue);
        /*
         * Recherche de la derniere date enregistree
         */
        if ($parentValue > 0) {
            $sql = "select measure_date as mt from sperme_freezing_measure" .
                " where sperme_congelation_id = :id:" .
                " order by measure_date desc limit 1";
            $last = $this->lireParamAsPrepared($sql, array("id" => $parentValue));
            if (strlen($last["mt"]) > 0) {
                $time = new DateTime($last["mt"]);
                date_add($time, new \DateInterval("PT1M"));
                $data["measure_date"] = $this->formatDateDBversLocal(date_format($time, "Y-m-d H:i:s"), 3);
            }
        }
        return $data;
    }
}
