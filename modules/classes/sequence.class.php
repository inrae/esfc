<?php

/**
 *
 * @author quinton
 *        
 */
class Sequence extends ObjetBDD {
	
	/**
	 *
	 * @param
	 *        	instance ADODB
	 *        	
	 */
	public function __construct($p_connection, $param = NULL) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "sequence";
		$this->id_auto = "1";
		$this->colonnes = array (
				"sequence_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"sequence_nom" => array (
						"type" => 0,
						"requis" => 1 
				),
				"annee" => array (
						"type" => 1,
						"requis" => 1,
						"defaultValue" => "getYear" 
				),
				"sequence_date_debut" => array (
						"type" => 2 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		
		parent::__construct ( $p_connection, $param );
	}
	
	/**
	 * Retourne l'annee courante
	 *
	 * @return int
	 */
	function getYear() {
		return date ( 'Y' );
	}
	
	/**
	 * Retourne la liste des séquences pour une année donnée
	 *
	 * @param unknown $annee        	
	 */
	function getListeByYear($annee) {
		if ($annee > 0 && is_numeric($annee)) {
			$sql = "select sequence_id, sequence_nom, annee, sequence_date_debut 
				from sequence
				where annee = " . $annee . " 
				order by sequence_date_debut";
			return parent::getListeParam ( $sql );
		}
	}
}

/**
 * ORM de gestion de la table poisson_sequence
 *
 * @author quinton
 *        
 */
class PoissonSequence extends ObjetBDD {
	public function __construct($p_connection, $param = NULL) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "poisson_sequence";
		$this->id_auto = "1";
		$this->colonnes = array (
				"poisson_sequence_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"poisson_campagne_id" => array (
						"type" => 1,
						"requis" => 1,
						"parentAttrib" => 1 
				),
				"sequence_id" => array (
						"type" => 1,
						"requis" => 1 
				),
				
				"ovocyte_masse" => array (
						"type" => 1 
				),
				"ps_statut_id" => array (
						"type" => 1,
						"defaultValue" => 1 
				),
				"ovocyte_expulsion_date" => array (
						"type" => 3 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		
		parent::__construct ( $p_connection, $param );
	}
	
	/**
	 * Surcharge de la fonction lire, pour separer le champ ovocyte_expulsion_date en date et time
	 * (non-PHPdoc)
	 * 
	 * @see ObjetBDD::lire()
	 */
	function lire($id, $getDefault = false, $parentValue = 0) {
		$data = parent::lire ( $id, $getDefault, $parentValue );
		$datetime = explode ( " ", $data ["ovocyte_expulsion_date"] );
		$data ["ovocyte_expulsion_date"] = $datetime [0];
		$data ["ovocyte_expulsion_time"] = $datetime [1];
		return $data;
	}
	
	/**
	 * Surcharge de la fonction ecrire, pour reintegrer l'heure a la date pour
	 * reconstituer ovocyte_expulsion_date
	 * (non-PHPdoc)
	 * 
	 * @see ObjetBDD::ecrire()
	 */
	function ecrire($data) {
		if (strlen ( $data ["ovocyte_expulsion_date"] ) > 0 && strlen ( $data ["ovocyte_expulsion_time"] ) > 0)
			$data ["ovocyte_expulsion_date"] = $data ["ovocyte_expulsion_date"] . " " . $data ["ovocyte_expulsion_time"];
		$id = parent::ecrire ( $data );
		if ($data ["ovocyte_masse"] > 0 && $data ["ps_statut_id"] < 4)
			$this->updateStatut ( $id, 4 );
		return $id;
	}
	/**
	 * Retourne la liste des sequences auxquelles est rattaché un poisson, pour
	 * l'année considérée
	 *
	 * @param int $poisson_campagne_id        	
	 * @return array|NULL
	 */
	function getListFromPoisson($poisson_campagne_id) {
		if ($poisson_campagne_id > 0 && is_numeric($poisson_campagne_id)) {
			$sql = "select poisson_campagne_id, poisson_sequence_id, sequence_id,
					ovocyte_masse, ovocyte_expulsion_date,
					annee, sequence_nom, sequence_date_debut,
					ps_statut_libelle
					from poisson_sequence
					join sequence using (sequence_id)
					left outer join ps_statut using (ps_statut_id)
					where poisson_campagne_id = " . $poisson_campagne_id . "
					order by sequence_date_debut";
			$data = $this->getListeParam ( $sql );
			/*
			 * formatage des dates
			 */
			foreach ( $data as $key => $value ) {
				$data [$key] ["sequence_date_debut"] = $this->formatDateDBversLocal ( $value ["sequence_date_debut"] );
			}
			return $data;
		} else
			return null;
	}
	
