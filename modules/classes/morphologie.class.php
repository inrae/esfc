<?php

/**
 * ORM de gestion de la table morphologie
 *
 * @author quinton
 *        
 */
class Morphologie extends ObjetBDD
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
        $this->table = "morphologie";
        $this->colonnes = array(
            "morphologie_id" => array(
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
            "longueur_fourche" => array(
                "type" => 1
            ),
            "longueur_totale" => array(
                "type" => 1
            ),
            "masse" => array(
                "type" => 1
            ),
            "morphologie_date" => array(
                "type" => 2
            ),
            "evenement_id" => array(
                "type" => 1
            ),
            "morphologie_commentaire" => array(
                "type" => 0
            ),
            "circonference" => array(
                "type" => 1
            )
        );
        parent::__construct($bdd, $param);
    }

    /**
     * Fonction retournant la liste des donnees morphologiques pour un poisson
     *
     * @param int $poisson_id
     * @return array
     */
    function getListeByPoisson(int $poisson_id)
    {
        $sql = "select morphologie_id, m.poisson_id, longueur_fourche, longueur_totale, masse, circonference, morphologie_date, morphologie_commentaire, 
					m.evenement_id, evenement_type_libelle
					from morphologie m
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					where m.poisson_id = :id order by morphologie_date desc";
        return $this->getListeParamAsPrepared($sql, array("id" => $poisson_id));
    }

    /**
     * Retourne la dernière masse connue pour un poisson
     *
     * @param int $poisson_id
     * @return array
     */
    function getMasseLast(int $poisson_id)
    {
        $sql = "select masse from v_poisson_last_masse
					where  poisson_id = :poisson_id";
        return $this->lireParamAsPrepared($sql, array("poisson_id" => $poisson_id));
    }

    /**
     * Retourne la masse d'un poisson entre deux dates
     *
     * @param int $poisson_id
     * @param string $date_from
     * @param string $date_to
     * @return array
     */
    function getListMasseFromPoisson(int $poisson_id, string $date_from, string $date_to)
    {

        $sql = "select poisson_id, morphologie_date, masse 
					from morphologie
					where poisson_id = :poisson_id
					and morphologie_date between :date_from and :date_to
					order by morphologie_date";
        return $this->getListeParamAsPrepared(
            $sql,
            array(
                "poisson_id" => $poisson_id,
                "date_from" => $date_from,
                "date_to" => $date_to
            )
        );
    }

    /**
     * Retourne la masse d'un poissson après le 1er juin (post-repro)
     *
     * @param int $poisson_id
     * @param string $date
     * @return array
     */
    function getMasseBeforeDate($poisson_id, $date)
    {
        $sql = "select masse, morphologie_date from morphologie
					where morphologie_date < :date
					and poisson_id = :poisson_id
					order by morphologie_date desc
					limit 1";
        return $this->lireParamAsPrepared($sql, array(
            "poisson_id" => $poisson_id,
            "date" => $date
        ));
    }

    /**
     * Retourne la masse d'un poisson avant le 1er juin pré-repro
     *
     * @param int $poisson_id
     * @param int $annee
     * @return array
     */
    function getMasseBeforeRepro($poisson_id, $annee)
    {
        $date_from = $annee . "-01-01";
        $date_to = $annee . "-05-31";
        $sql = "select masse, morphologie_date from morphologie
					where morphologie_date between :date_from and :date_to
					and poisson_id = :poisson_id
					order by morphologie_date asc
					limit 1";
        return $this->lireParamAsPrepared($sql, array(
            "poisson_id" => $poisson_id,
            "date_from" => $date_from,
            "date_to" => $date_to
        ));
    }

    /**
     * Lit un enregistrement à partir de l'événement
     *
     * @param int $evenement_id
     * @return array
     */
    function getDataByEvenement(int $evenement_id)
    {
        $sql = "select * from morphologie where evenement_id = :id";
        return $this->lireParamAsPrepared($sql, array("id" => $evenement_id));
    }
}
