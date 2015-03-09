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
		if ($annee > 0) {
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
				
				"qualite_semence" => array (
						"type" => 0 
				),
				"ovocyte_masse" => array (
						"type" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		
		parent::__construct ( $p_connection, $param );
	}
	/**
	 * Retourne la liste des sequences auxquelles est rattaché un poisson, pour
	 * l'année considérée
	 * 
	 * @param int $poisson_campagne_id        	
	 * @return array|NULL
	 */
	function getListFromPoisson($poisson_campagne_id) {
		if ($poisson_campagne_id > 0) {
			$sql = "select poisson_campagne_id, poisson_sequence_id, sequence_id,
					qualite_semence, ovocyte_masse,
					annee, sequence_nom, sequence_date_debut
					from poisson_sequence
					join sequence using (sequence_id)
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
				"s_evenement_id" => array (
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
				"ps_date" => array (
						"type" => 2,
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
	 * @param int $poisson_campagne_id
	 * @return tableau|NULL
	 */
	function getListeEvenementFromPoisson($poisson_campagne_id) {
		if ($poisson_campagne_id > 0) {
			$sql = "select ps_evenement_id, poisson_campagne_id, poisson_sequence_id, 
					ps_date, ps_libelle, ps_commentaire,
					sequence_nom
					from ps_evenement
					join poisson_sequence using (poisson_sequence_id) 
					join sequence using (sequence_id)
					where poisson_campagne_id = " . $poisson_campagne_id . " 
					order by ps_date ";
			return $this->getListeParam ( $sql );
		} else
			return null;
	}
}

?>