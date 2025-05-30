<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table lot_mesure
 *
 * @author quinton
 *        
 */
class LotMesure extends PpciModel
{
	public Lot $lot;

	function __construct()
	{
		$this->table = "lot_mesure";
		$this->fields = array(
			"lot_mesure_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"lot_id" => array(
				"type" => 1,
				"requis" => 1,
				"parentAttrib" => 1
			),
			"lot_mesure_date" => array(
				"type" => 2,
				"requis" => 1,
				"defaultValue" => "getDateJour"
			),
			"nb_jour" => array(
				"type" => 1
			),
			"lot_mortalite" => array(
				"type" => 1
			),
			"lot_mesure_masse" => array(
				"type" => 1
			),
			"lot_mesure_masse_indiv" => array(
				"type" => 1
			)
		);

		parent::__construct();
	}

	/**
	 * Retourne la liste des mesures pur un lot
	 *
	 * @param int $lot_id        	
	 * @return array
	 */
	function getListFromLot(int $lot_id)
	{
		$sql = "SELECT lot_mesure_id, lot_id, lot_mesure_date, nb_jour, lot_mortalite,
					lot_mesure_masse, lot_mesure_masse_indiv
					from lot_mesure
					where lot_id = :id:
					order by lot_mesure_date";
		return $this->getListeParamAsPrepared($sql, array("id" => $lot_id));
	}

	/**
	 * Calcul du nombre de jours depuis l'eclosion avant l'écriture en table
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::ecrire()
	 */
	function write($data): int
	{
		/*
		 * Calcul du nombre de jours depuis l'éclosion
		 */
		if ($data["lot_id"] > 0 && strlen($data["lot_mesure_date"]) > 0) {
			if (!isset($this->lot)) {
				$this->lot = new Lot;
			}
			$dataLot = $this->lot->lire($data["lot_id"]);
			$dateDebut = date_parse_from_format("d/m/Y", $dataLot["eclosion_date"]);
			$dateFin = date_parse_from_format("d/m/Y", $data["lot_mesure_date"]);
			$nbJours = round((strtotime($dateFin["year"] . "-" . $dateFin["month"] . "-" . $dateFin["day"]) - strtotime($dateDebut["year"] . "-" . $dateDebut["month"] . "-" . $dateDebut["day"])) / (60 * 60 * 24));
			if ($nbJours > 0 && $nbJours < 365) {
				$data["nb_jour"] = $nbJours;
			}
		}
		return parent::write($data);
	}

	/**
	 * Retourne le nombre de poissons morts et la derniere masse individuelle connue
	 * pour un lot a une date connue
	 * @param int $lot_id
	 * @param string $date
	 * @return array
	 */
	function getMesureAtDate(int $lot_id, string $date)
	{
		$date = $this->formatDateLocaleVersDB($date);
		/*
		 * Recuperation de la mortalite totale
		 */
		$param = array("lot_id" => $lot_id, "date" => $date);
		$sql = "SELECT sum(lot_mortalite) as lot_mortalite
					from lot_mesure
					where lot_mesure_date <= :date:
						and lot_id = :lot_id:";
		$data = $this->lireParamAsPrepared($sql, $param);
		if (!is_array($data))
			$data["lot_mortalite"] = 0;
		/*
		 * Recuperation de la derniere masse individuelle connue
		 */
		$sql = "SELECT lot_mesure_masse_indiv 
					from lot_mesure
					where lot_mesure_date <= :date:
						and lot_id = :lot_id: 
					order by lot_mesure_date desc
					limit 1";
		$dataMasse = $this->lireParamAsPrepared($sql, $param);
		$data["masse_indiv"] = $dataMasse["lot_mesure_masse_indiv"];
		return $data;
	}
}
