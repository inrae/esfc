<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 23 mars 2015
 */
/**
 * ORM de gestion de la table injection
 * @author quinton
 *
 */
class Injection extends ObjetBDD {
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "injection";
		$this->id_auto = "1";
		$this->colonnes = array (
				"injection_id" => array (
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
				"hormone_id" => array("type"=>1),
				"injection_date" => array (
						"type" => 3,
						"requis" => 1,
						"defaultValue" => "getDateJour" 
				),
				"injection_dose" => array ("type"=>1),
				"injection_commentaire" => array("type"=>0)
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}

	/**
	 * Retourne la liste des injections pour un poisson
	 * @param int $poisson_campagne_id
	 * @return tableau|NULL
	 */
	function getListFromPoissonCampagne($poisson_campagne_id) {
		if ($poisson_campagne_id > 0) {
			$sql = "select injection_id, poisson_campagne_id, sequence_id, injection_date,
					sequence_nom, injection_dose, injection_commentaire,
					hormone_id, hormone_nom, hormone_unite
					from injection
					join sequence using (sequence_id)
					left outer join hormone using (hormone_id)
					where poisson_campagne_id = ".$poisson_campagne_id."
					order by injection_date";
			return $this->getListeParam($sql);
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
		$dateTime = explode ( " ", $data ["injection_date"] );
		$data ["injection_date"] = $dateTime [0];
		$data ["injection_time"] = $dateTime [1];
		return $data;
	}
	
	/**
	 * Surcharge de la fonction ecrire pour reconstituer le champ injection_date
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::ecrire()
	 */
	function ecrire($data) {
		$data ["injection_date"] = $data ["injection_date"] . " " . $data ["injection_time"];
		return parent::ecrire ( $data );
	}
	
}

class Hormone extends ObjetBDD {
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "hormone";
		$this->id_auto = "1";
		$this->colonnes = array (
				"hormone_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0
				),			
				"hormone_nom" => array (
						"type" => 0,
						"requis" => 1
				),
				"hormone_unite" => array (
						"type" => 0			
				)
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	
}

?>