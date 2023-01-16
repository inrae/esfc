<?php

class Sortie extends ObjetBDD
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
        $this->table = "sortie";
        $this->colonnes = array(
            "sortie_id" => array(
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
            "evenement_id" => array(
                "type" => 1
            ),
            "sortie_lieu_id" => array(
                "type" => 1
            ),
            "sortie_date" => array(
                "type" => 2
            ),
            "sortie_commentaire" => array(
                "type" => 0
            ),
            "sevre" => array(
                "type" => 0
            )
        );
        parent::__construct($bdd, $param);
    }

    /**
     * Surcharge de la fonction ecrire
     * pour mettre a jour le statut du poisson
     * (non-PHPdoc)
     *
     * @see ObjetBDD::ecrire()
     */
    function ecrire($data)
    {
        $sortie_id = parent::ecrire($data);
        if ($sortie_id > 0 && $data["poisson_id"] > 0) {
            /*
             * Lecture du poisson
             */
            $poisson = new Poisson($this->connection, $this->paramori);
            $dataPoisson = $poisson->lire($data["poisson_id"]);
            if ($dataPoisson["poisson_id"] > 0 && $dataPoisson["poisson_statut_id"] == 1) {
                /*
                 * Mise a niveau du statut : le poisson a quitte l'elevage
                 */
                $dataPoisson["poisson_statut_id"] = 4;
                $poisson->ecrire($dataPoisson);
            }
        }
        return $sortie_id;
    }

    /**
     * Retourne la liste des sorties pour un poisson
     *
     * @param unknown $poisson_id
     * @return Ambigous <tableau, boolean, $data, string>
     */
    function getListByPoisson($poisson_id)
    {
        if ($poisson_id > 0 && is_numeric($poisson_id)) {
            $sql = "select sortie_id, sortie.poisson_id, sortie_date, sortie_commentaire,
					localisation, evenement_type_libelle, sortie.evenement_id, sevre
					from sortie
					left outer join sortie_lieu using (sortie_lieu_id)
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					where sortie.poisson_id = " . $poisson_id . " order by sortie_date desc";
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
            $sql = "select sortie_id, poisson_id, sortie_date, sortie_commentaire,
					localisation, evenement_id, sortie_lieu_id, sevre
					from sortie
					left outer join sortie_lieu using (sortie_lieu_id)
					where evenement_id = " . $evenement_id;
            return $this->lireParam($sql);
        }
    }
}
