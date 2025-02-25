<?php

namespace App\Models;

class SearchAlimentation extends SearchParam
{
	function __construct()
	{
		$date_debut = new \DateTime();
		date_sub($date_debut, new \DateInterval("P30D"));
		$this->param = array(
			"date_debut" => date_format($date_debut, "d/m/Y"),
			"date_fin" => date("d/m/Y")
		);
		parent::__construct();

	}
}