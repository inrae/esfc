<?php
/**
 * Classe de base pour gerer des parametres de recherche
* Classe non instanciable, a heriter
* L'instance doit etre conservee en variable de session
* @author Eric Quinton
*
*/
class SearchParam {
	/**
	 * Tableau des parametres geres par la classe
	 * La liste des parametres doit etre declaree dans la fonction construct
	 * 
	 * @var array
	 */
	public $param;
	/**
	 * Indique si la lecture des parametres a ete realisee au moins une fois
	 * Permet ainsi de declencher ou non la recherche
	 * 
	 * @var int
	 */
	public $isSearch;
	/**
	 * Constructeur de la classe
	 * A rappeler systematiquement pour initialiser isSearch
	 */
	function __construct() {
		if (! is_array ( $this->param ))
			$this->param = array ();
		$this->isSearch = 0;
	}
	/**
	 * Stocke les parametres fournis
	 * 
	 * @param array $data : tableau des valeurs, ou non de la variable
	 * @param string $valeur : valeur a renseigner, dans le cas ou la donnee est unique       	
	 */
	function setParam($data, $valeur=NULL) {
		if (is_array($data)) {
			/*
			 * Les donnees sont fournies sous forme de tableau
			 */
		foreach ( $this->param as $key => $value ) {
			/*
			 * Recherche si une valeur de $data correspond a un parametre
			 */
			if (isset ( $data [$key] ))
				$this->param [$key] = $data [$key];
		}
		} else {
			/*
			 * Une donnee unique est fournie
			 */
			if (isset($this->param[$data]) && !is_null($valeur)) $this->param[$data] = $valeur;
		}
		/*
		 * Gestion de l'indicateur de recherche
		 */
		if ($data ["isSearch"] == 1)
			$this->isSearch = 1;
	}
	/**
	 * Retourne les parametres existants
	 */
	function getParam() {
		return $this->param;
	}
	/**
	 * Indique si la recherche a ete deja lancee
	 * 
	 * @return int
	 */
	function isSearch() {
		if ($this->isSearch == 1) {
			return 1;
		} else {
			return 0;
		}
	}
}
/**
 * Exemple d'instanciation
 * 
 * @author Eric Quinton
 *        
 */
class SearchPoisson extends SearchParam {
	function __construct() {
		$this->param = array (
				"statut" => "",
				"sexe" => "",
				"texte" => "" 
		);
		parent::__construct ();
	}
}
/**
 * Classe de recherche des bassins
 * 
 * @author quinton
 *        
 */
class SearchBassin extends SearchParam {
	function __construct() {
		$this->param = array (
				"bassin_type" => "",
				"bassin_usage" => "",
				"bassin_zone" => "",
				"circuit_eau" => "",
				"bassin_actif" => "" 
		);
		parent::__construct ();
	}
}
/**
 * Classe de recherche des circuits d'eau
 * 
 * @author quinton
 *        
 */
class SearchCircuitEau extends SearchParam {
	function __construct() {
		$this->param = array (
				"circuit_eau_libelle" => "",
				"circuit_eau_actif" => 1,
				"analyse_date" => date ( 'd/m/Y' ),
				"offset" => 0,
				"limit" => 100
		);
	}
}
/**
 * Classe de recherche des anomalies détectées dans la base de données
 * @author quinton
 *
 */
class SearchAnomalie extends SearchParam {
	function __construct() {
		$this->param = array(
			"statut" => 0,
			"type" => 0
		);
	}
}
?>