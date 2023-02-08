<?php

class PsStatut extends ObjetBDD
{
	public function __construct($p_connection, $param = array())
	{
		$this->table = "ps_statut";
		$this->colonnes = array(
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
		parent::__construct($p_connection, $param);
	}
}