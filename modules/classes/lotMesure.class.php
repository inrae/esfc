<?php
/**
 * ORM de gestion de la table lot_mesure
 *
 * @author quinton
 *        
 */
class LotMesure extends ObjetBDD
{
	/**
	 * Constructeur de la classe
	 *
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null)
	{
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "lot_mesure";
		$this->id_auto = "1";
		$this->colonnes = array(
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
		if (!is_array($param))
			$param = array();
		$param["fullDescription"] = 1;
		parent::__construct($bdd, $param);
	}

	/**
	 * Retourne la liste des mesures pur un lot
	 *
	 * @param int $lot_id        	
	 * @return tableau|NULL
	 */
	function getListFromLot($lot_id)
	{
		if ($lot_id > 0 && is_numeric($lot_id)) {
			$sql = "select lot_mesure_id, lot_id, lot_mesure_date, nb_jour, lot_mortalite,
					lot_mesure_masse, lot_mesure_masse_indiv
					from lot_mesure
					where lot_id = " . $lot_id . "
					order by lot_mesure_date";
			return $this->getListeParam($sql);
		} else
			return null;
	}

	/**
	 * Calcul du nombre de jours depuis l'eclosion avant l'écriture en table
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::ecrire()
	 */
	function ecrire($data)
	{
		/*
		 * Calcul du nombre de jours depuis l'éclosion
		 */
		if ($data["lot_id"] > 0 && strlen($data["lot_mesure_date"]) > 0) {
			$lot = new Lot($this->connection, $this->paramori);
			$dataLot = $lot->lire($data["lot_id"]);
			$dateDebut = date_parse_from_format("d/m/Y", $dataLot["eclosion_date"]);
			$dateFin = date_parse_from_format("d/m/Y", $data["lot_mesure_date"]);
			$nbJours = round((strtotime($dateFin["year"] . "-" . $dateFin["month"] . "-" . $dateFin["day"]) - strtotime($dateDebut["year"] . "-" . $dateDebut["month"] . "-" . $dateDebut["day"])) / (60 * 60 * 24));
			if ($nbJours > 0 && $nbJours < 365) {
				$data["nb_jour"] = $nbJours;
			}
		}
		return parent::ecrire($data);
	}

	/**
	 * Retourne le nombre de poissons morts et la derniere masse individuelle connue
	 * pour un lot a une date connue
	 * @param unknown $lot_id
	 * @param unknown $date
	 * @return array|NULL
	 */
	function getMesureAtDate($lot_id, $date)
	{
		if ($lot_id > 0  && is_numeric($lot_id) && strlen($date) > 0) {
			$date = $this->encodeData($date);
			$date = $this->formatDateLocaleVersDB($date);
			/*
			 * Recuperation de la mortalite totale
			 */
			$sql = "select sum(lot_mortalite) as lot_mortalite
					from lot_mesure
					where lot_mesure_date <= '" . $date . "' 
						and lot_id = " . $lot_id;
			$data = $this->lireParam($sql);
			if (!is_array($data))
				$data["lot_mortalite"] = 0;
			/*
			 * Recuperation de la derniere masse individuelle connue
			 */
			$sql = "select lot_mesure_masse_indiv 
					from lot_mesure
					where lot_mesure_date <= '" . $date . "' 
						and lot_id = " . $lot_id . "
					order by lot_mesure_date desc
					limit 1";
			$dataMasse = $this->lireParam($sql);
			$data["masse_indiv"] = $dataMasse["lot_mesure_masse_indiv"];
			return $data;
		} else
			return null;
	}
}