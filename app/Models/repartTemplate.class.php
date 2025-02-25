<?php 
namespace App\Models;
use Ppci\Models\PpciModel;
class RepartTemplate extends PpciModel
{
	public RepartAliment $repartAliment;
	/**
	 * Constructeur de la classe
	 *
	         	
	 */
	function __construct()
	{
		$this->table = "repart_template";
		$this->fields = array(
			"repart_template_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"categorie_id" => array(
				"type" => 1,
				"requis" => 1
			),
			"repart_template_libelle" => array(
				"type" => 0
			),
			"repart_template_date" => array(
				"type" => 2,
				"requis" => 1,
				"defaultValue" => "getDateJour"
			),
			"actif" => array(
				"type" => 1,
				"defaultValue" => 1,
				"requis" => 1
			)
		);
		parent::__construct();
	}
	/**
	 * Recherche des modèles selon les parametres fournis
	 *
	 * @param array $param        	
	 * @return array
	 */
	function getListSearch($param)
	{
		$sql = "SELECT * from repart_template
				left outer join categorie using (categorie_id)";
		$asql = array();
		$order = " order by repart_template_date desc";
		$and = "";
		$where = "";
		if ($param["categorie_id"] > 0) {
			$where .= $and . $this->table . ".categorie_id = :categorie_id";
			$and = " and ";
			$asql["categorie_id"] = $param["categorie_id"];
		}
		if ($param["actif"] > -1) {
			$where .= $and . " actif = :actif";
			$and = " and ";
			$asql["actif"] = $param["actif"];
		}
		if ($and == " and ") {
			$where = " where " . $where;
		}
		return $this->getListeParamAsPrepared($sql . $where . $order, $asql);
	}
	/**
	 * Surcharge de la fonction supprimer pour effacer les répartitions d'aliment
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::supprimer()
	 */
	function supprimer(int $id)
	{
		/**
		 * Verification que le modele n'a pas été utilisé
		 */
		$sql = "SELECT count(*) as nb from distribution where repart_template_id = :id:";
		$rs = $this->getListeParamAsPrepared($sql, array("id"=>$id));
		if ($rs[0]["nb"] == 0) {
			/*
			 * Suppression des répartitions d'aliments attachées
			 */
			if (!isset($this->repartAliment)) {
				$this->repartAliment = $this->classInstanciate("RepartAliment", "repartAliment.class.php");
			}
			$this->repartAliment->deleteFromField($id, "repart_template_id");
			return parent::supprimer($id);
		} else {
			return false;
		}
	}
	/**
	 * Retourne les modèles actifs pour la catégorie considérée
	 *
	 * @param int $categorie_id        	
	 * @return array
	 */
	function getListActifFromCategorie($categorie_id)
	{
		$sql = "SELECT * from repart_template
					where actif = 1 
					and categorie_id = :id:
					order by repart_template_libelle";
		return $this->getListeParamAsPrepared($sql, array("id" => $categorie_id));
	}
}
