<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table devenir_type
 * @author quinton
 *
 */
class DevenirType extends PpciModel
{
	function __construct()
	{
		$this->table = "devenir_type";
		$this->useAutoIncrement = false;
		$this->fields = array(
			"devenir_type_id" => array("type" => 1, "key" => 1, "requis" => 1, "defaultValue" => 0),
			"devenir_type_libelle" => array("requis" => 1)
		);
		parent::__construct();
	}
}
