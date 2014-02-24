<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 *  Creation 18 févr. 2014
 */
/**
 * ORM de la table evenement
 * @author quinton
 *
 */
 class Evenement extends ObjetBDD {
 	/**
 	 * Constructeur de la classe
 	 * @param instance ADODB $bdd
 	 * @param array $param
 	 */
 	function __construct($bdd,$param=null) {
 		$this->param = $param;
 		$this->table="evenement";
 		$this->id_auto="1";
 		$this->colonnes=array(
 				"evenement_id"=>array("type"=>1,"key"=>1, "requis"=>1, "defaultValue"=>0),
 				"poisson_id"=>array("type"=>1, "requis"=>1, "parentAttrib"=>1),
 				"evenement_type_id"=>array("type"=>1, "requis"=>1),
 				"evenement_date"=>array("type"=>2,"requis"=>1, "defaultValue"=>"getDateJour"),
 		);
 		if(!is_array($param)) $param==array();
 		$param["fullDescription"]=1;
 		parent::__construct($bdd,$param);
 	}
 }
/**
 * ORM de la table evenement_type
 * @author quinton
 *
 */
 class Evenement_type extends ObjetBDD {
 	/**
 	 * Constructeur de la classe
 	 * @param instance ADODB $bdd
 	 * @param array $param
 	 */
 	function __construct($bdd,$param=null) {
 		$this->param = $param;
 		$this->table="evenement_type";
 		$this->id_auto="1";
 		$this->colonnes=array(
 				"evenement_type_id"=>array("type"=>1,"key"=>1, "requis"=>1, "defaultValue"=>0),
 				"evenement_type_libelle"=>array("type"=>0, "requis"=>1),
 				"evenement_type_actif"=>array("type"=>1, "requis"=>1, "defaultValue"=>1)
 		);
 		if(!is_array($param)) $param==array();
 		$param["fullDescription"]=1;
 		parent::__construct($bdd,$param);
 	}
 	
 	/**
 	 * Reecriture de la fonction pour trier la liste
 	 * (non-PHPdoc)
 	 * @see ObjetBDD::getListe()
 	 */
 	function getListe() {
 		$sql = 'select * from '.$this->table.' order by evenement_type_libelle';
 		return $this->getListeParam($sql);
 	}
 }
?>