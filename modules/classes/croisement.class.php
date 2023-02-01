<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 12 mars 2015
 */
/**
 * ORM de gestion de la table croisement
 *
 * @author quinton
 *        
 */

class Croisement extends ObjetBDD
{
	public PoissonSequence $poissonSequence;
	function __construct($bdd, $param = array())
	{
		$this->table = "croisement";
		$this->colonnes = array(
			"croisement_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"sequence_id" => array(
				"type" => 1,
				"requis" => 1,
				"parentAttrib" => 1
			),
			"croisement_qualite_id" => array(
				"type" => 1
			),
			"croisement_date" => array(
				"type" => 3
			),
			"croisement_nom" => array(
				"type" => 0,
				"requis" => 1
			),
			"ovocyte_masse" => array(
				"type" => 1
			),
			"ovocyte_densite" => array(
				"type" => 1
			),
			"tx_fecondation" => array(
				"type" => 1
			),
			"tx_survie_estime" => array(
				"type" => 1
			),
			"croisement_parents" => array(
				"type" => 0
			)
		);
		parent::__construct($bdd, $param);
	}

	/**
	 * Surcharge de la fonction ecrire pour prendre en compte la liste des reproducteurs
	 * attaches
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::ecrire()
	 */
	function ecrire($data)
	{
		$id = parent::ecrire($data);
		if ($id > 0) {
			/*
			 * Ecriture de la liste des poissons concernes
			 */
			$this->ecrireTableNN("poisson_croisement", "croisement_id", "poisson_campagne_id", $id, $data["poisson_campagne_id"]);
		}
		return $id;
	}
	/**
	 * Ajout de la suppression des poissons rattaches avant suppression du croisement
	 * {@inheritDoc}
	 * @see ObjetBDD::supprimer()
	 */
	function supprimer($id)
	{
		$this->ecrireTableNN("poisson_croisement", "croisement_id", "poisson_campagne_id", $id, array());
		return parent::supprimer($id);
	}

	/**
	 * recupere la liste des croisement pour une sequence
	 *
	 * @param int $sequence_id        	
	 * @return array
	 */
	function getListFromSequence(int $sequence_id)
	{
		$sql = "select croisement_id, sequence_id, croisement_qualite_id, croisement_qualite_libelle,
					croisement_date, ovocyte_masse, ovocyte_densite, tx_fecondation, tx_survie_estime,
					sequence_nom, croisement_nom
					from croisement
					join sequence using (sequence_id)
					left outer join croisement_qualite using (croisement_qualite_id)
					where sequence_id = :id
					order by croisement_date, croisement_nom";
		$data = $this->getListeParamAsPrepared($sql, array("id" => $sequence_id));
		/*
			 * Recherche des parents
			 */
		foreach ($data as $key => $value) {
			$data[$key]["parents"] = $this->getParentsFromCroisement($value["croisement_id"]);
		}
		return $data;
	}

	/**
	 * Recupere la liste des croisements pour une annee
	 * 
	 * @param int $annee        	
	 * @return array
	 */
	function getListFromAnnee(int $annee)
	{
		$sql = "select croisement_id, sequence_id, croisement_qualite_id, croisement_qualite_libelle,
					croisement_date, ovocyte_masse, ovocyte_densite, tx_fecondation, tx_survie_estime
					from croisement
					join sequence using (sequence_id)
					left outer join croisement_qualite using (croisement_qualite_id)
					where annee = :annee
					order by croisement_date, croisement_id";
		$data = $this->getListeParamAsPrepared($sql, array("annee" => $annee));
		/*
			 * Recherche des parents
			 */
		foreach ($data as $key => $value) {
			$data[$key]["parents"] = $this->getParentsFromCroisement($value["croisement_id"]);
		}
		return $data;
	}

	/**
	 * Recupere la liste des parents d'un croisement, sous forme de chaine "prete a l'emploi"
	 *
	 * @param int $croisement_id        	
	 * @return string
	 */
	function getParentsFromCroisement(int $croisement_id)
	{
		$parents = "";
		$new = true;
		if ($croisement_id > 0 && is_numeric($croisement_id)) {
			$sql = "select prenom, sexe_libelle_court
						from poisson_croisement
						join poisson_campagne using (poisson_campagne_id)
						join poisson using (poisson_id)
						left outer join sexe using (sexe_id)
						where croisement_id = :id
						order by sexe_libelle_court, prenom";
			$poissons = $this->getListeParamAsPrepared($sql, array("id" => $croisement_id));
			foreach ($poissons as $value1) {
				if ($new == false) {
					$parents .= " ";
				} else {
					$new = false;
				}
				$parents .= $value1["prenom"] . "(" . $value1["sexe_libelle_court"] . ")";
			}
		}
		return $parents;
	}

	/**
	 * Retourne les poissons pour un croisement
	 * @param int $croisement_id
	 * @return array
	 */
	function getPoissonsFromCroisement(int $croisement_id)
	{
		$sql = "select poisson_campagne_id 
					from poisson_croisement
					where croisement_id = :id";
		return $this->getListeParamAsPrepared($sql, array("id" => $croisement_id));
	}

	/**
	 * Retourne les identifiants des poissons utilises dans un croisement
	 * @param int $croisement_id
	 * @return array
	 */
	function getPoissonIdFromCroisement(int $croisement_id)
	{
		$sql = "select poisson_id
					from poisson_croisement
					join poisson_campagne using (poisson_campagne_id)
					join poisson using (poisson_id)
					where croisement_id = :id";
		return $this->getListeParamAsPrepared($sql, array("id" => $croisement_id));
	}

	/**
	 * Retourne la liste de tous les poissons de la sequence, avec le fait q'ils soient
	 * selectionnes ou non dans le croisement considere
	 *
	 * @param int $croisement_id        	
	 * @param int $sequence_id        	
	 * @return array
	 */
	function getListAllPoisson(int $croisement_id, int $sequence_id = null)
	{
		$data = array();
		if (is_null($sequence_id)) {
			/*
				 * Recuperation du numero de sequence
				 */
			$dataSequence = $this->lire($croisement_id);
			$sequence_id = $dataSequence["sequence_id"];
		}
		if ($sequence_id > 0) {
			/*
				 * Recherche des poissons attaches a la sequence
				 */
			if (!isset($this->poissonSequence)) {
				$this->poissonSequence = $this->classInstanciate("PoissonSequence", "poissonSequence.class.php");
			}
			$data = $this->poissonSequence->getListFromSequence($sequence_id);
			/*
				 * Recherche des poissons attaches au croisement
				 */
			$sql = "select poisson_campagne_id 
						from poisson_croisement
						where croisement_id = :croisement_id" . $croisement_id;
			$poissonCroisement = $this->getListeParamAsPrepared($sql, array("croisement_id" => $croisement_id));
			foreach ($data as $key => $value) {
				foreach ($poissonCroisement as $value1) {
					if ($value["poisson_campagne_id"] == $value1["poisson_campagne_id"]) {
						$data[$key]["selected"] = 1;
					}
				}
			}
		}
		return $data;
	}

	/**
	 * Retourne le detail d'un croisement, pour affichage
	 * @param int $id
	 * @return array
	 */
	function getDetail($id)
	{
		$sql = "select * from croisement
					left outer join croisement_qualite using (croisement_qualite_id)";
		$where = " where croisement_id = :id " . $id;
		$data = $this->lireParamAsPrepared($sql . $where, array("id" => $id));
		$data["parents"] = $this->getParentsFromCroisement($id);
		return $data;
	}
}
