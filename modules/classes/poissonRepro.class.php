<?php
require_once 'modules/classes/poisson.class.php';
/**
 *
 * @author quinton
 *        
 */
class PoissonCampagne extends ObjetBDD {
	
	/**
	 *
	 * @param
	 *        	instance ADODB
	 *        	
	 */
	public function __construct($p_connection, $param = NULL) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "poisson_campagne";
		$this->id_auto = "1";
		$this->colonnes = array (
				"poisson_campagne_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"poisson_id" => array (
						"type" => 1,
						"requis" => 1,
						"parentAttrib" => 1 
				),
				"annee" => array (
						"type" => 1,
						"requis" => 1,
						"defaultValue" => "getYear" 
				),
				"tx_croissance_journalier" => array (
						"type" => 1 
				),
				"specific_growth_rate" => array (
						"type" => 1 
				),
				"masse" => array (
						"type" => 1 
				),
				"repro_statut_id" => array (
						"type" => 1,
						"requis" => 1,
						"defaultValue" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		
		parent::__construct ( $p_connection, $param );
	}
	
	/**
	 * Retourne l'annee courante
	 *
	 * @return int
	 */
	function getYear() {
		return date ( 'Y' );
	}
	
	/**
	 * Calcule le taux de croissance d'un poisson
	 *
	 * @param int $poisson_id        	
	 * @param int $annee        	
	 * @return array
	 */
	function txCroissanceJourCalcul($poisson_id, $annee = NULL) {
		$result = array ();
		if ($poisson_id > 0) {
			$morphologie = new Morphologie ( $this->connection, $this->paramori );
			if (is_null ( $annee ))
				$annee = getYear ();
			$masse_actuelle = $morphologie->getMasseBeforeRepro ( $poisson_id, $annee );
			$result ["masse_actuelle"] = $masse_actuelle ["masse"];
			$masse_anterieure = $morphologie->getMasseBeforeDate ( $poisson_id, $masse_actuelle ["morphologie_date"] );
			$result ["masse_anterieure"] = $masse_anterieure ["masse"];
			if (is_array ( $masse_actuelle ) && is_array ( $masse_anterieure )) {
				if ($masse_actuelle ["masse"] > 0 && $masse_anterieure ["masse"] > 0) {
					/*
					 * Calcul du nombre de jours
					 */
					$date_anterieure = date_create_from_format ( "d/m/Y", $masse_anterieure ["morphologie_date"] );
					$date_actuelle = date_create_from_format ( "d/m/Y", $masse_actuelle ["morphologie_date"] );
					$interval = $date_anterieure->diff ( $date_actuelle, true );
					$nbJour = $interval->format ( "%a" );
					if ($nbJour > 0) {
						$masseDiff = $masse_actuelle ["masse"] - $masse_anterieure ["masse"];
						$result ["txCroissance"] = $masseDiff / $masse_anterieure ["masse"] * 100 / $nbJour;
						/*
						 * Calcul du SGR
						 */
						$result ["sgr"] = (log ( $masse_actuelle ["masse"] ) - log ( $masse_anterieure ["masse"] )) * 100 / $nbJour;
						/*
						 * Limitation du nombre de decimales
						 */
						$result ['txCroissance'] = intval ( $result ["txCroissance"] * 1000 ) / 1000;
						$result ['sgr'] = intval ( $result ["sgr"] * 1000 ) / 1000;
					}
				}
			}
		}
		return $result;
	}
	
