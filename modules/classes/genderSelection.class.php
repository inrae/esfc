<?php
/**
 * ORM de gestion de la table gender_selection
 *
 * @author quinton
 *        
 */
class Gender_selection extends ObjetBDD
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
        $this->param = $param;
        $this->paramori = $param;
        $this->table = "gender_selection";
        $this->id_auto = "1";
        $this->colonnes = array(
            "gender_selection_id" => array(
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
            "gender_methode_id" => array(
                "type" => 1
            ),
            "sexe_id" => array(
                "type" => 1
            ),
            "gender_selection_date" => array(
                "type" => 2
            ),
            "evenement_id" => array(
                "type" => 1
            ),
            "gender_selection_commentaire" => array(
                "type" => 0
            )
        );
        parent::__construct($bdd, $param);
    }

    /**
     * Surcharge de la fonction ecrire, pour mettre a jour le sexe dans l'enregistrement poisson, le cas echeant
     * (non-PHPdoc)
     *
     * @see ObjetBDD::ecrire()
     */
    function ecrire($data)
    {
        $ret = parent::ecrire($data);
        if ($ret > 0 && $data["poisson_id"] > 0) {
            /*
             * S'il s'agit d'une determination expert ou par échographie, on force le sexe
             */
            if ($data["gender_methode_id"] == 1 || $data["gender_methode_id"] == 4) {
                $poisson = new Poisson($this->connection, $this->paramori);
                $dataPoisson = $poisson->lire($data["poisson_id"]);
                $dataPoisson["sexe_id"] = $data["sexe_id"];
                $poisson->ecrire($dataPoisson);
            }
        }
        return $ret;
    }

    /**
     * Recupère la liste des déterminations sexuelles pour un poisson
     *
     * @param int $poisson_id
     * @return array
     */
    function getListByPoisson($poisson_id)
    {
        if ($poisson_id > 0 && is_numeric($poisson_id)) {
            $sql = "select gender_selection_id, g.poisson_id, gender_selection_date, gender_selection_commentaire,
					gender_methode_libelle, sexe_libelle_court, sexe_libelle, g.evenement_id,
					evenement_type_libelle
					from gender_selection g
					left outer join gender_methode using (gender_methode_id)
					left outer join sexe using (sexe_id)
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					where g.poisson_id = " . $poisson_id . " order by gender_selection_date desc";
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
            $sql = "select * from gender_selection where evenement_id = " . $evenement_id;
            return $this->lireParam($sql);
        }
    }
}
