<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table croisement_qualite
 *
 * @author quinton
 *        
 */
class CroisementQualite extends PpciModel
{
	function __construct()
	{
		$this->table = "croisement_qualite";
		$this->fields = array(
			"croisement_qualite_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"croisement_qualite_libelle" => array(
				"type" => 0,
				"requis" => 1
			)
		);
		parent::__construct();
	}
}
