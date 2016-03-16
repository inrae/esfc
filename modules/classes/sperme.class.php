<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 25 mars 2015
 */
class Sperme extends ObjetBDD {
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "sperme";
		$this->id_auto = "1";
		$this->colonnes = array (
				"sperme_id" => array (
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
				
				"sperme_date" => array (
						"type" => 3,
						"requis" => 1,
						"defaultValue" => "getDateHeure" 
				),
				"sperme_volume" => array(
						"type"=>1
				),
				
				"sperme_commentaire" => array (
						"type" => 0 
				),
				"congelation_date"=>array(
						"type"=>2
				),
				"congelation_volume"=>array(
						"type"=>2
				),
				"sperme_dilueur_id"=>array(
						"type"=>1
				),
				"nb_paillette"=>array(
						"type"=>1
				),
				"numero_canister"=>array(
						"type"=>0
				),
				"position_canister"=>array(
						"type"=>1
				)

		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	
	/**
	 * Retourne la liste des prelevements de sperme pour un poisson
	 *
	 * @param int $poisson_campagne_id        	
	 * @return tableau|NULL
	 */
	function getListFromPoissonCampagne($poisson_campagne_id) {
		if ($poisson_campagne_id > 0 && is_numeric($poisson_campagne_id)) {
			$sql = "select sperme_id, poisson_campagne_id, sperme_date,
					sequence_id, sequence_nom,
					 sperme_commentaire, sperme_ph
					
					from sperme
					
					left outer join sequence using (sequence_id)
					where poisson_campagne_id = " . $poisson_campagne_id . "
					order by sperme_date";
			return $this->getListeParam ( $sql );
		} else
			return null;
	}
	
	/**
	 * Retourne la liste des spermes disponibles pour la liste des poissons fournis
	 * @param array $poissons
	 * @return tableau
	 */
	function getListPotentielFromPoissons($poissons) {
		/*
		 * Verification que les poissons contiennent bien des valeurs numeriques
		 */
		$ok = true;
		foreach($poissons as $value) {
			if (!is_numeric($value))
				$ok = false;
		}
		if (count($poissons) == 0)
			$ok = false;
		if ($ok == true) {
			$sql = "select sperme_id, sequence_id, sperme_date, sperme_volume, sperme_commentaire,
					congelation_date, congelation_volume, nb_paillette, numero_canister, position_canister,
					annee, poisson_id, matricule, prenom";
			$from ="from sperme 
					natural join poisson_campagne
					natural join poisson
					 ";
			$where = " where poisson_id in (";
			$comma = "";
			foreach ($poissons as $value) {
				$where .= $comma.$value;
				$comma = ",";
			}
			$where .= ")";
			$order = " order by matricule, sperme_date";
			return $this->getListeParam($sql.$from.$where.$order);
		}
	}
	
}
/**
 * ORM de gestion de la table sperme_qualite
 * 
 * @author quinton
 *        
 */
class SpermeQualite extends ObjetBDD {
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "sperme_qualite";
		$this->id_auto = "1";
		$this->colonnes = array (
				"sperme_qualite_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"sperme_qualite_libelle" => array (
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
 * ORM de gestion de la table sperme_mesure
 * @author quinton
 *
 */
class SpermeMesure extends ObjetBDD {
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "sperme_mesure";
		$this->id_auto = "1";
		$this->colonnes = array (
				"sperme_mesure_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0
				),
				"sperme_id"=>array(
						"type"=>1,
						"requis"=>1,
						"parentAttrib"=>1
				),
				"sperme_mesure_date"=>array(
						"type"=>3,
						"requis"=>1,
						"defaultValue"=>"getDateHeure"
				),
				"motilite_initiale" => array (
						"type" => 1
				),
				"tx_survie_initial" => array (
						"type" => 1
				),
				"motilite_60" => array (
						"type" => 1
				),
				"tx_survie_60" => array (
						"type" => 1
				),
				"temps_survie" => array (
						"type" => 1
				),
				"sperme_ph" => array (
						"type" => 1
				)
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
}

/**
 * ORM de gestion de la table sperme_dilueur
 *
 * @author quinton
 *
 */
class SpermeDilueur extends ObjetBDD {
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "sperme_dilueur";
		$this->id_auto = "1";
		$this->colonnes = array (
				"sperme_dilueur_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0
				),
				"sperme_dilueur_libelle" => array (
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
 * ORM de gestion de la table sperme_caracteristique
 *
 * @author quinton
 *
 */
class SpermeCaracteristique extends ObjetBDD {
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "sperme_caracteristique";
		$this->id_auto = "1";
		$this->colonnes = array (
				"sperme_caracteristique_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0
				),
				"sperme_caracteristique_libelle" => array (
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
 * ORM de gestion de la table sperme_aspect
 *
 * @author quinton
 *
 */
class SpermeAspect extends ObjetBDD {
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "sperme_aspect";
		$this->id_auto = "1";
		$this->colonnes = array (
				"sperme_aspect_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0
				),
				"sperme_aspect_libelle" => array (
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
?>