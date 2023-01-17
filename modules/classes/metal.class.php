<?php
/**
 * ORM de gestion de la table metal
 *
 * @author quinton
 *        
 */
class Metal extends ObjetBDD
{
	/**
	 * Constructeur de la classe
	 *
	 * @param PDO $bdd        	
	 * @param array $param        	
	 */
	function __construct($bdd, $param = array())
	{
		$this->table = "metal";
		$this->colonnes = array(
			"metal_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),

			"metal_nom" => array(
				"type" => 0,
				"requis" => 1
			),
			"metal_unite" => array(
				"type" => 0
			),
			"metal_actif" => array(
				"type" => 1,
				"defaultValue" => 1
			)
		);
		parent::__construct($bdd, $param);
	}

	/**
	 * Retourne la liste des metaux analyses, selon qu'ils sont actifs ou non
	 *
	 * @param number $actif        	
	 * @return tableau
	 */
	function getListActif($actif = 1)
	{
		$actif = $this->encodeData($actif);
		$sql = "select * from metal";
		$order = " order by metal_nom";
		$where = "";
		if ($actif == 1 || $actif == 0)
			$where = " where actif = " . $actif;
		return $this->getListeParam($sql . $where . $order);
	}

	/**
	 * Retourne la liste des metaux actifs qui ne figurent pas dans la liste fournie
	 *
	 * @param array $analyse        	
	 * @return tableau
	 */
	function getListActifInconnu($analyse)
	{
		$sql = "select * from metal";
		$order = " order by metal_nom";
		$where = " where metal_actif = 1";
		if (count($analyse) > 0) {
			$where .= " and metal_id not in ( ";
			$comma = false;
			foreach ($analyse as $key => $value) {
				if ($comma == true) {
					$where .= ",";
				} else
					$comma = true;
				$where .= $value["metal_id"];
			}
			$where .= ")";
		}
		return $this->getListeParam($sql . $where . $order);
	}
}
