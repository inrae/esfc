<?php

/**
 *
 * @author quinton
 *        
 */
class Biopsie extends \ObjetBDD {
	
	/**
	 *
	 * @param
	 *        	instance ADODB
	 *        	
	 */
	public function __construct($p_connection, $param = NULL) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "biopsie";
		$this->id_auto = "1";
		$this->colonnes = array (
				"biopsie_id" => array (
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
				"biopsie_date" => array (
						"type" => 2,
						"requis" => 1,
						"defaultValue" => "getDateJour" 
				),
				"diam_moyen" => array (
						"type" => 1 
				),
				"tx_ovoide" => array (
						"type" => 1 
				),
				"tx_coloration_normal" => array (
						"type" => 1 
				),
				"ringer_t50" => array (
						"type" => 0 
				),
				"ringer_tx_max" => array (
						"type" => 1 
				),
				"ringer_duree" => array (
						"type" => 0 
				),
				"ringer_commentaire" => array (
						"type" => 0 
				),
				"tx_eclatement" => array (
						"type" => 1 
				),
				"leibovitz_t50" => array (
						"type" => 0 
				),
				"leibovitz_tx_max" => array (
						"type" => 1 
				),
				"leibovitz_duree" => array (
						"type" => 0 
				),
				"leibovitz_commentaire" => array (
						"type" => 0 
				),
				"biopsie_commentaire" => array (
						"type" => 0 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		$param["transformComma"] = 1;
		
		parent::__construct ( $p_connection, $param );
	}

	/**
	 * Retourne la liste des biopsies pour un poisson, pour une campagne
	 * @param int $poisson_campagne_id
	 * @return array|NULL
	 */
	function getListeFromPoissonCampagne($poisson_campagne_id) {
		if ($poisson_campagne_id > 0) {
			$sql = "select * from biopsie 
					where poisson_campagne_id = ".$poisson_campagne_id." 
					order by biopsie_date";
			return $this->getListeParam($sql);
		} else
			return null;
	}
}

?>