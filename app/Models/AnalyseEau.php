<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table analyse_eau
 *
 * @author quinton
 *        
 */
class AnalyseEau extends PpciModel
{
	/**
	 * Constructeur de la classe
	 *
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	public AnalyseMetal $analyseMetal;
	function __construct()
	{
		$this->table = "analyse_eau";
		$this->fields = array(
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
		parent::__construct();
	}

	/**
	 * Retourne les analyses d'eau pour un circuit d'eau, avec les criteres limitatifs fournis
	 *
	 * @param int $id        	
	 * @param string $dateRef        	
	 * @param int $limit        	
	 * @param int $offset        	
	 * @return array
	 */
	function getDetailByCircuitEau($id, $dateRef = null, int $limit = 1, int $offset = 0): ?array
	{
		if ($id > 0 && is_numeric($id)) {
			$sql = "SELECT * from analyse_eau
					join circuit_eau using (circuit_eau_id)
					left outer join laboratoire_analyse using (laboratoire_analyse_id)";
			if (is_null($dateRef))
				$dateRef = date("d/m/Y");
			$param = array(
				"date_ref" => $this->formatDateLocaleVersDB($dateRef, 2),
				"id" => $id
			);
			$where = " where analyse_eau_date <= :date_ref: and circuit_eau.circuit_eau_id = :id:";

			$order = " order by analyse_eau_date desc LIMIT " . $limit . " OFFSET " . $offset;
			if (!isset($this->analyseMetal)) {
				$this->analyseMetal = new AnalyseMetal;
			}
			if ($limit == 1) {
				$data = $this->lireParamAsPrepared($sql . $where . $order, $param);
				if ($data["analyse_eau_id"] > 0 && is_numeric($data["analyse_eau_id"]))
					$data["metaux"] = $this->analyseMetal->getAnalyseToText($data["analyse_eau_id"]);
			} else {
				$data = $this->getListeParamAsPrepared($sql . $where . $order, $param);
				foreach ($data as $key => $value) {
					$data[$key]["metaux"] = $this->analyseMetal->getAnalyseToText($value["analyse_eau_id"]);
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
	function supprimer($id): bool
	{
		if ($id > 0) {
			/*
			 * Suppression des analyses des metaux
			 */
			$analyseMetal = new AnalyseMetal($this->connection, $this->paramori);
			$analyseMetal->supprimerChamp($id, "analyse_eau_id");
			return parent::supprimer($id);
		} else {
			return false;
		}
	}

	/**
	 * Retourne le numero d'analyse en fonction de la date et du bassin concerne
	 *
	 * @param string $dateAnalyse        	
	 * @param int $bassin_id        	
	 * @return int
	 */
	function getIdFromDateBassin($dateAnalyse, $bassin_id): ?int
	{
		$dateAnalyse = $this->encodeData($dateAnalyse);
		$dateAnalyse = $this->formatDateLocaleVersDB($dateAnalyse, 3);
		if (strlen($dateAnalyse) > 0 && is_numeric($bassin_id) && $bassin_id > 0) {
			$sql = "SELECT analyse_eau_id
					from analyse_eau
					natural join circuit_eau
					natural join bassin
					where bassin_id = :bassin_id:
					and analyse_eau_date = :date_analyse:";
			$data = $this->lireParam($sql, ["bassin_id" => $bassin_id, "date_analyse" => $dateAnalyse]);
			return ($data["analyse_eau_id"]);
		}
	}
	/**
	 * Retourne l'id de l'analyse à partir de la date et du circuit d'eau
	 *
	 * @param [string] $dateAnalyse
	 * @param [int] $circuit_id
	 * @return array
	 */
	function getIdFromDateCircuit($dateAnalyse, $circuit_id)
	{
		$dateAnalyse = $this->formatDateLocaleVersDB($dateAnalyse, 3);
		$sql = "SELECT analyse_eau_id from analyse_eau 
				where circuit_eau_id = :circuit_id:
				and analyse_eau_date = :date_analyse:";
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
	function getValFromDatesCircuit($circuit_id, $date_from, $date_to, $attribut): ?array
	{
		if (in_array($attribut, array("temperature", "o2_pc", "salinite", "ph", "nh4", "n_nh4", "no2", "n_no2", "no3", "n_no3"))) {
			$date_from = $this->formatDateLocaleVersDB($date_from);
			$date_to = $this->formatDateLocaleVersDB($date_to);
			$sql = "SELECT circuit_eau_id, analyse_eau_date, " . $attribut . "
			from analyse_eau 
			where circuit_eau_id = :circuit_id: and analyse_eau_date::date between :date_from: and :date_to: 
			order by analyse_eau_date";
			return (
				$this->getListeParamAsPrepared(
					$sql,
					array(
						"circuit_id" => $circuit_id,
						"date_from" => $date_from,
						"date_to" => $date_to
					)
				)
			);
		}
	}
}
