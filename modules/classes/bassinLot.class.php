<?php
/**
 * ORM de gestion de la table bassin_lot
 *
 * @author quinton
 *        
 */
class BassinLot extends ObjetBDD
{
	/**
	 * Constructeur de la classe
	 *
	 * @param PDO $bdd        	
	 * @param array $param        	
	 */
	function __construct($bdd, $param = array())
	{
		$this->table = "bassin_lot";
		$this->colonnes = array(
			"bassin_lot_id" => array(
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

			"bassin_id" => array(
				"type" => 1,
				"requis" => 1
			),
			"bl_date_arrivee" => array(
				"type" => 2,
				"requis" => 1
			),
			"bl_date_depart" => array(
				"type" => 2
			)
		);
		parent::__construct($bdd, $param);
	}

	/**
	 * Retourne la liste des bassins utilisés pour un lot
	 *
	 * @param int $lot_id        	
	 * @return tableau|NULL
	 */
	function getListeFromLot($lot_id)
	{
		if ($lot_id > 0 && is_numeric($lot_id)) {
			$sql = "select bassin_lot_id, lot_id, bassin_id, 
					bl_date_arrivee, bl_date_depart,
					bassin_nom
					from bassin_lot
					join bassin using (bassin_id)
					where lot_id = " . $lot_id . "
					order by bl_date_arrivee desc";
			return $this->getListeParam($sql);
		} else
			return null;
	}

	/**
	 * Surcharge de la fonction ecrire pour mettre a jour la date de fin pour
	 * le bassin precedent
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::ecrire()
	 */
	function write($data)
	{
		$data["bassin_lot_id"] == 0 ? $creation = true : $creation = false;
		$id = parent::ecrire($data);
		if ($id > 0 && $creation == true) {
			/*
			 * Ecrit la date d'arrivee dans le bassin comme date de depart du bassin precedent
			 */
			$dataPrec = $this->getPrecedentBassin($data["lot_id"], $data["bl_date_arrivee"]);
			if ($dataPrec["bassin_lot_id"] > 0 && strlen($dataPrec["bl_date_depart"]) == 0) {
				/*
				 * Calcul de la veille de la date d'arrivee
				 */
				$date = DateTime::createFromFormat('d/m/Y', $data["bl_date_arrivee"]);
				$date->sub(new DateInterval('P1D'));
				$dataPrec["bl_date_depart"] = $date->format('d/m/Y');
				parent::ecrire($dataPrec);
			}
		}
		return $id;
	}
	/**
	 * Retourne le bassin precedemment utilise
	 *
	 * @param int $lot_id        	
	 * @param string $bl_date_arrivee        	
	 * @return array|NULL
	 */
	function getPrecedentBassin($lot_id, $bl_date_arrivee)
	{
		if ($lot_id > 0 && is_numeric($lot_id) && strlen($bl_date_arrivee) > 0) {
			$bl_date_arrivee = $this->formatDateLocaleVersDB($this->encodeData($bl_date_arrivee));
			$sql = "select * from bassin_lot
				where bl_date_arrivee < '" . $bl_date_arrivee . "' 
						and lot_id = " . $lot_id . "
				order by bl_date_arrivee desc
				limit 1";
			return $this->lireParam($sql);
		} else
			return null;
	}

	/**
	 * Retourne le bassin occupe a la date fournie par le lot considere
	 *
	 * @param int $lot_id        	
	 * @param string $date        	
	 * @return array|NULL
	 */
	function getBassin($lot_id, $date)
	{
		if ($lot_id > 0 && is_numeric($lot_id) && strlen($date) > 0) {
			$this->encodeData($date);
			$date = $this->formatDateLocaleVersDB($date);
			$sql = "select bassin_id, lot_id, bl_date_arrivee, bl_date_depart,
					bassin_nom
					from bassin_lot
					join bassin using (bassin_id)
					where bl_date_arrivee < '" . $date . "' 
						and lot_id = " . $lot_id . "
					order by bl_date_arrivee desc
					limit 1";
			return $this->lireParam($sql);
		} else
			return null;
	}
}
