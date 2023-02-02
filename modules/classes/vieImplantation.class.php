<?php
/**
 * ORM de gestion de la table vie_implantation
 *
 * @author quinton
 *        
 */
class VieImplantation extends ObjetBDD
{
	function __construct($bdd, $param = array())
	{
		$this->table = "vie_implantation";
		$this->colonnes = array(
			"vie_implantation_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"vie_implantation_libelle" => array(
				"type" => 0,
				"requis" => 1
			)
		);
		parent::__construct($bdd, $param);
	}
}
