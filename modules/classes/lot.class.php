<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 13 mars 2015
 */
require_once "modules/classes/croisement.class.php";
class Lot extends ObjetBDD {
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
		$this->table = "lot";
		$this->id_auto = "1";
		$this->colonnes = array (
				"lot_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"croisement_id" => array (
						"type" => 1,
						"requis" => 1,
						"parentAttrib" => 1 
				),
				"lot_nom" => array (
						"type" => 0,
						"requis" => 1 
				),
				"nb_larve_initial" => array (
						"type" => 1 
				),
				"nb_larve_compte" => array (
						"type" => 1 
				),
				"eclosion_date" => array (
						"type" => 2 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	
	/**
	 * Retourne la liste des lots pour une annee
	 *
	 * @param int $annee        	
	 * @return array|NULL
	 */
	function getLotByAnnee($annee) {
		if ($annee > 0) {
			$sql = "select lot_id, lot_nom, croisement_id, nb_larve_initial, nb_larve_compte,
					croisement_date, 
					sequence_id, annee, sequence_nom, croisement_nom, eclosion_date
					from lot 
					join croisement using (croisement_id)
					join sequence using (sequence_id)
					where annee = " . $annee . "
					order by sequence_nom, croisement_id";
			$data = $this->getListeParam ( $sql );
			/*
			 * Mise en forme des donnees et recuperation des reproducteurs
			 */
			$croisement = new Croisement ( $this->connection, $this->paramori );
			foreach ( $data as $key => $value ) {
				$data [$key] ["croisement_date"] = $this->formatDateDBversLocal ( $value ["croisement_date"] );
				$data [$key] ["parents"] = $croisement->getParentsFromCroisement ( $value ["croisement_id"] );
			}
			return $data;
		} else
			return null;
	}
	function getLotBySequence($sequence_id) {
		if ($sequence_id > 0) {
			$sql = "select lot_id, lot_nom, croisement_id, nb_larve_initial, nb_larve_compte,
					croisement_date,
					sequence_id, annee, sequence_nom, croisement_nom, eclosion_date
					from lot
					join croisement using (croisement_id)
					join sequence using (sequence_id)
					where sequence_id = " . $sequence_id . "
					order by sequence_nom, croisement_id";
			$data = $this->getListeParam ( $sql );
			/*
			 * Mise en forme des donnees et recuperation des reproducteurs
			 */
			$croisement = new Croisement ( $this->connection, $this->paramori );
			foreach ( $data as $key => $value ) {
				$data [$key] ["croisement_date"] = $this->formatDateDBversLocal ( $value ["croisement_date"] );
				$data [$key] ["parents"] = $croisement->getParentsFromCroisement ( $value ["croisement_id"] );
			}
			return $data;
		} else
			return null;
	}
	
	/**
	 * Retourne le detail d'un lot
	 *
	 * @param int $lot_id        	
	 * @return array|NULL
	 */
	function getDetail($lot_id) {
		if ($lot_id > 0) {
			$sql = "select lot_id, croisement_id, lot_nom, nb_larve_initial, nb_larve_compte,
					sequence_id, sequence_nom, annee, croisement_nom, eclosion_date
					from lot 
					join croisement using (croisement_id)
					join sequence using (sequence_id)
					where lot_id = " . $lot_id;
			$data = $this->lireParam ( $sql );
			$croisement = new Croisement ( $this->connection, $this->paramori );
			$data ["parents"] = $croisement->getParentsFromCroisement ( $data ["croisement_id"] );
			return $data;
		} else
			return null;
	}
	
	/**
	 * Compte le nombre de larves pour tous les lots d'un croisement
	 *
	 * @param int $croisement_id        	
	 * @return array|NULL
	 */
	function getNbLarveFromCroisement($croisement_id) {
		if ($croisement_id > 0) {
			$sql = "select sum(nb_larve_initial) as total_larve_initial, 
					sum(nb_larve_compte) as total_larve_compte
					from lot
					where croisement_id = " . $croisement_id;
			return $this->lireParam ( $sql );
		} else
			return null;
	}
}

/**
 * ORM de gestion de la table lot_mesure
 *
 * @author quinton
 *        
 */
class LotMesure extends ObjetBDD {
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
		$this->table = "lot_mesure";
		$this->id_auto = "1";
		$this->colonnes = array (
				"lot_mesure_id" => array (
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
				"lot_mesure_date" => array (
						"type" => 2,
						"requis" => 1,
						"defaultValue" => "getDateJour" 
				),
				"nb_jour" => array (
						"type" => 1 
				),
				"lot_mortalite" => array (
						"type" => 1 
				),
				"lot_mesure_masse" => array (
						"type" => 1 
				),
				"lot_mesure_masse_indiv" => array (
						"type" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	
	/**
	 * Retourne la liste des mesures pur un lot
	 *
	 * @param int $lot_id        	
	 * @return tableau|NULL
	 */
	function getListFromLot($lot_id) {
		if ($lot_id > 0) {
			$sql = "select lot_mesure_id, lot_id, lot_mesure_date, nb_jour, lot_mortalite,
					lot_mesure_masse, lot_mesure_masse_indiv
					from lot_mesure
					where lot_id = " . $lot_id . "
					order by lot_mesure_date";
			return $this->getListeParam ( $sql );
		} else
			return null;
	}
	
	/**
	 * Calcul du nombre de jours depuis l'eclosion avant l'écriture en table
	 * (non-PHPdoc)
	 * 
	 * @see ObjetBDD::ecrire()
	 */
	function ecrire($data) {
		/*
		 * Calcul du nombre de jours depuis l'éclosion
		 */
		if ($data ["lot_id"] > 0 && strlen ( $data ["lot_mesure_date"] ) > 0) {
			$lot = new Lot ( $this->connection, $this->paramori );
			$dataLot = $lot->lire ( $data ["lot_id"] );
			$dateDebut = date_parse_from_format ( "d/m/Y", $dataLot ["eclosion_date"] );
			$dateFin = date_parse_from_format ( "d/m/Y", $data ["lot_mesure_date"] );
			$nbJours = round ( (strtotime ( $dateFin ["year"] . "-" . $dateFin ["month"] . "-" . $dateFin ["day"] ) 
					- strtotime ( $dateDebut ["year"] . "-" . $dateDebut ["month"] . "-" . $dateDebut ["day"] )) 
					/ (60 * 60 * 24) );
			if ($nbJours > 0 && $nbJours < 365) {
				$data ["nb_jour"] = $nbJours;
			}
		}
		return parent::ecrire ( $data );
	}
}

?>