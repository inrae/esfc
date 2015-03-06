<?php

/**
 *
 * @author quinton
 *        
 */
class DosageSanguin extends \ObjetBDD {
	
	/**
	 *
	 * @param
	 *        	instance ADODB
	 *        	
	 */
	public function __construct($p_connection, $param = NULL) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "dosage_sanguin";
		$this->id_auto = "1";
		$this->colonnes = array (
				"dosage_sanguin_id" => array (
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
				"dosage_sanguin_date" => array (
						"type" => 2,
						"requis" => 1,
						"defaultValue" => "getDateJour" 
				),
				"tx_e2" => array (
						"type" => 1 
				),
				"tx_e2_texte" => array (
						"type" => 0 
				),
				"tx_calcium" => array (
						"type" => 1 
				),
				"dosage_sanguin_commentaire" => array (
						"type" => 0 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		
		parent::__construct ( $p_connection, $param );
	}
	
	/**
	 * Retourne l'ensemble des bilans sanguins pour un poisson, pour une campagne donnee
	 * 
	 * @param int $poissonCampagneId        	
	 * @return NULL array
	 */
	function getListeFromPoissonCampagne($poissonCampagneId) {
		if ($poissonCampagneId > 0) {
			$sql = "select dosage_sanguin_id, poisson_campagne_id, dosage_sanguin_date, 
					tx_e2, tx_e2_texte, tx_calcium, dosage_sanguin_commentaire 
					from dosage_sanguin
					where poisson_campagne_id = " . $poissonCampagneId . " 
					order by dosage_sanguin_date";
			return $this->getListeParam ( $sql );
		} else
			return null;
	}
}

?>