	/**
	 * Initialise globalement une campagne
	 *
	 * @param int $annee        	
	 * @return int $nb : nombre de poissons ajoutés
	 */
	function initCampagne($annee) {
		$nb = 0;
		if ($annee > 0) {
			/*
			 * recherche des adultes qui n'existent pas dans la table poisson_campagne pour l'annee consideree
			 */
			$sql = "select p.poisson_id from poisson p
				where categorie_id = 1 
				and poisson_statut_id = 1 
				and p.poisson_id not in (select c.poisson_id from poisson_campagne c where annee = " . $annee . ")";
			$liste = $this->getListeParam ( $sql );
			/*
			 * Traitement de chaque occurence de la liste
			 */
			foreach ( $liste as $key => $value ) {
				if ($this->initCampagnePoisson ( $value ["poisson_id"], $annee ) > 0)
					$nb ++;
			}
			return $nb;
		} else
			return 0;
	}
	/**
	 * Initialise une annee de campagne pour un poisson
	 *
	 * @param int $poisson_id        	
	 * @param int $annee        	
	 * @return int
	 */
	function initCampagnePoisson($poisson_id, $annee) {
		if ($poisson_id > 0 && $annee > 0) {
			/*
			 * Recherche s'il existe deja un enregistrement
			 */
			$exist = $this->lireFromPoissonAnnee ( $poisson_id, $annee );
			if (! $exist ["poisson_campagne_id"] > 0) {
				$data = array (
						"poisson_id" => $poisson_id,
						"annee" => $annee,
						"repro_statut_id" => 1 
				);
				/*
				 * Calcul du taux de croissance journalier
				 */
				$result = $this->txCroissanceJourCalcul ( $poisson_id, $annee );
				if (! is_null ( $result )) {
					// printr($result);
					$data ["tx_croissance_journalier"] = $result ["txCroissance"];
					$data ["specific_growth_rate"] = $result ["sgr"];
					$data ["masse"] = $result ["masse_actuelle"];
				}
				return $this->ecrire ( $data );
			}
		}
		return 0;
	}
	function lireFromPoissonAnnee($poisson_id, $annee) {
		if ($poisson_id > 0 && $annee > 0) {
			$sql = "select * from poisson_campagne 
					where poisson_id = " . $poisson_id . "
					and annee = " . $annee;
			return $this->lireParam ( $sql );
		} else
			return null;
	}
	
	/**
	 * retourne les poissons retenus pour une année
	 *
	 * @param array $param        	
	 * @return array number
	 */
	function getListForDisplay($param) {
		if ($param ["annee"] > 0) {
			$sql = "select poisson_campagne_id, poisson_id, 
					matricule, prenom, pittag_valeur, cohorte,
				tx_croissance_journalier, specific_growth_rate,
				sexe_libelle, sexe_libelle_court, masse,
				repro_statut_id, repro_statut_libelle
				
				from poisson p
				join poisson_campagne c using (poisson_id)
				join repro_statut using (repro_statut_id)
				left outer join sexe using (sexe_id)
				left outer join v_pittag_by_poisson using (poisson_id)";
			
			$where = " where annee = " . $param ["annee"];
			if ($param ["repro_statut_id"] > 0)
				$where .= " and repro_statut_id = " . $param ["repro_statut_id"];
			$order = " order by sexe_libelle, prenom";
			
			$liste = $this->getListeParam ( $sql . $where . $order );
			/*
			 * Rajout des années de croisement antérieures
			 */
			foreach ( $liste as $key => $value ) {
				$liste [$key] ["annees"] = $this->getAnneeCroisement ( $value ["poisson_id"] );
				$liste [$key] ["sequences"] = $this->getSequences ( $value ["poisson_id"], $annee );
			}
			return $liste;
		} else
			return - 1;
	}
	/**
	 * Recherche les années de croisement pour un poisson
	 *
	 * @param int $poisson_id        	
	 * @return string
	 */
	function getAnneeCroisement($poisson_id) {
		$annees = "";
		if ($poisson_id > 0) {
			$sql = "select distinct annee 
					from poisson_campagne 
					join poisson_croisement using(poisson_campagne_id)
					where poisson_id = " . $poisson_id . " 
					order by annee";
			$liste = $this->getListeParam ( $sql );
			$virgule = false;
			foreach ( $liste as $key => $value ) {
				$annees .= $value ["annee"];
				if ($virgule == true)
					$annees .= ",";
				else
					$virgule = true;
			}
		}
		return $annees;
	}
	/**
	 * Retourne les séquences auxquelles participe un poisson
	 *
	 * @param int $poisson_id        	
	 * @param int $annee        	
	 * @return string
	 */
	function getSequences($poisson_id, $annee) {
		$sequences = "";
		if ($poisson_id > 0 && $annee > 0) {
			$sql = "select distinct sequence_nom, sequence_date_debut
					from sequence s
					join poisson_sequence using (sequence_id) 
					join poisson_campagne using (poisson_campagne_id)
					where s.annee = " . $annee . " 
					and poisson_id = " . $poisson_id . " 
					order by sequence_date_debut, sequence_nom";
			$liste = $this->getListeParam ( $sql );
			$virgule = false;
			foreach ( $liste as $key => $value ) {
				$sequences .= $value ["sequence_nom"];
				if ($virgule == true)
					$sequences .= ",";
				else
					$virgule = true;
			}
		}
		return $sequences;
	}
	
	/**
	 * Retourne la liste des années de reproduction
	 *
	 * @return array
	 */
	function getAnnees() {
		$sql = "select distinct annee from poisson_campagne order by annee";
		return $this->getListeParam ( $sql );
	}
	
