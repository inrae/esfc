<?php
/**
 * ORM de gestion de la table Transfert
 *
 * @author quinton
 *        
 */
class Transfert extends ObjetBDD
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
        $this->table = "transfert";
        $this->id_auto = "1";
        $this->colonnes = array(
            "transfert_id" => array(
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
            "bassin_origine" => array(
                "type" => 1
            ),
            "bassin_destination" => array(
                "type" => 1
            ),
            "transfert_date" => array(
                "type" => 2,
                "requis" => 1
            ),
            "evenement_id" => array(
                "type" => 1
            ),
            "transfert_commentaire" => array(
                "type" => 0
            )
        );
        parent::__construct($bdd, $param);
    }

    /**
     * Retourne la liste des transferts pour un poisson
     *
     * @param int $poisson_id
     * @return array
     */
    function getListByPoisson($poisson_id, $annee = 0)
    {
        if ($poisson_id > 0 && is_numeric($poisson_id)) {
            $sql = 'select transfert_id, transfert.poisson_id, bassin_origine, bassin_destination, transfert_date, evenement_id,
					ori.bassin_nom as "bassin_origine_nom", dest.bassin_nom as "bassin_destination_nom",
					evenement_id, evenement_type_libelle, transfert_commentaire
					from transfert
					join poisson using (poisson_id)
					left outer join bassin ori on (bassin_origine = ori.bassin_id)
					left outer join bassin dest on (bassin_destination = dest.bassin_id)
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)';
            $where = ' where transfert.poisson_id = ' . $poisson_id;
            if ($annee > 0 && is_numeric($annee))
                $where .= " and extract(year from transfert_date) = " . $annee;
            $order = " order by transfert_date desc";
            return $this->getListeParam($sql . $where . $order);
        }
    }

    /**
     * Calcule la liste des poissons presents dans un bassin
     *
     * @param int $bassin_id
     * @return array
     */
    function getListPoissonPresentByBassin($bassin_id)
    {
        if ($bassin_id > 0 && is_numeric($bassin_id)) {
            $sql = 'select distinct t.poisson_id,matricule, prenom, cohorte, t.transfert_date, 
					(case when t.bassin_destination is not null then t.bassin_destination else t.bassin_origine end) as "bassin_id",
					bassin_nom, sexe_libelle_court,
					pittag_valeur, masse
 					from transfert t
 					join v_transfert_last_bassin_for_poisson v on (v.poisson_id = t.poisson_id and transfert_date_last = transfert_date)
					join bassin on (bassin.bassin_id = (case when t.bassin_destination is not null then t.bassin_destination else t.bassin_origine end))
					join poisson on (t.poisson_id = poisson.poisson_id)
					left outer join v_pittag_by_poisson pittag on (pittag.poisson_id = poisson.poisson_id)
					left outer join v_poisson_last_masse vmasse on (t.poisson_id = vmasse.poisson_id)
					left outer join sexe using (sexe_id)
					where  poisson_statut_id = 1 and bassin.bassin_id = ' . $bassin_id . "
 					order by matricule";
        }
        return ($this->getListeParam($sql));
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
            $sql = "select * from transfert where evenement_id = " . $evenement_id;
            return $this->lireParam($sql);
        }
    }

    /**
     * Complement de la fonction ecrire pour mettre a jour le statut de l'animal,
     * en cas de transfert dans un bassin adulte
     * (non-PHPdoc)
     *
     * @see ObjetBDD::ecrire()
     */
    function ecrire($data)
    {
        $transfert_id = parent::ecrire($data);
        if ($transfert_id > 0 && $data["bassin_destination"] > 0 && $data["poisson_id"] > 0) {
            /*
             * Recuperation de l'usage du bassin
             */
            $bassin = new Bassin($this->connection, $this->paramori);
            $dataBassin = $bassin->lire($data["bassin_destination"]);
            if ($dataBassin["bassin_usage_id"] == 1) {
                /*
                 * Recuperation du poisson
                 */
                $poisson = new Poisson($this->connection, $this->paramori);
                $dataPoisson = $poisson->lire($data["poisson_id"]);
                if ($dataPoisson["poisson_categorie_id"] == 2) {
                    $dataPoisson["poisson_categorie_id"] = 1;
                    $poisson->ecrire($dataPoisson);
                }
            }
        }
        return $transfert_id;
    }
}
