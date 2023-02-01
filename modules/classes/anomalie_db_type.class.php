<?php
/**
 * ORM de gestion de la table anomalie_db_type
 * 
 * @author quinton
 *        
 */
class Anomalie_db_type extends ObjetBDD
{
	/**
	 * Constructeur
	 * 
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = array())
	{
		$this->table = "anomalie_db_type";
		$this->colonnes = array(
			"anomalie_db_type_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"anomalie_db_type_libelle" => array(
				"requis" => 1
			)
		);
		parent::__construct($bdd, $param);
	}
	/**
	 * Tri de la liste
	 * (non-PHPdoc)
	 * 
	 * @see ObjetBDD::getListe()
	 */
	function getListe($order = "anomalie_db_type_libelle"):array|bool
	{
		return parent::getListe($order);
	}
}
