<?php
/**
 * ORM de gestion de la table pathologie
 *
 * @author quinton
 *        
 */
class Pathologie extends ObjetBDD
{

    /**
     * Constructeur de la classe
     *
     * @param
     *            instance ADODB $bdd
     * @param array $param
     */
    function __construct($bdd, $param = array())
    {
        $this->paramori = $param;
        $this->param = $param;
        $this->table = "pathologie";
        $this->id_auto = "1";
        $this->colonnes = array(
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
        parent::__construct($bdd, $param);
    }

    /**
     * Retourne la liste des pathologies pour un poisson
     *
     * @param unknown $poisson_id
     * @return Ambigous <tableau, boolean, $data, string>
     */
    function getListByPoisson($poisson_id)
    {
        if ($poisson_id > 0 && is_numeric($poisson_id)) {
            $sql = "select pathologie_id, patho.poisson_id, pathologie_date, pathologie_commentaire,
					pathologie_type_libelle, evenement_type_libelle, patho.evenement_id
					from pathologie patho
					left outer join pathologie_type using (pathologie_type_id)
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					where patho.poisson_id = " . $poisson_id . " order by pathologie_date desc";
            return $this->getListeParam($sql);
        }
    }

    /**
     * Lit un enregistrement à partir de l'événement
     *
     * @param unknown $evenement_id
     * @return Ambigous <multitype:, boolean, $data, string>
     */
    function getDataByEvenement($evenement_id)
    {
        if ($evenement_id > 0 && is_numeric($evenement_id)) {
            $sql = "select * from pathologie where evenement_id = " . $evenement_id;
            return $this->lireParam($sql);
        }
    }
}
