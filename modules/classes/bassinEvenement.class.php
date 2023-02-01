<?php

/**
 * ORM de gestion de la table bassin_evenement
 *
 * @author quinton
 *        
 */
class BassinEvenement extends ObjetBDD
{
	/**
	 * Constructeur de la classe
	 *
	 * @param PDO $bdd        	
	 * @param array $param        	
	 */
	function __construct($bdd, $param = array())
	{
		$this->table = "bassin_evenement";
		$this->colonnes = array(
			"bassin_evenement_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"bassin_id" => array(
				"type" => 1,
				"requis" => 1,
				"parentAttrib" => 1
			),
			"bassin_evenement_type_id" => array(
				"type" => 1,
				"requis" => 1
			),
			"bassin_evenement_date" => array(
				"type" => 2,
				"defaultValue" => "getDateJour"
			),
			"bassin_evenement_commentaire" => array(
				"type" => 0
			)
		);
		parent::__construct($bdd, $param);
	}
	/**
	 * Retourne la liste des événements pour un bassin
	 *
	 * @param int $bassin_id        	
	 * @return array
	 */
	function getListeByBassin($bassin_id)
	{
		$sql = "select * from bassin_evenement
					natural join bassin_evenement_type
					where bassin_id = :id
					order by bassin_evenement_date desc";
		return $this->getListeParamAsPrepared($sql, array("id"=>$bassin_id));
	}
}
