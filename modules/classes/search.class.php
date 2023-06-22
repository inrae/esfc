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
	public $paramNum;
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
		$this->param ["isSearch"] = 0;
		if (is_array ( $this->paramNum ))
			$this->paramNum = array_flip ( $this->paramNum );
	}
	/**
	 * Stocke les parametres fournis
	 *
	 * @param array $data
	 *        	: tableau des valeurs, ou non de la variable
	 * @param string $valeur
	 *        	: valeur a renseigner, dans le cas ou la donnee est unique
	 */
	function setParam($data, $valeur = NULL) {
		if (is_array ( $data )) {
			/*
			 * Les donnees sont fournies sous forme de tableau
			 */
			foreach ( $this->param as $key => $value ) {
				/*
				 * Recherche si une valeur de $data correspond a un parametre
				 */
				if (isset ( $data [$key] )) {
					/*
					 * Recherche si la valeur doit etre numerique
					 */
					if (isset ( $this->paramNum [$key] )) {
						if (! is_numeric ( $data [$key] ))
							$data [$key] = "";
					}
					$this->param [$key] = $data [$key];
				}
			}
			/**
		 * Gestion de l'indicateur de recherche
		 */
		if ($data ["isSearch"] == 1)
			$this->isSearch = 1;
		} else {
			/*
			 * Une donnee unique est fournie
			 */
			if (isset ( $this->param [$data] ) && ! is_null ( $valeur )) {
				if (isset ( $this->paramNum [$data] )) {
					if (! is_numeric ( $valeur ))
						$valeur = "";
				}
				$this->param [$data] = $valeur;
			}
		}
	}
	/**
	 * Retourne les parametres existants
	 */
	function getParam() {
		// return $this->encodeData($this->param);
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
	
	/**
	 * Encode les donnees avant de les envoyer au navigateur
	 *
	 * @param array|string $data        	
	 * @return string|array
	 */
	function encodeData($data) {
		if (is_array ( $data )) {
			foreach ( $data as $key => $value ) {
				$data [$key] = $this->encodeData ( $value );
			}
		} else {
			$data = htmlspecialchars ( $data );
		}
		return $data;
	}
}
/**
 * Exemple d'instanciation
 *
 * @author Eric Quinton
 *        
 */
class SearchPoisson extends SearchParam {
	public $searchByEvent ;
	function __construct() {
		$this->param = array (
				"statut" => 1,
				"sexe" => "",
				"texte" => "",
				"categorie" => 1,
				"displayMorpho" => 0,
				"displayBassin" => 0,
				"displayCumulTemp" => 0,
				"dateDebutTemp" => date("d/m/").(date("Y")-1),
				"dateFinTemp" => date("d/m/Y"),
				"site_id" => $_SESSION["site_id"],
				"dateFromEvent" => date("d/m/").(date("Y")-1),
				"dateToEvent" => date("d/m/Y"),
				"eventSearch" =>""
		);
		$this->paramNum = array (
				"statut",
				"displayMorpho",
				"displayBassin",
				"categorie",
				"sexe",
				"displayCumulTemp",
				"site_id"
		);
		$this->searchByEvent = array (
			"morphologie"=>_("Morphologie"),
			"mortalite"=>_("Mortalite"),
			"parente"=>_("Détermination des parents"),
			"gender_selection"=>_("Détermination du sexe"),
			"pathologie"=>_("Pathologie"),
			"echographie"=>_("Échographie"),
			"dosage_sanguin"=>_("Dosage sanguin"),
			"anesthesie"=>_("Anesthésie"),
			"genetique"=>_("Génétique"),
			"transfert"=>_("Transfert")
		);
		asort($this->searchByEvent);

		parent::__construct ();
	}

	function getSearchByEvent() {
		return $this->searchByEvent;
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
				"bassin_actif" => "",
				"bassin_nom" =>"",
				"site_id"=> $_SESSION["site_id"]
		);
		$this->paramNum = array (
				"bassin_type",
				"bassin_usage",
				"bassin_zone",
				"circuit_eau",
				"bassin_actif",
				"site_id" 
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
				"limit" => 100,
				"site_id" => $_SESSION["site_id"]
		);
		$this->paramNum = array (
				"circuit_eau_actif",
				"offset",
				"limit",
				"site_id"
		);
		parent::__construct ();
	}
}
/**
 * Classe de recherche des anomalies détectées dans la base de données
 *
 * @author quinton
 *        
 */
class SearchAnomalie extends SearchParam {
	function __construct() {
		$this->param = array (
				"statut" => 0,
				"type" => 0 
		);
		$this->paramNum = array (
				"statut",
				"type" 
		);
		parent::__construct ();
		
	}
}
/**
 * Classe de recherche des modèles de répartition des aliments
 *
 * @author quinton
 *        
 */
class SearchRepartTemplate extends SearchParam {
	function __construct() {
		$this->param = array (
				"categorie_id" => 0,
				"actif" => - 1 
		);
		$this->paramNum = array (
				"categorie_id",
				"actif" 
		);
		parent::__construct ();
		
	}
}
/**
 * Classe de recherche des répartions d'aliments dans les bassins
 *
 * @author quinton
 *        
 */
class SearchRepartition extends SearchParam {
	function __construct() {
		$annee_prec = date ( 'Y' ) - 1;
		$this->param = array (
				"categorie_id" => 0,
				"date_reference" => date ( 'd/m/' ) . $annee_prec,
				"offset" => 0,
				"limit" => 10,
				"site_id"=> $_SESSION["site_id"]
		);
		$this->paramNum = array (
				"categorie_id",
				"offset",
				"limit",
				"site_id"
		);
		parent::__construct ();
		
	}
}
/**
 * Classe de recherche des aliments
 *
 * @author quinton
 *        
 */
class SearchAlimentation extends SearchParam {
	function __construct() {
		$date_debut = new DateTime ();
		date_sub ( $date_debut, new DateInterval ( "P30D" ) );
		$this->param = array (
				"date_debut" => date_format ( $date_debut, "d/m/Y" ),
				"date_fin" => date ( "d/m/Y" ) 
		);
		parent::__construct ();
		
	}
}

/**
 * Classe de recherche des poissons sélectionnés pour une repro
 *
 * @author quinton
 *        
 */
class SearchRepro extends SearchParam {
	function __construct() {
		$this->param = array (
				"annee" => date ( 'Y' ),
				"repro_statut_id" => 2,
				"site_id"=>$_SESSION["site_id"]
		);
		$this->paramNum = array (
				"annee",
				"repro_statut_id",
				"site_id"
		);
		parent::__construct ();
	}
}

/**
 * Parametres utilises pour generer l'alimentation des juveniles
 *
 * @author quinton
 *        
 */
class AlimJuv extends SearchParam {
	function __construct() {
		$this->param = array (
				"date_debut_alim" => date ( "d/m/Y" ),
				"duree" => 1,
				"densite" => 1500 
		);
		$this->paramNum = array (
				"duree",
				"densite" 
		);
		parent::__construct ();
	}
}
