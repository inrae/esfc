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
			"devenir_type_libelle" => array("requis" => 1),
			"evenement_type_id" => ["type"=>1]
		);
		parent::__construct();
	}
	function getList(string $order = ""):array {
		$sql = "SELECT devenir_type_id, devenir_type_libelle,
		evenement_type_id, evenement_type_libelle
		from devenir_type
		left outer join evenement_type using (evenement_type_id)";
		empty ($order) ? $order = "" : $order = " order by $order";
		return $this->getListParam($sql.$order);
	}
}
