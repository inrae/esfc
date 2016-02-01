<?php
/**
 * @author : quinton
 * @date : 1 févr. 2016
 * @encoding : UTF-8
 * (c) 2016 - All rights reserved
 */

/**
 * ORM de gestion de la table devenir
 * @author quinton
 *
 */
class Devenir extends ObjetBDD {
	private $sql = "select devenir.*, devenir_type_libelle, localisation,
			categorie_libelle, lot_nom
			from devenir
			natural join devenir_type
			natural join categorie
			left outer join sortie_lieu using (sortie_lieu_id)
			left outer join lot using (lot_id)
			";
	private $sqlOrder = " order by lot_nom, devenir_date";
	/**
	 * Constructeur
	 * @param PDO $bdd
	 * @param ARRAY $param
	 */
	function __construct($bdd,$param=null) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table="devenir";
		$this->id_auto="1";
		$this->colonnes=array(
				"devenir_id"=>array("type"=>1,"key"=>1, "requis"=>1, "defaultValue"=>0),
				"devenir_type_id"=>array("type"=>1, "requis"=>1),
				"lot_id"=>array("type"=>1, "parentAttrib"=>1),
				"sortie_lieu_id"=>array("type"=>1),
				"categorie_id"=>array("type"=>1, "requis"=>1),
				"devenir_date"=>array("type"=>2, "requis"=>1),
				"poisson_nombre"=>array("type"=>1)
		);
		if(!is_array($param)) $param==array();
		$param["fullDescription"]=1;
		parent::__construct($bdd,$param);
	}
	/**
	 * Retourne la liste des lachers realises
	 * @param number $annee
	 * @return tableau
	 */
	function getListeFull ($annee=0) {
		$where = "";
		if ($annee > 0 && is_numeric($annee)) {
			$where = " where extract(year from devenir_date) = ".$annee;
		}
		return $this->getListeParam($this->sql.$where.$this->sqlOrder);
	}
	/**
	 * Retourne la liste des devenirs pour un lot considere
	 * @param int $lotId
	 * @return tableau
	 */
	function getListFromLot($lotId) {
		if ($lotId > 0 && is_numeric($lotId)) {
			$where = " where lot_id = ".$lotId;
			return $this->getListeParam($this->sql.$where.$this->sqlOrder);
		}
	}
}

/**
 * ORM de gestion de la table devenir_type
 * @author quinton
 *
 */
class DevenirType extends ObjetBDD {
	function __construct($bdd,$param=null) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table="devenir_type";
		$this->id_auto="0";
		$this->colonnes=array(
				"devenir_type_id"=>array("type"=>1,"key"=>1, "requis"=>1, "defaultValue"=>0),
				"devenir_type_libelle"=>array("requis"=>1)
				);
		if(!is_array($param)) $param==array();
		$param["fullDescription"]=1;
		parent::__construct($bdd,$param);
	}
}

?>