<?php

namespace App\Models;

use Ppci\Models\PpciModel;

class LotRepartTemplate extends PpciModel
{
	/**
	 * Constructeur de la classe
	 *
	 *         	
	 */
	function __construct()
	{
		$this->table = "lot_repart_template";
		$this->fields = array(
			"lot_repart_template_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"age" => array(
				"type" => 1,
				"requis" => 1
			),
			"artemia" => array(
				"type" => 1
			),
			"chironome" => array(
				"type" => 1
			)
		);
		parent::__construct();
	}
	/**
	 * Retourne la quantite a distribuer en fonction de l'age (en jours)
	 * 
	 * @param int $age        	
	 * @return array
	 */
	function getFromAge(int $age)
	{
		$sql = "select * from lot_repart_template
				where age = :age:";
		return $this->lireParamAsPrepared($sql, array("age" => $age));
	}
}
