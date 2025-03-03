<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table anomalie_db_type
 * 
 * @author quinton
 *        
 */
class AnomalieDbType extends PpciModel
{
	/**
	 * Constructeur
	 * 
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct()
	{
		$this->table = "anomalie_db_type";
		$this->fields = array(
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
		parent::__construct();
	}
	/**
	 * Tri de la liste
	 * (non-PHPdoc)
	 * 
	 * @see ObjetBDD::getListe()
	 */
	function getListe(string $order = "anomalie_db_type_libelle"): array
	{
		return parent::getListe($order);
	}
}
