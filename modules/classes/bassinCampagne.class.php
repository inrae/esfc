<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 10 mars 2015
 */

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
		if ($annee > 0) {
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
	 * @param int $annee
	 * @return tableau|NULL
	 */
	function getListFromAnnee($annee) {
		if ($annee > 0) {
			$sql = "select bassin_id, bassin_campagne_id, annee, bassin_nom
					from bassin_campagne
					join bassin using (bassin_id)
					where annee = " . $annee . "
					order by bassin_nom";
			return $this->getListeParam ( $sql );
		} else
			return null;
	}
}

?>