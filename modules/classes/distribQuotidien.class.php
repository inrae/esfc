<?php

/**
 * ORM de gestion de la table distrib_quotidien
 *
 * @author quinton
 *        
 */
class DistribQuotidien extends ObjetBDD
{
	/**
	 * Liste des aliments uniques d'un intervalle de distribution
	 *
	 * @var array
	 */
	public $alimentListe;
	/**
	 * Constructeur de la classe
	 *
	 * @param PDO $bdd        	
	 * @param array $param        	
	 */
	function __construct($bdd, $param = array())
	{
		$this->table = "distrib_quotidien";
		$this->colonnes = array(
			"distrib_quotidien_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"bassin_id" => array(
				"type" => 1,
				"requis" => 1,
				"parentAttrib" => 1
			),
			"distrib_quotidien_date" => array(
				"type" => 2,
				"requis" => 1
			),
			"total_distribue" => array(
				"type" => 1
			),
			"reste" => array(
				"type" => 1
			)
		);
		parent::__construct($bdd, $param);
	}
	/**
	 * Supprime un enregistrement attache a un bassin et a une date
	 *
	 * @param string $date        	
	 * @param int $bassin_id        	
	 * @return array|bool
	 */
	function deleteFromDateBassin($date, int $bassin_id)
	{
		if (strlen($date) > 0 && $bassin_id > 0) {
			$sql = "delete from distrib_quotidien
					where distrib_quotidien_date = :dqd
					and bassin_id = :id";
			return $this->executeAsPrepared($sql, array("dqd" => $date, "id" => $bassin_id), true);
		} else {
			return false;
		}
	}
	/**
	 * Recherche un enregistrement a partir de la date et du bassin
	 *
	 * @param int $bassin_id        	
	 * @param string $distrib_date        	
	 * @return array
	 */
	function lireFromDate(int $bassin_id, $distrib_date)
	{
		$distribDate = $this->formatDateLocaleVersDB($distrib_date);
		$sql = "select * from distrib_quotidien
					where bassin_id = :bassin_id 
					and distrib_quotidien_date = :distrib_date ";
		return ($this->lireParamAsPrepared($sql, array("bassin_id" => $bassin_id, "distrib_date" => $distribDate)));
	}
	/**
	 * Retourne la liste des aliments consommés pendant la période définie
	 *
	 * @param int $bassin_id        	
	 * @param string $date_debut        	
	 * @param string $date_fin        	
	 * @return array
	 */
	function getListAliment($bassin_id, $date_debut, $date_fin)
	{

		$date_debut = $this->formatDateLocaleVersDB($date_debut);
		$date_fin = $this->formatDateLocaleVersDB($date_fin);
		$sql = "select distinct aliment_id, aliment_libelle_court
				from distrib_quotidien
					join aliment_quotidien using (aliment_quotidien_id)
					join aliment using (aliment_id)
				where distrib_quotidien_date >= :date_debut
					and distrib_quotidien_date <= :date_fin
					and bassin_id = :bassin_id 
				order by aliment_id";
		return $this->getListeParamAsPrepared($sql, array(
			"date_debut" => $date_debut,
			"date_fin" => $date_fin,
			"bassin_id" => $bassin_id
		));
	}
	function getListeConsommation(int $bassin_id, $date_debut, $date_fin)
	{
		$date_debut = $this->connection->quote($this->formatDateLocaleVersDB( $date_debut));
		$date_fin = $this->connection->quote($this->formatDateLocaleVersDB($date_fin));
		/**
		 * Preparation de la premiere commande de selection du crosstab
		 */
		$sql1 = "select distrib_quotidien_id, bassin_nom, distrib_quotidien_date, 
				total_distribue, reste, 
				aliment_libelle_court, quantite
				from distrib_quotidien
				join bassin using (bassin_id)
				left outer join aliment_quotidien using (distrib_quotidien_id)
				left outer join aliment using (aliment_id)
				where distrib_quotidien_date >= '$date_debut'
					and distrib_quotidien_date <= '$date_fin'
					and bassin_id = $bassin_id
				order by distrib_quotidien_date desc";
		/**
		 * Recuperation de la liste des libellés des aliments
		 */
		$sql2 = "select distinct aliment_libelle_court
					from distrib_quotidien
					natural join aliment_quotidien
					natural join aliment
					where distrib_quotidien_date >= $date_debut
					and distrib_quotidien_date <= $date_fin
					and bassin_id = $bassin_id
					order by 1";
		$sql3 = "select distinct aliment_libelle_court
					from distrib_quotidien
					natural join aliment_quotidien
					natural join aliment
					where distrib_quotidien_date >= '$date_debut'
					and distrib_quotidien_date <= '$date_fin'
					and bassin_id = $bassin_id
					order by 1";
		$this->alimentListe = $this->getListeParam($sql2);
		if (empty($this->alimentListe)) {
			return array();
		}
		/**
			 * Preparation de la clause AS
			 */
		$as = "distrib_quotidien_id int8, 
				bassin_nom text, 
				distrib_quotidien_date timestamp,
				total_distribue float4,
				reste float4
			";
		foreach ($this->alimentListe as $value) {
			$as .= ', "' . $value["aliment_libelle_court"] . '" float4';
		}
		/*
			 * Preparation de la requete
			 */
			$sql = "select * from crosstab ('" . $sql1 . "'::varchar, '" . $sql3 . "'::varchar)
			AS ( " . $as . " )";
		return $this->getListeParam($sql);
	}
	/**
	 * Ecrit un enregistrement à partir du bassin et de la date
	 * @param array $data
	 * @return int
	 */
	function ecrireFromBassinDate($data)
	{
		/**
		 * Recuperation de la cle, si existante
		 */
		$date = $this->formatDateLocaleVersDB($data["distrib_quotidien_date"]);
		$sql = "select distrib_quotidien_id from distrib_quotidien
				where bassin_id = :bassin_id
				and distrib_quotidien_date = :date";
		$dataCle = $this->lireParamAsPrepared($sql, array(
			"bassin_id" => $data["bassin_id"],
			"date" => $date
		));
		if ($dataCle["distrib_quotidien_id"] > 0) {
			$data["distrib_quotidien_id"] = $dataCle["distrib_quotidien_id"];
		} else {
			$data["distrib_quotidien_id"] = 0;
		}
		return $this->ecrire($data);
	}
}
