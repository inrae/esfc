<?php
/**
 * ORM de gestion de la table repro_statut
 *
 * @author quinton
 *
 */
class ReproStatut extends ObjetBDD
{
	public function __construct($p_connection, $param = array())
	{
		$this->table = "repro_statut";
		$this->colonnes = array(
			"repro_statut_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"repro_statut_libelle" => array(
				"type" => 0,
				"requis" => 1
			)
		);

		parent::__construct($p_connection, $param);
	}
}
