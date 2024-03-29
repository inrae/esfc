<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 19 mars 2014
 */


/**
 * ORM de la table aliment
 *
 * @author quinton
 *        
 */
class Aliment extends ObjetBDD

{
	public $classpath = "modules/classes";
	public AlimentCategorie $alimentCategorie;
	/**
	 * Constructeur de la classe
	 *
	 * @param PDO $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = array())
	{
		$this->table = "aliment";
		$this->colonnes = array(
			"aliment_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"aliment_libelle" => array(
				"type" => 0,
				"requis" => 1
			),
			"aliment_libelle_court" => array(
				"type" => 0,
				"requis" => 1
			),
			"aliment_type_id" => array(
				"type" => 1,
				"requis" => 1
			),
			"actif" => array(
				"type" => 1,
				"defaultValue" => 1,
				"requis" => 1
			)
		);
		parent::__construct($bdd, $param);
	}
	function ecrire($data)
	{
		$id = parent::ecrire($data);
		if ($id > 0 ) {
			/*
			 * Traitement des categories rattachees
			 */
			$this->ecrireTableNN("aliment_categorie", "aliment_id", "categorie_id", $id, $data["categorie"]);
		}
		return $id;
	}
	/**
	 * Surcharge de la fonction supprimer() pour effacer les enregistrements dans aliment_categorie
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::supprimer()
	 */
	function supprimer($id)
	{
		if ($id > 0 && is_numeric($id)) {
			/*
			 * Suppression des rattachements aux catégories
			 */
			if (!isset($this->alimentCategorie)) {
				$this->alimentCategorie = $this->classInstanciate("AlimentCategorie", "alimentCategorie.class.php");
			} 
			$this->alimentCategorie->supprimerChamp($id, "aliment_id");
			return parent::supprimer($id);
		}
	}
	/**
	 * Retourne la liste des aliments actuellement utilisés
	 *
	 * @return array
	 */
	function getListeActif()
	{
		$sql = "select * from aliment where actif = 1 order by aliment_libelle";
		return $this->getListeParam($sql);
	}
	/**
	 * Reecriture de la recuperation de la liste
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::getListe()
	 */
	function getListe($order = "")
	{
		$sql = "select * from aliment 
				join aliment_type using (aliment_type_id)
				order by aliment_libelle";
		return $this->getListeParam($sql);
	}
}

