<?php

/**
 * ORM de gestion de la table analyse_eau
 *
 * @author quinton
 *        
 */
class AnalyseEau extends ObjetBDD
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
		$this->table = "analyse_eau";
		$this->colonnes = array(
			"analyse_eau_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"circuit_eau_id" => array(
				"type" => 0,
				"requis" => 1,
				"parentAttrib" => 1
			),
			"laboratoire_analyse_id" => array(
				"type" => 1
			),
			"analyse_eau_date" => array(
				"type" => 3
			),
			"temperature" => array(
				"type" => 1
			),
			"oxygene" => array(
				"type" => 1
			),
			"salinite" => array(
				"type" => 1
			),
			"ph" => array(
				"type" => 1
			),
			"nh4" => array(
				"type" => 1
			),
			"nh4_seuil" => array(
				"type" => 0
			),
			"n_nh4" => array(
				"type" => 1
			),
			"no2" => array(
				"type" => 1
			),
			"no2_seuil" => array(
				"type" => 0
			),
			"n_no2" => array(
				"type" => 1
			),
			"no3" => array(
				"type" => 1
			),
			"no3_seuil" => array(
				"type" => 0
			),
			"n_no3" => array(
				"type" => 1
			),
			"backwash_mecanique" => array(
				"type" => 1,
				"defaultValue" => 0
			),
			"backwash_biologique" => array(
				"type" => 1,
				"defaultValue" => 0
			),
			"backwash_biologique_commentaire" => array(
				"type" => 0
			),
			"debit_eau_riviere" => array(
				"type" => 1
			),
			"debit_eau_forage" => array(
				"type" => 1
			),
			"debit_eau_mer" => array(
				"type" => 1
			),
			"observations" => array(
				"type" => 0
			),
			"o2_pc" => array(
				"type" => 1
			)
		);
		parent::__construct($bdd, $param);
	}
	/**
	 * Retourne les analyses d'eau pour un circuit d'eau, avec les criteres limitatifs fournis
	 *
	 * @param int $id        	
	 * @param string $dateRef        	
	 * @param number $limit        	
	 * @param number $offset        	
	 * @return array
	 */
	function getDetailByCircuitEau($id, $dateRef = null, $limit = 1, $offset = 0)
	{
		if ($id > 0 && is_numeric($id)) {
			$sql = "select * from " . $this->table . " 
					natural join circuit_eau
					left outer join laboratoire_analyse using (laboratoire_analyse_id)";
			if (is_null($dateRef))
				$dateRef = date("d/m/Y");
			$dateRef = $this->formatDateLocaleVersDB($dateRef, 2);
			$where = " where analyse_eau_date <= '" . $dateRef . "' and circuit_eau.circuit_eau_id = " . $id;
			$order = " order by analyse_eau_date desc LIMIT " . $limit . " OFFSET " . $offset;
			$analyseMetal = new AnalyseMetal($this->connection, $this->paramori);
			if ($limit == 1) {
				$data = $this->lireParam($sql . $where . $order);
				if ($data["analyse_eau_id"] > 0 && is_numeric($data["analyse_eau_id"]))
					$data["metaux"] = $analyseMetal->getAnalyseToText($data["analyse_eau_id"]);
			} else {
				$data = $this->getListeParam($sql . $where . $order);
				foreach ($data as $key => $value) {
					$data[$key]["metaux"] = $analyseMetal->getAnalyseToText($value["analyse_eau_id"]);
				}
			}
			return $data;
		}
	}

	/**
	 * Surcharge de la fonction supprimer, pour effacer les analyses de metaux lourds
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::supprimer()
	 */
	function supprimer($id)
	{
		if ($id > 0 && is_numeric($id)) {
			/*
			 * Suppression des analyses des metaux
			 */
			$analyseMetal = new AnalyseMetal($this->connection, $this->paramori);
			$analyseMetal->supprimerChamp($id, "analyse_eau_id");
			return parent::supprimer($id);
		}
	}

	/**
	 * Retourne le numero d'analyse en fonction de la date et du bassin concerne
	 *
	 * @param unknown $dateAnalyse        	
	 * @param unknown $bassin_id        	
	 * @return int
	 */
	function getIdFromDateBassin($dateAnalyse, $bassin_id)
	{
		$dateAnalyse = $this->encodeData($dateAnalyse);
		$dateAnalyse = $this->formatDateLocaleVersDB($dateAnalyse, 3);
		if (strlen($dateAnalyse) > 0 && is_numeric($bassin_id) && $bassin_id > 0) {
			$sql = "select analyse_eau_id
					from analyse_eau
					natural join circuit_eau
					natural join bassin
					where bassin_id = " . $bassin_id . "
					and analyse_eau_date = '" . $dateAnalyse . "'";
			$data = $this->lireParam($sql);
			return ($data["analyse_eau_id"]);
		}
	}
	/**
	 * Retourne l'id de l'analyse à partir de la date et du circuit d'eau
	 *
	 * @param [string] $dateAnalyse
	 * @param [int] $circuit_id
	 * @return int
	 */
	function getIdFromDateCircuit($dateAnalyse, $circuit_id)
	{
		$dateAnalyse = $this->formatDateLocaleVersDB($dateAnalyse, 3);
		$sql = "select analyse_eau_id from analyse_eau 
				where circuit_eau_id = :circuit_id
				and analyse_eau_date = :date_analyse";
		return ($this->lireParamAsPrepared($sql, array("circuit_id" => $circuit_id, "date_analyse" => $dateAnalyse)));
	}

	/**
	 * Liste des valeurs enregistrees pour un type d'analyse
	 * pour un circuit d'eau et pour une periode
	 *
	 * @param [int] $circuit_id
	 * @param [string] $date_from
	 * @param [string] $date_to
	 * @param [string] $attribut
	 * @return array
	 */
	function getValFromDatesCircuit($circuit_id, $date_from, $date_to, $attribut)
	{
		if (in_array($attribut, array("temperature", "o2_pc", "salinite", "ph", "nh4", "n_nh4", "no2", "n_no2", "no3", "n_no3"))) {
			$date_from = $this->formatDateLocaleVersDB($date_from);
			$date_to = $this->formatDateLocaleVersDB($date_to);
			$sql = "select circuit_eau_id, analyse_eau_date, " . $attribut . "
			from analyse_eau 
			where circuit_eau_id = :circuit_id and analyse_eau_date::date between :date_from and :date_to 
			order by analyse_eau_date";
			return ($this->getListeParamAsPrepared(
				$sql,
				array(
					"circuit_id" => $circuit_id, "date_from" => $date_from, "date_to" => $date_to
				)
			));

		}
	}
}