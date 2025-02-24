<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 *
 * @author quinton
 *        
 */
class Biopsie extends PpciModel
{
	public DocumentSturio $documentSturio;

	public function __construct()
	{

		$this->table = "biopsie";
		$this->fields = array(
			"biopsie_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"poisson_campagne_id" => array(
				"type" => 1,
				"requis" => 1,
				"parentAttrib" => 1
			),
			"biopsie_date" => array(
				"type" => 3,
				"requis" => 1,
				"defaultValue" => "getDateJour"
			),
			"diam_moyen" => array(
				"type" => 1
			),
			"diametre_ecart_type" => array(
				"type" => 1
			),
			"biopsie_technique_calcul_id" => array(
				"type" => 1,
				"defaultValue" => 1
			),
			"tx_opi" => array(
				"type" => 1
			),
			"tx_coloration_normal" => array(
				"type" => 1
			),
			"ringer_t50" => array(
				"type" => 0
			),
			"ringer_tx_max" => array(
				"type" => 1
			),
			"ringer_duree" => array(
				"type" => 0
			),
			"ringer_commentaire" => array(
				"type" => 0
			),
			"tx_eclatement" => array(
				"type" => 1
			),
			"leibovitz_t50" => array(
				"type" => 0
			),
			"leibovitz_tx_max" => array(
				"type" => 1
			),
			"leibovitz_duree" => array(
				"type" => 0
			),
			"leibovitz_commentaire" => array(
				"type" => 0
			),
			"biopsie_commentaire" => array(
				"type" => 0
			)
		);
		parent::__construct();
	}

	/**
	 * Retourne la liste des biopsies pour un poisson, pour une campagne
	 * 
	 * @param int $poisson_campagne_id        	
	 * @return array
	 */
	function getListeFromPoissonCampagne(int $poisson_campagne_id)
	{
		$sql = "select * from biopsie 
					left outer join biopsie_technique_calcul using (biopsie_technique_calcul_id)
					where poisson_campagne_id = :id:
					order by biopsie_date";
		return $this->getListeParamAsPrepared($sql, array("id" => $poisson_campagne_id));
	}

	/**
	 * Retourne le poisson_id correspondant a la biopsie
	 * @param int $id
	 * @return array
	 */
	function getPoissonId($id)
	{
		$sql = "select poisson_id from biopsie
					 join poisson_campagne using (poisson_campagne_id)
					where biopsie_id = :id:";
		$data = $this->lireParamAsPrepared($sql, array("id" => $id));
		return $data["poisson_id"];
	}

	function supprimer($id)
	{
		/**
		 * Search for the associated documents
		 */
		if (!isset($this->documentSturio)) {
			$this->documentSturio = new DocumentSturio;
		}
		$sql = "select document_id from biopsie_document
				where biopsie_id = :id:";
		$docs = $this->getListeParamAsPrepared($sql, array("id" => $id));
		foreach ($docs as $doc) {
			$this->documentSturio->supprimer($doc["document_id"]);
		}
		return parent::supprimer($id);
	}
}
