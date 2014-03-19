<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 19 mars 2014
 */
/**
 * ORM de la table aliment_type
 *
 * @author quinton
 *        
 */
class AlimentType extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "aliment_type";
		$this->id_auto = 1;
		$this->colonnes = array (
				"aliment_type_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"aliment_type_libelle" => array (
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
/**
 * ORM de la table aliment
 *
 * @author quinton
 *        
 */
class Aliment extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "aliment";
		$this->id_auto = 1;
		$this->colonnes = array (
				"aliment_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"aliment_libelle" => array (
						"type" => 0,
						"requis" => 1 
				),
				"aliment_type_id" => array (
						"type" => 1,
						"requis" => 1 
				),
				"actif" => array (
						"type" => 1,
						"defaultValue" => 1,
						"requis" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Retourne la liste des aliments actuellement utilisés
	 * @return array
	 */
	function getListeActif() {
		$sql = "select * from ".$this->table." where actif = 1 order by aliment_libelle";
		return $this->getListeParam($sql);
	}
	/**
	 * Reecriture de la recuperation de la liste
	 * (non-PHPdoc)
	 * @see ObjetBDD::getListe()
	 */
	function getListe() {
		$sql = "select * from ".$this->table. " 
				natural join aliment_type
				order by aliment_libelle";
		return $this->getListeParam($sql);
	}
}
/**
 * ORM de gestion de la table categorie
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
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
}
?>