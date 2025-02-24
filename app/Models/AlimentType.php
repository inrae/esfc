<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de la table aliment_type
 *
 * @author quinton
 *        
 */
class AlimentType extends PpciModel
{
	/**
	 * Constructeur de la classe
	 *
	         	
	 */
	function __construct()
	{
		$this->table = "aliment_type";
		$this->fields = array(
			"aliment_type_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"aliment_type_libelle" => array(
				"type" => 0,
				"requis" => 1
			)
		);
		parent::__construct();
	}
}