	/**
	 * Retourne la liste des poissons concernes par une sequence
	 *
	 * @param int $sequence_id        	
	 * @return tableau|NULL
	 */
	function getListFromSequence($sequence_id) {
		if ($sequence_id > 0 && is_numeric($sequence_id)) {
			$sql = "select poisson_campagne_id, poisson_sequence_id, sequence_id,
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
					where sequence_id = " . $sequence_id . "
					order by sexe_libelle_court, prenom, matricule";
			return $this->getListeParam ( $sql );
		} else
			return null;
	}
	
	/**
	 * Met a jour le statut de poisson_sequence, en
	 * incrementant uniquement la valeur du statut si $level est superieur a la valeur initiale
	 *
	 * @param int $poisson_sequence_id        	
	 * @param int $level        	
	 */
	function updateStatut($poisson_sequence_id, $level) {
		if ($poisson_sequence_id > 0 && is_numeric($poisson_sequence_id) && $level > 0 && is_numeric($level)) {
			$data = $this->lire ( $poisson_sequence_id );
			if ($data ["poisson_sequence_id"] > 0) {
				if ($level > $data ["ps_statut_id"]) {
					$data ["ps_statut_id"] = $level;
					$this->ecrire ( $data );
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
	function updateStatutFromPoissonCampagne($poisson_campagne_id, $sequence_id, $level) {
		if ($poisson_campagne_id > 0 && is_numeric($poisson_campagne_id) && $sequence_id > 0 && is_numeric($sequence_id)) {
			/*
			 * Recherche de la sequence correspondante
			 */
			$sql = "select poisson_sequence_id from poisson_sequence
					where poisson_campagne_id = " . $poisson_campagne_id . "
					and sequence_id = " . $sequence_id;
			$data = $this->lireParam ( $sql );
			if ($data ["poisson_sequence_id"] > 0)
				$this->updateStatut ( $data ["poisson_sequence_id"], $level );
		}
	}
}

/**
 * ORM de gestion de la table ps_evenement
 *
 * @author quinton
 *        
 */
class PsEvenement extends ObjetBDD {
	public function __construct($p_connection, $param = NULL) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "ps_evenement";
		$this->id_auto = "1";
		$this->colonnes = array (
				"ps_evenement_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"poisson_sequence_id" => array (
						"type" => 1,
						"requis" => 1,
						"parentAttrib" => 1 
				),
				"ps_datetime" => array (
						"type" => 3,
						"requis" => 1 
				),
				
				"ps_libelle" => array (
						"type" => 0,
						"requis" => 1 
				),
				"ps_commentaire" => array (
						"type" => 0 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		
		parent::__construct ( $p_connection, $param );
	}
	/**
	 * Retourne l'ensemble des événements pour un poisson
	 *
	 * @param int $poisson_campagne_id        	
	 * @return tableau|NULL
	 */
	function getListeEvenementFromPoisson($poisson_campagne_id) {
		if ($poisson_campagne_id > 0 && is_numeric($poisson_campagne_id)) {
			$sql = "select ps_evenement_id, poisson_campagne_id, poisson_sequence_id, 
					ps_datetime, ps_libelle, ps_commentaire,
					sequence_nom
					from ps_evenement
					join poisson_sequence using (poisson_sequence_id) 
					join sequence using (sequence_id)
					where poisson_campagne_id = " . $poisson_campagne_id . " 
					order by ps_datetime ";
			return $this->getListeParam ( $sql );
		} else
			return null;
	}
	
	/**
	 * Retourne la liste des evenements a partir du numero de poisson_sequence
	 *
	 * @param int $poisson_sequence_id        	
	 * @return tableau|NULL
	 */
	function getListeFromPoissonSequence($poisson_sequence_id) {
		if ($poisson_sequence_id > 0 && is_numeric($poisson_sequence_id)) {
			$sql = "select ps_evenement_id, poisson_sequence_id, ps_datetime, ps_libelle, ps_commentaire 
					from ps_evenement 
					where poisson_sequence_id = " . $poisson_sequence_id . " 
					order by ps_datetime";
			return $this->getListeParam ( $sql );
		} else
			return null;
	}
	
	/**
	 * Reecriture de la fonction lire pour separer la date et l'heure dans 2 champs
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::lire()
	 */
	function lire($id, $getDefault = false, $parentValue = 0) {
		$data = parent::lire ( $id, $getDefault, $parentValue );
		$date = explode ( " ", $data ["ps_datetime"] );
		$data ["ps_date"] = $date [0];
		$data ["ps_time"] = $date [1];
		return $data;
	}
	
	/**
	 * Reecriture de la fonction ecrire pour generer le champ ps_datetime a partir
	 * des champs separes
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::ecrire()
	 */
	function ecrire($data) {
		$data ["ps_datetime"] = $data ["ps_date"] . " " . $data ["ps_time"];
		return parent::ecrire ( $data );
	}
}
class PsStatut extends ObjetBDD {
	public function __construct($p_connection, $param = NULL) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "ps_statut";
		$this->id_auto = "1";
		$this->colonnes = array (
				"ps_statut_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"ps_libelle" => array (
						"requis" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		
		parent::__construct ( $p_connection, $param );
	}
}

?>