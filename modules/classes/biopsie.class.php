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
						"type" => 3,
						"requis" => 1,
						"defaultValue" => "getDateJour" 
				),
				"diam_moyen" => array (
						"type" => 1 
				),
				"diametre_ecart_type" => array (
						"type" => 1 
				),
				"biopsie_technique_calcul_id" => array (
						"type" => 1,
						"defaultValue" => 1
				),
				"tx_opi" => array (
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
		$param ["transformComma"] = 1;
		
		parent::__construct ( $p_connection, $param );
	}
	
	/**
	 * Retourne la liste des biopsies pour un poisson, pour une campagne
	 * 
	 * @param int $poisson_campagne_id        	
	 * @return array|NULL
	 */
	function getListeFromPoissonCampagne($poisson_campagne_id) {
		if ($poisson_campagne_id > 0 && is_numeric($poisson_campagne_id)) {
			$sql = "select * from biopsie 
					left outer join biopsie_technique_calcul using (biopsie_technique_calcul_id)
					where poisson_campagne_id = " . $poisson_campagne_id . " 
					order by biopsie_date";
			return $this->getListeParam ( $sql );
		} else
			return null;
	}

	/**
	 * Retourne le poisson_id correspondant a la biopsie
	 * @param int $id
	 * @return array
	 */
	function getPoissonId($id) {
		if (is_numeric($id)) {
			$sql = "select poisson_id from biopsie
					 join poisson_campagne using (poisson_campagne_id)
					where biopsie_id = ".$id;
			$data = $this->lireParam($sql);
			return $data["poisson_id"];
		}
	}
}
/**
 * ORM de gestion de la table biopsie_technique_calcul
 * @author quinton
 *
 */
class BiopsieTechniqueCalcul extends ObjetBDD {
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "biopsie_technique_calcul";
		$this->id_auto = "1";
		$this->colonnes = array (
				"biopsie_technique_calcul_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"biopsie_technique_calcul_libelle" => array (
						"type" => 0,
						"requis" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
}

?>