<?php

namespace App\Models;
class SearchCircuitEau extends SearchParam
{
	function __construct()
	{
		$this->param = array(
			"circuit_eau_libelle" => "",
			"circuit_eau_actif" => 1,
			"analyse_date" => date('d/m/Y'),
			"offset" => 0,
			"limit" => 100,
			"site_id" => $_SESSION["site_id"]
		);
		$this->paramNum = array(
			"circuit_eau_actif",
			"offset",
			"limit",
			"site_id"
		);
		parent::__construct();
	}
}