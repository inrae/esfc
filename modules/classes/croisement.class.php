<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 12 mars 2015
 */
/**
 * ORM de gestion de la table croisement
 * @author quinton
 *
 */
class Croisement extends ObjetBDD {
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "croisement";
		$this->id_auto = "1";
		$this->colonnes = array (
				"croisement_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"sequence_id" => array (
						"type" => 1,
						"requis" => 1,
						"parentAttrib" => 1 
				),
				"croisement_qualite_id" => array (
						"type" => 1 
				),
				"croisement_date" => array (
						"type" => 2 
				),
				"ovocyte_masse" => array (
						"type" => 1 
				),
				"ovocyte_densite" => array (
						"type" => 1 
				),
				"tx_fecondation" => array (
						"type" => 1 
				),
				"tx_survie_estime" => array (
						"type" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}

	/**
	 * recupere la liste des croisement pour une sequence
	 * @param int $sequence_id
	 * @return tableau|NULL
	 */
	function getListFromSequence ($sequence_id){
		if ($sequence_id > 0) {
			$sql = "select croisement_id, sequence_id, croisement_qualite_id, croisement_qualite_libelle,
					croisement_date, ovocyte_masse, ovocyte_densite, tx_fecondation, tx_survie_estime
					from croisement
					left outer join croisement_qualite using (croisement_qualite_id)
					where sequence_id = ".$sequence_id."
					order by croisement_date, croisement_id";
			return $this->getListeParam($sql);
		} else
			return null;
	}
}
?>