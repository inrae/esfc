<?php
/**
 * ORM de gestion de la table biopsie_technique_calcul
 * @author quinton
 *
 */
class BiopsieTechniqueCalcul extends ObjetBDD
{
	function __construct($bdd, $param = array())
	{
		$this->table = "biopsie_technique_calcul";
		$this->colonnes = array(
			"biopsie_technique_calcul_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"biopsie_technique_calcul_libelle" => array(
				"type" => 0,
				"requis" => 1
			)
		);
		parent::__construct($bdd, $param);
	}
}
