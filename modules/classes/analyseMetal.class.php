<?php

/**
 * ORM de gestion de la table analyse_metal
 *
 * @author quinton
 *        
 */
class AnalyseMetal extends ObjetBDD
{
	/**
	 * Constructeur de la classe
	 *
	 * @param PDO $bdd        	
	 * @param array $param        	
	 */
	function __construct($bdd, $param = array())
	{
		$this->table = "analyse_metal";
		$this->colonnes = array(
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
		parent::__construct($bdd, $param);
	}
	/**
	 * Retourne la liste des analyses de metaux realisees pour une analyse
	 *
	 * @param int $analyse_id        	
	 * @return tableau|NULL
	 */
	function getListeFromAnalyse($analyse_id)
	{
		if ($analyse_id > 0 && is_numeric($analyse_id)) {
			$sql = "select analyse_metal_id, analyse_eau_id, metal_id, 
					mesure, mesure_seuil, metal_nom, metal_unite
					from analyse_metal
					join metal using (metal_id)
					where analyse_eau_id = " . $analyse_id . "
					order by metal_nom
					";
			return $this->getListeParam($sql);
		} else
			return null;
	}
	function getAnalyseToText($analyse_id)
	{
		$data = $this->getListeFromAnalyse($analyse_id);
		$texte = "";
		$comma = false;
		foreach ($data as $key => $value) {
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
	function ecrireGlobal($data, $analyse_eau_id)
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