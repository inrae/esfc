<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 *
 * @author quinton
 *
 */
class PoissonCampagne extends PpciModel
{

	public Morphologie $morphologie;

	public function __construct()
	{
		$this->table = "poisson_campagne";
		$this->fields = array(
			"poisson_campagne_id" => array(
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
			"annee" => array(
				"type" => 1,
				"requis" => 1,
				"defaultValue" => "getYear"
			),
			"tx_croissance_journalier" => array(
				"type" => 1
			),
			"specific_growth_rate" => array(
				"type" => 1
			),
			"masse" => array(
				"type" => 1
			),
			"repro_statut_id" => array(
				"type" => 1,
				"requis" => 1,
				"defaultValue" => 1
			)
		);

		parent::__construct();
	}

	/**
	 * Retourne l'annee courante
	 *
	 * @return int
	 */
	function getYear()
	{
		return date('Y');
	}

	/**
	 * Calcule le taux de croissance d'un poisson
	 *
	 * @param int $poisson_id
	 * @param int $annee
	 * @return array
	 */
	function txCroissanceJourCalcul($poisson_id, $annee = null)
	{
		$result = array();

		if (!isset($this->morphologie)) {
			$this->morphologie = new Morphologie;
		}
		if (is_null($annee)) {
			$annee = $this->getYear();
		}
		$masse_actuelle = $this->morphologie->getMasseBeforeRepro($poisson_id, $annee);
		$result["masse_actuelle"] = $masse_actuelle["masse"];
		$masse_anterieure = $this->morphologie->getMasseBeforeDate($poisson_id, $masse_actuelle["morphologie_date"]);
		$result["masse_anterieure"] = $masse_anterieure["masse"];
		if (is_array($masse_actuelle) && is_array($masse_anterieure)) {
			if ($masse_actuelle["masse"] > 0 && $masse_anterieure["masse"] > 0) {
				/**
				 * Calcul du nombre de jours
				 */
				$date_anterieure = date_create_from_format("d/m/Y", $masse_anterieure["morphologie_date"]);
				$date_actuelle = date_create_from_format("d/m/Y", $masse_actuelle["morphologie_date"]);
				$interval = $date_anterieure->diff($date_actuelle, true);
				$nbJour = $interval->format("%a");
				if ($nbJour > 0) {
					$masseDiff = $masse_actuelle["masse"] - $masse_anterieure["masse"];
					$result["txCroissance"] = $masseDiff / $masse_anterieure["masse"] * 100 / $nbJour;
					/**
					 * Calcul du SGR
					 */
					$result["sgr"] = (log($masse_actuelle["masse"]) - log($masse_anterieure["masse"])) * 100 / $nbJour;
					/**
					 * Limitation du nombre de decimales
					 */
					$result['txCroissance'] = intval($result["txCroissance"] * 1000) / 1000;
					$result['sgr'] = intval($result["sgr"] * 1000) / 1000;
				}
			}
		}
		return $result;
	}

	/**
	 * Initialise globalement une campagne
	 *
	 * @param int $annee
	 * @return int $nb : nombre de poissons ajoutés
	 */
	function initCampagne(int $annee)
	{
		$nb = 0;

		/*
		 * recherche des adultes qui n'existent pas dans la table poisson_campagne pour l'annee consideree
		 */
		$sql = "SELECT p.poisson_id from poisson p
				where categorie_id = 1
				and poisson_statut_id = 1
				and p.poisson_id not in (SELECT c.poisson_id from poisson_campagne c where annee = :annee:)";
		$liste = $this->getListeParamAsPrepared($sql, array("annee" => $annee));
		/*
		 * Traitement de chaque occurence de la liste
		 */
		foreach ($liste as $value) {
			if ($this->initCampagnePoisson($value["poisson_id"], $annee) > 0)
				$nb++;
		}
		return $nb;
	}
	/**
	 * Initialise une annee de campagne pour un poisson
	 *
	 * @param int $poisson_id
	 * @param int $annee
	 * @return int
	 */
	function initCampagnePoisson(int $poisson_id, int $annee)
	{
		/*
		 * Recherche s'il existe deja un enregistrement
		 */
		$data = $this->lireFromPoissonAnnee($poisson_id, $annee);
		if (!$data["poisson_campagne_id"] > 0) {
			$data = array(
				"poisson_id" => $poisson_id,
				"annee" => $annee,
				"repro_statut_id" => 1,
				"poisson_campagne_id" => 0
			);
		}
		/*
		 * Calcul du taux de croissance journalier
		 */
		$result = $this->txCroissanceJourCalcul($poisson_id, $annee);
		if (!is_null($result)) {
			$data["tx_croissance_journalier"] = $result["txCroissance"];
			$data["specific_growth_rate"] = $result["sgr"];
			$data["masse"] = $result["masse_actuelle"];
		}
		return $this->ecrire($data);
	}
	/**
	 * Get the detail of a fish
	 * @param int $poisson_id
	 * @param int $annee
	 * @return array
	 */
	function readFromPoissonAnnee(int $poisson_id, int $annee)
	{
		$sql = "SELECT * from poisson_campagne
					where poisson_id = :poisson_id:
					and annee = :annee:";
		return $this->lireParam($sql, ["poisson_id" => $poisson_id, "annee" => $annee]);
	}
	function lireFromPoissonAnnee(int $poisson_id, int $annee) {
		return $this->readFromPoissonAnnee($poisson_id,$annee);
	}

	/**
	 * retourne les poissons retenus pour une année
	 *
	 * @param array $param
	 * @return array number
	 */
	function getListForDisplay($param)
	{
		$liste = array();
		$sql = "SELECT poisson_campagne_id, poisson_id,
					matricule, prenom, pittag_valeur, cohorte,
				tx_croissance_journalier, specific_growth_rate,
				sexe_libelle, sexe_libelle_court, masse,
				repro_statut_id, repro_statut_libelle,
				poisson_statut_libelle, poisson_statut_id,
				site_id
				from poisson p
				join poisson_campagne c using (poisson_id)
				join repro_statut using (repro_statut_id)
				left outer join sexe using (sexe_id)
				left outer join poisson_statut using (poisson_statut_id)
				left outer join v_pittag_by_poisson using (poisson_id)
				left outer join v_poisson_last_bassin using (poisson_id)
				";
		$psql = array("annee" => $param["annee"]);
		$where = " where annee = :annee:";
		if ($param["repro_statut_id"] > 0) {
			$where .= " and repro_statut_id = :repro_statut_id:";
			$psql["repro_statut_id"] = $param["repro_statut_id"];
		}
		if ($param["site_id"] > 0) {
			$where .= " and site_id = :site_id:";
			$psql["site_id"] = $param["site_id"];
		}
		$order = " order by sexe_libelle, prenom";
		$liste = $this->getListeParamAsPrepared($sql . $where . $order, $psql);
		/*
		 * Rajout des années de croisement antérieures
		 */
		foreach ($liste as $key => $value) {
			$liste[$key]["annees"] = $this->getAnneeCroisement($value["poisson_id"]);
			$annees = explode(",", $liste[$key]["annees"]);
			if ($annees[0] > 0) {
				$liste[$key]["sequences"] = $this->getSequences($value["poisson_id"], $annees);
			}
		}
		return $liste;
	}
	/**
	 * Recherche les années de croisement pour un poisson
	 *
	 * @param int $poisson_id
	 * @return string
	 */
	function getAnneeCroisement(int $poisson_id)
	{
		$annees = "";
		if ($poisson_id > 0) {
			$sql = "SELECT distinct annee
					from poisson_campagne
					join poisson_croisement using(poisson_campagne_id)
					where poisson_id = :poisson_id:
					order by annee";
			$liste = $this->getListeParamAsPrepared($sql, array("poisson_id" => $poisson_id));
			$virgule = false;
			foreach ($liste as $value) {
				if ($virgule == true) {
					$annees .= ",";
				} else {
					$virgule = true;
				}
				$annees .= $value["annee"];
			}
		}
		return $annees;
	}
	/**
	 * Retourne la liste des sequences pour un poisson, pour une annee
	 *
	 * @param int $poisson_id
	 * @param int|array $annee
	 * @return array
	 */
	function getListSequence(int $poisson_id, $annee, bool $isPoissonCampagne = true)
	{
		$sql = "SELECT distinct sequence_id, s.annee, sequence_nom, sequence_date_debut
					from sequence s
					join poisson_sequence using (sequence_id)
					join poisson_campagne using (poisson_campagne_id) where";
		$param = array("poisson_id" => $poisson_id);
		$and = " ";
		if (!$isPoissonCampagne) {
			if (is_array($annee)) {
				$sql .= " s.annee in (";
				$comma = false;
				$i = 0;
				foreach ($annee as $an) {
					if (is_numeric($an)) {
						if ($comma) {
							$sql .= ",";
						} else {
							$comma = true;
						}
						$sql .= ":an$i:";
						$param["an$i"] = $an;
						$i++;
					}
				}
				$sql .= ")";
			} else {
				$sql .= " s.annee = :annee:";
				$param["annee"] = $annee;
			}
			$and = " and ";
		}
		if ($isPoissonCampagne) {
			$sql .= $and . "poisson_campagne_id = :poisson_id:";
		} else {
			$sql .= " and poisson_id = :poisson_id:";
		}
		$sql .= " order by sequence_date_debut, sequence_nom";
		return $this->getListeParamAsPrepared($sql, $param);
	}

	/**
	 * Retourne les séquences auxquelles participe un poisson, sous forme textuelle
	 *
	 * @param int $poisson_id
	 * @param $annee
	 * @return string
	 */
	function getSequences(int $poisson_id, $annee)
	{
		$sequences = "";
		$liste = $this->getListSequence($poisson_id, $annee, false);
		$virgule = false;
		foreach ($liste as $value) {
			if ($virgule == true) {
				$sequences .= ",";
			} else {
				$virgule = true;
			}
			$sequences .= $value["annee"] . "-" . $value["sequence_nom"];
		}
		return $sequences;
	}

	/**
	 * Retourne la liste des années de reproduction
	 *
	 * @return array
	 */
	function getAnnees()
	{
		$sql = "SELECT distinct annee from poisson_campagne order by annee desc";
		$data = $this->getListeParam($sql);
		$years = array();
		$current = date('Y');
		if ($data[0]["annee"] < $current)
			$years[] = $current;
		foreach ($data as $v) {
			$years[] = $v["annee"];
		}
		return $years;
	}

	/**
	 * Reecriture de la fonction lire, pour recuperer les informations liees
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::lire()
	 */
	function read($id, $getDefault = false, $parentValue = 0): array
	{
		if ($id > 0) {
			$sql = "SELECT poisson_campagne_id, poisson_id, matricule, prenom, pittag_valeur, cohorte,
				annee, tx_croissance_journalier, specific_growth_rate,
				sexe_libelle, sexe_libelle_court, masse, sexe_id,
				repro_statut_id, repro_statut_libelle,
				poisson_statut_libelle, poisson_statut_id
				from poisson p
				join poisson_campagne c using (poisson_id)
				join repro_statut using (repro_statut_id)
				left outer join sexe using (sexe_id)
				left outer join poisson_statut using (poisson_statut_id)
				left outer join v_pittag_by_poisson using (poisson_id)
				where poisson_campagne_id = :id:";
			$data = parent::lireParamAsPrepared($sql, array("id" => $id));
		} else {
			$data = parent::getDefaultValues($parentValue);
		}
		return $data;
	}
	/**
	 * Surcharge de la fonction ecrire, pour calculer les taux de croissance en cas de creation
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::ecrire()
	 */
	function write($data): int
	{
		if ($data["poisson_campagne_id"] == 0) {
			/*
			 * Recherche s'il existe deja un enregistrement
			 */
			$exist = $this->lireFromPoissonAnnee($data["poisson_id"], $data["annee"]);
			if (!$exist["poisson_campagne_id"] > 0) {
				$result = $this->txCroissanceJourCalcul($data["poisson_id"], $data["annee"]);
				if (!is_null($result)) {
					$data["tx_croissance_journalier"] = $result["txCroissance"];
					$data["specific_growth_rate"] = $result["sgr"];
					$data["masse"] = $result["masse_actuelle"];
				}
			} else {
				$data["poisson_campagne_id"] = $exist["poisson_campagne_id"];
			}
		}
		return parent::write($data);
	}

	/**
	 * Retourne la liste des campagnes de reproduction pour un poisson
	 *
	 * @param int $poisson_id
	 * @return array
	 */
	function getListFromPoisson(int $poisson_id)
	{
		$sql = "SELECT poisson_campagne_id, poisson_id, annee,
					masse, tx_croissance_journalier, specific_growth_rate,
					repro_statut_id, repro_statut_libelle
					from poisson_campagne
					join repro_statut using (repro_statut_id)
					where poisson_id = :poisson_id:
					order by annee desc";
		return $this->getListeParamAsPrepared($sql, array("poisson_id" => $poisson_id));
	}

	/**
	 * Change le statut du poisson
	 *
	 * @param int $poisson_campagne_id
	 * @param int $repro_statut_id
	 * @return int
	 */
	function changeStatut(int $poisson_campagne_id, int $repro_statut_id)
	{

		$data = parent::lire($poisson_campagne_id);
		$data["repro_statut_id"] = $repro_statut_id;
		return $this->ecrire($data);
	}

	/**
	 * Fonction permettant de restituer l'ensemble des temperatures des bassins frequentes par un poisson
	 *
	 * @param int $poisson_campagne_id
	 * @param int $annee
	 * @param int $profil_thermique_type_id
	 * @return array
	 */
	function getTemperatures(int $poisson_id, int $annee, int $profil_thermique_type_id = 1)
	{
		$param = array("poisson_id" => $poisson_id, "annee" => $annee);
		$this->fields["pf_datetime"]["type"] = 3;
		if ($profil_thermique_type_id == 1) {
			/*
			 * Traitement des valeurs constatees, lues dans les analyses d'eau
			 */

			$sql = "SELECT distinct b.poisson_id,b.bassin_id,b.bassin_nom,b.date_debut,b.date_fin,
    				analyse_eau_date as pf_datetime,
    				temperature as pf_temperature
				   FROM v_poisson_bassins b
					 join bassin using (bassin_id)
					 join circuit_eau ce using (circuit_eau_id)
					 join bassin_campagne bc on bc.bassin_id = b.bassin_id
				     JOIN analyse_eau ae ON (ae.circuit_eau_id = ce.circuit_eau_id
						and extract (year from analyse_eau_date) = :annee:
						AND ae.analyse_eau_date between b.date_debut
						AND CASE WHEN b.date_fin IS NULL THEN 'now'::text::date ELSE b.date_fin END
						)
					where poisson_id =:poisson_id:
					and temperature is not null
					order by analyse_eau_date";
		} else {
			/*
			 * Traitement des valeurs prevues
			 */
			$sql = "SELECT b.poisson_id,b.bassin_id,b.bassin_nom,b.date_debut,b.date_fin,
    				bc.bassin_campagne_id,pt.profil_thermique_id,bc.annee,pt.pf_datetime,
    				pt.pf_temperature,pt.profil_thermique_type_id
				   FROM v_poisson_bassins b
				     join bassin_campagne bc on bc.bassin_id = b.bassin_id
				     JOIN profil_thermique pt ON (bc.bassin_campagne_id = pt.bassin_campagne_id
						AND pt.pf_datetime between b.date_debut
						AND CASE WHEN b.date_fin IS NULL THEN 'now'::text::date ELSE b.date_fin END
						)
					where poisson_id = :poisson_id:
					and annee = :annee:
					and profil_thermique_type_id = :profil_thermique_type_id: 
					order by pf_datetime";
			$param["profil_thermique_type_id"] = $profil_thermique_type_id;
		}
		$this->datetimeFields[] = "pf_temperature";
		$this->datetimeFields[] = "pf_datetime";
		return $this->getListeParamAsPrepared($sql, $param);
	}
}
