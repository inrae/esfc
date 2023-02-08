<?php

/**
 *
 * @author quinton
 *        
 */
class Sequence extends ObjetBDD
{

	/**
	 *
	 * @param
	 *        	instance ADODB
	 *        	
	 */
	public function __construct($p_connection, $param = null)
	{
		$this->table = "sequence";
		$this->colonnes = array(
			"sequence_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"sequence_nom" => array(
				"type" => 0,
				"requis" => 1
			),
			"annee" => array(
				"type" => 1,
				"requis" => 1,
				"defaultValue" => "getYear"
			),
			"sequence_date_debut" => array(
				"type" => 2
			),
			"site_id" => array("type" => 1)
		);
		parent::__construct($p_connection, $param);
	}
	/**
	 * Reecriture de lire pour récuperer le nom du site
	 *
	 * @param int $id
	 * @return array
	 */
	function lire($id, bool $getDefault = true, int $parent = 0)
	{
		if ($id > 0) {
			$sql = "select sequence_id, sequence_nom, annee, sequence_date_debut,
					site_id, site_name
					from sequence
					left outer join site using (site_id)
					where sequence_id = :sequence_id";
			$data = $this->lireParamAsPrepared($sql, array("sequence_id" => $id));
		} else {
			$data = $this->getDefaultValue();
			$data["site_id"] = $_SESSION["site_id"];
		}
		return $data;
	}

	/**
	 * Retourne l'annee courante
	 *
	 * @return int
	 */
	function getYear()
	{
		return date('Y');
	}

	/**
	 * Retourne la liste des séquences pour une année donnée
	 *
	 * @param int $annee        	
	 */
	function getListeByYear(int $annee, $site_id = 0)
	{

		$sql = "select sequence_id, sequence_nom, annee, sequence_date_debut,
				site_id, site_name
				from sequence
				left outer join site using (site_id)
				where annee = :annee ";
		$param = array("annee" => $annee);
		if ($site_id > 0) {
			$sql .= " and site_id = :site_id";
			$param["site_id"] = $site_id;
		}
		$sql .= " order by sequence_date_debut";
		return parent::getListeParamAsPrepared($sql, $param);
	}
}



