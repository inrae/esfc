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
		$dataSearch = $this->encodeData ( $dataSearch );
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
			if ($dataSearch ["bassin_type"] > 0 && is_numeric($dataSearch["bassin_type"])) {
				$where .= $and . " bassin_type_id = " . $dataSearch ["bassin_type"];
				$and = " and ";
			}
			if ($dataSearch ["bassin_usage"] > 0 && is_numeric($dataSearch["bassin_usage"])) {
				$where .= $and . " bassin_usage_id = " . $dataSearch ["bassin_usage"];
				$and = " and ";
			}
			if ($dataSearch ["bassin_zone"] > 0 && is_numeric($dataSearch["bassin_zone"])) {
				$where .= $and . " bassin_zone_id = " . $dataSearch ["bassin_zone"];
				$and = " and ";
			}
			if ($dataSearch ["circuit_eau"] > 0 && is_numeric($dataSearch["circuit_eau"])) {
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
		if ($bassinId > 0 && is_numeric($bassinId)) {
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
	 * rajout le 7/5/15 d'un parametre concernant l'usage
	 *
	 * @param
	 *        	int actif
	 * @return array (non-PHPdoc)
	 * @see ObjetBDD::getListe()
	 */
	function getListe($actif = -1, $usage = 0) {
		$sql = "select * from bassin ";
		$where = " where ";
		$bwhere = false;
		if ($actif > - 1 && is_numeric($actif)) {
			$where .= " actif = " . $actif;
			$bwhere = true;
		}
		if ($usage > 0 && is_numeric($usage)) {
			$bwhere == true ? $where .= " and " : $bwhere = true;
			$where .= " bassin_usage_id = " . $usage;
		}
		if ($bwhere == false)
			$where = "";
		$order = " order by bassin_nom";
		return ($this->getListeParam ( $sql . $where . $order ));
	}
	/**
	 * Retourne la liste des bassins associes a un circuit d'eau
	 *
	 * @param int $circuitId        	
	 * @return array
	 */
	function getListeByCircuitEau($circuitId) {
		if ($circuitId > 0 && is_numeric($circuitId)) {
			$sql = "select bassin_id, bassin_nom from bassin where circuit_eau_id = " . $circuitId . "
				order by bassin_nom";
			return $this->getListeParam ( $sql );
		}
	}
	/**
	 * Calcule la masse des poissons présents dans un bassin
	 *
	 * @param unknown $bassinId        	
	 * @return unknown
	 */
	function calculMasse($bassinId) {
		if ($bassinId > 0 && is_numeric($bassinId)) {
			/*
			 * Recuperation de la liste des poissons
			 */
			$transfert = new Transfert ( $this->connection, $this->paramori );
			$morphologie = new Morphologie ( $this->connection, $this->paramori );
			$listePoisson = $transfert->getListPoissonPresentByBassin ( $bassinId );
			$masse = 0;
			foreach ( $listePoisson as $key => $value ) {
				$data = $morphologie->getMasseLast ( $value ["poisson_id"] );
				$masse += $data ["masse"];
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
				"categorie_id" => array (
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
	 *
	 * @see ObjetBDD::getListe()
	 */
	function getListe($order = 0) {
		$sql = "select * from " . $this->table . "
				left outer join categorie using (categorie_id)";
		if ($order > 0 && is_numeric($order))
			$sql .= " order by " . $order;
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
		$data = $this->encodeData ( $data );
		$sql = 'select * from ' . $this->table;
		$order = ' order by circuit_eau_libelle';
		$where = '';
		$and = '';
		if (strlen ( $data ["circuit_eau_libelle"] ) > 0) {
			$where .= $and . " upper(circuit_eau_libelle) like upper('%" . $data ["circuit_eau_libelle"] . "%') ";
			$and = " and ";
		}
		if ($data ["circuit_eau_actif"] > - 1 && is_numeric($data["circuit_eau_actif"])) {
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
		$this->paramori = $param;
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
				"laboratoire_analyse_id" => array (
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
				"backwash_biologique_commentaire" => array (
						"type" => 0 
				),
				"debit_eau_riviere" => array (
						"type" => 1 
				),
				"debit_eau_forage" => array (
						"type" => 1 
				),
				"debit_eau_mer" => array (
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
		if ($id > 0 && is_numeric($id)) {
			$sql = "select * from " . $this->table . " 
					natural join circuit_eau
					left outer join laboratoire_analyse using (laboratoire_analyse_id)";
			if (is_null ( $dateRef ))
				$dateRef = date ( "d/m/Y" );
			$dateRef = $this->formatDateLocaleVersDB ( $dateRef, 2 );
			$where = " where analyse_eau_date <= '" . $dateRef . "' and circuit_eau.circuit_eau_id = " . $id;
			$order = " order by analyse_eau_date desc LIMIT " . $limit . " OFFSET " . $offset;
			$analyseMetal = new AnalyseMetal ( $this->connection, $this->paramori );
			if ($limit == 1) {
				$data = $this->lireParam ( $sql . $where . $order );
				if ($data ["analyse_eau_id"] > 0 && is_numeric($data["analyse_eau_id"]))
					$data ["metaux"] = $analyseMetal->getAnalyseToText ( $data ["analyse_eau_id"] );
			} else {
				$data = $this->getListeParam ( $sql . $where . $order );
				foreach ( $data as $key => $value ) {
					$data [$key] ["metaux"] = $analyseMetal->getAnalyseToText ( $value ["analyse_eau_id"] );
				}
			}
			return $data;
		}
	}
	
	/**
	 * Surcharge de la fonction supprimer, pour effacer les analyses de metaux lourds
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::supprimer()
	 */
	function supprimer($id) {
		if ($id > 0 && is_numeric($id)) {
			/*
			 * Suppression des analyses des metaux
			 */
			$analyseMetal = new AnalyseMetal ( $this->connection, $this->paramori );
			$analyseMetal->supprimerChamp ( $id, "analyse_eau_id" );
			return parent::supprimer ( $id );
		}
	}
}
/**
 * ORM de gestion de la table laboratoire_analyse
 *
 * @author quinton
 *        
 */
class LaboratoireAnalyse extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
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
		$sql = "select * from " . $this->table . "
				where laboratoire_analyse_actif = 1
				order by laboratoire_analyse_libelle";
		return $this->getListeParam ( $sql );
	}
}
/**
 * ORM de gestion de la table bassin_evenement_type
 *
 * @author quinton
 *        
 */
class BassinEvenementType extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
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
 *
 * @author quinton
 *        
 */
class BassinEvenement extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
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
				"bassin_id" => array (
						"type" => 1,
						"requis" => 1,
						"parentAttrib" => 1 
				),
				"bassin_evenement_type_id" => array (
						"type" => 1,
						"requis" => 1 
				),
				"bassin_evenement_date" => array (
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
	 *
	 * @param int $bassin_id        	
	 * @return array
	 */
	function getListeByBassin($bassin_id) {
		if ($bassin_id > 0 && is_numeric($bassin_id)) {
			$sql = "select * from bassin_evenement
					natural join bassin_evenement_type
					where bassin_id = " . $bassin_id . "
					order by bassin_evenement_date desc";
			return $this->getListeParam ( $sql );
		}
	}
}
/**
 * ORM de gestion de la table metal
 *
 * @author quinton
 *        
 */
class Metal extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
	 * @param AdoDB $bdd        	
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "metal";
		$this->id_auto = "1";
		$this->colonnes = array (
				"metal_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				
				"metal_nom" => array (
						"type" => 0,
						"requis" => 1 
				),
				"metal_unite" => array (
						"type" => 0 
				),
				"metal_actif" => array (
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
	 * Retourne la liste des metaux analyses, selon qu'ils sont actifs ou non
	 *
	 * @param number $actif        	
	 * @return tableau
	 */
	function getListActif($actif = 1) {
		$actif = $this->encodeData ( $actif );
		$sql = "select * from metal";
		$order = " order by metal_nom";
		$where = "";
		if ($actif == 1 || $actif == 0)
			$where = " where actif = " . $actif;
		return $this->getListeParam ( $sql . $where . $order );
	}
	
	/**
	 * Retourne la liste des metaux actifs qui ne figurent pas dans la liste fournie
	 *
	 * @param array $analyse        	
	 * @return tableau
	 */
	function getListActifInconnu($analyse) {
		$sql = "select * from metal";
		$order = " order by metal_nom";
		$where = " where metal_actif = 1";
		if (count ( $analyse ) > 0) {
			$where .= " and metal_id not in ( ";
			$comma = false;
			foreach ( $analyse as $key => $value ) {
				if ($comma == true) {
					$where .= ",";
				} else
					$comma = true;
				$where .= $value ["metal_id"];
			}
			$where .= ")";
		}
		return $this->getListeParam ( $sql . $where . $order );
	}
}

/**
 * ORM de gestion de la table analyse_metal
 *
 * @author quinton
 *        
 */
class AnalyseMetal extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
	 * @param AdoDB $bdd        	
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "analyse_metal";
		$this->id_auto = "1";
		$this->colonnes = array (
				"analyse_metal_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"analyse_eau_id" => array (
						"type" => 1,
						"requis" => 1,
						"parentAttrib" => 1 
				),
				
				"metal_id" => array (
						"type" => 1,
						"requis" => 1 
				),
				"mesure" => array (
						"type" => 1 
				),
				"mesure_seuil" => array (
						"type" => 0 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Retourne la liste des analyses de metaux realisees pour une analyse
	 *
	 * @param int $analyse_id        	
	 * @return tableau|NULL
	 */
	function getListeFromAnalyse($analyse_id) {
		if ($analyse_id > 0 && is_numeric($analyse_id)) {
			$sql = "select analyse_metal_id, analyse_eau_id, metal_id, 
					mesure, mesure_seuil, metal_nom, metal_unite
					from analyse_metal
					join metal using (metal_id)
					where analyse_eau_id = " . $analyse_id . "
					order by metal_nom
					";
			return $this->getListeParam ( $sql );
		} else
			return null;
	}
	function getAnalyseToText($analyse_id) {
		$data = $this->getListeFromAnalyse ( $analyse_id );
		$texte = "";
		$comma = false;
		foreach ( $data as $key => $value ) {
			if ($comma == true) {
				$texte .= ", ";
			} else
				$comma = true;
			$texte .= $value ["metal_nom"] . ":" . $value ["mesure"] . $value ["mesure_seuil"] . $value ["metal_unite"];
		}
		return $texte;
	}
	
	/**
	 * Fonction permettant d'ecrire globalement les analyses de metaux, a partir
	 * des variables transmises par le formulaire
	 *
	 * @param array $data
	 *        	: donnees du formulaire. Les donnees interessantes commencent
	 *        	par mesure- et mesure_seuil-
	 * @param int $analyse_eau_id        	
	 */
	function ecrireGlobal($data, $analyse_eau_id) {
		foreach ( $data as $key => $value ) {
			/*
			 * Recuperation des cles concernant les analyses de metaux
			 */
			if (substr ( $key, 0, 7 ) == "mesure-") {
				$cle = explode ( "-", $key );
				/*
				 * cle[1] contient la valeur d'analyse_metal_id
				 * cle[2] contient la valeur de metal_id
				 */
				$cleSeuil = "mesure_seuil-" . $cle [1] . "-" . $cle [2];
				/*
				 * Recherche s'il faut ou non ecrire l'enregistrement
				 */
				$ecrire = false;
				if ($cle [1] > 0 || strlen ( $value ) > 0) {
					$ecrire = true;
				} else {
					/*
					 * On regarde s'il existe une valeur seuil
					 */
					if (strlen ( $data [$cleSeuil] ) > 0)
						$ecrire = true;
				}
				if ($ecrire == true) {
					$donnee = array (
							"" 
					);
					if ($cle [1] > 0) {
						$donnee ["analyse_metal_id"] = $cle [1];
					} else
						$donnee ["analyse_metal_id"] = 0;
					$donnee ["analyse_eau_id"] = $analyse_eau_id;
					$donnee ["metal_id"] = $cle [2];
					$donnee ["mesure"] = $value;
					$donnee ["mesure_seuil"] = $data [$cleSeuil];
					$this->ecrire ( $donnee );
				}
			}
		}
	}
}
/**
 * ORM de gestion de la table bassin_lot
 * 
 * @author quinton
 *        
 */
class BassinLot extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
	 * @param AdoDB $bdd        	
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "bassin_lot";
		$this->id_auto = "1";
		$this->colonnes = array (
				"bassin_lot_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"lot_id" => array (
						"type" => 1,
						"requis" => 1,
						"parentAttrib" => 1 
				),
				
				"bassin_id" => array (
						"type" => 1,
						"requis" => 1 
				),
				"bl_date_arrivee" => array (
						"type" => 2,
						"requis" => 1 
				),
				"bl_date_depart" => array (
						"type" => 2 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	
	/**
	 * Retourne la liste des bassins utilisés pour un lot
	 *
	 * @param int $lot_id        	
	 * @return tableau|NULL
	 */
	function getListeFromLot($lot_id) {
		if ($lot_id > 0 && is_numeric($lot_id)) {
			$sql = "select bassin_lot_id, lot_id, bassin_id, 
					bl_date_arrivee, bl_date_depart,
					bassin_nom
					from bassin_lot
					join bassin using (bassin_id)
					where lot_id = " . $lot_id . "
					order by bl_date_arrivee desc";
			return $this->getListeParam ( $sql );
		} else
			return null;
	}
	
	/**
	 * Surcharge de la fonction ecrire pour mettre a jour la date de fin pour
	 * le bassin precedent
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::ecrire()
	 */
	function write($data) {
		$data ["bassin_lot_id"] == 0 ? $creation = true : $creation = false;
		$id = parent::ecrire ( $data );
		if ($id > 0 && $creation == true) {
			/*
			 * Ecrit la date d'arrivee dans le bassin comme date de depart du bassin precedent
			 */
			$dataPrec = $this->getPrecedentBassin ( $data ["lot_id"], $data ["bl_date_arrivee"] );
			if ($dataPrec ["bassin_lot_id"] > 0 && strlen ( $dataPrec ["bl_date_depart"] ) == 0) {
				/*
				 * Calcul de la veille de la date d'arrivee
				 */
				$date = DateTime::createFromFormat ( 'd/m/Y', $data ["bl_date_arrivee"] );
				$date->sub ( new DateInterval ( 'P1D' ) );
				$dataPrec ["bl_date_depart"] = $date->format ( 'd/m/Y' );
				parent::ecrire ( $dataPrec );
			}
		}
		return $id;
	}
	/**
	 * Retourne le bassin precedemment utilise
	 *
	 * @param unknown $lot_id        	
	 * @param unknown $bl_date_arrivee        	
	 * @return array|NULL
	 */
	function getPrecedentBassin($lot_id, $bl_date_arrivee) {
		if ($lot_id > 0 && is_numeric($lot_id) && strlen ( $bl_date_arrivee ) > 0) {
			$bl_date_arrivee = $this->formatDateLocaleVersDB ( $this->encodeData ( $bl_date_arrivee ) );
			$sql = "select * from bassin_lot
				where bl_date_arrivee < '" . $bl_date_arrivee . "' 
						and lot_id = " . $lot_id . "
				order by bl_date_arrivee desc
				limit 1";
			return $this->lireParam ( $sql );
		} else
			return null;
	}
	
	/**
	 * Retourne le bassin occupe a la date fournie par le lot considere
	 *
	 * @param int $lot_id        	
	 * @param string $date        	
	 * @return array|NULL
	 */
	function getBassin($lot_id, $date) {
		if ($lot_id > 0 && is_numeric($lot_id) && strlen ( $date ) > 0) {
			$this->encodeData ( $date );
			$date = $this->formatDateLocaleVersDB ( $date );
			$sql = "select bassin_id, lot_id, bl_date_arrivee, bl_date_depart,
					bassin_nom
					from bassin_lot
					join bassin using (bassin_id)
					where bl_date_arrivee < '" . $date . "' 
						and lot_id = " . $lot_id . "
					order by bl_date_arrivee desc
					limit 1";
			return $this->lireParam ( $sql );
		} else
			return null;
	}
}
?>