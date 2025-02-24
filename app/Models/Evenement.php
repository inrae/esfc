<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 *  Creation 18 févr. 2014
 */
/**
 * ORM de la table evenement
 *
 * @author quinton
 *        
 */
class Evenement extends PpciModel
{
    public $evenementType;
    public $poisson;

    /**
     * Constructeur de la classe
     *
     * @param PDO $bdd
     * @param array $param
     */
    function __construct()
    {
        $this->table = "evenement";
        $this->fields = array(
            "evenement_id" => array(
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
            "evenement_type_id" => array(
                "type" => 1,
                "requis" => 1
            ),
            "evenement_date" => array(
                "type" => 2,
                "requis" => 1,
                "defaultValue" => "getDateJour"
            ),
            "evenement_commentaire" => array(
                "type" => 0
            )
        );
        parent::__construct();
    }

    /**
     * Retourne les événements associés à un poisson
     *
     * @param int $poisson_id
     * @return array
     */
    function getEvenementByPoisson(int $poisson_id)
    {
        $sql = "select evenement_id, poisson_id, evenement_date, evenement_type_libelle,
 					evenement_commentaire
                from evenement
 					left outer join evenement_type using (evenement_type_id)
                where poisson_id = :id: order by evenement_date desc";
        return $this->getListeParamAsPrepared($sql, array("id" => $poisson_id));
    }
    /**
     * Get the id of an event occurred on a fish at a date
     *
     * @param integer $poisson_id
     * @param string $date
     * @return integer
     */
    function getEvenementIdByPoissonDate(int $poisson_id, string $date): int
    {
        $sql = "select evenement_id from evenement
                where poisson_id = :poisson_id: and evenement_date = :date:";
        $data = $this->lireParamAsPrepared($sql, array("poisson_id" => $poisson_id, "date" => $date));
        if ($data["evenement_id"] > 0) {
            return $data["evenement_id"];
        } else {
            return 0;
        }
    }

    /**
     * Retourne l'ensemble des données d'événement pour les poissons répondant aux critères fournis
     * 
     * @param array $dataSearch
     * @return array
     */
    function getAllEvenements(array $dataSearch)
    {
        $sql = "select p.poisson_id, matricule, prenom, cohorte, pittag_valeur,					 
 					e.evenement_id, evenement_type_id, evenement_type_libelle,
 					evenement_date, evenement_commentaire,
 					mortalite_date, mortalite_commentaire, mortalite_type_id, mortalite_type_libelle,
 					sortie_date, sortie_commentaire, sevre, sortie_lieu_id, localisation,
 					pathologie_valeur, pathologie_type_id, pathologie_type_libelle, pathologie_commentaire,
 					longueur_fourche, longueur_totale, masse, circonference, morphologie_commentaire,
 					bassin_origine, bassin_destination, transfert_commentaire,
 					b1.bassin_nom as bassin_origine_nom, b2.bassin_nom as bassin_destination_nom,
 					echographie_commentaire, cliche_nb, cliche_ref,
 					cohorte_determination, cohorte_commentaire, cohorte_type_id, cohorte_type_libelle,
 					gender_methode_id, gender_methode_libelle, gs.sexe_id, sexe_libelle, gender_selection_commentaire,
					anesthesie_produit_libelle, anesthesie_dosage, anesthesie_commentaire,
					tx_e2, tx_e2_texte, tx_calcium, tx_hematocrite, dosage_sanguin_commentaire,
                    parente_id, parente_commentaire, determination_parente_libelle
 					";
        $from = " from evenement e 
 					join poisson p using (poisson_id)
					left outer join mortalite on (e.evenement_id = mortalite.evenement_id)
					left outer join mortalite_type using (mortalite_type_id)
					left outer join v_pittag_by_poisson vp on (p.poisson_id = vp.poisson_id )
					left outer join evenement_type using (evenement_type_id)
 					left outer join sortie on (e.evenement_id = sortie.evenement_id)
 					left outer join sortie_lieu using (sortie_lieu_id)
 					left outer join pathologie on (e.evenement_id = pathologie.evenement_id)
 					left outer join pathologie_type using (pathologie_type_id)
 					left outer join morphologie on (e.evenement_id = morphologie.evenement_id)
 					left outer join transfert t on (e.evenement_id = t.evenement_id)
					left outer join bassin b1 on (b1.bassin_id = t.bassin_origine)
 					left outer join bassin b2 on (b2.bassin_id = t.bassin_destination)
 					left outer join echographie on (e.evenement_id = echographie.evenement_id)
 					left outer join cohorte on (e.evenement_id = cohorte.evenement_id)
 					left outer join cohorte_type using (cohorte_type_id)
 					left outer join gender_selection gs on (e.evenement_id = gs.evenement_id)
 					left outer join gender_methode using (gender_methode_id)
					left outer join anesthesie on (e.evenement_id = anesthesie.evenement_id)
					left outer join anesthesie_produit using (anesthesie_produit_id)
					left outer join sexe on (gs.sexe_id = sexe.sexe_id)
					left outer join dosage_sanguin ds on (e.evenement_id = ds.evenement_id)
                    left outer join parente pt on (e.evenement_id = pt.evenement_id)
                    left outer join determination_parente using (determination_parente_id)";
        $order = " order by matricule, evenement_date";
        $where = " where ";
        $param = array();
        $and = "";
        if ($dataSearch["statut"] > 0) {
            $where .= $and . " p.poisson_statut_id = :poisson_statut_id:";
            $and = " and ";
            $param["poisson_statut_id"] = $dataSearch["statut"];
        }
        if ($dataSearch["categorie"] > 0) {
            $where .= $and . " p.categorie_id = :categorie_id:";
            $and = " and ";
            $param["categorie_id"] = $dataSearch["categorie"];
        }
        if ($dataSearch["sexe"] > 0) {
            $where .= $and . " p.sexe_id = :sexe_id:";
            $and = " and ";
            $param["sexe_id"] = $dataSearch["sexe"];
        }
        if (strlen($dataSearch["texte"]) > 0) {
            $texte = "%" . strtoupper($dataSearch["texte"]) . "%";
            $where .= $and . " (upper(matricule) like :texte:
						or upper(prenom) like :texte1:
						or cohorte like :texte2:
						or upper(pittag_valeur) like :texte3:)";
            $param["texte"] = $texte;
            $param["texte1"] = $texte;
            $param["texte2"] = $texte;
            $param["texte3"] = $texte;
        }
        if (strlen($where) == 7) {
            $where = "";
        }
        return $this->getListeParamAsPrepared($sql . $from . $where . $order, $param);
    }

