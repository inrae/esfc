<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 14 mars 2014
 */
class Anomalie_db extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "anomalie_db";
		$this->id_auto = 1;
		$this->colonnes = array (
				"anomalie_db_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"anomalie_db_date" => array (
						"type" => 2,
						"requis" => 1,
						"defaultValue" => "getDateJour" 
				),
				"anomalie_type_id" => array (
						"type" => 1,
						"requis" => 1 
				),
				"poisson_id" => array (
						"type" => 1 
				),
				"evenement_id" => array (
						"type" => 1 
				),
				"anomalie_db_commentaire" => array (
						"type" => 0 
				),
				"anomalie_db_statut" => array (
						"type" => 1,
						"requis" => 1 
				),
				"anomalie_db_date_traitement" => array (
						"type" => 2 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Retourne la liste des anomalies pour un poisson
	 * @param int $poisson_id
	 * @return array
	 */
	function getListByPoisson ($poisson_id) {
		if ($poisson_id > 0) {
			$sql = "select anomalie_db_id, anomalie_db.poisson_id, anomalie_db_date, anomalie_db_commentaire,
					anomalie_db_type_libelle, evenement_type_libelle, anomalie_db.evenement_id,
					anomalie_db_statut, anomalie_db_date_traitement
					from anomalie_db
					left outer join anomalie_db_type using (anomalie_db_type_id)
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					where anomalie_db.poisson_id = " . $poisson_id . " order by anomalie_db_date desc";
			return $this->getListeParam ( $sql );
		}
	}
}

?>