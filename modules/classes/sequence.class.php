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

?>