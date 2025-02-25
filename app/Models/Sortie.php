<?php

namespace App\Models;

use Ppci\Models\PpciModel;

class Sortie extends PpciModel
{

    public Poisson $poisson;

    function __construct()
    {
        $this->table = "sortie";
        $this->fields = array(
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
        parent::__construct();
    }

    /**
     * Surcharge de la fonction ecrire
     * pour mettre a jour le statut du poisson
     * (non-PHPdoc)
     *
     * @see ObjetBDD::ecrire()
     */
    function write($data): int
    {
        $sortie_id = parent::write($data);
        if ($sortie_id > 0 && $data["poisson_id"] > 0) {
            /*
             * Lecture du poisson
             */
            if (!isset($this->poisson)) {
                $this->poisson = new Poisson;
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
        $sql = "SELECT sortie_id, sortie.poisson_id, sortie_date, sortie_commentaire,
					localisation, evenement_type_libelle, sortie.evenement_id, sevre
					from sortie
					left outer join sortie_lieu using (sortie_lieu_id)
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					where sortie.poisson_id = :id: order by sortie_date desc";
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
        $sql = "SELECT sortie_id, poisson_id, sortie_date, sortie_commentaire,
					localisation, evenement_id, sortie_lieu_id, sevre
					from sortie
					left outer join sortie_lieu using (sortie_lieu_id)
					where evenement_id = :id:";
        return $this->lireParamAsPrepared($sql, array("id" => $evenement_id));
    }
}
