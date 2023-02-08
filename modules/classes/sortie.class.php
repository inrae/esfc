<?php

class Sortie extends ObjetBDD
{

    public Poisson $poisson;
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
            if (!isset($this->poisson)) {
                $this->poisson = $this->classInstanciate("Poisson", "poisson.class.php");
            }
            $dataPoisson = $this->poisson->lire($data["poisson_id"]);
            if ($dataPoisson["poisson_id"] > 0 && $dataPoisson["poisson_statut_id"] == 1) {
                /*
                 * Mise a niveau du statut : le poisson a quitte l'elevage
                 */
                $dataPoisson["poisson_statut_id"] = 4;
                $this->poisson->ecrire($dataPoisson);
            }
        }
        return $sortie_id;
    }

    /**
     * Retourne la liste des sorties pour un poisson
     *
     * @param int $poisson_id
     * @return array
     */
    function getListByPoisson(int $poisson_id)
    {
        $sql = "select sortie_id, sortie.poisson_id, sortie_date, sortie_commentaire,
					localisation, evenement_type_libelle, sortie.evenement_id, sevre
					from sortie
					left outer join sortie_lieu using (sortie_lieu_id)
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					where sortie.poisson_id = :id order by sortie_date desc";
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
        $sql = "select sortie_id, poisson_id, sortie_date, sortie_commentaire,
					localisation, evenement_id, sortie_lieu_id, sevre
					from sortie
					left outer join sortie_lieu using (sortie_lieu_id)
					where evenement_id = :id";
        return $this->lireParamAsPrepared($sql, array("id" => $evenement_id));
    }
}
