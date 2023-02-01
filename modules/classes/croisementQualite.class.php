<?php
/**
 * ORM de gestion de la table croisement_qualite
 *
 * @author quinton
 *        
 */
class CroisementQualite extends ObjetBDD
{
	function __construct($bdd, $param = array())
	{
		$this->table = "croisement_qualite";
		$this->colonnes = array(
			"croisement_qualite_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"croisement_qualite_libelle" => array(
				"type" => 0,
				"requis" => 1
			)
		);
		parent::__construct($bdd, $param);
	}
}
