<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table biopsie_technique_calcul
 * @author quinton
 *
 */
class BiopsieTechniqueCalcul extends PpciModel
{
	function __construct()
	{
		$this->table = "biopsie_technique_calcul";
		$this->fields = array(
			"biopsie_technique_calcul_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"biopsie_technique_calcul_libelle" => array(
				"type" => 0,
				"requis" => 1
			)
		);
		parent::__construct();
	}
}
