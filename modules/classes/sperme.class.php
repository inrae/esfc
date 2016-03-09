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
				"sperme_qualite_id" => array (
						"type" => 1 
				),
				"sperme_date" => array (
						"type" => 3,
						"requis" => 1,
						"defaultValue" => "getDateJour" 
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
				"sperme_commentaire" => array (
						"type" => 0 
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
	
	/**
	 * Retourne la liste des injections pour un poisson
	 *
	 * @param int $poisson_campagne_id        	
	 * @return tableau|NULL
	 */
	function getListFromPoissonCampagne($poisson_campagne_id) {
		if ($poisson_campagne_id > 0 && is_numeric($poisson_campagne_id)) {
			$sql = "select sperme_id, poisson_campagne_id, sperme_date,
					sequence_id, sequence_nom,
					motilite_initiale, tx_survie_initial,
					motilite_60, tx_survie_60, 
					temps_survie, sperme_commentaire, sperme_ph,
					sperme_qualite_id, sperme_qualite_libelle
					from sperme
					left outer join sperme_qualite using (sperme_qualite_id)
					left outer join sequence using (sequence_id)
					where poisson_campagne_id = " . $poisson_campagne_id . "
					order by sperme_date";
			return $this->getListeParam ( $sql );
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
		$dateTime = explode ( " ", $data ["sperme_date"] );
		$data ["sperme_date"] = $dateTime [0];
		$data ["sperme_time"] = $dateTime [1];
		return $data;
	}
	
	/**
	 * Surcharge de la fonction ecrire pour reconstituer le champ injection_date
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::ecrire()
	 */
	function ecrire($data) {
		$data ["sperme_date"] = $data ["sperme_date"] . " " . $data ["sperme_time"];
		return parent::ecrire ( $data );
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
?>