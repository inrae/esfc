<?php 
namespace App\Models;
use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table repart_aliment
 *
 * @author quinton
 *        
 */
class RepartAliment extends PpciModel
{
	/**
	 * Constructeur de la classe
	 *
	 *         	
	 */
	function __construct()
	{
		$this->table = "repart_aliment";
		$this->fields = array(
			"repart_aliment_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"repart_template_id" => array(
				"type" => 1,
				"requis" => 1,
				"parentAttrib" => 1
			),
			"aliment_id" => array(
				"type" => 1,
				"requis" => 1
			),
			"consigne" => array(
				"type" => 0
			),
			"repart_alim_taux" => array(
				"type" => 1
			),
			"matin" => array(
				"type" => 1,
				"defaultValue" => 100
			),
			"midi" => array(
				"type" => 1
			),
			"soir" => array(
				"type" => 1
			),
			"nuit" => array(
				"type" => 1
			)
		);
		parent::__construct();
	}
	/**
	 * Retourne les aliments associes a un template
	 *
	 * @param int $templateId        	
	 * @return array
	 */
	function getFromTemplate(int $templateId)
	{

		$sql = "select * from " . $this->table . "
				join aliment using (aliment_id)
				where repart_template_id = :id:
				order by repart_alim_taux desc, aliment_libelle
				";
		return $this->getListeParamAsPrepared($sql, array("id" => $templateId));
	}
	/**
	 * Retourne les aliments associes a un template,
	 * ainsi que les aliments non associes mais du meme type
	 *
	 * @param int $templateId        	
	 * @param int $categorieId        	
	 * @return array
	 */
	function getFromTemplateWithAliment(int $templateId, int $categorieId)
	{
		$data = $this->getFromTemplate($templateId);
		/*
			 * Recuperation des aliments du même type
			 */
		$sql = "SELECT distinct aliment_id, aliment_type_id, aliment_libelle
				from aliment 
					join aliment_categorie using (aliment_id)
				where actif = 1 
					and categorie_id = :categorieId
					and aliment_id not in 
					(select aliment_id from repart_aliment where repart_template_id = :templateId)
					order by aliment_libelle";
		$dataAliment = $this->getListeParamAsPrepared($sql, array(
			"templateId" => $templateId,
			"categorieId" => $categorieId
		));
		/*
				 * Rajout des aliments à la liste
				 */
		foreach ($dataAliment as $value) {
			$value["repart_aliment_id"] = 0;
			$data[] = $value;
		}
		return $data;
	}
}
