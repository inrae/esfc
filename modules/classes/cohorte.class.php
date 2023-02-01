<?php
class Cohorte extends ObjetBDD
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
        $this->table = "cohorte";
        $this->colonnes = array(
            "cohorte_id" => array(
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
            "cohorte_date" => array(
                "type" => 2
            ),
            "cohorte_commentaire" => array(
                "type" => 0
            ),
            "evenement_id" => array(
                "type" => 1
            ),
            "cohorte_determination" => array(
                "type" => 0
            ),
            "cohorte_type_id" => array(
                "type" => 1
            )
        );
        parent::__construct($bdd, $param);
    }

    /**
     * Retourne la liste des déterminations de cohortes pour un poisson
     *
     * @param int $poisson_id
     * @return array 
     */
    function getListByPoisson(int $poisson_id)
    {
        $sql = "select cohorte_id, cohorte.poisson_id, cohorte_date, cohorte_commentaire,
					cohorte_determination, evenement_type_libelle, cohorte.evenement_id,
					cohorte_type_id, cohorte_type_libelle
					from cohorte
					left outer join cohorte_type using (cohorte_type_id)
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					where cohorte.poisson_id = :id order by cohorte_date desc";
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
        $sql = "select * from cohorte where evenement_id = :id";
        return $this->lireParamAsPrepared($sql, array("id" => $evenement_id));
    }

    /**
     * rajout de l'ecriture de la cohorte
     * (non-PHPdoc)
     *
     * @see ObjetBDD::ecrire()
     */
    function ecrire($data)
    {
        $ret = parent::ecrire($data);
        if ($ret > 0 && $data["poisson_id"] > 0 && strlen($data["cohorte_determination"]) > 0) {
            /*
             * S'il s'agit d'une determination expert, on force le sexe
             */
            if (!isset($this->poisson)) {
                $this->poisson = $this->classInstanciate("Poisson", "poisson.class.php");
            }
            $dataPoisson = $this->poisson->lire($data["poisson_id"]);
            $dataPoisson["cohorte"] = $data["cohorte_determination"];
            $this->poisson->ecrire($dataPoisson);
        }
        return $ret;
    }
}
