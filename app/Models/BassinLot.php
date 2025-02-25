<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table bassin_lot
 *
 * @author quinton
 *        
 */
class BassinLot extends PpciModel
{
	/**
	 * Constructeur de la classe
	 *
	 *         	
	 */
	function __construct()
	{
		$this->table = "bassin_lot";
		$this->fields = array(
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
		parent::__construct();
	}

	/**
	 * Retourne la liste des bassins utilisés pour un lot
	 *
	 * @param int $lot_id        	
	 * @return array
	 */
	function getListeFromLot(int $lot_id)
	{
		$sql = "SELECT bassin_lot_id, lot_id, bassin_id, 
					bl_date_arrivee, bl_date_depart,
					bassin_nom
					from bassin_lot
					join bassin using (bassin_id)
					where lot_id = :id:
					order by bl_date_arrivee desc";
		return $this->getListeParamAsPrepared($sql, array("id" => $lot_id));
	}

	/**
	 * Surcharge de la fonction ecrire pour mettre a jour la date de fin pour
	 * le bassin precedent
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::ecrire()
	 */
	function write($data): int
	{
		$data["bassin_lot_id"] == 0 ? $creation = true : $creation = false;
		$id = parent::write($data);
		if ($id > 0 && $creation == true) {
			/*
			 * Ecrit la date d'arrivee dans le bassin comme date de depart du bassin precedent
			 */
			$dataPrec = $this->getPrecedentBassin($data["lot_id"], $data["bl_date_arrivee"]);
			if ($dataPrec["bassin_lot_id"] > 0 && strlen($dataPrec["bl_date_depart"]) == 0) {
				/*
				 * Calcul de la veille de la date d'arrivee
				 */
				$date = \DateTime::createFromFormat('d/m/Y', $data["bl_date_arrivee"]);
				$date->sub(new \DateInterval('P1D'));
				$dataPrec["bl_date_depart"] = $date->format('d/m/Y');
				parent::write($dataPrec);
			}
		}
		return $id;
	}
	/**
	 * Retourne le bassin precedemment utilise
	 *
	 * @param int $lot_id        	
	 * @param string $bl_date_arrivee        	
	 * @return array
	 */
	function getPrecedentBassin(int $lot_id, $bl_date_arrivee)
	{
		if ($lot_id > 0 && strlen($bl_date_arrivee) > 0) {
			$bl_date_arrivee = $this->formatDateLocaleVersDB($bl_date_arrivee);
			$sql = "SELECT * from bassin_lot
				where bl_date_arrivee < :date_arrivee:
						and lot_id = :lot_id:
				order by bl_date_arrivee desc
				limit 1";
			return $this->lireParamAsPrepared($sql, array(
				"date_arrivee" => $bl_date_arrivee,
				"lot_id" => $lot_id
			));
		} else {
			return array();
		}
	}

	/**
	 * Retourne le bassin occupe a la date fournie par le lot considere
	 *
	 * @param int $lot_id        	
	 * @param string $date        	
	 * @return array|
	 */
	function getBassin(int $lot_id, $date)
	{
		if ($lot_id > 0  && strlen($date) > 0) {
			$date = $this->formatDateLocaleVersDB($date);
			$sql = "SELECT bassin_id, lot_id, bl_date_arrivee, bl_date_depart,
					bassin_nom
					from bassin_lot
					join bassin using (bassin_id)
					where bl_date_arrivee <= :date_arrivee:
						and lot_id = :lot_id:
					order by bl_date_arrivee desc
					limit 1";
			$param =  array(
				"date_arrivee" => $date,
				"lot_id" => $lot_id
			);
			return $this->lireParamAsPrepared($sql, $param);
		} else {
			return array();
		}
	}
}
