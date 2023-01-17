<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 3 mars 2014
 */
/**
 * ORM de gestion de la table bassin
 *
 * @author quinton
 *        
 */
class Bassin extends ObjetBDD
{
	/**
	 * Constructeur de la classe
	 *
	 * @param PDO $bdd
	 * @param array $param        	
	 */
	var $types = array();
	function __construct($bdd, $param = array())
	{
		$this->table = "bassin";
		$this->colonnes = array(
			"bassin_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"bassin_zone_id" => array(
				"type" => 1
			),
			"bassin_type_id" => array(
				"type" => 1
			),
			"circuit_eau_id" => array(
				"type" => 1
			),
			"bassin_usage_id" => array(
				"type" => 1
			),
			"bassin_nom" => array(
				"type" => 0
			),
			"bassin_description" => array(
				"type" => 0
			),
			"longueur" => array(
				"type" => 1
			),
			"largeur_diametre" => array(
				"type" => 1
			),
			"surface" => array(
				"type" => 1
			),
			"hauteur_eau" => array(
				"type" => 1
			),
			"volume" => array(
				"type" => 1
			),
			"actif" => array(
				"type" => 1,
				"defaultValue" => 1
			),
			"site_id" => array("type" => 1)
		);
		parent::__construct($bdd, $param);
	}
	/**
	 * Fonction de recherche des bassins selon les criteres definis
	 *
	 * @param array $dataSearch        	
	 */
	function getListeSearch($dataSearch)
	{
		if (is_array($dataSearch)) {
			$sql = "select bassin_id, bassin_nom, bassin_description, actif,
					bassin_type_libelle, bassin_usage_libelle, bassin_zone_libelle, 
					bassin.circuit_eau_id, circuit_eau_libelle,
					longueur, largeur_diametre, surface, hauteur_eau, volume,
					site.site_id, site_name
					from bassin
					left outer join bassin_type using (bassin_type_id)
					left outer join bassin_usage using (bassin_usage_id)
					left outer join bassin_zone using (bassin_zone_id)
					left outer join circuit_eau using (circuit_eau_id)
					left outer join site on (bassin.site_id = site.site_id)
					";
			/*
			 * Preparation de la clause order
			 */
			$order = " order by bassin_nom ";

			return $this->getListeParam($sql . $this->getWhere($dataSearch) . $order);
		}
	}
	function getWhere($dataSearch)
	{
		$dataSearch = $this->encodeData($dataSearch);
		/*
		 * Preparation de la clause where
		 */
		$where = " where ";
		$and = "";
		if (strlen($dataSearch["bassin_nom"]) > 0) {
			$where .= $and . " upper(bassin_nom) like upper('" . $dataSearch["bassin_nom"] . "')";
			$and = " and ";
		}
		if ($dataSearch["bassin_type"] > 0 && is_numeric($dataSearch["bassin_type"])) {
			$where .= $and . " bassin_type_id = " . $dataSearch["bassin_type"];
			$and = " and ";
		}
		if ($dataSearch["bassin_usage"] > 0 && is_numeric($dataSearch["bassin_usage"])) {
			$where .= $and . " bassin_usage_id = " . $dataSearch["bassin_usage"];
			$and = " and ";
		}
		if ($dataSearch["bassin_zone"] > 0 && is_numeric($dataSearch["bassin_zone"])) {
			$where .= $and . " bassin_zone_id = " . $dataSearch["bassin_zone"];
			$and = " and ";
		}
		if ($dataSearch["circuit_eau"] > 0 && is_numeric($dataSearch["circuit_eau"])) {
			$where .= $and . " circuit_eau_id = " . $dataSearch["circuit_eau"];
			$and = " and ";
		}
		if ($dataSearch["bassin_actif"] != "") {
			$where .= $and . " actif = " . $dataSearch["bassin_actif"];
			$and = " and ";
		}
		if ($dataSearch["site_id"] > 0) {
			$where .= $and . " bassin.site_id = " . $dataSearch["site_id"];
			$and = " and ";
		}
		if (strlen($where) == 7)
			$where = "";
		return $where;
	}

	/**
	 * Retourne les informations generales d'un bassin (cartouche)
	 *
	 * @param int $bassinId        	
	 * @return array
	 */
	function getDetail($bassinId)
	{
		if ($bassinId > 0 && is_numeric($bassinId)) {
			$sql = "select bassin_id, bassin_nom, bassin_description, actif,
					bassin_type_libelle, bassin_usage_libelle, bassin_zone_libelle, 
					bassin.circuit_eau_id, circuit_eau_libelle,
					bassin.site_id, site_name
					from bassin
					left outer join bassin_type using (bassin_type_id)
					left outer join bassin_usage using (bassin_usage_id)
					left outer join bassin_zone using (bassin_zone_id)
					left outer join circuit_eau using (circuit_eau_id)
					left outer join site on (bassin.site_id = site.site_id)
					where bassin_id = " . $bassinId;
			return $this->lireParam($sql);
		}
	}
	/**
	 * Retourne la liste des bassins, actifs ou non, ou tous
	 * rajout le 7/5/15 d'un parametre concernant l'usage
	 *
	 * @param
	 *        	int actif
	 * @return array (non-PHPdoc)
	 * @see ObjetBDD::getListe()
	 */
	function getListe($actif = -1, $usage = 0)
	{
		$sql = "select * from bassin ";
		$where = " where ";
		$bwhere = false;
		if ($actif > -1 && is_numeric($actif)) {
			$where .= " actif = " . $actif;
			$bwhere = true;
		}
		if ($usage > 0 && is_numeric($usage)) {
			$bwhere == true ? $where .= " and " : $bwhere = true;
			$where .= " bassin_usage_id = " . $usage;
		}
		if ($bwhere == false)
			$where = "";
		$order = " order by bassin_nom";
		return ($this->getListeParam($sql . $where . $order));
	}
	/**
	 * Retourne la liste des bassins associes a un circuit d'eau
	 *
	 * @param int $circuitId        	
	 * @return array
	 */
	function getListeByCircuitEau($circuitId)
	{
		if ($circuitId > 0 && is_numeric($circuitId)) {
			$sql = "select bassin_id, bassin_nom from bassin where circuit_eau_id = " . $circuitId . "
				order by bassin_nom";
			return $this->getListeParam($sql);
		}
	}
	/**
	 * Calcule la masse des poissons présents dans un bassin
	 *
	 * @param unknown $bassinId        	
	 * @return unknown
	 */
	function calculMasse($bassinId)
	{
		if ($bassinId > 0 && is_numeric($bassinId)) {
			/*
			 * Recuperation de la liste des poissons
			 */
			$transfert = new Transfert($this->connection, $this->paramori);
			$morphologie = new Morphologie($this->connection, $this->paramori);
			$listePoisson = $transfert->getListPoissonPresentByBassin($bassinId);
			$masse = 0;
			foreach ($listePoisson as $key => $value) {
				$data = $morphologie->getMasseLast($value["poisson_id"]);
				$masse += $data["masse"];
			}
			return ($masse);
		}
	}
	/**
	 * Fonction calculant la quantite hebdomadaire d'aliments distribues pour les bassins consideres
	 * 
	 * @param array $data
	 *        	: $_REQUEST
	 * @param array $search
	 *        	: parametres de recherche des bassins
	 * @return tableau
	 */
	function getRecapAlim($data, $search)
	{
		$data = $this->encodeData($data);
		if (isset($data["dateDebut"]) && isset($data["dateFin"])) {
			$dateDebut = $this->formatDateLocaleVersDB($data["dateDebut"]);
			$dateFin = $this->formatDateLocaleVersDB($data["dateFin"]);

			$sql = "with dq as (
				select bassin_id, bassin_nom, date_trunc('week', distrib_quotidien_date) as week,
				sum(total_distribue) as total_distribue,
				sum(reste) as restes
				from distrib_quotidien
				join bassin using (bassin_id) " . $this->getWhere($search) . "
				and distrib_quotidien_date between '" . $dateDebut . "' and '" . $dateFin . "'
				group by bassin_id, bassin_nom, week
				order by bassin_id, week)
				select dq.*, f_bassin_masse_at_date(dq.bassin_id, week::timestamp) as poissons_masse
				from dq";
			$this->types["week"] = 2;
			return $this->getListeParam($sql);
		}
	}
}
