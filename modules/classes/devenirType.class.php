<?php
/**
 * ORM de gestion de la table devenir_type
 * @author quinton
 *
 */
class DevenirType extends ObjetBDD
{
	function __construct($bdd, $param = array())
	{
		$this->table = "devenir_type";
		$this->id_auto = "0";
		$this->colonnes = array(
			"devenir_type_id" => array("type" => 1, "key" => 1, "requis" => 1, "defaultValue" => 0),
			"devenir_type_libelle" => array("requis" => 1)
		);
		parent::__construct($bdd, $param);
	}
}
