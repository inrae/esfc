<?php
/**
 * ORM de gestion de la table bassin_evenement_type
 *
 * @author quinton
 *        
 */
class BassinEvenementType extends ObjetBDD
{
	/**
	 * Constructeur de la classe
	 *
	 * @param PDO $bdd        	
	 * @param array $param        	
	 */
	function __construct($bdd, $param = array())
	{
		$this->table = "bassin_evenement_type";
		$this->colonnes = array(
			"bassin_evenement_type_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"bassin_evenement_type_libelle" => array(
				"type" => 0,
				"requis" => 1
			)
		);
		parent::__construct($bdd, $param);
	}
}