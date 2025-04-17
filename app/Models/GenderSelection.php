<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table gender_selection
 *
 * @author quinton
 *        
 */
class GenderSelection extends PpciModel
{
    public Poisson $poisson;

    function __construct()
    {
        $this->table = "gender_selection";
        $this->fields = array(
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
        parent::__construct();
    }

    /**
     * Surcharge de la fonction ecrire, pour mettre a jour le sexe dans l'enregistrement poisson, le cas echeant
     * (non-PHPdoc)
     *
     * @see ObjetBDD::ecrire()
     */
    function write($data): int
    {
        if (strlen($data["gender_selection_id"])== 0) {
            $data["gender_selection_id"] = 0;
        }
        $ret = parent::write($data);
        if ($ret > 0 && $data["poisson_id"] > 0) {
            /*
             * S'il s'agit d'une determination expert ou par échographie, on force le sexe
             */
            if ($data["gender_methode_id"] == 1 || $data["gender_methode_id"] == 4) {
                if (!isset($this->poisson)) {
                    $this->poisson = new Poisson;
                }
                $dataPoisson = $this->poisson->lire($data["poisson_id"]);
                $dataPoisson["sexe_id"] = $data["sexe_id"];
                $this->poisson->ecrire($dataPoisson);
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
        $sql = "SELECT gender_selection_id, g.poisson_id, gender_selection_date, gender_selection_commentaire,
					gender_methode_libelle, sexe_libelle_court, sexe_libelle, g.evenement_id,
					evenement_type_libelle
					from gender_selection g
					left outer join gender_methode using (gender_methode_id)
					left outer join sexe using (sexe_id)
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					where g.poisson_id = :id: order by gender_selection_date desc";
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
        $sql = "SELECT * from gender_selection where evenement_id = :id:";
        return $this->lireParamAsPrepared($sql, array("id" => $evenement_id));
    }
}