	/**
	 * Reecriture de la fonction lire, pour recuperer les informations liees
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::lire()
	 */
	function lire($id) {
		if ($id > 0) {
			$sql = "select poisson_campagne_id, poisson_id, matricule, prenom, pittag_valeur, cohorte,
				annee, tx_croissance_journalier, specific_growth_rate,
				sexe_libelle, sexe_libelle_court, masse,
				repro_statut_id, repro_statut_libelle
				
				from poisson p
				join poisson_campagne c using (poisson_id)
				join repro_statut using (repro_statut_id)
				left outer join sexe using (sexe_id)
				left outer join v_pittag_by_poisson using (poisson_id)
				where poisson_campagne_id = " . $id;
			return parent::lireParam ( $sql );
		} else
			return null;
	}
	/**
	 * Surcharge de la fonction ecrire, pour calculer les taux de croissance en cas de creation
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::ecrire()
	 */
	function ecrire($data) {
		$ok = false;
		if ($data ["poisson_id"] > 0 && $data ["annee"] > 0)
			$ok = true;
		if ($data ["poisson_campagne_id"] == 0 && $ok == true) {
			/*
			 * Recherche s'il existe deja un enregistrement
			 */
			$exist = $this->lireFromPoissonAnnee ( $data ["poisson_id"], $data ["annee"] );
			if (! $exist ["poisson_campagne_id"] > 0) {
				$result = $this->txCroissanceJourCalcul ( $data ["poisson_id"], $data ["annee"] );
				if (! is_null ( $result )) {
					$data ["tx_croissance_journalier"] = $result ["txCroissance"];
					$data ["specific_growth_rate"] = $result ["sgr"];
					$data ["masse"] = $result ["masse_actuelle"];
				}
			} else
				$ok = false;
		}
		if ($ok == true) {
			return parent::ecrire ( $data );
		} else
			return - 1;
	}
	
	/**
	 * Retourne la liste des campagnes de reproduction pour un poisson
	 *
	 * @param int $poisson_id        	
	 * @return tableau|NULL
	 */
	function getListFromPoisson($poisson_id) {
		if ($poisson_id > 0) {
			$sql = "select poisson_campagne_id, poisson_id, annee,
					masse, tx_croissance_journalier, specific_growth_rate,
					repro_statut_id, repro_statut_libelle
					from poisson_campagne
					join repro_statut using (repro_statut_id)
					where poisson_id = " . $poisson_id . "
					order by annee desc";
			return $this->getListeParam ( $sql );
		} else
			return null;
	}
	
	/**
	 * Change le statut du poisson
	 * 
	 * @param int $poisson_campagne_id        	
	 * @param int $repro_statut_id        	
	 * @return int
	 */
	function changeStatut($poisson_campagne_id, $repro_statut_id) {
		if ($poisson_campagne_id > 0 && $repro_statut_id > 0) {
			$data = parent::lire ( $poisson_campagne_id );
			$data ["repro_statut_id"] = $repro_statut_id;
			return $this->ecrire ( $data );
		} else
			return - 1;
	}

	/**
	 * Fonction permettant de restituer l'ensemble des temperatures des bassins frequentes par un poisson
	 * @param int $poisson_campagne_id
	 * @param int $annee
	 * @param int $profil_thermique_type_id
	 * @return array|NULL
	 */
	function getTemperatures($poisson_id, $annee, $profil_thermique_type_id = 1) {
		if ($poisson_id > 0 && $annee > 0) {
			$sql = "select pf_datetime, pf_temperature, poisson_id
					from v_poisson_campagne_profil_thermique
					where poisson_id = ".$poisson_id."
					and annee = ".$annee."
					and profil_thermique_type_id = ".$profil_thermique_type_id."
					order by pf_datetime";
			$data = $this->getListeParam($sql);
			/*
			 * Remise en forme des dates
			 */
			foreach ($data as $key => $value ) {
				$data[$key]["pf_datetime"] = $this->formatDateDBversLocal($value["pf_datetime"], 3); 
			}
			return $data;
		} else
			return null;
	}
}

/**
 * ORM de gestion de la table repro_statut
 *
 * @author quinton
 *        
 */
class ReproStatut extends ObjetBDD {
	public function __construct($p_connection, $param = NULL) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "repro_statut";
		$this->id_auto = "1";
		$this->colonnes = array (
				"repro_statut_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"repro_statut_libelle" => array (
						"type" => 0,
						"requis" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		
		parent::__construct ( $p_connection, $param );
	}
}

?>