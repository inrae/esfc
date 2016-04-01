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
	private $sql = "select d1.*, dt1.devenir_type_libelle, sl1.localisation,
			c.categorie_libelle, lot_nom,
			d2.devenir_date as devenir_date_parent, dt2.devenir_type_libelle as devenir_type_libelle_parent,
			c2.categorie_libelle as categorie_libelle_parent,
			sl2.localisation as localisation_parent, d2.poisson_nombre as poisson_nombre_parent
			from devenir d1
			join devenir_type dt1 on (d1.devenir_type_id = dt1.devenir_type_id)
			join categorie c on (c.categorie_id = d1.categorie_id) 
			left outer join sortie_lieu sl1 on  (sl1.sortie_lieu_id = d1.sortie_lieu_id)
			left outer join lot on (lot.lot_id = d1.lot_id)
			left outer join devenir d2 on (d2.devenir_id = d1.parent_devenir_id)
			left outer join devenir_type dt2 on (d2.devenir_type_id = dt2.devenir_type_id)
			left outer join categorie c2 on (c2.categorie_id = d2.categorie_id)
			left outer join sortie_lieu sl2 on (sl2.sortie_lieu_id = d2.sortie_lieu_id)
			";
	private $sqlOrder = " order by lot_nom, d1.devenir_date";
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
				"poisson_nombre"=>array("type"=>1),
				"parent_devenir_id"=>array("type"=>1)
				
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
			$where = " where extract(year from d1.devenir_date) = ".$annee;
		}
		$this->types["devenir_date_parent"] = 2;
		return $this->getListeParam($this->sql.$where.$this->sqlOrder);
	}
	/**
	 * Retourne la liste des devenirs pour un lot considere
	 * @param int $lotId
	 * @return tableau
	 */
	function getListFromLot($lotId) {
		if ($lotId > 0 && is_numeric($lotId)) {
			$where = " where d1.lot_id = ".$lotId;
			$this->types["devenir_date_parent"] = 2;
			return $this->getListeParam($this->sql.$where.$this->sqlOrder);
		}
	}

	/**
	 * Retourne la liste des devenirs potentiels pour un devenir considere
	 * @param int $id : devenir_id fils
	 * @param number $lotId : numero du lot
	 * @param number $annee : annee de reproduction
	 * @return tableau
	 */
	function getParentsPotentiels($id, $lotId = 0, $annee = 0) {
		if (is_numeric ($id) && is_numeric($lotId) && is_numeric ($annee)) {
			$where = " where d1.devenir_id <> ".$id;
			if ($lotId > 0)
				$where .= " and d1.lot_id = ".$lotId;
			if ($annee > 0)
				$where = " and extract(year from d1.devenir_date) = ".$annee;
			$this->types["devenir_date_parent"] = 2;
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