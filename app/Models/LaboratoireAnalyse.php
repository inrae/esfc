<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table laboratoire_analyse
 *
 * @author quinton
 *        
 */
class LaboratoireAnalyse extends PpciModel
{
	/**
	 * Constructeur de la classe
	 *
	 *         	
	 */
	function __construct()
	{
		$this->table = "laboratoire_analyse";
		$this->fields = array(
			"laboratoire_analyse_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"laboratoire_analyse_libelle" => array(
				"type" => 0,
				"requis" => 1
			),
			"laboratoire_analyse_actif" => array(
				"type" => 1,
				"defaultValue" => 1
			)
		);
		parent::__construct();
	}
	/**
	 * Retourne la liste des laboratoires produisant des analyses
	 */
	function getListeActif()
	{
		$sql = "select * from laboratoire_analyse
				where laboratoire_analyse_actif = 1
				order by laboratoire_analyse_libelle";
		return $this->getListeParam($sql);
	}
}
