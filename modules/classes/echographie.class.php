<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 11 mars 2015
 */
/**
 * ORM de gestion de la table echographie
 * 
 * @author quinton
 *        
 */
class Echographie extends ObjetBDD {
	public function __construct($p_connection, $param = NULL) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "echographie";
		$this->id_auto = "1";
		$this->colonnes = array (
				"echographie_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"poisson_campagne_id" => array (
						"type" => 1,
						"parentAttrib" => 1,
						"requis" => 1 
				),
				"echographie_date" => array (
						"type" => 2,
						"requis" => 1 
				),
				"echographie_commentaire" => array (
						"type" => 0 
				),				
				"cliche_nb" => array (
						"type" => 1 
				),
				"cliche_ref" => array (
						"type" => 0 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		
		parent::__construct ( $p_connection, $param );
	}

	/**
	 * Retourne la liste des échographies réalisées sur un poisson
	 * @param int $poisson_campagne_id
	 * @return tableau|NULL
	 */
	function getListFromPoissonCampagne ($poisson_campagne_id){
		if ($poisson_campagne_id > 0){
			$sql = "select echographie_id, poisson_campagne_id, echographie_date, 
					echographie_commentaire 
					from echographie
					where poisson_campagne_id = ".$poisson_campagne_id."
					order by echographie_date";
			return $this->getListeParam($sql);
		} else return null;
	}
}
?>