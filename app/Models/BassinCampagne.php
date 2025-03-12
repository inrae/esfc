<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 10 mars 2015
 */

/**
 * ORM de gestion de la table bassin_campagne
 *
 * @author quinton
 *        
 */
class BassinCampagne extends PpciModel
{
	public function __construct()
	{

		$this->table = "bassin_campagne";
		$this->fields = array(
			"bassin_campagne_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"bassin_id" => array(
				"type" => 1,
				"requis" => 1,
				"parentAttrib" => 1
			),
			"annee" => array(
				"type" => 1,
				"requis" => 1,
				"defaultValue" => "getYear"
			),
			"bassin_utilisation" => array(
				"type" => 0
			)
		);
		parent::__construct();
	}

	/**
	 * Genere les enregistrements pour les bassins, pour la campagne consideree
	 *
	 * @param int $annee        	
	 */
	function initCampagne($annee)
	{
		$nb = 0;
		/**
		 * Recherche des bassins de reproduction
		 */
		$sql = "SELECT bassin_id from bassin 
					where bassin_usage_id = :usage:
					and actif = 1
					and bassin_id not in (
					SELECT distinct c.bassin_id from bassin_campagne c where annee = :annee: )";
		$liste = $this->getListeParamAsPrepared(
			$sql,
			array("annee" => $annee, "usage" => $_SESSION["dbparams"]["code_usage_bassin_pour_reproduction"])
		);
		$data = [];
		foreach ($liste as $value) {
			$data["bassin_id"] = $value["bassin_id"];
			$data["annee"] = $annee;
			if ($this->ecrire($data) > 0)
				$nb++;
		}
		return $nb;
	}
	/**
	 * Retourne la liste des bassins utilisés pour l'année considérée
	 *
	 * @param int $annee        	
	 * @return array
	 */
	function getListFromAnnee($annee, $site_id = 0)
	{
		$sql = "SELECT bassin_id, bassin_campagne_id, annee, bassin_nom, bassin_utilisation,
					site_id, site_name
					from bassin_campagne
					join bassin using (bassin_id)
					left outer join site using (site_id)
					where annee = :annee:";
		$param = array("annee" => $annee);
		if ($site_id > 0) {
			$sql .= " and site_id = :site_id:";
			$param["site_id"] = $site_id;
		}
		$sql .= " order by bassin_nom";
		return $this->getListeParamAsPrepared($sql, $param);
	}
}
