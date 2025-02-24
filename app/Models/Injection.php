<?php 
namespace App\Models;
use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table injection
 * @author quinton
 *
 */
class Injection extends PpciModel {
	function __construct(){
		$this->table = "injection";
		$this->fields = array (
				"injection_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"poisson_campagne_id" => array (
						"type" => 1,
						"requis" => 1,
						"parentAttrib" => 1 
				),
				"sequence_id" => array (
						"type" => 1,
						"requis" => 1 
				),
				"hormone_id" => array("type"=>1),
				"injection_date" => array (
						"type" => 3,
						"requis" => 1,
						"defaultValue" => "getDateHeure" 
				),
				"injection_dose" => array ("type"=>1),
				"injection_commentaire" => array("type"=>0)
		);
		parent::__construct();
	}

	/**
	 * Retourne la liste des injections pour un poisson
	 * @param int $poisson_campagne_id
	 * @return array
	 */
	function getListFromPoissonCampagne(int $poisson_campagne_id) {

			$sql = "select injection_id, poisson_campagne_id, sequence_id, injection_date,
					sequence_nom, injection_dose, injection_commentaire,
					hormone_id, hormone_nom, hormone_unite
					from injection
					join sequence using (sequence_id)
					left outer join hormone using (hormone_id)
					where poisson_campagne_id = :id:
					order by injection_date";
			return $this->getListeParamAsPrepared($sql, array("id"=>$poisson_campagne_id));
	}
}
