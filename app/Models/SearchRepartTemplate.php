<?php

namespace App\Models;

class SearchRepartTemplate extends SearchParam
{
	function __construct()
	{
		$this->param = array(
			"categorie_id" => 0,
			"actif" => 1
		);
		$this->paramNum = array(
			"categorie_id",
			"actif"
		);
		parent::__construct();

	}
}