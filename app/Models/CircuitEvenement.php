<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table circuit_evenement
 *
 * @author quinton
 *        
 */
class CircuitEvenement extends PpciModel
{
	/**
	 * Constructeur de la classe
	 *
	 *         	
	 */
	function __construct()
	{
		$this->table = "circuit_evenement";
		$this->fields = array(
			"circuit_evenement_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"circuit_eau_id" => array(
				"type" => 1,
				"requis" => 1,
				"parentAttrib" => 1
			),
			"circuit_evenement_type_id" => array(
				"type" => 1,
				"requis" => 1
			),
			"circuit_evenement_date" => array(
				"type" => 2,
				"defaultValue" => "getDateJour"
			),
			"circuit_evenement_commentaire" => array(
				"type" => 0
			)
		);
		parent::__construct();
	}
	/**
	 * Retourne la liste des événements pour un circuit
	 *
	 * @param int $circuit_id        	
	 * @return array
	 */
	function getListeBycircuit(int $circuit_eau_id)
	{
		$sql = "SELECT * from circuit_evenement
					join circuit_evenement_type using (circuit_evenement_type_id)
					where circuit_eau_id = :id:
					order by circuit_evenement_date desc";
		return $this->getListeParamAsPrepared($sql, array("id" => $circuit_eau_id));
	}
}
