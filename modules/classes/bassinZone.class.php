<?php
/**
 * ORM de gestion de la table bassin_zone
 *
 * @author quinton
 *        
 */
class Bassin_zone extends ObjetBDD
{
	/**
	 * Constructeur de la classe
	 *
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = array())
	{
		$this->table = "bassin_zone";
		$this->id_auto = "1";
		$this->colonnes = array(
			"bassin_zone_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"bassin_zone_libelle" => array(
				"type" => 0,
				"requis" => 1
			)
		);
		parent::__construct($bdd, $param);
	}
}