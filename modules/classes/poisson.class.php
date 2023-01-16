<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 *  Creation 18 févr. 2014
 */
include_once 'modules/classes/categorie.class.php';
include_once 'modules/classes/evenement.class.php';
include_once 'modules/classes/documentSturio.class.php';

/**
 * ORM de gestion de la table poisson
 *
 * @author quinton
 *        
 */
class Poisson extends ObjetBDD
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
        $this->table = "poisson";
        $this->id_auto = "1";
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
        if (is_array($dataSearch)) {
            $dataSearch = $this->encodeData($dataSearch);
            $sql = "select poisson_id, sexe_id, matricule, prenom, cohorte, capture_date, sexe_libelle, sexe_libelle_court, poisson_statut_libelle,commentaire,
					pittag_valeur,
					mortalite_date,
					categorie_id, categorie_libelle";
            $from = " from " . $this->table . " natural join sexe
					  natural join poisson_statut
					  natural join categorie
					  left outer join mortalite using (poisson_id)					  
					  left outer join v_pittag_by_poisson using (poisson_id)";
            if ($dataSearch["displayMorpho"] == 1) {
                $sql .= ", longueur_fourche, longueur_totale, masse";
                $from .= " left outer join v_poisson_last_lf using (poisson_id)
					  left outer join v_poisson_last_lt using (poisson_id)
					  left outer join v_poisson_last_masse using (poisson_id) ";
            }
            if ($dataSearch["displayBassin"] == 1 || $dataSearch["site_id"]> 0) {
                $sql .= ", bassin_id, bassin_nom, site_id, site_name";
                $from .= " left outer join v_poisson_last_bassin using (poisson_id)
                            left outer join site using (site_id)";
            }
            /*
             * Preparation de la clause group by
             */
            /*
             * $group = " group by poisson_id, sexe_id, matricule, prenom,
             * cohorte, capture_date, sexe_libelle, sexe_libelle_court, poisson_statut_libelle, mortalite_date,
             * categorie_id, categorie_libelle, commentaire ";
             */
            /*
             * Preparation de la clause order
             */
            $order = " order by matricule ";
            /*
             * Preparation de la clause where
             */
            $where = " where ";
            $and = "";
            if ($dataSearch["statut"] > 0 && is_numeric($dataSearch["statut"])) {
                $where .= $and . " poisson_statut_id = " . $dataSearch["statut"];
                $and = " and ";
            }
            if ($dataSearch["categorie"] > 0 && is_numeric($dataSearch["categorie"])) {
                $where .= $and . " categorie_id = " . $dataSearch["categorie"];
                $and = " and ";
            }
            if ($dataSearch["sexe"] > 0 && is_numeric($dataSearch["sexe"])) {
                $where .= $and . " sexe_id = " . $dataSearch["sexe"];
                $and = " and ";
            }
            if (strlen($dataSearch["texte"]) > 0) {
                $texte = "%" . mb_strtoupper($dataSearch["texte"], 'UTF-8') . "%";
                $where .= $and . " (upper(matricule) like '" . $texte . "' 
						or upper(prenom) like '" . $texte . "' 
						or cohorte like '" . $texte . "' 
						or upper(pittag_valeur) like '" . $texte . "'";
                if (is_numeric($dataSearch["texte"])) {
                    $where .= " or poisson_id = " . $dataSearch["texte"];
                }
                $where .= ")";
                $and = " and ";
            }
            if ($dataSearch["site_id"] > 0 && is_numeric($dataSearch["site_id"])) {
                $where .= $and . " site_id = " . $dataSearch["site_id"];
                $and = " and ";
            }
            if (strlen($where) > 7)
                $data = $this->getListeParam($sql . $from . $where . /*$group .*/ $order);
            /*
             * Mise en forme des dates
             */
            foreach ($data as $key => $value) {
                if (strlen($value["mortalite_date"]) > 0)
                    $data[$key]["mortalite_date"] = $this->formatDateDBversLocal($value["mortalite_date"]);
            }
            /*
             * Recherche des temperatures cumulees
             */
            if ($dataSearch["displayCumulTemp"] == 1) {
                foreach ($data as $key => $value) {
                    $data[$key]["temperature"] = $this->calcul_temperature($value["poisson_id"], $dataSearch["dateDebutTemp"], $dataSearch["dateFinTemp"]);
                }
            }
            return ($data);
        }
    }

    /**
     * Retourne le detail d'un poisson
     *
     * @param int $poisson_id
     * @return array
     */
    function getDetail($poisson_id)
    {
        if ($poisson_id > 0 && is_numeric($poisson_id)) {
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
							";
            $where = " where p.poisson_id = " . $poisson_id;
            return $this->lireParam($sql . $where);
        }
    }

    /**
     * Fonction retournant la liste des poissons correspondant au libellé fourni
     *
     * @param string $libelle
     * @return array
     */
    function getListPoissonFromName($libelle)
    {
        if (strlen($libelle) > 0) {
            $libelle = $this->encodeData($libelle);
            $sql = "select poisson.poisson_id, matricule, prenom, pittag_valeur 
					from " . $this->table . "
					left outer join v_pittag_by_poisson using (poisson_id)
					where upper(matricule) like upper('%" . $libelle . "%') 
					or upper(prenom) like upper('%" . $libelle . "%')
					or upper(pittag_valeur) like upper('%" . $libelle . "%')
					order by matricule, pittag_valeur, prenom";
            return $this->getListeParam($sql);
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
            require_once 'modules/classes/lot.class.php';
            $lot = new Lot($this->connection, $this->paramori);
            $dataLot = $lot->getFromVieModele($data["vie_modele_id"]);
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
            $parents = $lot->getParents($dataLot["lot_id"]);
            $parentArray = array();
            /*
             * Formatage de la liste en tableau simple, pour prise en compte par la fonction ad-hoc
             */
            foreach ($parents as $key => $value)
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
        if ($id > 0 && is_numeric($id)) {
            $retour = 0;
            /*
             * Vérification des liens non supprimables
             */
            /*
             * Recherche des poissons "enfants"
             */
            $parent_poisson = new Parent_poisson($this->connection, $this->paramori);
            $listeEnfant = $parent_poisson->lireEnfant($id);
            if (is_array($listeEnfant) == true && count($listeEnfant) > 0) {
                $detailEnfant = "";
                foreach ($listeEnfant as $key => $value)
                    $detailEnfant .= $value["matricule"] . " ";
                $retour = - 1;
                $this->errorData[] = array(
                    "code" => 0,
                    "message" => "Le poisson est défini comme le parent d'autres poissons (" . $detailEnfant . ")"
                );
            }
            if ($retour == 0) {
                /*
                 * Vérification des événements
                 */
                $evenement = new Evenement($this->connection, $this->paramori);
                $listeEvenement = $evenement->getEvenementByPoisson($id);
                if (is_array($listeEvenement) && count($listeEvenement) > 0) {
                    $retour = - 1;
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
                $documentLie = new DocumentLie($this->connection, $this->paramori, "poisson");
                $listeDocument = $documentLie->getListeDocument($id);
                $documentSturio = new DocumentSturio($this->connection, $this->paramori);
                foreach ($listeDocument as $key => $value) {
                    if ($value["document_id"] > 0)
                        $documentSturio->supprimer($value["document_id"]);
                }
                /*
                 * Pittag
                 */
                $pittag = new Pittag($this->connection, $this->paramori);
                $pittag->supprimerChamp($id, "poisson_id");
                /*
                 * Suppression du poisson
                 */
                $retour = parent::supprimer($id);
            }
        }
        return $retour;
    }

    /**
     * Fonction permettant de calculer le cumul de temperature recu par un poisson
     * entre deux dates, en fonction des bassins frequentes
     *
     * @param int $poisson_id
     * @param date $date_debut
     * @param date $date_fin
     * @return numeric
     */
    function calcul_temperature($poisson_id, $date_debut, $date_fin)
    {
        $date_debut = $this->encodeData($date_debut);
        $date_debut = $this->formatDateLocaleVersDB($date_debut);
        $date_fin = $this->encodeData($date_fin);
        $date_fin = $this->formatDateLocaleVersDB($date_fin);
        if (is_numeric($poisson_id) && $poisson_id > 0) {
            /*
             * Recherche des bassins frequentes
             */
            $sql = "select pb.* from v_poisson_bassins pb
				where (date_debut <= '" . $date_debut . "' and ( date_fin > '" . $date_fin . "' or date_fin is null)
				or (date_debut <= '" . $date_debut . "' and date_fin > '" . $date_debut . "')
				or (date_debut > '" . $date_debut . "' and date_fin <= '" . $date_fin . "')
				or (date_debut between '" . $date_debut . "' and '" . $date_fin . "' and (date_fin > '" . $date_fin . "' or date_fin is null))
				)
				and poisson_id = " . $poisson_id . "
				order by date_debut, date_fin";
            $bassins = $this->getListeParam($sql);
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
}
