<?php

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
class Evenement extends ObjetBDD
{

    /**
     * Constructeur de la classe
     *
     * @param
     *            instance ADODB $bdd
     * @param array $param
     */
    function __construct($bdd, $param = null)
    {
        $this->param = $param;
        $this->paramori = $param;
        $this->table = "evenement";
        $this->id_auto = "1";
        $this->colonnes = array(
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
        if (! is_array($param))
            $param == array();
        $param["fullDescription"] = 1;
        parent::__construct($bdd, $param);
    }

    /**
     * Retourne les événements associés à un poisson
     *
     * @param int $poisson_id
     * @return array
     */
    function getEvenementByPoisson($poisson_id)
    {
        if ($poisson_id > 0 && is_numeric($poisson_id)) {
            $sql = "select evenement_id, poisson_id, evenement_date, evenement_type_libelle,
 					evenement_commentaire
 					from evenement
 					left outer join evenement_type using (evenement_type_id)
 					where poisson_id = " . $poisson_id . "order by evenement_date desc";
            return $this->getListeParam($sql);
        }
    }

    /**
     * Retourne l'ensemble des données d'événement pour les poissons répondant aux critères fournis
     * 
     * @param array $dataSearch
     * @return tableau
     */
    function getAllEvenements($dataSearch)
    {
        $dataSearch = $this->encodeData($dataSearch);
        if (is_array($dataSearch)) {
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
            $and = "";
            if ($dataSearch["statut"] > 0 && is_numeric($dataSearch["statut"])) {
                $where .= $and . " p.poisson_statut_id = " . $dataSearch["statut"];
                $and = " and ";
            }
            if ($dataSearch["categorie"] > 0 && is_numeric($dataSearch["categorie"])) {
                $where .= $and . " p.categorie_id = " . $dataSearch["categorie"];
                $and = " and ";
            }
            if ($dataSearch["sexe"] > 0 && is_numeric($dataSearch["sexe"])) {
                $where .= $and . " p.sexe_id = " . $dataSearch["sexe"];
                $and = " and ";
            }
            if (strlen($dataSearch["texte"]) > 0) {
                $texte = "%" . mb_strtoupper($dataSearch["texte"], 'UTF-8') . "%";
                $where .= $and . " (upper(matricule) like '" . $texte . "' 
						or upper(prenom) like '" . $texte . "' 
						or cohorte like '" . $texte . "' 
						or upper(pittag_valeur) like '" . $texte . "')";
            }
            if (strlen($where) == 7)
                $where = "";
            /* printr($sql.$from.$where.$order); */
            $data = $this->getListeParam($sql . $from . $where . /*$group .*/ $order);
            return $data;
        }
    }

    /**
     * Surcharge de la fonction supprimer, pour effacer les enregistrements dans les tables filles
     * (non-PHPdoc)
     *
     * @see ObjetBDD::supprimer()
     */
    function supprimer($id)
    {
        if ($id > 0 && is_numeric($id)) {
            /*
             * Traitement des suppressions en cascade
             */
            /*
             * pathologie
             */
            $pathologie = new Pathologie($this->connection, $this->paramori);
            $pathologie->supprimerChamp($id, "evenement_id");
            /*
             * Morphologie
             */
            $morphologie = new Morphologie($this->connection, $this->paramori);
            $morphologie->supprimerChamp($id, "evenement_id");
            /*
             * Gender_selection
             */
            $genderSelection = new Gender_selection($this->connection, $this->paramori);
            $genderSelection->supprimerChamp($id, "evenement_id");
            /*
             * Transfert
             */
            $transfert = new Transfert($this->connection, $this->paramori);
            $transfert->supprimerChamp($id, "evenement_id");
            /*
             * Anomalie
             */
            $anomalie = new Anomalie_db($this->connection, $this->paramori);
            $anomalie->supprimerChamp($id, "evenement_id");
            /*
             * Cohorte
             */
            $cohorte = new Cohorte($this->connection, $this->paramori);
            $cohorte->supprimerChamp($id, "evenement_id");
            /*
             * Sortie
             */
            $sortie = new Sortie($this->connection, $this->paramori);
            $sortie->supprimerChamp($id, "evenement_id");
            /*
             * Echographie
             */
            $echographie = new Echographie($this->connection, $this->paramori);
            $echographie->supprimerChamp($id, "evenement_id");
            /*
             * Anesthesie
             */
            $anesthesie = new Anesthesie($this->connection, $this->paramori);
            $anesthesie->supprimerChamp($id, "evenement_id");
            /*
             * Mortalite
             */
            $mortalite = new Mortalite($this->connection, $this->paramori);
            $mortalite->supprimerChamp($id, "evenement_id");
            /*
             * Dosage sanguin
             */
            require_once 'modules/classes/dosageSanguin.class.php';
            $dosageSanguin = new DosageSanguin($this->connection, $this->paramori);
            $dosageSanguin->supprimerChamp($id, "evenement_id");
            /*
             * Genetique
             */
            $genetique = new Genetique($this->connection, $this->paramori);
            $genetique->supprimerChamp($id, "evenement_id");
            /*
             * Determination de la parente
             */
            $parente = new Parente($this->connection, $this->paramori);
            $parente->supprimerChamp($id, "evenement_id");
            /*
             * Documents associes
             */
            $sql = "delete from evenement_document where evenement_id = " . $id;
            $this->executeSQL($sql);
            /*
             * Suppression finale de l'evenement
             */
            return parent::supprimer($id);
        }
    }
}

/**
 * ORM de la table evenement_type
 *
 * @author quinton
 *        
 */
class Evenement_type extends ObjetBDD
{

    /**
     * Constructeur de la classe
     *
     * @param
     *            instance ADODB $bdd
     * @param array $param
     */
    function __construct($bdd, $param = null)
    {
        $this->param = $param;
        $this->table = "evenement_type";
        $this->id_auto = "1";
        $this->colonnes = array(
            "evenement_type_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "evenement_type_libelle" => array(
                "type" => 0,
                "requis" => 1
            ),
            "evenement_type_actif" => array(
                "type" => 1,
                "requis" => 1,
                "defaultValue" => 1
            )
        );
        if (! is_array($param))
            $param == array();
        $param["fullDescription"] = 1;
        parent::__construct($bdd, $param);
    }

    /**
     * Reecriture de la fonction pour trier la liste
     * (non-PHPdoc)
     *
     * @see ObjetBDD::getListe()
     */
    function getListe()
    {
        $sql = 'select * from ' . $this->table . ' order by evenement_type_libelle';
        return $this->getListeParam($sql);
    }
}
?>