    /**
     * Surcharge de la fonction supprimer, pour effacer les enregistrements dans les tables filles
     * (non-PHPdoc)
     *
     * @see ObjetBDD::supprimer()
     */
    function supprimer($id)
    {
        /**
         * Traitement des suppressions en cascade
         */
        $tables = array(
            "pathologie",
            "morphologie",
            "gender_selection",
            "transfert",
            "anomalie_db",
            "cohorte",
            "sortie",
            "echographie",
            "anesthesie",
            "mortalite",
            "dosage_sanguin",
            "genetique",
            "parente",
            "evenement_document"
        );
        $param = array("id" => $id);
        foreach ($tables as $table) {
            $sql = "delete from $table where evenement_id = :id:";
            $this->executeAsPrepared($sql, $param);
        }
        /**
         * Suppression finale de l'evenement
         */
        return parent::supprimer($id);
    }

    function write($data): int
    {
        $id = parent::write($data);
        if ($id > 0) {
            /**
             * search if a status must be updated
             */
            if (!isset($this->evenementType)) {
                $this->evenementType = new Evenement_type;
            }
            $dtype = $this->evenementType->lire($data["evenement_type_id"]);
            if (!empty($dtype["poisson_statut_id"])) {
                if (!isset($this->poisson)) {
                    $this->poisson = new Poisson;
                }
                $dpoisson = $this->poisson->lire($data["poisson_id"]);
                $dpoisson["poisson_statut_id"] = $dtype["poisson_statut_id"];
                $this->poisson->ecrire($dpoisson);
            }
        }
        return $id;
    }
}
