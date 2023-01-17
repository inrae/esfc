<?php
class AlimentCategorie extends ObjetBDD
{
	/**
	 * Constructeur de la classe
	 *
	 * @param PDO $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = array())
	{
		$this->table = "aliment_categorie";
		$this->colonnes = array(
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
		parent::__construct($bdd, $param);
	}
	/**
	 * Retourne la liste des categories pour un aliment
	 *
	 * @param int $aliment_id        	
	 * @return array
	 */
	function getListeFromAliment($aliment_id) :?array
	{
		if ($aliment_id > 0 && is_numeric($aliment_id)) {
			$sql = "select * from " . $this->table . "
				where aliment_id =  :aliment_id";
			return $this->getListeParamAsPrepared($sql, array("aliment_id"=>$aliment_id));
		}
	}
}