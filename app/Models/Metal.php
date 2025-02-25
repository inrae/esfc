<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table metal
 *
 * @author quinton
 *        
 */
class Metal extends PpciModel
{
	/**
	 * Constructeur de la classe
	 *
	 *         	
	 */
	function __construct()
	{
		$this->table = "metal";
		$this->fields = array(
			"metal_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),

			"metal_nom" => array(
				"type" => 0,
				"requis" => 1
			),
			"metal_unite" => array(
				"type" => 0
			),
			"metal_actif" => array(
				"type" => 1,
				"defaultValue" => 1
			)
		);
		parent::__construct();
	}

	/**
	 * Retourne la liste des metaux analyses, selon qu'ils sont actifs ou non
	 *
	 * @param number $actif        	
	 * @return array
	 */
	function getListActif($actif = 1)
	{
		$actif = $this->encodeData($actif);
		$sql = "select * from metal";
		$order = " order by metal_nom";
		$param = [];
		$where = "";
		if ($actif == 1 || $actif == 0) {
			$where = " where actif = :actif:";
			$param = ["actif" => $actif];
		}
		return $this->getListeParam($sql . $where . $order, $param);
	}

	/**
	 * Retourne la liste des metaux actifs qui ne figurent pas dans la liste fournie
	 *
	 * @param array $analyse        	
	 * @return array
	 */
	function getListActifInconnu(array $analyse)
	{
		$sql = "select * from metal";
		$order = " order by metal_nom";
		$where = " where metal_actif = 1";
		$param = array();
		if (count($analyse) > 0) {
			$i = 1;
			$where .= " and metal_id not in ( ";

			foreach ($analyse as $value) {
				if ($i > 0) {
					$where .= ",";
				}
				$param["metal" . $i] = $value["metal_id"];
				$where .= "metal" . $i;
			}
			$where .= ")";
		}
		return $this->getListeParamAsPrepared($sql . $where . $order, $param);
	}
}
