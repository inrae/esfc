<?php
/**
 * ORM de gestion de la table aliment_quotidien
 *
 * @author quinton
 *        
 */
class AlimentQuotidien extends ObjetBDD
{
	/**
	 * Constructeur de la classe
	 *
	 * @param PDO $bdd        	
	 * @param array $param        	
	 */
	function __construct($bdd, $param = array())
	{
		$this->table = "aliment_quotidien";
		$this->id_auto = 1;
		$this->colonnes = array(
			"aliment_quotidien_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"distrib_quotidien_id" => array(
				"type" => 1,
				"requis" => 1,
				"parentAttrib" => 1
			),
			"aliment_id" => array(
				"type" => 1,
				"requis" => 1
			),
			"quantite" => array(
				"type" => 1
			)
		);
		parent::__construct($bdd, $param);
	}
	/**
	 * Supprime les enregistrements liés à un bassin, à une date donnée
	 *
	 * @param string $date        	
	 * @param int $bassin        	
	 * @return void
	 */
	function deleteFromDateBassin($date, $bassin_id)
	{
		if (strlen($date) > 0 && $bassin_id > 0 && is_numeric($bassin_id)) {
			$date = $this->encodeData($date);
			$sql = "delete from aliment_quotidien
					using distrib_quotidien
					where distrib_quotidien.distrib_quotidien_id = aliment_quotidien.distrib_quotidien_id
					and distrib_quotidien_date = :datedist
					and bassin_id = :bassin_id";
			 $this->executeAsPrepared($sql, array("datedist"=>$date, "bassin_id"=>$bassin_id), true);
		}
	}
}