<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 *  Creation 18 févr. 2014
 */
/**
 * ORM de gestion de la table poisson
 * 
 * @author quinton
 *        
 */
class Poisson extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 * 
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "poisson";
		$this->id_auto = "1";
		$this->colonnes = array (
				"poisson_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"poisson_statut_id" => array (
						"type" => 1,
						"requis" => 1 
				),
				"sexe_id" => array (
						"type" => 1,
						"requis" => 1 
				),
				"matricule" => array (
						"type" => 0 
				),
				"prenom" => array (
						"type" => 0 
				),
				"cohorte" => array (
						"type" => 0 
				),
				"capture_date" => array (
						"type" => 2 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
}
/**
 * ORM de la table poisson_statut
 * 
 * @author quinton
 *        
 */
class Poisson_statut extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 * 
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "poisson_statut";
		$this->id_auto = "1";
		$this->colonnes = array (
				"poisson_statut_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"poisson_statut_libelle" => array (
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
 * ORM de la table pittag_type
 * 
 * @author quinton
 *        
 */
class Pittag_type extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 * 
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "pittag_type";
		$this->id_auto = "1";
		$this->colonnes = array (
				"pittag_type_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"pittag_type_libelle" => array (
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
 * ORM de gestion de la table pittag
 * 
 * @author quinton
 *        
 */
class Pittag extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 * 
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "pittag";
		$this->id_auto = "1";
		$this->colonnes = array (
				"pittag_id" => array (
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
				"pittag_date_pose" => array (
						"type" => 2 
				),
				"pittag_type_id" => array (
						"type" => 1 
				),
				"pittag_valeur" => array (
						"type" => 0 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
}
/**
 * ORM de gestion de la table morphologie
 * 
 * @author quinton
 *        
 */
class Morphologie extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 * 
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "morphologie";
		$this->id_auto = "1";
		$this->colonnes = array (
				"morphologie_id" => array (
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
				"longueur_fourche" => array (
						"type" => 1 
				),
				"longueur_totale" => array (
						"type" => 1 
				),
				"masse" => array (
						"type" => 1 
				),
				"morphologie_date" => array (
						"type" => 2 
				),
				"evenement_id" => array (
						"type" => 1 
				),
				"morphologie_commentaire" => array (
						"type" => 0 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
}
/**
 * ORM de gestion de la table pathologie
 * 
 * @author quinton
 *        
 */
class Pathologie extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 * 
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "pathologie";
		$this->id_auto = "1";
		$this->colonnes = array (
				"pathologie_id" => array (
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
				"pathologie_type_id" => array (
						"type" => 1,
						"requis" => 1 
				),
				"pathlogie_date" => array (
						"type" => 2 
				),
				"pathologie_commentaire" => array (
						"type" => 0 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
}
/**
 * ORM de la table pathologie_type
 * 
 * @author quinton
 *        
 */
class Pathologie_type extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 * 
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "pathologie_type";
		$this->id_auto = "1";
		$this->colonnes = array (
				"pathologie_type_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"pathologie_type_libelle" => array (
						"type" => 0,
						"requis" => 1 
				),
				"pathologie_type_libelle_court" => array (
						"type" => 0 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
}
/**
 * ORM de la table sexe
 * 
 * @author quinton
 *        
 */
class Sexe extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 * 
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "sexe";
		$this->id_auto = "1";
		$this->colonnes = array (
				"sexe_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"sexe_libelle" => array (
						"type" => 0,
						"requis" => 1 
				),
				"sexe_libelle_court" => array (
						"type" => 0 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
}
/**
 * ORM de la table gender_methode
 * 
 * @author quinton
 *        
 */
class Gender_methode extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 * 
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "gender_methode";
		$this->id_auto = "1";
		$this->colonnes = array (
				"gender_methode_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"gender_methode_libelle" => array (
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
 * ORM de gestion de la table gender_selection
 * 
 * @author quinton
 *        
 */
class Gender_selection extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 * 
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "gender_selection";
		$this->id_auto = "1";
		$this->colonnes = array (
				"gender_selection_id" => array (
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
				"gender_methode_id" => array (
						"type" => 1 
				),
				"sexe_id" => array (
						"type" => 1 
				),
				"gender_selection_date" => array (
						"type" => 2 
				),
				"evenement_id" => array (
						"type" => 1 
				),
				"gender_selection_commentaire" => array (
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