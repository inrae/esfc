<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 19 mars 2014
 */
include_once 'modules/classes/categorie.class.php';
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
		$this->paramori = $param;
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
				"aliment_libelle_court" => array (
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
	 * Surcharge de la fonction supprimer() pour effacer les enregistrements dans aliment_categorie
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::supprimer()
	 */
	function supprimer($id) {
		if ($id > 0) {
			/*
			 * Suppression des rattachements aux catégories
			 */
			$alimentCategorie = new AlimentCategorie ( $this->connection, $this->paramori );
			$alimentCategorie->supprimerChamp ( $id, "aliment_id" );
			return parent::supprimer ( $id );
		}
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
	 *
	 * @param int $categorie_id        	
	 * @return array
	 */
	function getListActifFromCategorie($categorie_id) {
		if ($categorie_id > 0) {
			$sql = "select * from " . $this->table . "
					where actif = 1 
					and categorie_id = " . $categorie_id . "
					order by repart_template_libelle";
			return $this->getListeParam ( $sql );
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
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Lit un enregistrement avec les tables de parametres liees
	 *
	 * @param int $id        	
	 * @return array
	 */
	function lireWithCategorie($id) {
		if ($id > 0)
			$sql = "select * from " . $this->table . " left outer join categorie using (categorie_id)
					 where repartition_id = " . $id;
		return $this->lireParam ( $sql );
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
	 * Recopie les donnees dans une nouvelle repartition
	 * @param int $id
	 * @return int
	 */
	function duplicate($id) {
		if ($id > 0) {
			/*
			 * Lecture des infos précédentes
			 */
			$dataPrec = $this->lire ( $id );
			if ($dataPrec ["repartition_id"] > 0) {
				$err = 0;
				$data = $dataPrec;
				$data ["repartition_id"] = 0;
				/*
				 * Calcul des dates
				 */
				$datePrec = DateTime::createFromFormat ( "d/m/Y", $data ["date_fin_periode"] );
				$datePrec->add ( new DateInterval ( "P1D" ) );
				$data ["date_debut_periode"] = $datePrec->format ( "d/m/Y" );
				$datePrec->add ( new DateInterval ( "P6D" ) );
				$data ["date_fin_periode"] = $datePrec->format ( "d/m/Y" );
				/*
				 * Ecriture de la nouvelle repartition
				 */
				$newId = parent::ecrire ( $data );
				if ($newId > 0) {
					/*
					 * Gestion des bassins rattaches
					 */
					$distribution = new Distribution ( $this->connection, $this->paramori );
					/*
					 * Recuperation de la liste des bassins rattaches a l'ancienne répartition
					 */
					$dataDist = $distribution->getFromRepartition ( $id );
					foreach ( $dataDist as $key => $value ) {
						$data = $value;
						$data ["distribution_id"] = 0;
						$data ["repartition_id"] = $newId;
						$data ["evol_taux_nourrissage"] = null;
						$data ["ration_commentaire"] = null;
						$data ["reste_zone_calcul"] = null;
						$data ["distribution_id_prec"] = $value ["distribution_id"];
						$data ["reste_total"] = 0;
						$data ["taux_reste"] = 0;
						/*
						 * Ecriture des nouvelles distributions
						 */
						$idDistribution = $distribution->ecrire ( $data );
						if (! $idDistribution > 0) {
							$this->errorData [] = array (
									"code" => 0,
									"valeur" => $distribution->getErrorData ( 0 ) 
							);
							$err = - 1;
						}
					}
				} else {
					$err = - 1;
				}
				if ($err == - 1)
					return - 1;
				else
					return $newId;
			}
		}
	}
	
	/**
	 * Surcharge de supprimer() pour supprimer les enregistrements fils dans distribution
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::supprimer()
	 */
	function supprimer($id) {
		if ($id > 0) {
			/*
			 * Suppression des enregistrements lies dans distribution
			 */
			$distribution = new Distribution ( $this->connection, $this->paramori );
			$distribution->supprimerChamp ( $id, "repartition_id" );
			return (parent::supprimer ( $id ));
		}
	}
}
/**
 * ORM de gestion de la table distribution
 *
 * @author quinton
 *        
 */
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
						"type" => 1,
						"requis" => 1 
				),
				"reste_zone_calcul" => array (
						"type" => 0 
				),
				"reste_total" => array (
						"type" => 0 
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
				),
				"taux_reste" => array (
						"type" => 0 
				),
				"distribution_id_prec" => array (
						"type" => 0 
				),
				"distribution_jour" => array (
						"type" => 0,
						"defaultValue" => "1,1,1,1,1,1,1" 
				),
				"distribution_jour_soir" => array(
						"type" => 0,
						"defaultValue" => "0,0,0,0,0,0,0"
		)
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Surcharge de la fonction lire pour preparer les champs concernant les jours de distribution
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::lire()
	 */
	function lire($id, $getDefault = false, $parentValue = 0) {
		$data = parent::lire ( $id, $getDefault, $parentValue );
		/*
		 * Traitement des jours
		 */
		$distribJour = explode ( ",", $data ["distribution_jour"] );
		for($i = 0; $i < 7; $i ++) {
			$data ["distribution_jour_" . ($i + 1)] = $distribJour [$i];
		}
		$distribJourSoir = explode(",", $data["distribution_jour_soir"]);
		for($i = 0; $i < 7; $i ++) {
			$data ["distribution_jour_soir_" . ($i + 1)] = $distribJourSoir [$i];
		}
		return ($data);
	}
	/**
	 * Surcharge de l'écriture, pour renseigner les
	 * donnees quotidiennes d'alimentation
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::ecrire()
	 */
	function ecrire($data) {
		/*
		 * Remise en forme du champ distribution_jour
		 */		
			$data ["distribution_jour"] = $data ["distribution_jour_1"];
			for($i = 2; $i <= 7; $i ++) {
				$data ["distribution_jour"] .= "," . $data ["distribution_jour_" . $i];
			}		
		/*
		 * Remise en forme du champ distribution_jour_taux
		 */
			$data["distribution_jour_soir"] = $data["distribution_jour_soir_1"];
			for($i = 2; $i <= 7; $i ++) {
				$data ["distribution_jour_soir"] .= "," . $data ["distribution_jour_soir_" . $i];
			}
		$id = parent::ecrire ( $data );
		if ($id > 0) {
			/*
			 * Relecture, pour récupérer les données de restes
			*/
			$data = $this->lire($id);
			/*
			 * Ecriture de la repartition quotidienne des aliments
			 */
			$repartition = new Repartition ( $this->connection, $this->paramori );
			$dataRepartition = $repartition->lire ( $data ["repartition_id"] );
			$dateDebut = DateTime::createFromFormat ( 'd/m/Y', $dataRepartition ['date_debut_periode'] );
			$dateFin = DateTime::createFromFormat ( 'd/m/Y', $dataRepartition ["date_fin_periode"] );
			$dateDiff = date_diff ( $dateDebut, $dateFin, true );
			$nbJour = $dateDiff->format ( "%a" );
			/*
			 * Lecture des donnees de la repartition
			 */
			$repartAliment = new RepartAliment ( $this->connection, $this->paramori );
			$dataRepartAliment = $repartAliment->getFromTemplate ( $data ["repart_template_id"] );
			/*
			 * Instanciation des tables a mettre a jour
			 */
			$distribQuotidien = new DistribQuotidien ( $this->connection, $this->paramori );
			$alimentQuotidien = new AlimentQuotidien ( $this->connection, $this->paramori );
			/*
			 * Mise en forme facile a utiliser
			 */
			foreach ( $dataRepartAliment as $key => $value ) {
				$aliment [$value ["aliment_id"]] = $value ["repart_alim_taux"];
			}
			/*
			 * Preparation du reste
			 */
			if (strlen ( $data ["reste_zone_calcul"] ) > 0) {
				$reste = explode ( "+", $data ["reste_zone_calcul"] );
			}
			/*
			 * Mise en forme du tableau de jour de distribution
			 */
			$distribJour = explode ( ",", $data ["distribution_jour"] );
			$distribJourSoir = explode(",", $data["distribution_jour_soir"]);
			$i = 0;
			while ( $dateDebut <= $dateFin ) {
				/*
				 * Suppression des enregistrements precedents
				 */
				$alimentQuotidien->deleteFromDateBassin ( date_format ( $dateDebut, "Y-m-d" ), $data ["bassin_id"] );
				$distribQuotidien->deleteFromDateBassin ( date_format ( $dateDebut, "Y-m-d" ), $data ["bassin_id"] );
				/*
				 * Recuperation du numero de jour
				 */
				$numJour = date_format ( $dateDebut, "w" );
				if ($numJour == 0)
					$numJour = 7;
					
					/*
				 * Ecriture de l'enregistrement distrib_quotidien
				 */
				$dataDistrib = array (
						"distrib_quotidien_id" => 0,
						"bassin_id" => $data ["bassin_id"],
						"distrib_quotidien_date" => date_format ( $dateDebut, "d/m/Y" ),
						"total_distribue" => $data ["total_distribue"],
						"reste" => $reste [$i] 
				);
				/*
				 * On vérifie que l'aliment a été distribué ce jour-là
				 */
				if ($distribJour [$numJour - 1] != 1) {
					$dataDistrib ["total_distribue"] = 0;
				}
				/*
				 * Recalcul de la quantité si distribution uniquement le soir à 50 %
				 */
				if ($distribJourSoir[$numJour - 1] == 1) {
					$dataDistrib ["total_distribue"] = $dataDistrib["total_distribue"] * 0.5;
				}
				$idDataDistrib = $distribQuotidien->ecrire ( $dataDistrib );
				if ($idDataDistrib > 0 && $distribJour [$numJour - 1] == 1) {
					/*
					 * Ecriture des donnees quotidiennes des aliments
					 */
					foreach ( $aliment as $cle => $taux ) {
						$dataAlimQuot = array (
								"aliment_quotidien_id" => 0,
								"aliment_id" => $cle,
								"distrib_quotidien_id" => $idDataDistrib,
								"quantite" => intval ( $dataDistrib ["total_distribue"] * $taux / 100 ) 
						);
						$alimentQuotidien->ecrire ( $dataAlimQuot );
					}
				}
				$i ++;
				/*
				 * Incrementation de la date
				 */
				$dateDebut->add ( new DateInterval ( "P1D" ) );
			}
		}
		return ($id);
	}
	/**
	 * Ecrit les restes dans la table
	 *
	 * @param array $data        	
	 * @return integer
	 */
	function ecrireReste($data) {
		$erreur = 0;
		if (strlen ( $data ["date_debut_periode"] ) > 0 && strlen ( $data ["date_fin_periode"] ) > 0 && $data ["distribution_id"] > 0) {
			/*
			 * Ecriture de la zone contenant l'ensemble des restes quotidiens
			 */
			$dateDebut = DateTime::createFromFormat ( 'd/m/Y', $data ['date_debut_periode'] );
			$dateFin = DateTime::createFromFormat ( 'd/m/Y', $data ["date_fin_periode"] );
			$dateDiff = date_diff ( $dateDebut, $dateFin, true );
			$nbJour = $dateDiff->format ( "%a" );
			$data ["reste_zone_calcul"] = "";
			for($i = 0; $i <= $nbJour; $i ++) {
				if ($i > 0)
					$data ["reste_zone_calcul"] .= "+";
				$data ["reste_zone_calcul"] .= $data ["reste_" . $i];
			}
			$ret = parent::ecrire ( $data );
			if ($ret > 0) {
				/*
				 * Ecriture des données quotidiennes
				 */
				$di = new DateInterval ( "P1D" );
				$distribQuotidien = new DistribQuotidien ( $this->connection, $this->paramori );
				for($i = 0; $i <= $nbJour; $i ++) {
					/*
					 * Lecture de l'enregistrement précédent, qui doit exister
					 */
					$dataDistrib = $distribQuotidien->lireFromDate ( $data ["bassin_id"], $dateDebut->format ( "d/m/Y" ) );
					if ($dataDistrib ["distrib_quotidien_id"] > 0) {
						$dataDistrib ["reste"] = $data ["reste_" . $i];
						$ret1 = $distribQuotidien->ecrire ( $dataDistrib );
						if (! $ret1 > 0) {
							$erreur = 1;
							$this->errorData [] = $distribQuotidien->getErrorData ( 0 );
						}
					}
					date_add ( $dateDebut, $di );
				}
			}
			if ($erreur != 0)
				return - 1;
			else
				return $ret;
		}
	}
	/**
	 * Lit toutes les distributions à partir du numéro de répartition
	 *
	 * @param int $repartition_id        	
	 * @return array
	 */
	function getFromRepartition($repartition_id) {
		$sql = "select t1.distribution_id, t1.repartition_id, t1.bassin_id,
				t1.repart_template_id, t1.reste_zone_calcul, t1.evol_taux_nourrissage,
				t1.taux_nourrissage, t1.total_distribue, t1.distribution_consigne,
				t1.ration_commentaire, t1.distribution_masse, t1.distribution_jour,
				t1.distribution_jour_soir,
				t1.reste_total, t1.taux_reste, t1.distribution_id_prec,
				bassin_nom,".
				/*t2.reste_total as reste_precedent,
				t2.taux_reste as taux_reste_precedent,*/"
				t2.total_distribue as total_distrib_precedent,
				t2.ration_commentaire as ration_commentaire_precedent,
				t2.taux_nourrissage as taux_nourrissage_precedent
				from distribution t1 
				join bassin using (bassin_id)
				left outer join distribution t2 on (t2.distribution_id = t1.distribution_id_prec)
				where t1.repartition_id = " . $repartition_id . "
				order by bassin_nom";		
		$data = $this->getListeParam ( $sql );
		/*
		 * Recuperation des dates de la repartition
		 */
		$repartition = new Repartition($this->connection, $this->paramori);
		$dataRepart = $repartition->lire($repartition_id);
		$date_debut = date_create_from_format("d/m/Y", $dataRepart["date_debut_periode"]);
		$date_fin = date_create_from_format("d/m/Y", $dataRepart["date_fin_periode"]);
		$intervalle = $date_debut->diff( $date_fin);
		$nbJour = $intervalle->format('%a') + 1;
		$di_intervalle = new DateInterval("P".($nbJour)."D");
		//$date_debut->sub($di_intervalle);
		
		$distriQuotidien = new DistribQuotidien($this->connection, $this->paramori);
		$p1d = new DateInterval("P1D");
		/*
		 * Mise en forme des jours de distribution
		 */
		foreach ( $data as $key => $value ) {
			$distribJour = explode ( ",", $value ["distribution_jour"] );
			$distribJourSoir = explode (",", $value["distribution_jour_soir"]);
			for($i = 0; $i < 7; $i ++) {
				$data [$key] ["distribution_jour_" . ($i + 1)] = $distribJour [$i];
				$data [$key] ["distribution_jour_soir_". ($i + 1)] = $distribJourSoir[$i];
			}
			/*
			 * Calcul de la distribution globale
			 */
			$data[$key]["total_periode_distribue"] = 0;
			$date_debut = date_create_from_format("d/m/Y", $dataRepart["date_debut_periode"]);
			for($i = 1; $i <= $nbJour; $i++) {
				$dataDistrib = $distriQuotidien->lireFromDate($value["bassin_id"], $date_debut->format("d/m/Y"));
				$data[$key]["total_periode_distribue"] += $dataDistrib["total_distribue"];
				$date_debut->add($p1d);
			}
			/*
			 * Calcul des distributions et restes précédents
			 */
			$dateDeb = date_create_from_format("d/m/Y", $dataRepart["date_debut_periode"]);
			$dateDeb->sub($di_intervalle);
			$data[$key]["total_periode_distrib_precedent"] = 0;
			$data[$key]["total_reste_precedent"] = 0;
			/*
			 * Lecture des consommations et restes quotidiens
			 */
			for ($i=1;$i <= $nbJour;$i++) {
				$dataDistrib = $distriQuotidien->lireFromDate($value["bassin_id"], $dateDeb->format("d/m/Y"));
				$data[$key]["total_periode_distrib_precedent"] += $dataDistrib["total_distribue"];
				$data[$key]["reste_precedent"] += $dataDistrib["reste"];
				$dateDeb->add($p1d); 
			}
			/*
			 * Calcul du taux de reste
			 */
			if ($data[$key]["total_periode_distrib_precedent"] > 0) {
				$data[$key]["taux_reste_precedent"] = round(($data[$key]["reste_precedent"] / $data[$key]["total_periode_distrib_precedent"] * 100),2);
			} else {
				$data[$key]["taux_reste_precedent"] = 0;
			}
		}
		return ($data);
	}
	/**
	 * Retourne la liste des bassins associés à une répartition,
	 * avec les bassins qui peuvent en faire également partie
	 *
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
						(select bassin_id from " . $this->table . " where repartition_id = " . $repartition_id . ")
						order by bassin_nom";
				$dataBassin = $this->getListeParam ( $sql );
				/*
				 * Rajout des bassins à la liste
				 */
				foreach ( $dataBassin as $key => $value ) {
					$value ["distribution_id"] = 0;
					/*
					 * Rajout des distributions quotidiennes par defaut
					 */
					for($i = 1; $i <= 7; $i ++) {
						$value ["distribution_jour_" . $i ] = 1;
						$value ["distribution_jour_soir_".$i] = 0;
					}
					$data [] = $value;
				}
				return $data;
			}
		}
	}
	/**
	 * Calcule la quantite de nourriture a distribuer globalement
	 *
	 * @param int $repartition_id        	
	 * @return array
	 */
	function calculDistribution($repartition_id) {
		if ($repartition_id > 0) {
			$sql = 'select bassin_nom, aliment_id, taux_nourrissage, evol_taux_nourrissage, total_distribue, repart_alim_taux, 
					round (total_distribue * repart_alim_taux / 100) as "quantite",
					round (total_distribue * repart_alim_taux  * matin / 10000) as "quantiteMatin",
					round (total_distribue * repart_alim_taux * midi / 10000) as "quantiteMidi",
					round (total_distribue * repart_alim_taux * soir / 10000) as "quantiteSoir",
					round (total_distribue * repart_alim_taux * nuit / 10000) as "quantiteNuit",
					distribution_consigne, distribution_masse, distribution_jour, aliment_type_id
					from distribution
					join repart_template using (repart_template_id)
					join repart_aliment using (repart_template_id)
					join aliment using (aliment_id)
					join bassin using (bassin_id)
					where repartition_id = ' . $repartition_id . "
					order by bassin_nom";
			return ($this->getListeParam ( $sql ));
		}
	}
	/**
	 * Retourne la liste des aliments utilisés dans une distribution
	 *
	 * @param int $repartition_id        	
	 * @return array
	 */
	function getListeAlimentFromRepartition($repartition_id, $order = "adulte") {
		if ($repartition_id > 0) {
			$sql = "select distinct aliment_id, aliment_libelle_court, aliment_type_id
					from distribution
					join repart_template using (repart_template_id)
					join repart_aliment using (repart_template_id)
					join aliment using (aliment_id)
					where repartition_id = " . $repartition_id;
			if ($order == "adulte") {
				$order = " order by aliment_libelle_court";
			}
			if ($order == "juvenile") {
				$order = " order by aliment_type_id desc, aliment_libelle_court";
			}
			
			return ($this->getListeParam ( $sql . $order ));
		}
	}
}
/**
 * ORM de gestion de la table distrib_quotidien
 *
 * @author quinton
 *        
 */
