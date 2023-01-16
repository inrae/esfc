<?php
class Cohorte extends ObjetBDD
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
        $this->table = "cohorte";
        $this->id_auto = "1";
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
     * @return array <tableau, boolean, $data, string>
     */
    function getListByPoisson($poisson_id)
    {
        if ($poisson_id > 0 && is_numeric($poisson_id)) {
            $sql = "select cohorte_id, cohorte.poisson_id, cohorte_date, cohorte_commentaire,
					cohorte_determination, evenement_type_libelle, cohorte.evenement_id,
					cohorte_type_id, cohorte_type_libelle
					from cohorte
					left outer join cohorte_type using (cohorte_type_id)
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					where cohorte.poisson_id = " . $poisson_id . " order by cohorte_date desc";
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
            $sql = "select * from " . $this->table . " where evenement_id = " . $evenement_id;
            return $this->lireParam($sql);
        }
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
            $poisson = new Poisson($this->connection, $this->paramori);
            $dataPoisson = $poisson->lire($data["poisson_id"]);
            $dataPoisson["cohorte"] = $data["cohorte_determination"];
            $poisson->ecrire($dataPoisson);
        }
        return $ret;
    }
}
