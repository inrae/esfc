<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table bassin_usage
 *
 * @author quinton
 *        
 */
class Bassin_usage extends PpciModel
{
	/**
	 * Constructeur de la classe
	 *
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct()
	{
		$this->table = "bassin_usage";
		$this->fields = array(
			"bassin_usage_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"bassin_usage_libelle" => array(
				"type" => 0,
				"requis" => 1
			),
			"categorie_id" => array(
				"type" => 1
			)
		);
		parent::__construct();
	}
	/**
	 * Réécriture de la liste pour prendre en compte la table categorie
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::getListe()
	 */
	function getListe(string $order = ""): array
	{
		$sql = "SELECT * from bassin_usage
				left outer join categorie using (categorie_id)";
		if (strlen($order) > 0)
			$sql .= " order by " . $order;
		return $this->getListeParam($sql);
	}
}
