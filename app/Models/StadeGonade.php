<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * Created : 3 févr. 2017
 * Creator : quinton
 * Encoding : UTF-8
 * Copyright 2017 - All rights reserved
 */
class StadeGonade extends PpciModel
{
	function __construct()
	{
		$this->table = "stade_gonade";
		$this->fields = array(
			"stade_gonade_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"stade_gonade_libelle" => array(
				"type" => 0,
				"requis" => 1
			)
		);
		parent::__construct();
	}
}
