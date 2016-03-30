<?php

/**
 *
 * @author quinton
 *        
 */
require_once 'modules/classes/poissonRepro.class.php';
class DosageSanguin extends \ObjetBDD {
	
	/**
	 *
	 * @param
	 *        	instance ADODB
	 *        	
	 */
	private $sql = "select dosage_sanguin_id, poisson_campagne_id, dosage_sanguin_date, 
					tx_e2, tx_e2_texte, tx_calcium, tx_hematocrite,
					dosage_sanguin_commentaire,
					ds.poisson_id, evenement_id,
					evenement_type_libelle
					from dosage_sanguin ds
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)";
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
						"requis" => 0,
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
				"tx_hematocrite" => array(
						"type" => 1
				),
				"dosage_sanguin_commentaire" => array (
						"type" => 0 
				),
				"poisson_id" => array ("type" => 1),
				"evenement_id" => array ("type"=>1)
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		
		parent::__construct ( $p_connection, $param );
	}
	/**
	 * Surcharge de la fonction ecrire pour rajouter le numero du poisson
	 * @see ObjetBDD::write()
	 */
	function write($data) {
		if ($data["poisson_campagne_id"] > 0 && is_numeric($data["poisson_campagne_id"])) {
			/*
			 * Recherche du numero du poisson
			 */
			$poissonCampagne = new PoissonCampagne($this->connection, $this->paramori);
			$dataPoisson = $poissonCampagne->lire($data["poisson_campagne_id"]);
			$data["poisson_id"] = $dataPoisson["poisson_id"];
		}
		return parent::ecrire($data);
	}

	/**
	 * Retourne le prelevement sanguin correspondant a l'evenement considere
	 * @param int $id
	 * @return array
	 */
	function getdataByEvenement($id) {
		if ($id > 0 && is_numeric($id)) {
			$sql = "select * from ".$this->table. " where evenement_id = ".$id;
			return $this->lireParam($sql);
		}
	}
	
	/**
	 * Retourne l'ensemble des bilans sanguins pour un poisson, pour une campagne donnee
	 * 
	 * @param int $poissonCampagneId        	
	 * @return NULL array
	 */
	function getListeFromPoissonCampagne($poissonCampagneId) {
		if ($poissonCampagneId > 0 && is_numeric($poissonCampagneId)) {
			$where = " where poisson_campagne_id = " . $poissonCampagneId . " 
					order by dosage_sanguin_date";
			return $this->getListeParam ( $this->sql.$where );
		} else
			return null;
	}
	/**
	 * Retourne la liste des dosages sanguins pour un poisson
	 * @param int $poisson_id
	 * @return tableau
	 */
	function getListeFromPoisson($poisson_id) {
		if ($poisson_id > 0 && is_numeric($poisson_id)) {
			$where = " where ds.poisson_id = ".$poisson_id." 
					order by dosage_sanguin_date desc";
			return $this->getListeParam($this->sql.$where);
		}
	}
}

?>