<?php

class SpermeCongelation extends ObjetBDD
{

    private $sql = "select sperme_congelation_id, sperme_id, congelation_date, congelation_volume,
			sperme_dilueur_id, sperme_dilueur_libelle, nb_paillette, 
			nb_visiotube, sperme_congelation_commentaire,
            sperme_conservateur_id, sperme_conservateur_libelle,
            volume_sperme, volume_dilueur, volume_conservateur,
            nb_paillettes_utilisees
			from sperme_congelation 
			left outer join sperme_dilueur using (sperme_dilueur_id)
            left outer join sperme_conservateur using (sperme_conservateur_id)
             ";

    function __construct($bdd, $param = array())
    {
        $this->table = "sperme_congelation";
        $this->colonnes = array(
            "sperme_congelation_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "sperme_id" => array(
                "type" => 1,
                "requis" => 1,
                "parentAttrib" => 1
            ),

            "congelation_date" => array(
                "type" => 2,
                "requis" => 1
            ),
            "congelation_volume" => array(
                "type" => 1
            ),
            "sperme_dilueur_id" => array(
                "type" => 1
            ),
            "nb_paillette" => array(
                "type" => 1
            ),
            "nb_visiotube" => array(
                "type" => 1
            ),
            "sperme_conservateur_id" => array(
                "type" => 1,
                "defaultValue" => 1
            ),
            "volume_sperme" => array(
                "type" => 1
            ),
            "volume_dilueur" => array(
                "type" => 1
            ),
            "volume_conservateur" => array(
                "type" => 1
            ),
            "nb_paillettes_utilisees" => array(
                "type" => 1
            ),
            "sperme_congelation_commentaire" => array(
                "type" => 0
            )
        );
        parent::__construct($bdd, $param);
    }

    /**
     * Retourne la liste des congelations associees a un sperme
     *
     * @param int $sperme_id
     */
    function getListFromSperme(int $sperme_id)
    {
        $where = " where sperme_id = :sperme_id";
        $order = " order by congelation_date";
        $arg = array(
            "sperme_id" => $sperme_id
        );;
        return $this->getListeParamAsPrepared($this->sql . $where . $order, $arg);
    }
}
