<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table circuit_evenement_type
 *
 * @author quinton
 *        
 */
class CircuitEvenementType extends PpciModel
{
	/**
	 * Constructeur de la classe
	 *
	 *         	
	 */
	function __construct()
	{
		$this->table = "circuit_evenement_type";
		$this->fields = array(
			"circuit_evenement_type_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"circuit_evenement_type_libelle" => array(
				"type" => 0,
				"requis" => 1
			)
		);
		parent::__construct();
	}
}
