<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 14 mars 2014
 */
class Anomalie_db extends ObjetBDD
{
	/**
	 * Constructeur de la classe
	 *
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = array())
	{
		$this->table = "anomalie_db";
		$this->colonnes = array(
			"anomalie_db_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"anomalie_db_date" => array(
				"type" => 2,
				"requis" => 1,
				"defaultValue" => "getDateJour"
			),
			"anomalie_db_type_id" => array(
				"type" => 1,
				"requis" => 1
			),
			"poisson_id" => array(
				"type" => 1
			),
			"evenement_id" => array(
				"type" => 1
			),
			"anomalie_db_commentaire" => array(
				"type" => 0
			),
			"anomalie_db_statut" => array(
				"type" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"anomalie_db_date_traitement" => array(
				"type" => 2
			)
		);
		parent::__construct($bdd, $param);
	}
	/**
	 * Reecriture de la fonction lire pour recuperer les informations concernant le poisson
	 * (non-PHPdoc)
	 * @see ObjetBDD::lire()
	 */
	function lire($id, bool $getDefault = true, int $parentValue = 0): array|bool
	{

		$sql = "select anomalie_db_id, anomalie_db_date, anomalie_db.poisson_id, anomalie_db_commentaire, 
				anomalie_db_type_libelle, evenement_type_libelle, anomalie_db.evenement_id,
					anomalie_db_statut, anomalie_db_date_traitement,
					matricule, prenom, pittag_valeur
					from anomalie_db
					left outer join poisson using (poisson_id)
					left outer join v_pittag_by_poisson using (poisson_id)
					left outer join anomalie_db_type using (anomalie_db_type_id)
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					where anomalie_db_id = :id";
		$data = $this->lireParamAsPrepared($sql, array("id" => $id));
		if (!empty($data)) {
			$data = $this->getDefaultValue($parentValue);
		}
		return $data;
	}
	/**
	 * Retourne la liste des anomalies pour un poisson
	 *
	 * @param int $poisson_id        	
	 * @return array
	 */
	function getListByPoisson($poisson_id)
	{
		$sql = "select anomalie_db_id, anomalie_db.poisson_id, anomalie_db_date, anomalie_db_commentaire,
					anomalie_db_type_libelle, 
					evenement_id, evenement_type_libelle, 
					anomalie_db.evenement_id,
					anomalie_db_statut, anomalie_db_date_traitement
					from anomalie_db
					left outer join anomalie_db_type using (anomalie_db_type_id)
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					where anomalie_db.poisson_id = :id order by anomalie_db_date desc";
		return $this->getListeParamAsPrepared($sql, array("id" => $poisson_id));
	}
	/**
	 * Retourne la liste des anomalies en fonction des criteres de recherche
	 * 
	 * @param array $dataSearch        	
	 * @return array
	 */
	function getListeSearch($dataSearch)
	{
		$dataSearch = $this->encodeData($dataSearch);
		$sql = "select anomalie_db_id, anomalie_db_date, anomalie_db.poisson_id, anomalie_db_commentaire, 
				anomalie_db_type_libelle, 
				evenement_id, evenement_type_libelle, 
				anomalie_db.evenement_id,
					anomalie_db_statut, anomalie_db_date_traitement,
					matricule, prenom, pittag_valeur
					from anomalie_db
					left outer join poisson using (poisson_id)
					left outer join v_pittag_by_poisson using (poisson_id)
					left outer join anomalie_db_type using (anomalie_db_type_id)
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)";
		$where = "";
		$and = "";
		$data = array();
		if ($dataSearch["statut"] > -1 && is_numeric($dataSearch["statut"])) {
			$where .= $and . " anomalie_db_statut = :statut ";
			$data["statut"] = $dataSearch["statut"];
			$and = " and ";
		}
		if ($dataSearch["type"] > 0 && is_numeric($dataSearch["type"])) {
			$where .= $and . " anomalie_db_type_id = :type";
			$data["type"] = $dataSearch["type"];
			$and = " and ";
		}
		if ($and == " and ")
			$where = " where " . $where;

		$order = " order by anomalie_db_date desc";
		return $this->getListeParamAsPrepared($sql . $where . $order, $data);
	}
}
