<?php
require_once 'modules/classes/poisson.class.php';
/**
 *
 * @author quinton
 *        
 */
class poissonCampagne extends ObjetBDD {
	
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
						"requis" => 1 
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
			$masse_anterieure = $morphologie->getMasseBeforeDate ( $poisson_id, $masse_actuelle ["morphologie_date"] );
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
	function initCampagne($annee = NULL) {
		$nb = 0;
		if (is_null ( $annee ))
			$annee = getYear ();
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
			$data = array (
					"poisson_id" => $value ["poisson_id"],
					"annee" => $annee 
			);
			/*
			 * Calcul du taux de croissance journalier
			 */
			$result = $this->txCroissanceJourCalcul ( $value ["poisson_id"], $annee );
			if (! is_null ( $result )) {
				$data ["tx_croissance_journalier"] = $result ["txCroissance"];
				$data ["specific_growth_rate"] = $result ["sgr"];
			}
			if (parent::ecrire ( $data ) > 0)
				$nb ++;
		}
		return $nb;
	}
	
	/**
	 * retourne les poissons retenus pour une année
	 *
	 * @param int $annee        	
	 * @return array number
	 */
	function getListForDisplay($annee) {
		if ($annee > 0) {
			$sql = "select poisson_campagne_id, poisson_id, matricule, prenom, pittag_valeur, cohorte,
				tx_croissance_journalier, specific_growth_rate,
				sexe_libelle, sexe_libelle_court
				
				from poisson p
				join poisson_campagne c using (poisson_id)
				left outer join sexe using (sexe_id)
				left outer join v_pittag_by_poisson using (poisson_id)
				
				where annee = " . $annee . " 
				order by sexe_libelle, prenom
				";
			$liste = $this->getListeParam ( $sql );
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
				sexe_libelle, sexe_libelle_court
				
				from poisson p
				join poisson_campagne c using (poisson_id)
				left outer join sexe using (sexe_id)
				left outer join v_pittag_by_poisson using (poisson_id)
				where poisson_campagne_id = " . $id;
			return parent::lireParam ( $sql );
		} else
			return null;
	}
}

?>