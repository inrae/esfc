<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 11 avr. 2014
 */
/**
 * ORM de gestion de la table categorie
 *
 * @author quinton
 *
 */
class Categorie extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "categorie";
		$this->id_auto = 1;
		$this->colonnes = array (
				"categorie_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0
				),
				"categorie_libelle" => array (
						"type" => 0,
						"requis" => 1
				)
		);
		if (! is_array ( $param ))
			$param = array();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}

	/**
	 * Retourne uniquement les categories 1 et 2
	 * @return tableau
	 */
	function getListeSansLot() {
		$sql = "select * from categorie
				where categorie_id in (1, 2)
				order by categorie_id";
		return ($this->getListeParam($sql));
	}
}

?>