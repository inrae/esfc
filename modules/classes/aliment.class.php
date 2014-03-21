<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 19 mars 2014
 */
/**
 * ORM de la table aliment_type
 *
 * @author quinton
 *        
 */
class AlimentType extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "aliment_type";
		$this->id_auto = 1;
		$this->colonnes = array (
				"aliment_type_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"aliment_type_libelle" => array (
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
 * ORM de la table aliment
 *
 * @author quinton
 *        
 */
class Aliment extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "aliment";
		$this->id_auto = 1;
		$this->colonnes = array (
				"aliment_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"aliment_libelle" => array (
						"type" => 0,
						"requis" => 1 
				),
				"aliment_type_id" => array (
						"type" => 1,
						"requis" => 1 
				),
				"actif" => array (
						"type" => 1,
						"defaultValue" => 1,
						"requis" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	function ecrire($data) {
		$id = parent::ecrire ( $data );
		if ($id > 0) {
			/*
			 * Traitement des categories rattachees
			 */
			$this->ecrireTableNN ( "aliment_categorie", "aliment_id", "categorie_id", $id, $data ["categorie"] );
		}
		return $id;
	}
	
	/**
	 * Retourne la liste des aliments actuellement utilisés
	 *
	 * @return array
	 */
	function getListeActif() {
		$sql = "select * from " . $this->table . " where actif = 1 order by aliment_libelle";
		return $this->getListeParam ( $sql );
	}
	/**
	 * Reecriture de la recuperation de la liste
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::getListe()
	 */
	function getListe() {
		$sql = "select * from " . $this->table . " 
				natural join aliment_type
				order by aliment_libelle";
		return $this->getListeParam ( $sql );
	}
}
/**
 * ORM de gestion de la table categorie
 *
 * @author quinton
 *        
 */
class Categorie extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "categorie";
		$this->id_auto = 1;
		$this->colonnes = array (
				"categorie_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"categorie_libelle" => array (
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
class AlimentCategorie extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "aliment_categorie";
		$this->id_auto = 1;
		$this->colonnes = array (
				"aliment_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1 
				),
				"categorie_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Retourne la liste des categories pour un aliment
	 *
	 * @param int $aliment_id        	
	 * @return array
	 */
	function getListeFromAliment($aliment_id) {
		if ($aliment_id > 0) {
			$sql = "select * from " . $this->table . "
				where aliment_id = " . $aliment_id;
			return $this->getListeParam ( $sql );
		}
	}
}
class RepartTemplate extends ObjetBDD {
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
		$this->table = "repart_template";
		$this->id_auto = 1;
		$this->colonnes = array (
				"repart_template_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"categorie_id" => array (
						"type" => 1,
						"requis" => 1 
				),
				"repart_template_libelle" => array (
						"type" => 0 
				),
				"repart_template_date" => array (
						"type" => 2,
						"requis" => 1,
						"defaultValue" => "getDateJour" 
				),
				"actif" => array (
						"type" => 1,
						"defaultValue" => 1,
						"requis" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Recherche des modèles selon les parametres fournis
	 *
	 * @param array $param        	
	 * @return array
	 */
	function getListSearch($param) {
		$sql = "select * from " . $this->table . "
				left outer join categorie using (categorie_id)";
		$order = " order by repart_template_date desc";
		$and = "";
		$where = "";
		if ($param ["categorie_id"] > 0) {
			$where .= $and . $this->table . ".categorie_id = " . $param ["categorie_id"];
			$and = " and ";
		}
		if ($param ["actif"] > - 1) {
			$where .= $and . " actif = " . $param ["actif"];
			$and = " and ";
		}
		if ($and == " and ")
			$where = " where " . $where;
		return ($this->getListeParam ( $sql . $where . $order ));
	}
	/**
	 * Surcharge de la fonction supprimer pour effacer les répartitions d'aliment
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::supprimer()
	 */
	function supprimer($id) {
		if ($id > 0) {
			/*
			 * Verification que le modele n'a pas été utilisé
			 */
			$sql = "select count(*) as nb from distribution where repart_template_id = " . $id;
			$rs = $this->getListeParam ( $sql );
			if ($rs [0] ["nb"] == 0) {
				/*
				 * Suppression des répartitions d'aliments attachées
				 */
				$repartAliment = new RepartAliment ( $this->connection, $this->paramori );
				$repartAliment->deleteFromField ( $id, "repart_template_id" );
				return parent::supprimer ( $id );
			} else
				return - 1;
		} else
			return - 1;
	}
	/**
	 * Retourne les modèles actifs pour la catégorie considérée
	 * @param int $categorie_id
	 * @return array
	 */
	function getListActifFromCategorie ($categorie_id) {
		if ($categorie_id > 0) {
			$sql = "select * from ".$this->table."
					where actif = 1 
					and categorie_id = ".$categorie_id."
					order by repart_template_date desc";
			return $this->getListeParam($sql);
		}
	}
}
/**
 * ORM de gestion de la table repart_aliment
 *
 * @author quinton
 *        
 */
class RepartAliment extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
	 * @param adobb $bdd        	
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "repart_aliment";
		$this->id_auto = 1;
		$this->colonnes = array (
				"repart_aliment_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"repart_template_id" => array (
						"type" => 1,
						"requis" => 1,
						"parentAttrib" => 1 
				),
				"aliment_id" => array (
						"type" => 1,
						"requis" => 1 
				),
				"consigne" => array (
						"type" => 0 
				),
				"repart_alim_taux" => array (
						"type" => 1 
				),
				"matin" => array (
						"type" => 1,
						"defaultValue" => 100 
				),
				"midi" => array (
						"type" => 1 
				),
				"soir" => array (
						"type" => 1 
				),
				"nuit" => array (
						"type" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Retourne les aliments associes a un template
	 *
	 * @param int $templateId        	
	 * @return array
	 */
	function getFromTemplate($templateId) {
		if ($templateId > 0) {
			$sql = "select * from " . $this->table . "
				join aliment using (aliment_id)
				where repart_template_id = " . $templateId . " 
				order by repart_alim_taux desc, aliment_libelle
				";
			return $this->getListeParam ( $sql );
		}
	}
	/**
	 * Retourne les aliments associes a un template,
	 * ainsi que les aliments non associes mais du meme type
	 *
	 * @param int $templateId        	
	 * @param int $categorieId        	
	 * @return array
	 */
	function getFromTemplateWithAliment($templateId, $categorieId) {
		if ($templateId > 0) {
			$data = $this->getFromTemplate ( $templateId );
			/*
			 * Recuperation des aliments du même type
			 */
			if ($categorieId > 0) {
				$sql = "select distinct aliment_id, aliment_type_id, aliment_libelle
						from aliment 
						join aliment_categorie using (aliment_id)
						where actif = 1 
						and categorie_id = " . $categorieId . "
						and aliment_id not in 
						(select aliment_id from repart_aliment where repart_template_id = " . $templateId . ")
						order by aliment_libelle";
				$dataAliment = $this->getListeParam ( $sql );
				/*
				 * Rajout des aliments à la liste
				 */
				foreach ( $dataAliment as $key => $value ) {
					$value ["repart_aliment_id"] = 0;
					$data [] = $value;
				}
				return $data;
			}
		}
	}
}
class Repartition extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
	 * @param adobb $bdd        	
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "repartition";
		$this->id_auto = 1;
		$this->colonnes = array (
				"repartition_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"categorie_id" => array (
						"type" => 1,
						"requis" => 1 
				),
				"date_debut_periode" => array (
						"type" => 2,
						"requis" => 1 
				),
				"date_fin_periode" => array (
						"type" => 2,
						"requis" => 1 
				),
				"lundi" => array (
						"type" => 1 
				),
				"mardi" => array (
						"type" => 1 
				),
				"mercredi" => array (
						"type" => 1 
				),
				"jeudi" => array (
						"type" => 1 
				),
				"vendredi" => array (
						"type" => 1 
				),
				"samedi" => array (
						"type" => 1 
				),
				"dimanche" => array (
						"type" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Recherche des repartions d'aliments à partir des paramètres fournis
	 *
	 * @param array $param        	
	 * @return array
	 */
	function getListSearch($param) {
		$sql = "select * from " . $this->table . "
				join categorie using (categorie_id)";
		$where = "";
		$and = "";
		if ($param ["categorie_id"] > 0) {
			$where .= $and . "categorie_id = " . $param ["categorie_id"];
			$and = " and ";
		}
		if (strlen ( $param ["date_reference"] ) > 0) {
			$date_reference = $this->formatDateLocaleVersDB ( $param ["date_reference"], 2 );
			$where .= $and . "date_fin_periode >= '" . $date_reference . "'";
			$and = " and ";
		}
		if ($and = " and ")
			$where = "where " . $where;
		$order = " order by date_debut_periode desc LIMIT " . $param ["limit"] . " OFFSET " . $param ["offset"];
		return $this->getListeParam ( $sql . $where . $order );
	}
	/**
	 * Surcharge de la fonction ecrire
	 * (non-PHPdoc)
	 * 
	 * @see ObjetBDD::ecrire()
	 */
	function ecrire($data) {
		/*
		 * Verification de l'existence des donnees "jour" - saisie checkbox
		 */
		if (! isset ( $data ["lundi"] ))
			$data ["lundi"] = 0;
		if (! isset ( $data ["mardi"] ))
			$data ["mardi"] = 0;
		if (! isset ( $data ["mercredi"] ))
			$data ["mercredi"] = 0;
		if (! isset ( $data ["jeudi"] ))
			$data ["jeudi"] = 0;
		if (! isset ( $data ["vendredi"] ))
			$data ["vendredi"] = 0;
		if (! isset ( $data ["samedi"] ))
			$data ["samedi"] = 0;
		if (! isset ( $data ["dimanche"] ))
			$data ["dimanche"] = 0;
		$id = parent::ecrire ( $data );
		if ($id > 0) {
			/*
			 * Traitement de la table liee
			 */
		}
		return $id;
	}
}
class Distribution extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
	 * @param adobb $bdd        	
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "distribution";
		$this->id_auto = 1;
		$this->colonnes = array (
				"distribution_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"repartition_id" => array (
						"type" => 1,
						"requis" => 1,
						"parentAttrib" => 1 
				),
				"bassin_id" => array (
						"type" => 1,
						"requis" => 1 
				),
				"repart_template_id" => array (
						"type" => 2,
						"requis" => 1 
				),
				"taux_nourrissage_precedent" => array (
						"type" => 1 
				),
				"reste_precedent" => array (
						"type" => 1 
				),
				"evol_taux_nourrissage" => array (
						"type" => 1 
				),
				"taux_nourrissage" => array (
						"type" => 1 
				),
				"total_distribue" => array (
						"type" => 1 
				),
				"distribution_masse" => array (
						"type" => 1 
				),
				"distribution_consigne" => array (
						"type" => 0 
				),
				"ration_commentaire" => array (
						"type" => 0 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * 
	 * @param unknown $repartition_id
	 */
	function getFromRepartition ($repartition_id) {
		$sql = "select * from ".$this->table."
				join bassin using (bassin_id)
				where repartition_id = ".$repartition_id."
				order by bassin_nom";
		return $this->getListeParam($sql);
	}
	/**
	 * Retourne la liste des bassins associés à une répartition,
	 * avec les bassins qui peuvent en faire également partie
	 * @param int $repartition_id
	 * @param int $categorie_id
	 * @return array
	 */
	function getFromRepartitionWithBassin($repartition_id, $categorie_id) {
		if ($repartition_id > 0) {
			$data = $this->getFromRepartition ( $repartition_id );
			/*
			 * Recuperation des bassins du même type
			*/
			if ($categorie_id > 0) {
				$sql = "select distinct bassin_id, bassin_nom
						from bassin
						join bassin_usage using (bassin_usage_id)
						where actif = 1
						and categorie_id = " . $categorie_id . "
						and bassin_id not in
						(select bassin_id from ".$this->table." where repartition_id = " . $repartition_id . ")
						order by bassin_nom";
				$dataBassin = $this->getListeParam ( $sql );
				/*
				 * Rajout des bassins à la liste
				*/
				foreach ( $dataBassin as $key => $value ) {
					$value ["distribution_id"] = 0;
					$data [] = $value;
				}
				return $data;
			}
		}
	}
}
?>