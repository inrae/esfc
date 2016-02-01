<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 10 mars 2015
 */
require_once 'modules/classes/bassin.class.php';
/**
 * ORM de gestion de la table bassin_campagne
 *
 * @author quinton
 *        
 */
class BassinCampagne extends ObjetBDD {
	public function __construct($p_connection, $param = NULL) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "bassin_campagne";
		$this->id_auto = "1";
		$this->colonnes = array (
				"bassin_campagne_id" => array (
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
				"annee" => array (
						"type" => 1,
						"requis" => 1,
						"defaultValue" => "getYear" 
				),
				"bassin_utilisation" => array (
						"type" => 0 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		
		parent::__construct ( $p_connection, $param );
	}
	
	/**
	 * Genere les enregistrements pour les bassins, pour la campagne consideree
	 *
	 * @param int $annee        	
	 */
	function initCampagne($annee) {
		$nb = 0;
		if ($annee > 0 && is_numeric ( $annee )) {
			/*
			 * Recherche des bassins de reproduction
			 */
			$sql = "select bassin_id from bassin 
					where bassin_usage_id = 7 
					and actif = 1
					and bassin_id not in (
					select distinct c.bassin_id from bassin_campagne c where annee = " . $annee . ")";
			$liste = $this->getListeParam ( $sql );
			foreach ( $liste as $key => $value ) {
				$data = array ();
				$data ["bassin_id"] = $value ["bassin_id"];
				$data ["annee"] = $annee;
				if ($this->ecrire ( $data ) > 0)
					$nb ++;
			}
		}
		return $nb;
	}
	/**
	 * Retourne la liste des bassins utilisés pour l'année considérée
	 *
	 * @param int $annee        	
	 * @return tableau|NULL
	 */
	function getListFromAnnee($annee) {
		if ($annee > 0 && is_numeric ( $annee )) {
			$sql = "select bassin_id, bassin_campagne_id, annee, bassin_nom, bassin_utilisation
					from bassin_campagne
					join bassin using (bassin_id)
					where annee = " . $annee . "
					order by bassin_nom";
			return $this->getListeParam ( $sql );
		} else
			return null;
	}
}
/**
 * ORM de gestion de la table profil_thermique
 *
 * @author quinton
 *        
 */
class ProfilThermique extends ObjetBDD {
	public function __construct($p_connection, $param = NULL) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "profil_thermique";
		$this->id_auto = "1";
		$this->colonnes = array (
				"profil_thermique_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"bassin_campagne_id" => array (
						"type" => 1,
						"requis" => 1,
						"parentAttrib" => 1 
				),
				"profil_thermique_type_id" => array (
						"type" => 1,
						"requis" => 1 
				),
				"pf_datetime" => array (
						"type" => 3,
						"requis" => 1 
				),
				"pf_temperature" => array (
						"type" => 1,
						"requis" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		
		parent::__construct ( $p_connection, $param );
	}
	
	/**
	 * Recupere la liste des temperatures definies pour un bassin_campagne
	 *
	 * @param int $bassin_campagne_id        	
	 * @return tableau|NULL
	 */
	function getListFromBassinCampagne($bassin_campagne_id, $type_id = 0) {
		if ($bassin_campagne_id > 0 && is_numeric ( $bassin_campagne_id )) {
			$sql = "select profil_thermique_id, bassin_campagne_id, profil_thermique_type_id,
					pf_datetime, pf_temperature, 
					profil_thermique_type_libelle
					from profil_thermique
					join profil_thermique_type using (profil_thermique_type_id)";
			$where = " where bassin_campagne_id = " . $bassin_campagne_id;
			if ($type_id > 0 && is_numeric ( $type_id )) {
				$where .= " and profil_thermique_type_id = " . $type_id;
			}
			$order = " order by pf_datetime";
			return $this->getListeParam ( $sql . $where . $order );
		} else
			return null;
	}
	
	/**
	 * Surcharge de la fonction lire pour eclater la zone datetime en deux champs
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::lire()
	 */
	function lire($id, $getDefault = false, $parentValue = 0) {
		$data = parent::lire ( $id, $getDefault, $parentValue );
		$dateTime = explode ( " ", $data ["pf_datetime"] );
		$data ["pf_date"] = $dateTime [0];
		$data ["pf_time"] = $dateTime [1];
		return $data;
	}
	
	/**
	 * Surcharge de la fonction ecrire pour reconstituer le champ pf_datetime
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::ecrire()
	 */
	function ecrire($data) {
		$data ["pf_datetime"] = $data ["pf_date"] . " " . $data ["pf_time"];
		$id = parent::ecrire ( $data );
		if ($data ["profil_thermique_type_id"] == 1 && $id > 0 && $data ["bassin_id"] > 0 && is_numeric ( $data ["bassin_id"] )) {
			/*
			 * Ecriture de l'enregistrement dans les analyses du bassin
			 * Recuperation du numero d'analyse correspondant
			 */
			$analyseEau = new AnalyseEau ( $this->connection, $this->paramori );
			/*
			 * Forcage du champ date en datetime
			 */
			$analyseEau->types ["analyse_eau_date"] = 3;
			$analyse_eau_id = $analyseEau->getIdFromDateBassin ( $data ["pf_datetime"], $data ["bassin_id"] );
			if ($analyse_eau_id > 0) {
				$dataAnalyse = $analyseEau->lire ( $analyse_eau_id );
			} else {
				$dataAnalyse = array (
						"analyse_eau_id" => 0,
						"analyse_eau_date" => $data ["pf_datetime"],
						"circuit_eau_id" => $data ["circuit_eau_id"] 
				);
			}
			/*
			 * Mise a jour de la temperature
			 */
			$dataAnalyse ["temperature"] = $data ["pf_temperature"];
			$analyseEau->ecrire ( $dataAnalyse );
		}
		return ($id);
	}
}

/**
 * ORM de gestion de la table salinite
 *
 * @author quinton
 *        
 */
class Salinite extends ObjetBDD {
	public function __construct($p_connection, $param = NULL) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "salinite";
		$this->id_auto = "1";
		$this->colonnes = array (
				"salinite_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"bassin_campagne_id" => array (
						"type" => 1,
						"requis" => 1,
						"parentAttrib" => 1 
				),
				"profil_thermique_type_id" => array (
						"type" => 1,
						"requis" => 1 
				),
				"salinite_datetime" => array (
						"type" => 3,
						"requis" => 1 
				),
				"salinite_tx" => array (
						"type" => 1,
						"requis" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		
		parent::__construct ( $p_connection, $param );
	}
	
	/**
	 * Recupere la liste des salinites definies pour un bassin_campagne
	 *
	 * @param int $bassin_campagne_id        	
	 * @return tableau|NULL
	 */
	function getListFromBassinCampagne($bassin_campagne_id, $type_id = 0) {
		if ($bassin_campagne_id > 0 && is_numeric ( $bassin_campagne_id )) {
			$sql = "select salinite_id, bassin_campagne_id, profil_thermique_type_id,
					salinite_datetime, salinite_tx,
					profil_thermique_type_libelle
					from salinite
					join profil_thermique_type using (profil_thermique_type_id)";
			$where = " where bassin_campagne_id = " . $bassin_campagne_id;
			if ($type_id > 0 && is_numeric ( $type_id )) {
				$where .= " and profil_thermique_type_id = " . $type_id;
			}
			$order = " order by salinite_datetime";
			return $this->getListeParam ( $sql . $where . $order );
		} else
			return null;
	}
	
	/**
	 * Surcharge de la fonction lire pour eclater la zone datetime en deux champs
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::lire()
	 */
	function lire($id, $getDefault = false, $parentValue = 0) {
		$data = parent::lire ( $id, $getDefault, $parentValue );
		$dateTime = explode ( " ", $data ["salinite_datetime"] );
		$data ["salinite_date"] = $dateTime [0];
		$data ["salinite_time"] = $dateTime [1];
		return $data;
	}
	
	/**
	 * Surcharge de la fonction ecrire pour reconstituer le champ salinite_datetime
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::ecrire()
	 */
	function ecrire($data) {
		$data ["salinite_datetime"] = $data ["salinite_date"] . " " . $data ["salinite_time"];
		$id = parent::ecrire ( $data );
		if ($data ["profil_thermique_type_id"] == 1 && $id > 0 && $data ["bassin_id"] > 0 && is_numeric ( $data ["bassin_id"] )) {
			/*
			 * Ecriture de l'enregistrement dans les analyses du bassin
			 * Recuperation du numero d'analyse correspondant
			 */
			$analyseEau = new AnalyseEau ( $this->connection, $this->paramori );
			/*
			 * Forcage du champ date en datetime
			 */
			$analyseEau->types ["analyse_eau_date"] = 3;
			$analyse_eau_id = $analyseEau->getIdFromDateBassin ( $data ["salinite_datetime"], $data ["bassin_id"] );
			if ($analyse_eau_id > 0) {
				$dataAnalyse = $analyseEau->lire ( $analyse_eau_id );
			} else {
				$dataAnalyse = array (
						"analyse_eau_id" => 0,
						"analyse_eau_date" => $data ["salinite_datetime"],
						"circuit_eau_id" => $data ["circuit_eau_id"] 
				);
			}
			/*
			 * Mise a jour de la salinite
			 */
			$dataAnalyse ["salinite"] = $data ["salinite_tx"];
			$analyseEau->ecrire ( $dataAnalyse );
		}
		return ($id);
	}
}
?>