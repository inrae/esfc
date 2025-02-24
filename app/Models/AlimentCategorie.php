<?php

namespace App\Models;

use Ppci\Models\PpciModel;

class AlimentCategorie extends PpciModel
{
	/**
	 * Constructeur de la classe
	 *
	         	
	 */
	function __construct()
	{
		$this->table = "aliment_categorie";
		$this->fields = array(
			"aliment_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1
			),
			"categorie_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1
			)
		);
		parent::__construct();
	}
	/**
	 * Retourne la liste des categories pour un aliment
	 *
	 * @param int $aliment_id        	
	 * @return array
	 */
	function getListeFromAliment(int $aliment_id): ?array
	{
		if ($aliment_id > 0) {
			$sql = "select * from aliment_categorie
				where aliment_id =  :aliment_id:";
			return $this->getListeParamAsPrepared($sql, array("aliment_id" => $aliment_id));
		} else {
			return array();
		}
	}
}
