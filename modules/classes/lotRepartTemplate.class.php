<?php

class LotRepartTemplate extends ObjetBDD
{
	/**
	 * Constructeur de la classe
	 *
	 * @param PDO $bdd        	
	 * @param array $param        	
	 */
	function __construct($bdd, $param = array())
	{
		$this->table = "lot_repart_template";
		$this->colonnes = array(
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
		parent::__construct($bdd, $param);
	}
	/**
	 * Retourne la quantite a distribuer en fonction de l'age (en jours)
	 * 
	 * @param int $age        	
	 * @return array|NULL
	 */
	function getFromAge($age)
	{
		if ($age > 0 && is_numeric($age)) {
			$sql = "select * from lot_repart_template
				where age = " . $age;
			return $this->lireParam($sql);
		} else
			return null;
	}
}