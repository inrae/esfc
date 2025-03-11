<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table bassin_type
 *
 * @author quinton
 *        
 */
class BassinType extends PpciModel
{
	function __construct()
	{
		$this->table = "bassin_type";
		$this->fields = array(
			"bassin_type_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"bassin_type_libelle" => array(
				"type" => 0,
				"requis" => 1
			)
		);
		parent::__construct();
	}
}
