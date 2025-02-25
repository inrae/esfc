<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table repro_statut
 *
 * @author quinton
 *
 */
class ReproStatut extends PpciModel
{
	public function __construct()
	{
		$this->table = "repro_statut";
		$this->fields = array(
			"repro_statut_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"repro_statut_libelle" => array(
				"type" => 0,
				"requis" => 1
			)
		);

		parent::__construct();
	}
}
