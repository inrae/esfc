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
	/**
	 * Fonction permettant de retourner une liste de poissons selon les criteres specifies
	 *
	 * @param array $dataSearch        	
	 * @return array
	 */
	function getListeSearch($dataSearch) {
		if (is_array ( $dataSearch )) {
			$sql = "select poisson_id, sexe_id, matricule, prenom, cohorte, capture_date, sexe_libelle, sexe_libelle_court, poisson_statut_libelle,
					array_to_string(array_agg(pittag_valeur),' ') as pittag_valeur
					from " . $this->table . " natural join sexe
					  natural join poisson_statut
					  left outer join pittag using (poisson_id)";
			/*
			 * Preparation de la clause group by
			 */
			$group = " group by poisson_id, sexe_id, matricule, prenom, cohorte, capture_date, sexe_libelle, sexe_libelle_court, poisson_statut_libelle ";
			/*
			 * Preparation de la clause order
			 */
			$order = " order by prenom, cohorte ";
			/*
			 * Preparation de la clause where
			 */
			$where = " where ";
			$and = "";
			if ($dataSearch ["statut"] > 0) {
				$where .= $and . " poisson_statut_id = " . $dataSearch ["statut"];
				$and = " and ";
			}
			if ($dataSearch ["sexe"] > 0) {
				$where .= $and . " sexe_id = " . $dataSearch ["sexe"];
				$and = " and ";
			}
			if (strlen ( $dataSearch ["texte"] ) > 0) {
				$texte = "%" . mb_strtoupper ( $dataSearch ["texte"], 'UTF-8' ) . "%";
				$where .= $and . " (upper(matricule) like '" . $texte . "' 
						or upper(prenom) like '" . $texte . "' 
						or cohorte like '" . $texte . "' 
						or upper(pittag_valeur) like '" . $texte . "')";
			}
			if (strlen ( $where ) == 7)
				$where = "";
			return $this->getListeParam ( $sql . $where . $group . $order );
		}
	}
	/**
	 * Retourne le detail d'un poisson
	 *
	 * @param int $poisson_id        	
	 * @return array
	 */
	function getDetail($poisson_id) {
		if ($poisson_id > 0) {
			$sql = "select p.poisson_id, sexe_id, matricule, prenom, cohorte, capture_date, sexe_libelle, sexe_libelle_court, poisson_statut_libelle,
					pittag_valeur, p.poisson_statut_id,
					bassin_nom, b.bassin_id
					from " . $this->table . " p natural join sexe
					  natural join poisson_statut
					  left outer join v_pittag_by_poisson using (poisson_id)
					  left outer join v_transfert_last_bassin_for_poisson vlast on (vlast.poisson_id = p.poisson_id)
					  left outer join transfert t on (vlast.poisson_id = t.poisson_id and transfert_date_last = transfert_date)
					  left outer join bassin b on (b.bassin_id = (case when t.bassin_destination is not null then t.bassin_destination else t.bassin_origine end))
							";
			$where = " where p.poisson_id = " . $poisson_id;
			return $this->lireParam ( $sql . $where );
		}
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
	/**
	 * Reecriture de la fonction d'affichage de la liste
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::getListe()
	 */
	function getListe() {
		$sql = "select * from " . $this->table . " order by poisson_statut_id";
		return $this->getListeParam ( $sql );
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
	/**
	 * Retourne la liste des pittag attribués à un poisson
	 *
	 * @param int $poisson_id        	
	 * @return array
	 */
	function getListByPoisson($poisson_id) {
		if ($poisson_id > 0) {
			$sql = "select pittag_id, poisson_id, pittag_date_pose, pittag_valeur, pittag_type_libelle
					from pittag
					left outer join pittag_type using (pittag_type_id)
					where poisson_id = " . $poisson_id . " order by pittag_date_pose desc";
			return $this->getListeParam ( $sql );
		}
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
	/**
	 * Fonction retournant la liste des donnees morphologiques pour un poisson
	 *
	 * @param int $poisson_id        	
	 * @return array
	 */
	function getListeByPoisson($poisson_id) {
		if ($poisson_id > 0) {
			$sql = "select morphologie_id, m.poisson_id, longueur_fourche, longueur_totale, masse, morphologie_date, morphologie_commentaire, 
					m.evenement_id, evenement_type_libelle
					from morphologie m
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					where m.poisson_id = " . $poisson_id . " order by morphologie_date desc";
			return $this->getListeParam ( $sql );
		}
	}
	/**
	 * Lit un enregistrement à partir de l'événement
	 *
	 * @param int $evenement_id        	
	 * @return array
	 */
	function getDataByEvenement($evenement_id) {
		if ($evenement_id > 0) {
			$sql = "select * from morphologie where evenement_id = " . $evenement_id;
			return $this->lireParam ( $sql );
		}
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
		$this->paramori = $param;
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
				"pathologie_date" => array (
						"type" => 2 
				),
				"pathologie_commentaire" => array (
						"type" => 0 
				),
				"evenement_id" => array (
						"type" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Retourne la liste des pathologies pour un poisson
	 *
	 * @param unknown $poisson_id        	
	 * @return Ambigous <tableau, boolean, $data, string>
	 */
	function getListByPoisson($poisson_id) {
		if ($poisson_id > 0) {
			$sql = "select pathologie_id, patho.poisson_id, pathologie_date, pathologie_commentaire,
					pathologie_type_libelle, evenement_type_libelle, patho.evenement_id
					from pathologie patho
					left outer join pathologie_type using (pathologie_type_id)
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					where patho.poisson_id = " . $poisson_id . " order by pathologie_date desc";
			return $this->getListeParam ( $sql );
		}
	}
	/**
	 * Lit un enregistrement à partir de l'événement
	 *
	 * @param unknown $evenement_id        	
	 * @return Ambigous <multitype:, boolean, $data, string>
	 */
	function getDataByEvenement($evenement_id) {
		if ($evenement_id > 0) {
			$sql = "select * from pathologie where evenement_id = " . $evenement_id;
			return $this->lireParam ( $sql );
		}
	}
	/**
	 * Complement de la fonction ecrire, pour forcer le statut a mort 
	 * pour le poisson en cas de type de pathologie : mortalite
	 * (non-PHPdoc)
	 * @see ObjetBDD::ecrire()
	 */
	function ecrire($data) {
		$pathologie_id = parent::ecrire($data);
		/*
		 * Traitement de la mortalite - ecriture du statut mort dans le poisson
		 */
		if ($pathologie_id > 0 && $data["pathologie_type_id"] == 5) {
			$poisson = new Poisson($this->connection, $this->paramori);
			$dataPoisson = $poisson->lire($data["poisson_id"]);
			$dataPoisson["poisson_statut_id"] = 3;
			$poisson->ecrire($dataPoisson);
		}  
		return ($pathologie_id);
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
	/**
	 * Reecriture de la fonction pour trier la liste
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::getListe()
	 */
	function getListe() {
		$sql = 'select * from ' . $this->table . ' order by pathologie_type_libelle';
		return $this->getListeParam ( $sql );
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
		$this->id_auto = 1;
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
		$this->paramori = $param;
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
	/**
	 * Surcharge de la fonction ecrire, pour mettre a jour le sexe dans l'enregistrement poisson, le cas echeant
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::ecrire()
	 */
	function ecrire($data) {
		$ret = parent::ecrire ( $data );
		if ($ret > 0 && $data ["poisson_id"] > 0) {
			$maj = 0;
			$poisson = new Poisson ( $this->connection, $this->paramori );
			$dataPoisson = $poisson->lire ( $data ["poisson_id"] );
			/*
			 * S'il s'agit d'une determination expert, on force le sexe
			 */
			if ($data ["gender_methode_id"] == 1)
				$maj = 1;
			else {
				/*
				 * Si le sexe n'est pas precisé, on met à jour
				 */
				if (is_null ( $dataPoisson ["sexe_id"] ))
					$maj = 1;
				else {
					/*
					 * On recherche si l'enregistrement est le plus recent et s'il n'existe pas une determination expert antérieure
					 */
					$date_ref = $this->formatDateLocaleVersDB ( $data ["gender_selection_date"], 2 );
					$sql = "select count(*) as nb from gender_selection
					where (gender_selection_date > '" . $date_ref . "' or gender_methode_id = 1 )
					and poisson_id = " . $data ["poisson_id"] . " and gender_selection_id != " . $ret;
					$requete = $this->lireParam ( $sql );
					if ($requete ["nb"] == 0)
						$maj = 1;
				}
				/*
				 * Mise a jour le cas echeant de l'enregistrement du poisson
				 */
				if ($maj == 1) {
					$dataPoisson ["sexe_id"] = $data ["sexe_id"];
					$poisson->ecrire ( $dataPoisson );
				}
			}
		}
		return $ret;
	}
	/**
	 * Recupère la liste des déterminations sexuelles pour un poisson
	 *
	 * @param int $poisson_id        	
	 * @return array
	 */
	function getListByPoisson($poisson_id) {
		if ($poisson_id > 0) {
			$sql = "select gender_selection_id, g.poisson_id, gender_selection_date, gender_selection_commentaire,
					gender_methode_libelle, sexe_libelle_court, sexe_libelle, g.evenement_id,
					evenement_type_libelle
					from gender_selection g
					left outer join gender_methode using (gender_methode_id)
					left outer join sexe using (sexe_id)
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					where g.poisson_id = " . $poisson_id . " order by gender_selection_date desc";
			return $this->getListeParam ( $sql );
		}
	}
	/**
	 * Lit un enregistrement à partir de l'événement
	 *
	 * @param int $evenement_id        	
	 * @return array
	 */
	function getDataByEvenement($evenement_id) {
		if ($evenement_id > 0) {
			$sql = "select * from gender_selection where evenement_id = " . $evenement_id;
			return $this->lireParam ( $sql );
		}
	}
}
/**
 * ORM de gestion de la table Transfert
 *
 * @author quinton
 *        
 */
class Transfert extends ObjetBDD {
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
		$this->table = "transfert";
		$this->id_auto = "1";
		$this->colonnes = array (
				"transfert_id" => array (
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
				"bassin_origine" => array (
						"type" => 1 
				),
				"bassin_destination" => array (
						"type" => 1 
				),
				"transfert_date" => array (
						"type" => 2,
						"requis" => 1 
				),
				"evenement_id" => array (
						"type" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Retourne la liste des transferts pour un poisson
	 *
	 * @param int $poisson_id        	
	 * @return array
	 */
	function getListByPoisson($poisson_id) {
		if ($poisson_id > 0) {
			$sql = 'select transfert_id, transfert.poisson_id, bassin_origine, bassin_destination, transfert_date, evenement_id,
					ori.bassin_nom as "bassin_origine_nom", dest.bassin_nom as "bassin_destination_nom",
					evenement_id, evenement_type_libelle
					from transfert
					join poisson using (poisson_id)
					left outer join bassin ori on (bassin_origine = ori.bassin_id)
					left outer join bassin dest on (bassin_destination = dest.bassin_id)
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					where transfert.poisson_id = ' . $poisson_id . " order by transfert_date desc";
			return $this->getListeParam ( $sql );
		}
	}
	/**
	 * Calcule la liste des poissons presents dans un bassin
	 * @param int $bassin_id
	 * @return array
	 */
	function getListPoissonPresentByBassin($bassin_id) {
		if ($bassin_id > 0) {
			$sql = 'select distinct t.poisson_id,matricule, prenom, t.transfert_date,  
					(case when t.bassin_destination is not null then t.bassin_destination else t.bassin_origine end) as "bassin_id",
					bassin_nom, sexe_libelle_court
 					from transfert t
 					join v_transfert_last_bassin_for_poisson v on (v.poisson_id = t.poisson_id and transfert_date_last = transfert_date)
					join bassin on (bassin.bassin_id = (case when t.bassin_destination is not null then t.bassin_destination else t.bassin_origine end))
					join poisson on (t.poisson_id = poisson.poisson_id)
					left outer join sexe using (sexe_id)
					where  poisson_statut_id not in (3, 4) and bassin.bassin_id = '.$bassin_id."
 					order by matricule";
		}
		return ($this->getListeParam($sql));
	}
	/**
	 * Lit un enregistrement à partir de l'événement
	 *
	 * @param int $evenement_id
	 * @return array
	 */
	function getDataByEvenement($evenement_id) {
		if ($evenement_id > 0) {
			$sql = "select * from transfert where evenement_id = " . $evenement_id;
			return $this->lireParam ( $sql );
		}
	}
	/**
	 * Complement de la fonction ecrire pour mettre a jour le statut de l'animal, 
	 * en cas de transfert dans un bassin adulte
	 * (non-PHPdoc)
	 * @see ObjetBDD::ecrire()
	 */
	function ecrire($data) {
		$transfert_id = parent::ecrire($data);
		if ($transfert_id > 0 && $data["bassin_destination"] > 0 && $data["poisson_id"] > 0) {
			/*
			 * Recuperation de l'usage du bassin
			 */
			$bassin = new Bassin($this->connection, $this->paramori);
			$dataBassin = $bassin->lire($data["bassin_destination"]);
			if ($dataBassin["bassin_usage_id"] == 1) {
				/*
				 * Recuperation du poisson
				 */
				$poisson = new Poisson($this->connection, $this->paramori);
				$dataPoisson = $poisson->lire($data["poisson_id"]);
				if ($dataPoisson["poisson_statut_id"] == 2) {
					$dataPoisson["poisson_statut_id"] = 1;
					$poisson->ecrire($dataPoisson);
				}
			}
		}
		return $transfert_id;
	}
}
?>