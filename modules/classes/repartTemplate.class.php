<?php
class RepartTemplate extends ObjetBDD
{
	/**
	 * Constructeur de la classe
	 *
	 * @param PDO $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = array())
	{
		$this->table = "repart_template";
		$this->colonnes = array(
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
		parent::__construct($bdd, $param);
	}
	/**
	 * Recherche des modèles selon les parametres fournis
	 *
	 * @param array $param        	
	 * @return array
	 */
	function getListSearch($param)
	{
		$param = $this->encodeData($param);
		$sql = "select * from " . $this->table . "
				left outer join categorie using (categorie_id)";
		$order = " order by repart_template_date desc";
		$and = "";
		$where = "";
		if ($param["categorie_id"] > 0) {
			$where .= $and . $this->table . ".categorie_id = " . $param["categorie_id"];
			$and = " and ";
		}
		if ($param["actif"] > -1) {
			$where .= $and . " actif = " . $param["actif"];
			$and = " and ";
		}
		if ($and == " and ")
			$where = " where " . $where;
		return ($this->getListeParam($sql . $where . $order));
	}
	/**
	 * Surcharge de la fonction supprimer pour effacer les répartitions d'aliment
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::supprimer()
	 */
	function supprimer($id)
	{
		if ($id > 0 && is_numeric($id)) {
			/*
			 * Verification que le modele n'a pas été utilisé
			 */
			$sql = "select count(*) as nb from distribution where repart_template_id = " . $id;
			$rs = $this->getListeParam($sql);
			if ($rs[0]["nb"] == 0) {
				/*
				 * Suppression des répartitions d'aliments attachées
				 */
				$repartAliment = new RepartAliment($this->connection, $this->paramori);
				$repartAliment->deleteFromField($id, "repart_template_id");
				return parent::supprimer($id);
			} else
				return -1;
		} else
			return -1;
	}
	/**
	 * Retourne les modèles actifs pour la catégorie considérée
	 *
	 * @param int $categorie_id        	
	 * @return array
	 */
	function getListActifFromCategorie($categorie_id)
	{
		if ($categorie_id > 0 && is_numeric($categorie_id)) {
			$sql = "select * from " . $this->table . "
					where actif = 1 
					and categorie_id = " . $categorie_id . "
					order by repart_template_libelle";
			return $this->getListeParam($sql);
		}
	}
}