<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 13 mars 2015
 */
require_once "modules/classes/croisement.class.php";
require_once "modules/classes/bassin.class.php";
/**
 * ORM  de gestion de la table Lot
 * @author quinton
 *
 */
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
				),
				"vie_modele_id" => array (
						"type" => 1 
				),
				"vie_date_marquage" => array (
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
			$where = " where s.annee = " . $annee;
			return $this->getDataParam ( $where );
		} else
			return null;
	}
	/**
	 * Retourne les lots a partir du numero de sequence
	 *
	 * @param int $sequence_id        	
	 * @return array|NULL
	 */
	function getLotBySequence($sequence_id) {
		if ($sequence_id > 0) {
			$where = " where sequence_id = " . $sequence_id;
			return $this->getDataParam ( $where );
		} else
			return null;
	}
	
	/**
	 * Fonction retournant la liste des lots en fonction du critere de recherche fourni
	 *
	 * @param string $where        	
	 * @return array
	 */
	private function getDataParam($where) {
		if (strlen ( $where ) > 0) {
			$sql = "select lot_id, lot_nom, croisement_id, nb_larve_initial, nb_larve_compte,
					croisement_date,
					sequence_id, s.annee, sequence_nom, croisement_nom, eclosion_date, vie_date_marquage,
					vie_modele_id, couleur, vie_implantation_libelle, vie_implantation_libelle2,
					 extract(epoch from age(eclosion_date))/86400 as age
					from lot
					join croisement using (croisement_id)
					join sequence s using (sequence_id)
					left outer join v_vie_modele vm using (vie_modele_id) ";
			$order = " order by sequence_nom, lot_nom";
			$data = $this->getListeParam ( $sql . $where . $order );
			/*
			 * Mise en forme des donnees, recuperation des reproducteurs et du bassin
			 */
			$bassinLot = new BassinLot($this->connection, $this->paramori);
			$croisement = new Croisement ( $this->connection, $this->paramori );
			foreach ( $data as $key => $value ) {
				$data [$key] ["croisement_date"] = $this->formatDateDBversLocal ( $value ["croisement_date"] );
				$data [$key] ["parents"] = $croisement->getParentsFromCroisement ( $value ["croisement_id"] );
				/*
				 * Recherche du bassin
				 */
				$date = new DateTime();
				$dataBassin = $bassinLot->getBassin($value["lot_id"], $date->format("d/m/Y"));
				$data[$key] ["bassin_id"] = $dataBassin["bassin_id"];
				$data[$key] ["bassin_nom"] = $dataBassin["bassin_nom"];
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
			$where = "where lot_id = " . $lot_id;
			$data = $this->getDataParam ( $where );
			if (is_array ( $data ))
				return $data [0];
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
	/**
	 * Retourne un enregistrement a partir de la valeur de vie_modele_id
	 * 
	 * @param int $vie_modele_id        	
	 * @return array|NULL
	 */
	function getFromVieModele($vie_modele_id) {
		if ($vie_modele_id > 0) {
			$sql = "select * from lot where vie_modele_id = " . $vie_modele_id;
			return $this->lireParam ( $sql );
		} else
			return null;
	}
	/**
	 * Retourne les parents d'un lot
	 * @param int $lot_id
	 * @return tableau|NULL
	 */
	function getParents($lot_id) {
		if ($lot_id > 0) {
			$sql = "select poisson_id
				from lot
				join poisson_croisement using (croisement_id)
				join poisson_campagne using (poisson_campagne_id)
				where lot_id = " . $lot_id;
			return $this->getListeParam ( $sql );
		} else
			return null;
	}
	
	/**
	 * Retourne la liste des lots dont la date de naissance est anterieure a la date fournie,
	 * pour l'annee consideree
	 * @param unknown $dateDebut
	 */
	function getListAfterDate($dateDebut) {
		$dateDebut = $this->encodeData($dateDebut);
		if (strlen($dateDebut) > 0) {
			$dateDebut = $this->formatDateLocaleVersDB($dateDebut);
			$sql = "select lot_id, lot_nom, croisement_id, nb_larve_initial, eclosion_date,
					s.annee, sequence_nom
				from lot
				join croisement using (croisement_id)
				join sequence s using (sequence_id)
				where eclosion_date < '".$dateDebut."' 
					and extract(year from eclosion_date) = ".substr($dateDebut, 0, 4)."
				order by lot_nom";
			$data = $this->getListeParam($sql);
			return ($data);

		} else
			return null;
	}

	/**
	 * Retourne les informations sur les lots pour la liste des lots fournie
	 * @param array $lots
	 * @return tableau
	 */
	function getDataFromListe($lots) {
		$empty = true;
		$liste = "";
		foreach($lots as $key => $value) {
			if ($value > 0) {
			if ($empty == false) {
				$liste .= ", ";
			} else 
				$empty = false;
			}
			$liste .= $value;
		}
		if ($empty == false) {
			$sql = "select lot_id, lot_nom, croisement_id, nb_larve_initial, eclosion_date,
					s.annee, sequence_nom
				from lot
				join croisement using (croisement_id)
				join sequence s using (sequence_id)
				where lot_id in (".$liste.")";
			return $this->getListeParam($sql);
		}
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
			$nbJours = round ( (strtotime ( $dateFin ["year"] . "-" . $dateFin ["month"] . "-" . $dateFin ["day"] ) - strtotime ( $dateDebut ["year"] . "-" . $dateDebut ["month"] . "-" . $dateDebut ["day"] )) / (60 * 60 * 24) );
			if ($nbJours > 0 && $nbJours < 365) {
				$data ["nb_jour"] = $nbJours;
			}
		}
		return parent::ecrire ( $data );
	}

	/**
	 * Retourne le nombre de poissons morts et la derniere masse individuelle connue
	 * pour un lot a une date connue
	 * @param unknown $lot_id
	 * @param unknown $date
	 * @return array|NULL
	 */
	function getMesureAtDate($lot_id, $date) {
		if ($lot_id > 0 && strlen($date) > 0) {
			$date = $this->encodeData($date);
			$date = $this->formatDateLocaleVersDB($date);
			/*
			 * Recuperation de la mortalite totale
			 */
			$sql = "select sum(lot_mortalite) as lot_mortalite
					from lot_mesure
					where lot_mesure_date <= '".$date."' 
						and lot_id = ".$lot_id;
			$data = $this->lireParam($sql);
			if (!is_array($data))
				$data ["lot_mortalite"] = 0;
			/*
			 * Recuperation de la derniere masse individuelle connue
			 */
			$sql = "select lot_mesure_masse_indiv 
					from lot_mesure
					where lot_mesure_date <= '".$date."' 
						and lot_id = ".$lot_id."
					order by lot_mesure_date desc
					limit 1";
			$dataMasse = $this->lireParam($sql);
			$data["masse_indiv"] = $dataMasse["lot_mesure_masse_indiv"];
			return $data;
		} else 
			return null;
	}
}
/**
 * ORM de gestion de la table vie_modele
 *
 * @author quinton
 *        
 */
class VieModele extends ObjetBDD {
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "vie_modele";
		$this->id_auto = "1";
		$this->colonnes = array (
				"vie_modele_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"vie_implantation_id" => array (
						"type" => 1,
						"requis" => 1 
				),
				"vie_implantation_id2" => array (
						"type" => 1,
						"requis" => 1 
				),
				"annee" => array (
						"type" => 1,
						"requis" => 1 
				),
				"couleur" => array (
						"type" => 0,
						"requis" => 0 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	
	/**
	 * Retourne l'ensemble des modèles pour l'année considérée
	 *
	 * @param int $annee        	
	 * @return tableau
	 */
	function getModelesFromAnnee($annee) {
		if ($annee > 0) {
			$sql = "select vie_modele_id, vm.vie_implantation_id, vie_implantation_id2,
					annee, couleur,
					v1.vie_implantation_libelle, v2.vie_implantation_libelle as vie_implantation_libelle2
					from vie_modele vm
					join vie_implantation v1 on (vm.vie_implantation_id = v1.vie_implantation_id)
					join vie_implantation v2 on (vm.vie_implantation_id2 = v2.vie_implantation_id)
					where annee = " . $annee . " 
					order by vie_modele_id";
			return $this->getListeParam ( $sql );
		}
	}
	
	/**
	 * Recupere l'ensemble des modeles disponibles dans la base de donnees
	 *
	 * @return tableau
	 */
	function getAllModeles() {
		$sql = "select * from v_vie_modele order by annee desc, couleur, vie_modele_id";
		return $this->getListeParam ( $sql );
	}
}
/**
 * ORM de gestion de la table vie_implantation
 *
 * @author quinton
 *        
 */
class VieImplantation extends ObjetBDD {
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "vie_implantation";
		$this->id_auto = "1";
		$this->colonnes = array (
				"vie_implantation_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"vie_implantation_libelle" => array (
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