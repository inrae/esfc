<?php

namespace App\Models;

class SearchAnomalie extends SearchParam
{
	function __construct()
	{
		$this->param = array(
			"statut" => 0,
			"type" => 0
		);
		$this->paramNum = array(
			"statut",
			"type"
		);
		parent::__construct();

	}
}