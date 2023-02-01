<?php
/**
 * ORM de gestion de la table bassin_usage
 *
 * @author quinton
 *        
 */
class Bassin_usage extends ObjetBDD
{
	/**
	 * Constructeur de la classe
	 *
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = array())
	{
		$this->table = "bassin_usage";
		$this->id_auto = "1";
		$this->colonnes = array(
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
		parent::__construct($bdd, $param);
	}
	/**
	 * Réécriture de la liste pour prendre en compte la table categorie
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::getListe()
	 */
	function getListe($order = ""):array|bool
	{
		$sql = "select * from bassin_usage
				left outer join categorie using (categorie_id)";
		if (strlen($order) > 0 )
			$sql .= " order by " . $order;
		return $this->getListeParam($sql);
	}
}