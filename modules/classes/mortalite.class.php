<?php

/**
 * ORM de gestion de la table mortalite
 *
 * @author quinton
 *        
 */
class Mortalite extends ObjetBDD
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
        $this->table = "mortalite";
        $this->colonnes = array(
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
        $mortalite_id = parent::ecrire($data);
        if ($mortalite_id > 0 && $data["poisson_id"] > 0) {
            /*
             * Lecture du poisson
             */
            if (!isset($this->poisson)) {
                $this->poisson = $this->classInstanciate("Poisson", "poisson.class.php");
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
        $sql = "select mortalite_id, mortalite.poisson_id, mortalite_date, mortalite_commentaire,
					mortalite_type_libelle, evenement_type_libelle, mortalite.evenement_id
					from mortalite 
					left outer join mortalite_type using (mortalite_type_id)
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					where mortalite.poisson_id = :id order by mortalite_date desc";
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
        $sql = "select * from mortalite where evenement_id = :id";
        return $this->lireParamAsPrepared($sql, array("id" => $evenement_id));
    }
}
