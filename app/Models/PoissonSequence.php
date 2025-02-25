<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table poisson_sequence
 *
 * @author quinton
 *        
 */
class PoissonSequence extends PpciModel
{
	public function __construct()
	{
		$this->table = "poisson_sequence";
		$this->fields = array(
			"poisson_sequence_id" => array(
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
				"requis" => 1,
				"defaultValue" => 0
			),

			"ovocyte_masse" => array(
				"type" => 1
			),
			"ps_statut_id" => array(
				"type" => 1,
				"defaultValue" => 1
			),
			"ovocyte_expulsion_date" => array(
				"type" => 3
			)
		);
		parent::__construct();
	}

	/**
	 * Surcharge de la fonction lire, pour separer le champ ovocyte_expulsion_date en date et time
	 * (non-PHPdoc)
	 * 
	 * @see ObjetBDD::lire()
	 */
	function read($id, bool $getDefault = true, $parentValue = 0): array
	{
		$data = parent::lire($id, $getDefault, $parentValue);
		$datetime = explode(" ", $data["ovocyte_expulsion_date"]);
		$data["ovocyte_expulsion_date"] = $datetime[0];
		$data["ovocyte_expulsion_time"] = $datetime[1];
		return $data;
	}

	/**
	 * Surcharge de la fonction ecrire, pour reintegrer l'heure a la date pour
	 * reconstituer ovocyte_expulsion_date
	 * (non-PHPdoc)
	 * 
	 * @see ObjetBDD::ecrire()
	 */
	function write($data): int
	{
		if (strlen($data["ovocyte_expulsion_date"]) > 0 && strlen($data["ovocyte_expulsion_time"]) > 0)
			$data["ovocyte_expulsion_date"] = $data["ovocyte_expulsion_date"] . " " . $data["ovocyte_expulsion_time"];
		$id = parent::write($data);
		if ($data["ovocyte_masse"] > 0 && $data["ps_statut_id"] < 4)
			$this->updateStatut($id, 4);
		return $id;
	}
	/**
	 * Retourne la liste des sequences auxquelles est rattaché un poisson, pour
	 * l'année considérée
	 *
	 * @param int $poisson_campagne_id        	
	 * @return array
	 */
	function getListFromPoisson(int $poisson_campagne_id)
	{
		$sql = "SELECT poisson_campagne_id, poisson_sequence_id, sequence_id,
					ovocyte_masse, ovocyte_expulsion_date,
					annee, sequence_nom, sequence_date_debut,
					ps_statut_libelle
					from poisson_sequence
					join sequence using (sequence_id)
					left outer join ps_statut using (ps_statut_id)
					where poisson_campagne_id = :id:
					order by sequence_date_debut";
		$this->fields["sequence_date_debut"]["type"] = 2;
		return $this->getListeParamAsPrepared($sql, array("id" => $poisson_campagne_id));
	}

	/**
	 * Retourne la liste des poissons concernes par une sequence
	 *
	 * @param int $sequence_id        	
	 * @return array
	 */
	function getListFromSequence($sequence_id)
	{
		$sql = "SELECT poisson_campagne_id, poisson_sequence_id, sequence_id,
					ovocyte_masse, ovocyte_expulsion_date,
					matricule, prenom, pittag_valeur,
					sexe_libelle, sexe_libelle_court,
					ps_statut_libelle
					from poisson_sequence
					join poisson_campagne using (poisson_campagne_id)
					join poisson using (poisson_id)
					left outer join sexe using (sexe_id)
					left outer join v_pittag_by_poisson using (poisson_id)
					left outer join ps_statut using (ps_statut_id)
					where sequence_id = :id:
					order by sexe_libelle_court, prenom, matricule";
		return $this->getListeParamAsPrepared($sql, array("id" => $sequence_id));
	}

	/**
	 * Met a jour le statut de poisson_sequence, en
	 * incrementant uniquement la valeur du statut si $level est superieur a la valeur initiale
	 *
	 * @param int $poisson_sequence_id        	
	 * @param int $level        	
	 */
	function updateStatut($poisson_sequence_id, $level)
	{
		if ($poisson_sequence_id > 0 && is_numeric($poisson_sequence_id) && $level > 0 && is_numeric($level)) {
			$data = $this->lire($poisson_sequence_id);
			if ($data["poisson_sequence_id"] > 0) {
				if ($level > $data["ps_statut_id"]) {
					$data["ps_statut_id"] = $level;
					$this->ecrire($data);
				}
			}
		}
	}

	/**
	 * Met a jour le statut de poisson_sequence a partir de poisson_campagne_id et de sequence_id
	 * 
	 * @param int $poisson_campagne_id        	
	 * @param int $sequence_id        	
	 * @param int $level        	
	 * @return NULL
	 */
	function updateStatutFromPoissonCampagne($poisson_campagne_id, $sequence_id, $level)
	{
		if ($poisson_campagne_id > 0 && $sequence_id > 0 ) {
			/*
			 * Recherche de la sequence correspondante
			 */
			$sql = "SELECT poisson_sequence_id from poisson_sequence
					where poisson_campagne_id = :poisson_campagne_id:
					and sequence_id = :sequence_id:";
			$data = $this->lireParam($sql, ["poisson_campagne_id" => $poisson_campagne_id, "sequence_id" => $sequence_id]);
			if ($data["poisson_sequence_id"] > 0)
				$this->updateStatut($data["poisson_sequence_id"], $level);
		}
	}
}
