<?php
/**
 * Table de determination de la parente
 * @author quinton
 *
 */
class Parente extends ObjetBDD
{
    function __construct($bdd, $param = array())
    {
        $this->table = "parente";
        $this->colonnes = array(
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
        parent::__construct($bdd, $param);
    }
    
    function getListByPoisson($poisson_id)
    {
        if ($poisson_id > 0 && is_numeric($poisson_id)) {
            $sql = "select parente_id, parente.poisson_id, parente_date, parente_commentaire,
					determination_parente_libelle, evenement_type_libelle, parente.evenement_id
					from parente
					left outer join determination_parente using (determination_parente_id)
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					where parente.poisson_id = " . $poisson_id . " order by parente_date desc";
            return $this->getListeParam($sql);
        }
    }
    
    /**
     * Lit un enregistrement à partir de l'événement
     *
     * @param int $evenement_id
     * @return array
     */
    function getDataByEvenement($evenement_id)
    {
        if ($evenement_id > 0 && is_numeric($evenement_id)) {
            $sql = "select * from parente where evenement_id = " . $evenement_id;
            return $this->lireParam($sql);
        }
    }
}
