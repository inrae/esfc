<?php 
namespace App\Models;
use Ppci\Models\PpciModel;

class PsStatut extends PpciModel
{
	public function __construct()
	{
		$this->table = "ps_statut";
		$this->fields = array(
			"ps_statut_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"ps_libelle" => array(
				"requis" => 1
			)
		);
		parent::__construct();
	}
}