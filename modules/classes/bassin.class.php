<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 3 mars 2014
 */
/**
 * ORM de gestion de la table bassin
 *
 * @author quinton
 *        
 */
class Bassin extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "bassin";
		$this->id_auto = "1";
		$this->colonnes = array (
				"bassin_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"bassin_zone_id" => array (
						"type" => 1 
				),
				"bassin_type_id" => array (
						"type" => 1 
				),
				"circuit_eau_id" => array (
						"type" => 1 
				),
				"bassin_usage_id" => array (
						"type" => 1 
				),
				"bassin_nom" => array (
						"type" => 0 
				),
				"bassin_description" => array (
						"type" => 0 
				),
				"longueur" => array (
						"type" => 1 
				),
				"largeur_diametre" => array (
						"type" => 1 
				),
				"surface" => array (
						"type" => 1 
				),
				"hauteur_eau" => array (
						"type" => 1 
				),
				"volume" => array (
						"type" => 1 
				),
				"actif" => array (
						"type" => 1,
						"defaultValue" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Fonction de recherche des bassins selon les criteres definis
	 * 
	 * @param unknown $dataSearch        	
	 */
	function getListeSearch($dataSearch) {
		if (is_array ( $dataSearch )) {
			$sql = "select bassin_id, bassin_nom, bassin_description, actif,
					bassin_type_libelle, bassin_usage_libelle, bassin_zone_libelle, circuit_eau_libelle,
					longueur, largeur_diametre, surface, hauteur_eau, volume
					from bassin
					left outer join bassin_type using (bassin_type_id)
					left outer join bassin_usage using (bassin_usage_id)
					left outer join bassin_zone using (bassin_zone_id)
					left outer join circuit_eau using (circuit_eau_id)
					";
			/*
			 * Preparation de la clause order
			 */
			$order = " order by bassin_nom ";
			/*
			 * Preparation de la clause where
			 */
			$where = " where ";
			$and = "";
			if ($dataSearch ["bassin_type"] > 0) {
				$where .= $and . " bassin_type_id = " . $dataSearch ["bassin_type"];
				$and = " and ";
			}
			if ($dataSearch ["bassin_usage"] > 0) {
				$where .= $and . " bassin_usage_id = " . $dataSearch ["bassin_usage"];
				$and = " and ";
			}
			if ($dataSearch ["bassin_zone"] > 0) {
				$where .= $and . " bassin_zone_id = " . $dataSearch ["bassin_zone"];
				$and = " and ";
			}
			if ($dataSearch ["circuit_eau"] > 0) {
				$where .= $and . " circuit_eau_id = " . $dataSearch ["circuit_eau"];
				$and = " and ";
			}
			if ($dataSearch ["bassin_actif"] != "") {
				$where .= $and . " actif = " . $dataSearch ["bassin_actif"];
				$and = " and ";
			}
			if (strlen ( $where ) == 7)
				$where = "";
			return $this->getListeParam ( $sql . $where . $order );
		}
	}
	/**
	 * Retourne les informations generales d'un bassin (cartouche)
	 * 
	 * @param int $bassinId        	
	 * @return array
	 */
	function getDetail($bassinId) {
		if ($bassinId > 0) {
			$sql = "select bassin_id, bassin_nom, bassin_description, actif,
					bassin_type_libelle, bassin_usage_libelle, bassin_zone_libelle, circuit_eau_libelle
					from bassin
					left outer join bassin_type using (bassin_type_id)
					left outer join bassin_usage using (bassin_usage_id)
					left outer join bassin_zone using (bassin_zone_id)
					left outer join circuit_eau using (circuit_eau_id)
					where bassin_id = " . $bassinId;
			return $this->lireParam ( $sql );
		}
	}
}
/**
 * ORM de gestion de la table bassin_type
 * 
 * @author quinton
 *        
 */
class Bassin_type extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "bassin_type";
		$this->id_auto = "1";
		$this->colonnes = array (
				"bassin_type_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"bassin_type_libelle" => array (
						"type" => 0,
						"requis" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Reecriture de la fonction d'affichage de la liste
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::getListe()
	 */
	function getListe() {
		$sql = "select * from " . $this->table . " order by bassin_type_libelle";
		return $this->getListeParam ( $sql );
	}
}
/**
 * ORM de gestion de la table bassin_usage
 * 
 * @author quinton
 *        
 */
class Bassin_usage extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "bassin_usage";
		$this->id_auto = "1";
		$this->colonnes = array (
				"bassin_usage_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"bassin_usage_libelle" => array (
						"type" => 0,
						"requis" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Reecriture de la fonction d'affichage de la liste
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::getListe()
	 */
	function getListe() {
		$sql = "select * from " . $this->table . " order by bassin_usage_libelle";
		return $this->getListeParam ( $sql );
	}
}
/**
 * ORM de gestion de la table bassin_zone
 * 
 * @author quinton
 *        
 */
class Bassin_zone extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "bassin_zone";
		$this->id_auto = "1";
		$this->colonnes = array (
				"bassin_zone_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"bassin_zone_libelle" => array (
						"type" => 0,
						"requis" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Reecriture de la fonction d'affichage de la liste
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::getListe()
	 */
	function getListe() {
		$sql = "select * from " . $this->table . " order by bassin_zone_libelle";
		return $this->getListeParam ( $sql );
	}
}
/**
 * ORM de gestion de la table circuit_eau
 * 
 * @author quinton
 *        
 */
class Circuit_eau extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "circuit_eau";
		$this->id_auto = "1";
		$this->colonnes = array (
				"circuit_eau_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"circuit_eau_libelle" => array (
						"type" => 0,
						"requis" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Reecriture de la fonction d'affichage de la liste
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::getListe()
	 */
	function getListe() {
		$sql = "select * from " . $this->table . " order by circuit_eau_libelle";
		return $this->getListeParam ( $sql );
	}
}
class Bassin_poisson extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "bassin_poisson";
		$this->id_auto = "1";
		$this->colonnes = array (
				"bassin_poisson_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"bassin_id" => array (
						"type" => 1,
						"requis" => 1 
				),
				"poisson_id" => array (
						"type" => 1,
						"requis" => 1 
				),
				"bassin_date_arrivee" => array (
						"type" => 2 
				),
				"bassin_date_depart" => array (
						"type" => 2 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Retourne la liste des poissons presents dans le bassin
	 * @param int $bassin_id
	 * @return array
	 */
	function getListPoissonPresent($bassin_id) {
		if ($bassin_id > 0) {
			$sql = "select bassin_poisson_id, b.bassin_id, b.poisson_id, bassin_date_arrivee, bassin_date_depart, 
				matricule, prenom, sexe_libelle_court
				from bassin_poisson b
				join v_bassin_poisson_last v on (b.poisson_id = v.poisson_id and b.bassin_date_arrivee = v.last_date_arrivee)
				join poisson p on (b.poisson_id = p. poisson_id)
				left outer join sexe using (sexe_id)
				where b.bassin_id = " . $bassin_id . " 				
				order by matricule				
				";
			return $this->getListeParam ( $sql );
		}
	}
}
?>