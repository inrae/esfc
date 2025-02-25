<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 *
 * @author quinton
 *        
 */

class DosageSanguin extends PpciModel
{
	public PoissonCampagne $poissonCampagne;
	private $sql = "SELECT dosage_sanguin_id, poisson_campagne_id, dosage_sanguin_date, 
					tx_e2, tx_e2_texte, tx_calcium, tx_hematocrite,
					dosage_sanguin_commentaire,
					ds.poisson_id, evenement_id,
					evenement_type_libelle
					from dosage_sanguin ds
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)";
	public function __construct()
	{
		$this->table = "dosage_sanguin";
		$this->fields = array(
			"dosage_sanguin_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"poisson_campagne_id" => array(
				"type" => 1,
				"requis" => 0,
				"parentAttrib" => 1
			),
			"dosage_sanguin_date" => array(
				"type" => 2,
				"requis" => 1,
				"defaultValue" => "getDateJour"
			),
			"tx_e2" => array(
				"type" => 1
			),
			"tx_e2_texte" => array(
				"type" => 0
			),
			"tx_calcium" => array(
				"type" => 1
			),
			"tx_hematocrite" => array(
				"type" => 1
			),
			"dosage_sanguin_commentaire" => array(
				"type" => 0
			),
			"poisson_id" => array("type" => 1),
			"evenement_id" => array("type" => 1)
		);
		parent::__construct();
	}
	/**
	 * Surcharge de la fonction ecrire pour rajouter le numero du poisson
	 * @see ObjetBDD::write()
	 */
	function write($data): int
	{
		if ($data["poisson_campagne_id"] > 0) {
			/*
			 * Recherche du numero du poisson
			 */
			if (!isset($this->poissonCampagne)) {
				$this->poissonCampagne = new PoissonCampagne;
			}
			$dataPoisson = $this->poissonCampagne->lire($data["poisson_campagne_id"]);
			$data["poisson_id"] = $dataPoisson["poisson_id"];
		}
		return parent::write($data);
	}

	/**
	 * Retourne le prelevement sanguin correspondant a l'evenement considere
	 * @param int $id
	 * @return array
	 */
	function getdataByEvenement(int $id)
	{
		$sql = "SELECT * from dosage_sanguin where evenement_id = :id:";
		return $this->lireParamAsPrepared($sql, array("id" => $id));
	}

	/**
	 * Retourne l'ensemble des bilans sanguins pour un poisson, pour une campagne donnee
	 * 
	 * @param int $poissonCampagneId        	
	 * @return array
	 */
	function getListeFromPoissonCampagne($poissonCampagneId)
	{
		$where = " where poisson_campagne_id = :id:
						order by dosage_sanguin_date";
		return $this->getListeParamAsPrepared($this->sql . $where, array("id" => $poissonCampagneId));
	}
	/**
	 * Retourne la liste des dosages sanguins pour un poisson
	 * @param int $poisson_id
	 * @return array
	 */
	function getListeFromPoisson(int $poisson_id)
	{
		$where = " where ds.poisson_id = :id:
					order by dosage_sanguin_date desc";
		return $this->getListeParamAsPrepared($this->sql . $where, array("id" => $poisson_id));
	}
}