class DistribQuotidien extends ObjetBDD {
	/**
	 * Liste des aliments uniques d'un intervalle de distribution
	 *
	 * @var array
	 */
	public $alimentListe;
	/**
	 * Constructeur de la classe
	 *
	 * @param connexion $bdd        	
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "distrib_quotidien";
		$this->id_auto = 1;
		$this->colonnes = array (
				"distrib_quotidien_id" => array (
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
				"distrib_quotidien_date" => array (
						"type" => 2,
						"requis" => 1 
				),
				"total_distribue" => array (
						"type" => 1 
				),
				"reste" => array (
						"type" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Supprime un enregistrement attache a un bassin et a une date
	 *
	 * @param string $date        	
	 * @param int $bassin_id        	
	 * @return code
	 */
	function deleteFromDateBassin($date, $bassin_id) {
		if (strlen ( $date ) > 0 && $bassin_id > 0) {
			$sql = "delete from " . $this->table . "
					where distrib_quotidien_date = '" . $date . "'
					and bassin_id = " . $bassin_id;
			return $this->executeSQL ( $sql );
		}
	}
	/**
	 * Recherche un enregistrement a partir de la date et du bassin
	 *
	 * @param int $bassin_id        	
	 * @param date $distrib_date        	
	 * @return array
	 */
	function lireFromDate($bassin_id, $distrib_date) {
		$distribDate = $this->formatDateLocaleVersDB ( $distrib_date );
		if ($bassin_id > 0) {
			$sql = "select * from " . $this->table . " 
					where bassin_id = " . $bassin_id . "
						and distrib_quotidien_date = '" . $distribDate . "'";
			return ($this->lireParam ( $sql ));
		}
	}
	/**
	 * Retourne la liste des aliments consommés pendant la période définie
	 *
	 * @param int $bassin_id        	
	 * @param string $date_debut        	
	 * @param string $date_fin        	
	 * @return array
	 */
	function getListAliment($bassin_id, $date_debut, $date_fin) {
		if ($bassin_id > 0 && strlen ( $date_debut ) > 2 && strlen ( $date_fin ) > 2) {
			$date_debut = $this->formatDateLocaleVersDB ( $date_debut );
			$date_fin = $this->formatDateLocaleVersDB ( $date_fin );
			$sql = "select distinct aliment_id, aliment_libelle_court
					from distrib_quotidien
					natural join aliment_quotidien
					natural join aliment
					where distrib_quotidien_date >= '" . $date_debut . "' 
						and distrib_quotidien_date <= '" . $date_fin . "
						and bassin_id = " . $bassin_id . "
					order by aliment_id";
			return $this->getListeParam ( $sql );
		}
	}
	function getListeConsommation($bassin_id, $date_debut, $date_fin) {
		if ($bassin_id > 0 && strlen ( $date_debut ) > 2 && strlen ( $date_fin ) > 2) {
			$date_debut = $this->formatDateLocaleVersDB ( $date_debut );
			$date_fin = $this->formatDateLocaleVersDB ( $date_fin );
			/*
			 * Preparation de la premiere commande de selection du crosstab
			 */
			$sql1 = "select distrib_quotidien_id, bassin_nom, distrib_quotidien_date, 
				total_distribue, reste, 
				aliment_libelle_court, quantite
				from distrib_quotidien
				natural join bassin
				left outer join aliment_quotidien using (distrib_quotidien_id)
				left outer join aliment using (aliment_id)
				where distrib_quotidien_date >= ''" . $date_debut . "'' 
						and distrib_quotidien_date <= ''" . $date_fin . "''
						and bassin_id = " . $bassin_id . "
				order by distrib_quotidien_date desc";
			/*
			 * Recuperation de la liste des libellés des aliments
			 */
			$sql2 = "select distinct aliment_libelle_court
					from distrib_quotidien
					natural join aliment_quotidien
					natural join aliment
					where distrib_quotidien_date >= '" . $date_debut . "'
						and distrib_quotidien_date <= '" . $date_fin . "'
						and bassin_id = " . $bassin_id . "
					order by 1";
			$sql3 = "select distinct aliment_libelle_court
					from distrib_quotidien
					natural join aliment_quotidien
					natural join aliment
					where distrib_quotidien_date >= ''" . $date_debut . "''
						and distrib_quotidien_date <= ''" . $date_fin . "''
						and bassin_id = " . $bassin_id . "
					order by 1";
			$this->alimentListe = $this->getListeParam ( $sql2 );
			/*
			 * Preparation de la clause AS
			 */
			$as = "distrib_quotidien_id int8, 
				bassin_nom text, 
				distrib_quotidien_date timestamp,
				total_distribue float4,
				reste float4
			";
			foreach ( $this->alimentListe as $key => $value ) {
				$as .= ', "' . $value ["aliment_libelle_court"] . '" float4';
			}
			/*
			 * Preparation de la requete
			 */
			$sql = "select * from crosstab ('" . $sql1 . "', '" . $sql3 . "')
				AS ( " . $as . " )";
			// printr($sql);
			return $this->getListeParam ( $sql );
		}
	}
}
/**
 * ORM de gestion de la table aliment_quotidien
 *
 * @author quinton
 *        
 */
class AlimentQuotidien extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
	 * @param connexion $bdd        	
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "aliment_quotidien";
		$this->id_auto = 1;
		$this->colonnes = array (
				"aliment_quotidien_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"distrib_quotidien_id" => array (
						"type" => 1,
						"requis" => 1,
						"parentAttrib" => 1 
				),
				"aliment_id" => array (
						"type" => 1,
						"requis" => 1 
				),
				"quantite" => array (
						"type" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Supprime les enregistrements liés à un bassin, à une date donnée
	 *
	 * @param string $date        	
	 * @param int $bassin        	
	 * @return code
	 */
	function deleteFromDateBassin($date, $bassin_id) {
		if (strlen ( $date ) > 0 && $bassin_id > 0) {
			$sql = "delete from " . $this->table . "
					using distrib_quotidien
					where distrib_quotidien.distrib_quotidien_id = aliment_quotidien.distrib_quotidien_id
					and distrib_quotidien_date = '" . $date . "'
					and bassin_id = " . $bassin_id;
			return $this->executeSQL ( $sql );
		}
	}
}
?>