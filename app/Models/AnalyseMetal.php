<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table analyse_metal
 *
 * @author quinton
 *        
 */
class AnalyseMetal extends PpciModel
{
	/**
	 * Constructeur de la classe
	 *
	 *         	
	 */
	function __construct()
	{
		$this->table = "analyse_metal";
		$this->fields = array(
			"analyse_metal_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"analyse_eau_id" => array(
				"type" => 1,
				"requis" => 1,
				"parentAttrib" => 1
			),

			"metal_id" => array(
				"type" => 1,
				"requis" => 1
			),
			"mesure" => array(
				"type" => 1
			),
			"mesure_seuil" => array(
				"type" => 0
			)
		);
		parent::__construct();
	}
	/**
	 * Retourne la liste des analyses de metaux realisees pour une analyse
	 *
	 * @param int $analyse_id        	
	 * @return array
	 */
	function getListeFromAnalyse(int $analyse_id): ?array
	{
		if ($analyse_id > 0) {
			$sql = "select analyse_metal_id, analyse_eau_id, metal_id, 
					mesure, mesure_seuil, metal_nom, metal_unite
					from analyse_metal
					join metal using (metal_id)
					where analyse_eau_id = :analyse_id:
					order by metal_nom
					";
			return $this->getListeParam($sql, ["analyse_id" => $analyse_id]);
		}
	}
	/**
	 * Transform the result of the analysis in string
	 * @param int $analyse_id
	 * @return string
	 */
	function getAnalyseToText(int $analyse_id): string
	{
		$data = $this->getListeFromAnalyse($analyse_id);
		$texte = "";
		$comma = false;
		foreach ($data as $value) {
			if ($comma == true) {
				$texte .= ", ";
			} else
				$comma = true;
			$texte .= $value["metal_nom"] . ":" . $value["mesure"] . $value["mesure_seuil"] . $value["metal_unite"];
		}
		return $texte;
	}

	/**
	 * Fonction permettant d'ecrire globalement les analyses de metaux, a partir
	 * des variables transmises par le formulaire
	 *
	 * @param array $data
	 *        	: donnees du formulaire. Les donnees interessantes commencent
	 *        	par mesure- et mesure_seuil-
	 * @param int $analyse_eau_id        	
	 */
	function writeGlobal($data, $analyse_eau_id)
	{
		foreach ($data as $key => $value) {
			/*
			 * Recuperation des cles concernant les analyses de metaux
			 */
			if (substr($key, 0, 7) == "mesure-") {
				$cle = explode("-", $key);
				/*
				 * cle[1] contient la valeur d'analyse_metal_id
				 * cle[2] contient la valeur de metal_id
				 */
				$cleSeuil = "mesure_seuil-" . $cle[1] . "-" . $cle[2];
				/*
				 * Recherche s'il faut ou non ecrire l'enregistrement
				 */
				$ecrire = false;
				if ($cle[1] > 0 || strlen($value) > 0) {
					$ecrire = true;
				} else {
					/*
					 * On regarde s'il existe une valeur seuil
					 */
					if (strlen($data[$cleSeuil]) > 0)
						$ecrire = true;
				}
				if ($ecrire == true) {
					$donnee = array(
						""
					);
					if ($cle[1] > 0) {
						$donnee["analyse_metal_id"] = $cle[1];
					} else
						$donnee["analyse_metal_id"] = 0;
					$donnee["analyse_eau_id"] = $analyse_eau_id;
					$donnee["metal_id"] = $cle[2];
					$donnee["mesure"] = $value;
					$donnee["mesure_seuil"] = $data[$cleSeuil];
					$this->ecrire($donnee);
				}
			}
		}
	}
}
