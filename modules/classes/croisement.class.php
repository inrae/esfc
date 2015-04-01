<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 12 mars 2015
 */
/**
 * ORM de gestion de la table croisement
 *
 * @author quinton
 *        
 */
require_once 'modules/classes/sequence.class.php';
class Croisement extends ObjetBDD {
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "croisement";
		$this->id_auto = "1";
		$this->colonnes = array (
				"croisement_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"sequence_id" => array (
						"type" => 1,
						"requis" => 1,
						"parentAttrib" => 1 
				),
				"croisement_qualite_id" => array (
						"type" => 1 
				),
				"croisement_date" => array (
						"type" => 3 
				),
				"croisement_nom" => array (
						"type" => 0,
						"requis" => 1 
				),
				"ovocyte_masse" => array (
						"type" => 1 
				),
				"ovocyte_densite" => array (
						"type" => 1 
				),
				"tx_fecondation" => array (
						"type" => 1 
				),
				"tx_survie_estime" => array (
						"type" => 1 
				),
				"croisement_parents" => array (
						"type" => 0
				)
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	
	/**
	 * Surcharge de la fonction ecrire pour prendre en compte la liste des reproducteurs
	 * attaches
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::ecrire()
	 */
	function write($data) {
		/*
		 * Reconstitution de la date
		 */
		$data ["croisement_date"] = $data ["croisement_date"] . " " . $data ["croisement_time"];
		$id = parent::ecrire ( $data );
		if ($id > 0) {
			/*
			 * Ecriture de la liste des poissons concernes
			 */
			$this->ecrireTableNN ( "poisson_croisement", "croisement_id", "poisson_campagne_id", $id, $data ["poisson_campagne_id"] );
		}
		return $id;
	}
	function lire($id, $getDefault = false, $parentValue = 0) {
		$data = parent::lire ( $id, $getDefault, $parentValue );
		$dateTime = explode ( " ", $data ["croisement_date"] );
		$data ["croisement_date"] = $dateTime [0];
		$data ["croisement_time"] = $dateTime [1];
		return $data;
	}
	
	/**
	 * recupere la liste des croisement pour une sequence
	 *
	 * @param int $sequence_id        	
	 * @return tableau|NULL
	 */
	function getListFromSequence($sequence_id) {
		if ($sequence_id > 0) {
			$sql = "select croisement_id, sequence_id, croisement_qualite_id, croisement_qualite_libelle,
					croisement_date, ovocyte_masse, ovocyte_densite, tx_fecondation, tx_survie_estime,
					sequence_nom, croisement_nom
					from croisement
					join sequence using (sequence_id)
					left outer join croisement_qualite using (croisement_qualite_id)
					where sequence_id = " . $sequence_id . "
					order by croisement_date, croisement_nom";
			$data = $this->getListeParam ( $sql );
			/*
			 * Recherche des parents
			 */
			foreach ( $data as $key => $value ) {
				$data [$key] ["parents"] = $this->getParentsFromCroisement ( $value ["croisement_id"] );
			}
			return $data;
		} else
			return null;
	}
	
	/**
	 * Recupere la liste des croisements pour une annee
	 * 
	 * @param int $annee        	
	 * @return array|NULL
	 */
	function getListFromAnnee($annee) {
		if ($annee > 0) {
			$sql = "select croisement_id, sequence_id, croisement_qualite_id, croisement_qualite_libelle,
					croisement_date, ovocyte_masse, ovocyte_densite, tx_fecondation, tx_survie_estime
					from croisement
					join sequence using (sequence_id)
					left outer join croisement_qualite using (croisement_qualite_id)
					where annee = " . $annee . "
					order by croisement_date, croisement_id";
			$data = $this->getListeParam ( $sql );
			/*
			 * Recherche des parents
			 */
			foreach ( $data as $key => $value ) {
				$data [$key] ["parents"] = $this->getParentsFromCroisement ( $value ["croisement_id"] );
			}
			return $data;
		} else
			return null;
	}
	
	/**
	 * Recupere la liste des parents d'un croisement, sous forme de chaine "prete a l'emploi"
	 *
	 * @param int $croisement_id        	
	 * @return string
	 */
	function getParentsFromCroisement($croisement_id) {
		$parents = "";
		if ($croisement_id > 0) {
			$sql = "select prenom, sexe_libelle_court
						from poisson_croisement
						join poisson_campagne using (poisson_campagne_id)
						join poisson using (poisson_id)
						left outer join sexe using (sexe_id)
						where croisement_id = " . $croisement_id . "
						order by sexe_libelle_court, prenom";
			$poissons = $this->getListeParam ( $sql );
			foreach ( $poissons as $key1 => $value1 ) {
				if ($new == false) {
					$parents .= " ";
				} else
					$new = false;
				$parents .= $value1 ["prenom"] . "(" . $value1 ["sexe_libelle_court"] . ")";
			}
		}
		return $parents;
	}

	/**
	 * Retourne les poissons pour un croisement
	 * @param int $croisement_id
	 * @return tableau|NULL
	 */
	function getPoissonsFromCroisement ($croisement_id) {
		if ($croisement_id > 0) {
			$sql = "select poisson_campagne_id 
					from poisson_croisement
					where croisement_id = ".$croisement_id;
			return $this->getListeParam($sql);
		} else 
			return null;
	}
	
	/**
	 * Retourne la liste de tous les poissons de la sequence, avec le fait q'ils soient
	 * selectionnes ou non dans le croisement considere
	 *
	 * @param unknown $croisement_id        	
	 * @param string $sequence_id        	
	 * @return Ambigous <multitype:, number, tableau, NULL, boolean, $data>
	 */
	function getListAllPoisson($croisement_id, $sequence_id = null) {
		$data = array ();
		if ($croisement_id > 0) {
			if (is_null ( $sequence_id )) {
				/*
				 * Recuperation du numero de sequence
				 */
				$data = $this->lire ( $croisement_id );
				$sequence_id = $data ["sequence_id"];
			}
			if ($sequence_id > 0) {
				/*
				 * Recherche des poissons attaches a la sequence
				 */
				$poissonSequence = new PoissonSequence ( $this->connection, $this->paramori );
				$data = $poissonSequence->getListFromSequence ( $sequence_id );
				/*
				 * Recherche des poissons attaches au croisement
				 */
				$sql = "select poisson_campagne_id 
						from poisson_croisement
						where croisement_id = " . $croisement_id;
				$poissonCroisement = $this->getListeParam ( $sql );
				foreach ( $data as $key => $value ) {
					foreach ( $poissonCroisement as $key1 => $value1 ) {
						if ($value ["poisson_campagne_id"] == $value1 ["poisson_campagne_id"]) {
							$data [$key] ["selected"] = 1;
						}
					}
				}
			}
		}
		return $data;
	}
}
/**
 * ORM de gestion de la table croisement_qualite
 *
 * @author quinton
 *        
 */
class CroisementQualite extends ObjetBDD {
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "croisement_qualite";
		$this->id_auto = "1";
		$this->colonnes = array (
				"croisement_qualite_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"croisement_qualite_libelle" => array (
						"type" => 0,
						"requis" => 1 
				) 
		);
		
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		$param ["transformComma"] = 1;
		parent::__construct ( $bdd, $param );
	}
}
?>