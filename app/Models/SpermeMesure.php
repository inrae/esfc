<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table sperme_mesure
 *
 * @author quinton
 *        
 */
class SpermeMesure extends PpciModel
{

    private $sql = "SELECT sperme_mesure_id, sperme_id, sperme_mesure_date,
			motilite_initiale, tx_survie_initial, motilite_60, tx_survie_60, temps_survie,
			sperme_ph, nb_paillette_utilise, sperme_qualite_id, sperme_qualite_libelle,
            sperme_congelation_id, concentration
			from sperme_mesure
			join sperme using (sperme_id)
			left outer join sperme_qualite using (sperme_qualite_id)";

    private $order = " order by sperme_mesure_date";
    public SpermeCongelation $spermeCongelation;

    function __construct()
    {
        $this->table = "sperme_mesure";
        $this->fields = array(
            "sperme_mesure_id" => array(
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
            "sperme_qualite_id" => array(
                "type" => 1
            ),
            "sperme_mesure_date" => array(
                "type" => 3,
                "requis" => 1,
                "defaultValue" => $this->getDateTime()
            ),
            "motilite_initiale" => array(
                "type" => 1
            ),
            "tx_survie_initial" => array(
                "type" => 1
            ),
            "motilite_60" => array(
                "type" => 1
            ),
            "tx_survie_60" => array(
                "type" => 1
            ),
            "temps_survie" => array(
                "type" => 1
            ),
            "sperme_ph" => array(
                "type" => 1
            ),
            "nb_paillette_utilise" => array(
                "type" => 1
            ),
            "sperme_congelation_id" => array(
                "type" => 1
            ),
            "concentration" => array("type" => 1)
        );
        parent::__construct();
    }

    /**
     * Surcharge de la fonction ecrire, pour renseigner les caracteristiques et les mesures realisees au moment du prelevement
     *
     * @see ObjetBDD::ecrire()
     */
    function write($data): int
    {
        if ($data["sperme_mesure_id"] > 0) {
            $dataold = $this->lire($data["sperme_mesure_id"]);
        }
        $id = parent::write($data);
        if ($id > 0 && $data["sperme_congelation_id"] > 0) {
            /*
             * Modification du nombre de paillettes utilisees
             */
            $data["sperme_mesure_id"] = $id;
            if (!isset($this->spermeCongelation)) {
                $this->spermeCongelation = new SpermeCongelation;
            }
            $dsc = $this->spermeCongelation->lire($data["sperme_congelation_id"]);
            if (empty ($dataold["nb_paillette_utilise"])) {
                $dataold["nb_paillette_utilise"] = 0;
            }
            if (empty ($data["nb_paillette_utilise"])) {
                $data["nb_paillette_utilise"] = 0;
            }
            $dsc["nb_paillettes_utilisees"] = $dsc["nb_paillettes_utilisees"] - $dataold["nb_paillette_utilise"] + $data["nb_paillette_utilise"];
            $this->spermeCongelation->ecrire($dsc);
        }
        return $id;
    }

    /**
     * Recherche la liste des analyses effectuees
     *
     * @param int $sperme_id
     * @return array
     */
    function getListFromSperme(int $sperme_id)
    {
        $where = " where sperme_id = :id:";
        return $this->getListeParamAsPrepared($this->sql . $where . $this->order, array("id" => $sperme_id));
    }

    /**
     * Retourne la liste des analyses effectuees a partir d'une congelation
     *
     * @param int $sperme_congelation_id
     * @return array
     */
    function getListFromCongelation(int $sperme_congelation_id)
    {
        $where = " where sperme_congelation_id = :id: ";
        return $this->getListeParamAsPrepared($this->sql . $where . $this->order, array("id" => $sperme_congelation_id));
    }

    /**
     * Retourne l'analyse realisee le jour du prelevement
     *
     * @param int $sperme_id
     * @return array
     */
    function getFromSpermeDate(int $sperme_id)
    {
        $where = " where sperme_id = :id:
				and sperme_date::date = sperme_mesure_date::date";
        $limit = " LIMIT 1";
        return $this->lireParamAsPrepared($this->sql . $where . $this->order . $limit, array("id" => $sperme_id));
    }
}
