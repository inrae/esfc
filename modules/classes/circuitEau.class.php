<?php
/**
 * ORM de gestion de la table circuit_eau
 *
 * @author quinton
 *        
 */
class CircuitEau extends ObjetBDD
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
		$this->table = "circuit_eau";
		$this->id_auto = "1";
		$this->colonnes = array(
			"circuit_eau_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"circuit_eau_libelle" => array(
				"type" => 0,
				"requis" => 1
			),
			"circuit_eau_actif" => array(
				"type" => 1,
				"defaultValue" => 1
			),
			"site_id" => array("type" => 1)
		);
		parent::__construct($bdd, $param);
	}
	/**
	 * Réécriture de la fonction lire pour récupérer le nom du site
	 *
	 * @param int $id
	 * @return array
	 */
	function lire($id, $getDefault = true, $parentValue = 0):array
	{
		if ($id > 0) {
			$sql = "select circuit_eau_id, circuit_eau_libelle, circuit_eau_actif,
					site_id, site_name
					from circuit_eau
					left outer join site using (site_id)
					where circuit_eau_id = :cei";
			$data = $this->lireParamAsPrepared($sql, array("cei" => $id));
		} else {
			$data = $this->getDefaultValue();
		}
		return $data;
	}

	/**
	 * Retourne la liste des circuits d'eau en fonction des parametres de recherche
	 *
	 * @param array $data        	
	 * @return array
	 */
	function getListeSearch($data)
	{
		$param = array();
		$sql = "select * 
				from circuit_eau
				left outer join site using (site_id)";
		$order = ' order by circuit_eau_libelle';
		$where = '';
		$and = '';
		if (strlen($data["circuit_eau_libelle"]) > 0) {
			$where .= $and . " upper(circuit_eau_libelle) like upper(:circuit_eau_libelle) ";
			$and = " and ";
			$param["circuit_eau_libelle"] = "%" . $data["circuit_eau_libelle"] . "%";
		}
		if ($data["circuit_eau_actif"] > -1 ) {
			$where .= $and . " circuit_eau_actif = :circuit_eau_actif"  ;
			$and = " and ";
			$param["circuit_eau_actif"] = $data["circuit_eau_actif"];
		}
		if ($data["site_id"] > 0) {
			$where .= $and . " site_id = :site_id" ;
			$and = " and ";
			$param["site_id"] = $data["site_id"];
		}
		if ($and == " and ")
			$where = " where " . $where;
		return $this->getListeParamAsPrepared($sql . $where . $order, $param);
	}

	/**
	 * Retourne l'identifiant du circuit d'eau à partir de son nom
	 *
	 * @param int $name
	 * @return array
	 */
	function getIdFromName($name)
	{
		$sql = "select circuit_eau_id from circuit_eau where circuit_eau_libelle = :name";
		return $this->lireParamAsPrepared($sql, array("name" => $name));
	}
}