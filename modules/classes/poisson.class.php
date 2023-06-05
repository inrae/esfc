<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 *  Creation 18 févr. 2014
 */

/**
 * ORM de gestion de la table poisson
 *
 * @author quinton
 *        
 */
class Poisson extends ObjetBDD
{
    public Lot $lot;
    public ParentPoisson $parent_poisson;
    public Evenement $evenement;
    public DocumentLie $documentLie;
    public Pittag $pittag;
    public DocumentSturio $documentSturio;
    /**
     * Constructeur de la classe
     *
     * @param
     *            instance ADODB $bdd
     * @param array $param
     */
    function __construct($bdd, $param = array())
    {
        $this->table = "poisson";
        $this->colonnes = array(
            "poisson_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "poisson_statut_id" => array(
                "type" => 1,
                "requis" => 1
            ),
            "sexe_id" => array(
                "type" => 1,
                "requis" => 1,
                "defaultValue" => 3
            ),
            "matricule" => array(
                "type" => 0
            ),
            "prenom" => array(
                "type" => 0
            ),
            "cohorte" => array(
                "type" => 0
            ),
            "capture_date" => array(
                "type" => 2
            ),
            "date_naissance" => array(
                "type" => 2
            ),
            "categorie_id" => array(
                "type" => 1,
                "requis" => 1,
                "defaultValue" => 2
            ),
            "commentaire" => array(
                "type" => 0
            ),
            "vie_modele_id" => array(
                "type" => 1
            )
        );
        parent::__construct($bdd, $param);
    }

    /**
     * Fonction permettant de retourner une liste de poissons selon les criteres specifies
     *
     * @param array $dataSearch
     * @return array
     */
    function getListeSearch($dataSearch)
    {

        $sql = "select poisson_id, sexe_id, matricule, prenom, cohorte, capture_date, 
                sexe_libelle, sexe_libelle_court, poisson_statut_libelle,commentaire,
					pittag_valeur,
					mortalite_date,
					categorie_id, categorie_libelle";
        $from = " from poisson 
                    join sexe using (sexe_id)
					join poisson_statut using (poisson_statut_id)
					join categorie using (categorie_id)
					left outer join mortalite using (poisson_id)					  
					left outer join v_pittag_by_poisson using (poisson_id)";
        if ($dataSearch["displayMorpho"] == 1) {
            $sql .= ", longueur_fourche, longueur_totale, masse";
            $from .= " left outer join v_poisson_last_lf using (poisson_id)
					  left outer join v_poisson_last_lt using (poisson_id)
					  left outer join v_poisson_last_masse using (poisson_id) ";
        }
        if ($dataSearch["displayBassin"] == 1 || $dataSearch["site_id"] > 0) {
            $sql .= ", bassin_id, bassin_nom, site_id, site_name";
            $from .= " left outer join v_poisson_last_bassin using (poisson_id)
                            left outer join site using (site_id)";
        }
        /**
         * Preparation de la clause order
         */
        $order = " order by matricule ";
        /**
         * Preparation de la clause where
         */
        $where = " where ";
        $and = "";
        if ($dataSearch["statut"] > 0) {
            $where .= $and . " poisson_statut_id = :poisson_statut_id";
            $param["poisson_statut_id"] = $dataSearch["statut"];
            $and = " and ";
        }
        if ($dataSearch["categorie"] > 0) {
            $where .= $and . " categorie_id = :categorie_id";
            $param["categorie_id"] = $dataSearch["categorie"];
            $and = " and ";
        }
        if ($dataSearch["sexe"] > 0) {
            $where .= $and . " sexe_id = :sexe_id";
            $param["sexe_id"] = $dataSearch["sexe"];
            $and = " and ";
        }
        if (strlen($dataSearch["texte"]) > 0) {
            $texte = "%" . mb_strtoupper($dataSearch["texte"], 'UTF-8') . "%";
            $where .= $and . " (upper(matricule) like :texte
						or upper(prenom) like :texte
						or cohorte like :texte
						or upper(pittag_valeur) like :texte";
            $param["texte"] = $texte;
            if (is_numeric($dataSearch["texte"])) {
                $where .= " or poisson_id = :texte";
            }
            $where .= ")";
            $and = " and ";
        }
        if ($dataSearch["site_id"] > 0) {
            $where .= $and . " site_id = :site_id ";
            $param["site_id"] = $dataSearch["site_id"];
            $and = " and ";
        }
        if (strlen($where) > 7) {
            $this->colonnes["mortalite_date"] = array("type" => 2);
            $data = $this->getListeParamAsPrepared($sql . $from . $where . $order, $param);
        }
        /**
         * Recherche des temperatures cumulees
         */
        if ($dataSearch["displayCumulTemp"] == 1) {
            foreach ($data as $key => $value) {
                $data[$key]["temperature"] = $this->calcul_temperature($value["poisson_id"], $dataSearch["dateDebutTemp"], $dataSearch["dateFinTemp"]);
            }
        }
        return ($data);
    }

    /**
     * Retourne le detail d'un poisson
     *
     * @param int $poisson_id
     * @return array
     */
    function getDetail(int $poisson_id)
    {
        $sql = "select p.poisson_id, sexe_id, matricule, prenom, cohorte, capture_date, sexe_libelle, sexe_libelle_court, poisson_statut_libelle,
					pittag_valeur, p.poisson_statut_id, date_naissance,
					bassin_nom, b.bassin_id, b.site_id, site_name, 
					categorie_id, categorie_libelle, commentaire
                    from poisson p 
                     join sexe using (sexe_id)
					  join poisson_statut using (poisson_statut_id)
					  join categorie using (categorie_id)
					  left outer join v_pittag_by_poisson using (poisson_id)
					  /*left outer join v_transfert_last_bassin_for_poisson vlast on (vlast.poisson_id = p.poisson_id)
					  left outer join transfert t on (vlast.poisson_id = t.poisson_id and transfert_date_last = transfert_date)
                      left outer join bassin b on (b.bassin_id = (case when t.bassin_destination is not null then t.bassin_destination else t.bassin_origine end))*/
                      left outer join v_poisson_last_bassin b using (poisson_id)
                      left outer join site on (b.site_id = site.site_id)
					 where p.poisson_id = :poisson_id";
        return $this->lireParamAsPrepared($sql, array("poisson_id" => $poisson_id));
    }

    /**
     * Fonction retournant la liste des poissons correspondant au libellé fourni
     *
     * @param string $libelle
     * @return array
     */
    function getListPoissonFromName($libelle)
    {
        if (!empty($libelle)) {
            $libelle = "%" . $libelle . "%";
            $sql = "select poisson.poisson_id, matricule, prenom, pittag_valeur 
					from poisson
					left outer join v_pittag_by_poisson using (poisson_id)
					where upper(matricule) like upper(:libelle) 
					or upper(prenom) like upper(:libelle)
					or upper(pittag_valeur) like upper(:libelle)
					order by matricule, pittag_valeur, prenom";
            return $this->getListeParamAsPrepared($sql, array("libelle" => $libelle));
        } else {
            return array();
        }
    }

    /**
     * Surcharge de la fonction ecrire pour generer les parents et la date de naissance
     * si indication du modele de marque VIE utilise
     * (non-PHPdoc)
     *
     * @see ObjetBDD::ecrire()
     */
    function ecrire($data)
    {
        /*
         * Recuperation des donnees de naissance, si vie_modele_id est renseigne
         */
        $dataLot = array();
        if ($data["vie_modele_id"] > 0) {
            if (!isset($this->lot)) {
                $this->lot = $this->classInstanciate("Lot", "lot.class.php");
            }
            $dataLot = $this->lot->getFromVieModele($data["vie_modele_id"]);
            if ($dataLot["lot_id"] > 0) {
                /*
                 * Mise a jour de la date de naissance
                 */
                if (strlen($dataLot["eclosion_date"]) > 0) {
                    $data["date_naissance"] = $dataLot["eclosion_date"];
                    $date = explode("/", $dataLot["eclosion_date"]);
                    $data["cohorte"] = $date[2];
                }
            }
        }
        /*
         * Ecriture de l'enregistrement
         */
        $id = parent::ecrire($data);
        if ($id > 0 && $dataLot["lot_id"] > 0) {
            /*
             * Recuperation et ecriture des parents
             */
            $parents = $this->lot->getParents($dataLot["lot_id"]);
            $parentArray = array();
            /*
             * Formatage de la liste en tableau simple, pour prise en compte par la fonction ad-hoc
             */
            foreach ($parents as $value)
                $parentArray[] = $value["poisson_id"];
            /*
             * Ecriture des parents
             */
            $this->ecrireTableNN("parent_poisson", "poisson_id", "parent_id", $id, $parentArray);
        }
        return $id;
    }

    /**
     * Réécriture de la fonction supprimer, pour vérifier si c'est possible, et supprimer les enregistrements
     * dans les tables liées
     * (non-PHPdoc)
     *
     * @see ObjetBDD::supprimer()
     */
    function supprimer($id)
    {

        $retour = 0;
        /*
             * Vérification des liens non supprimables
             */
        /*
             * Recherche des poissons "enfants"
             */
        if (!isset($this->parent_poisson)) {
            $this->parent_poisson = $this->classInstanciate("ParentPoisson", "parent_poisson.class.php");
        }
        $listeEnfant = $this->parent_poisson->lireEnfant($id);
        if (is_array($listeEnfant) == true && count($listeEnfant) > 0) {
            $detailEnfant = "";
            foreach ($listeEnfant as $key => $value)
                $detailEnfant .= $value["matricule"] . " ";
            $retour = -1;
            $this->errorData[] = array(
                "code" => 0,
                "message" => "Le poisson est défini comme le parent d'autres poissons (" . $detailEnfant . ")"
            );
        }
        if ($retour == 0) {
            /*
                 * Vérification des événements
                 */
            if (!isset($this->evenement)) {
                $this->evenement = $this->classInstanciate("Evenement", "evenement.class.php");
            }
            $listeEvenement = $this->evenement->getEvenementByPoisson($id);
            if (is_array($listeEvenement) && count($listeEvenement) > 0) {
                $retour = -1;
                $this->errorData[] = array(
                    "code" => 0,
                    "message" => "Le poisson contient des événements qui doivent être supprimés préalablement"
                );
            }
        }
        if ($retour == 0) {
            /*
             * Suppression dans les tables liées
             */
            /*
             * Documents
             */
            if (isset($this->documentLie)) {
                include_once $this->classpath . "/documentLie.class.php";
                $this->documentLie = new DocumentLie($this->connection, $this->paramori, "poisson");
            }
            if (!isset($this->documentSturio)) {
                $this->documentSturio = $this->classInstanciate("DocumentSturio", "documentSturio.class.php");
            }
            $listeDocument = $this->documentLie->getListeDocument($id);
            foreach ($listeDocument as  $value) {
                if ($value["document_id"] > 0)
                    $this->documentSturio->supprimer($value["document_id"]);
            }
            /*
             * Pittag
             */
            if (!isset($this->pittag)) {
                $this->pittag = $this->classInstanciate("Pittag", "pittag.class.php");
            }
            $pittag->supprimerChamp($id, "poisson_id");
            /*
             * Suppression du poisson
             */
            $retour = parent::supprimer($id);
        }
        return $retour;
    }

    /**
     * Fonction permettant de calculer le cumul de temperature recu par un poisson
     * entre deux dates, en fonction des bassins frequentes
     *
     * @param int $poisson_id
     * @param string $date_debut
     * @param string $date_fin
     * @return numeric
     */
    function calcul_temperature($poisson_id, $date_debut, $date_fin)
    {
        $date_debut = $this->formatDateLocaleVersDB($date_debut);
        $date_fin = $this->formatDateLocaleVersDB($date_fin);

        /**
         * Recherche des bassins frequentes
         */
        $sql = "select pb.* from v_poisson_bassins pb
            where (:date_debut, :date_fin) overlaps 
                (date_debut, case when date_fin is null then '2050-12-31' else date_fin end)
				and poisson_id = :poisson_id
				order by date_debut, date_fin";
        $bassins = $this->getListeParamAsPrepared($sql, array(
            "date_debut" => $date_debut,
            "date_fin" => $date_fin,
            "poisson_id" => $poisson_id
        ));
        $temperature = 0;
        foreach ($bassins as $bassin) {
            if ($bassin["date_debut"] < $date_debut)
                $bassin["date_debut"] = $date_debut;
            if (strlen($bassin["date_fin"]) == 0)
                $bassin["date_fin"] = $date_fin;
            /*
                 * Calcul du total de la temperature
                 */
            $sqltemp = "with gs as (
				select generate_series('" . $bassin["date_debut"] . "'::date, '" . $bassin["date_fin"] . "'::date, interval ' 1 day') as date_jour
				)
				select  sum( ae.temperature) as temperature
				from gs, analyse_eau ae, circuit_eau ce, bassin b
				where b.circuit_eau_id = ce.circuit_eau_id 
				and b.bassin_id = " . $bassin["bassin_id"] . "
				and ae.circuit_eau_id = ce.circuit_eau_id
				and ae.analyse_eau_id = 
				(select a2.analyse_eau_id from analyse_eau a2
				join circuit_eau ce2 using (circuit_eau_id)
				where a2.temperature is not null
				and a2.analyse_eau_date <= gs.date_jour
				and ce.circuit_eau_id = ce2.circuit_eau_id
				order by a2.analyse_eau_date desc limit 1)
				";
            $dataTotal = $this->lireParam($sqltemp);
            if ($dataTotal["temperature"] > 0)
                $temperature += $dataTotal["temperature"];
        }
        return $temperature;
    }
}
