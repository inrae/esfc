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
		$this->paramori = $param;
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
					bassin_type_libelle, bassin_usage_libelle, bassin_zone_libelle, 
					bassin.circuit_eau_id, circuit_eau_libelle,
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
					bassin_type_libelle, bassin_usage_libelle, bassin_zone_libelle, 
					bassin.circuit_eau_id, circuit_eau_libelle
					from bassin
					left outer join bassin_type using (bassin_type_id)
					left outer join bassin_usage using (bassin_usage_id)
					left outer join bassin_zone using (bassin_zone_id)
					left outer join circuit_eau using (circuit_eau_id)
					where bassin_id = " . $bassinId;
			return $this->lireParam ( $sql );
		}
	}
	/**
	 * Retourne la liste des bassins, actifs ou non, ou tous
	 *
	 * @param
	 *        	int actif
	 * @return array (non-PHPdoc)
	 * @see ObjetBDD::getListe()
	 */
	function getListe($actif = -1) {
		$sql = "select * from bassin ";
		if ($actif > - 1)
			$sql .= " where actif = " . $actif;
		$sql .= " order by bassin_nom";
		return ($this->getListeParam ( $sql ));
	}
	/**
	 * Retourne la liste des bassins associes a un circuit d'eau
	 * @param int $circuitId
	 * @return array
	 */
	function getListeByCircuitEau($circuitId) {
		if ($circuitId > 0) {
			$sql = "select bassin_id, bassin_nom from bassin where circuit_eau_id = " . $circuitId . "
				order by bassin_nom";
			return $this->getListeParam ( $sql );
		}
	}
	/**
	 * Calcule la masse des poissons présents dans un bassin
	 * @param unknown $bassinId
	 * @return unknown
	 */
	function calculMasse($bassinId) {
		if ($bassinId > 0){
			/*
			 * Recuperation de la liste des poissons
			 */
			$transfert = new Transfert($this->connection, $this->paramori);
			$morphologie = new Morphologie($this->connection, $this->paramori);
			$listePoisson = $transfert->getListPoissonPresentByBassin($bassinId);
			$masse = 0;
			foreach ($listePoisson as $key=>$value) {
				$data = $morphologie->getMasseLast($value["poisson_id"]);
				$masse += $data["masse"];
			}
			return ($masse);
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
				),
				"categorie_id" => array(
						"type" => 1
				)
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Réécriture de la liste pour prendre en compte la table categorie
	 * (non-PHPdoc)
	 * @see ObjetBDD::getListe()
	 */
	function getListe($order = 0){
		$sql = "select * from ".$this->table."
				left outer join categorie using (categorie_id)";
		if ($order > 0) $sql .= " order by ".$order;
		return $this->getListeParam($sql);
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
				),
				"circuit_eau_actif" => array (
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
	 * Retourne la liste des circuits d'eau en fonction des parametres de recherche
	 *
	 * @param array $data        	
	 * @return array
	 */
	function getListeSearch($data) {
		$sql = 'select * from ' . $this->table;
		$order = ' order by circuit_eau_libelle';
		$where = '';
		$and = '';
		if (strlen ( $data ["circuit_eau_libelle"] ) > 0) {
			$where .= $and . " upper(circuit_eau_libelle) like upper('%" . $data ["circuit_eau_libelle"] . "%') ";
			$and = " and ";
		}
		if ($data ["circuit_eau_actif"] > - 1) {
			$where .= $and . " circuit_eau_actif = " . $data ["circuit_eau_actif"];
			$and = " and ";
		}
		if ($and == " and ")
			$where = " where " . $where;
		return $this->getListeParam ( $sql . $where . $order );
	}
}
/**
 * ORM de gestion de la table analyse_eau
 *
 * @author quinton
 *        
 */
class AnalyseEau extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "analyse_eau";
		$this->id_auto = "1";
		$this->colonnes = array (
				"analyse_eau_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"circuit_eau_id" => array (
						"type" => 0,
						"requis" => 1,
						"parentAttrib" => 1 
				),
				"laboratoire_analyse_id" => array(
						"type" => 1
				),
				"analyse_eau_date" => array (
						"type" => 2 
				),
				"temperature" => array (
						"type" => 1 
				),
				"oxygene" => array (
						"type" => 1 
				),
				"salinite" => array (
						"type" => 1 
				),
				"ph" => array (
						"type" => 1 
				),
				"nh4" => array (
						"type" => 1 
				),
				"nh4_seuil" => array (
						"type" => 0 
				),
				"n_nh4" => array (
						"type" => 1 
				),
				"no2" => array (
						"type" => 1 
				),
				"no2_seuil" => array (
						"type" => 0 
				),
				"n_no2" => array (
						"type" => 1 
				),
				"no3" => array (
						"type" => 1 
				),
				"no3_seuil" => array (
						"type" => 0 
				),
				"n_no3" => array (
						"type" => 1 
				),
				"backwash_mecanique" => array (
						"type" => 1,
						"defaultValue" => 0
				),
				"backwash_biologique" => array (
						"type" => 1,
						"defaultValue" => 0 
				),
				"backwash_biologique_commentaire" => array(
						"type" => 0
				),
				"debit_eau_riviere" => array (
						"type" => 1 
				),
				"debit_eau_forage" => array (
						"type" => 1 
				),
				"observations" => array (
						"type" => 0 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Retourne les analyses d'eau pour un circuit d'eau, avec les criteres limitatifs fournis
	 *
	 * @param ind $id        	
	 * @param string $dateRef        	
	 * @param number $limit        	
	 * @param number $offset        	
	 * @return array
	 */
	function getDetailByCircuitEau($id, $dateRef = NULL, $limit = 1, $offset = 0) {
		if ($id > 0) {
			$sql = "select * from " . $this->table . " 
					natural join circuit_eau
					left outer join laboratoire_analyse using (laboratoire_analyse_id)";
			if (is_null ( $dateRef ))
				$dateRef = date ( "d/m/Y" );
			$dateRef = $this->formatDateLocaleVersDB ( $dateRef, 2 );
			$where = " where analyse_eau_date <= '" . $dateRef . "' and circuit_eau.circuit_eau_id = " . $id;
			$order = " order by analyse_eau_date desc LIMIT " . $limit . " OFFSET " . $offset;
			if ($limit == 1) {
				return ($this->lireParam ( $sql . $where . $order ));
			} else {
				return ($this->getListeParam ( $sql . $where . $order ));
			}
		}
	}
}
/**
 * ORM de gestion de la table laboratoire_analyse
 * @author quinton
 *
 */
class LaboratoireAnalyse extends ObjetBDD {
	/**
	 * Constructeur de la classe 
	 * @param AdoDB $bdd
	 * @param array $param
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "laboratoire_analyse";
		$this->id_auto = "1";
		$this->colonnes = array (
				"laboratoire_analyse_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0
				),
				"laboratoire_analyse_libelle" => array (
						"type" => 0,
						"requis" => 1
				),
				"laboratoire_analyse_actif" => array (
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
	 * Retourne la liste des laboratoires produisant des analyses
	 */
	function getListeActif() {
		$sql = "select * from ".$this->table."
				where laboratoire_analyse_actif = 1
				order by laboratoire_analyse_libelle";
		return $this->getListeParam($sql);
	}
}
/**
 * ORM de gestion de la table bassin_evenement_type
 * @author quinton
 *
 */
class BassinEvenementType extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 * @param AdoDB $bdd
	 * @param array $param
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "bassin_evenement_type";
		$this->id_auto = "1";
		$this->colonnes = array (
				"bassin_evenement_type_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0
				),
				"bassin_evenement_type_libelle" => array (
						"type" => 0,
						"requis" => 1
				)
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
}
/**
 * ORM de gestion de la table bassin_evenement
 * @author quinton
 *
 */
class BassinEvenement extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 * @param AdoDB $bdd
	 * @param array $param
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "bassin_evenement";
		$this->id_auto = "1";
		$this->colonnes = array (
				"bassin_evenement_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0
				),
				"bassin_id" => array(
						"type"=>1,
						"requis" =>1,
						"parentAttrib" => 1
				),
				"bassin_evenement_type_id" => array (
						"type" => 1,
						"requis" => 1
				),
				"bassin_evenement_date" => array(
						"type" => 2,
						"defaultValue" => "getDateJour"
				),
				"bassin_evenement_commentaire" => array (
						"type" => 0
				)
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Retourne la liste des événements pour un bassin
	 * @param int $bassin_id
	 * @return array
	 */
	function getListeByBassin($bassin_id) {
		if ($bassin_id > 0) {
			$sql = "select * from bassin_evenement
					natural join bassin_evenement_type
					where bassin_id = ".$bassin_id."
					order by bassin_evenement_date desc";
			return $this->getListeParam($sql);
		}
	}
}
?>