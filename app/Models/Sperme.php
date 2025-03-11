<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 25 mars 2015
 */
class Sperme extends PpciModel
{

    private $sql = "SELECT distinct on (sperme_date, sperme_id) sperme_id, poisson_campagne_id, sperme_date,
					sequence_id, sequence_nom,
					 sperme_commentaire, 
					sperme_qualite_libelle,
					sperme_mesure_date,
					motilite_initiale, tx_survie_initial,
					motilite_60, tx_survie_60, temps_survie,
					sperme_ph,
					sperme_aspect_id, sperme_aspect_libelle,
					poisson_campagne.annee, poisson_id, matricule, prenom,
					congelation_dates";

    private $from = " from sperme
					natural join poisson_campagne
					natural join poisson
					left outer join sperme_aspect using (sperme_aspect_id)
					left outer join sperme_mesure using (sperme_id)
					left outer join sperme_qualite using (sperme_qualite_id)
					left outer join sequence using (sequence_id)
					left outer join v_sperme_congelation_date using (sperme_id)";
    public SpermeMesure $spermeMesure;
    public SpermeCaract $spermeCaract;

    function __construct()
    {

        $this->table = "sperme";
        $this->fields = array(
            "sperme_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "poisson_campagne_id" => array(
                "type" => 1,
                "requis" => 1,
                "parentAttrib" => 1
            ),
            "sequence_id" => array(
                "type" => 1,
                "requis" => 1
            ),
            "sperme_aspect_id" => array(
                "type" => 1
            ),
            "sperme_date" => array(
                "type" => 3,
                "requis" => 1,
                "defaultValue" => date ($_SESSION["date"]["maskdatelong"])
            ),
            "sperme_volume" => array(
                "type" => 1
            ),

            "sperme_commentaire" => array(
                "type" => 0
            ),
            "sperme_dilueur_id" => array(
                "type" => 1
            )
        );
        parent::__construct();
    }

    /**
     * Surcharge pour ecrire la mesure realisee en meme temps que le prelevement
     *
     * @see ObjetBDD::ecrire()
     */
    function write($data): int
    {
        $id = parent::write($data);
        if ($id > 0 && strlen($_REQUEST["sperme_mesure_date"]) > 0) {

            $data["sperme_id"] = $id;
            /**
             * Ecriture des caracteristiques
             */
            $this->ecrireTableNN("sperme_caract", "sperme_id", "sperme_caracteristique_id", $data["sperme_id"], $data["sperme_caracteristique_id"]);
            /**
             * Ecriture des mesures realisees lors du prelevement
             */
            if (!isset($this->spermeMesure)) {
                $this->spermeMesure = new SpermeMesure;
            }
            $this->spermeMesure->ecrire($data);
        }
        return $id;
    }

    /**
     * Surcharge de la fonction supprimer pour effacer les enregistrements lies
     *
     * {@inheritdoc}
     *
     * @see ObjetBDD::supprimer()
     */
    function supprimer($id)
    {
        if ($id > 0) {
            /**
             * Suppression des informations rattachees
             */
            if (!isset($this->spermeCaract)) {
                $this->spermeCaract = new SpermeCaract;
            }
            if (!isset($this->spermeMesure)) {
                $this->spermeMesure = new SpermeMesure;
            }
            $this->spermeCaract->supprimerChamp($id, "sperme_id");
            $this->spermeMesure->supprimerChamp($id, "sperme_id");
            return parent::supprimer($id);
        }
    }

    /**
     * Retourne la liste des prelevements de sperme pour un poisson
     *
     * @param int $poisson_campagne_id
     * @return array
     */
    function getListFromPoissonCampagne(int $poisson_campagne_id)
    {
        $this->fields["sperme_mesure_date"]["type"] = 3;
        $where = " where poisson_campagne_id = :id:
					order by sperme_date, sperme_id";
        return $this->getListeParamAsPrepared($this->sql . $this->from . $where, array("id" => $poisson_campagne_id));
    }

    /**
     * Retourne la liste des spermes disponibles pour la liste des poissons fournis
     *
     * @param array $poissons
     * @return array
     */
    function getListPotentielFromPoissons(array $poissons)
    {
        if (count($poissons) > 0) {
            $where = " where poisson_id in (";
            $comma = "";
            $i = 0;
            $param = [];
            foreach ($poissons as $value) {
                $where .= $comma . ":id$i:";
                $param["id$i"] = $value;
                $comma = ",";
                $i++;
            }
            $where .= ")";
            $order = " order by matricule, sperme_date";
            return $this->getListeParam($this->sql . $this->from . $where . $order, $param);
        } else {
            return array();
        }
    }

    /**
     * Recherche la liste de tous les spermes potentiels pour un croisement (congeles ou ceux de la sequence)
     *
     * @param int $croisement_id
     * @return array
     */
    function getListPotentielFromCroisement(int $croisement_id)
    {
        $sql = $this->sql . " ,congelation_date, sg.sperme_congelation_id, sg.nb_paillette, sg.nb_paillettes_utilisees ";
        $from = $this->from . " left outer join sperme_congelation sg using (sperme_id) ";
        $where = " where poisson_id in (
					SELECT poisson_id from croisement
					join poisson_croisement using (croisement_id)
					join poisson_campagne using (poisson_campagne_id)
					where croisement_id = :id:
						and (congelation_date is not null
                    or sperme.sequence_id = croisement.sequence_id))
                    ";
        $order = " order by prenom, matricule, sperme_date";
        $sql = "with req as ($sql $from $where ) SELECT * from req $order";
        return $this->getListeParamAsPrepared($sql, array("id" => $croisement_id));
    }

    /**
     * Lit un enregistrement a partir du numero de poisson_campagne et de la sequence
     *
     * @param int $poissonCampagneId
     * @param int $sequenceId
     * @return array
     */
    function readFromSequence(int $poissonCampagneId, int $sequenceId)
    {
        /*
             * Recherche de l'identifiant correspondant
             */
        $sql = "SELECT sperme_id from sperme where poisson_campagne_id = :poissonCampagneId:
					and sequence_id = :sequence_id:";
        $data = $this->lireParamAsPrepared($sql, array(
            "poissonCampagneId" => $poissonCampagneId,
            "sequence_id" => $sequenceId
        ));
        $data["sperme_id"] > 0 ? $id = $data["sperme_id"] : $id = 0;
        return $this->read($id, false);
    }

    /**
     * Surcharge de la fonction lire, pour recuperer la mesure effectuee le meme jour que le prelevement
     *
     * @see ObjetBDD::lire()
     */
    function read($id, $getDefault = true, $defaultValue = 0): array
    {
        $data = parent::read($id, $getDefault,$defaultValue);
        if ($data["sperme_id"] > 0) {
            if (!isset($this->spermeMesure)) {
                $this->spermeMesure = new SpermeMesure;
            }
            $dataMesure = $this->spermeMesure->getFromSpermeDate($data["sperme_id"]);
            foreach ($dataMesure as $key => $value)
                $data[$key] = $value;
        }
        if (!$data["sperme_mesure_id"]> 0) {
            $data["sperme_mesure_id"] = 0;
        }
        return $data;
    }
}
