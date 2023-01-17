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
	 * @return code
	 */
	function deleteFromDateBassin($date, $bassin_id)
	{
		if (strlen($date) > 0 && $bassin_id > 0 && is_numeric($bassin_id)) {
			$sql = "delete from " . $this->table . "
					where distrib_quotidien_date = '" . $date . "'
					and bassin_id = " . $bassin_id;
			return $this->executeSQL($sql);
		}
	}
	/**
	 * Recherche un enregistrement a partir de la date et du bassin
	 *
	 * @param int $bassin_id        	
	 * @param date $distrib_date        	
	 * @return array
	 */
	function lireFromDate($bassin_id, $distrib_date)
	{
		$distribDate = $this->formatDateLocaleVersDB($this->encodeData($distrib_date));
		if ($bassin_id > 0 && is_numeric($bassin_id)) {
			$sql = "select * from " . $this->table . " 
					where bassin_id = " . $bassin_id . "
						and distrib_quotidien_date = '" . $distribDate . "'";
			return ($this->lireParam($sql));
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
	function getListAliment($bassin_id, $date_debut, $date_fin)
	{
		if ($bassin_id > 0 && is_numeric($bassin_id) && strlen($date_debut) > 2 && strlen($date_fin) > 2) {
			$date_debut = $this->formatDateLocaleVersDB($this->encodeData($date_debut));
			$date_fin = $this->formatDateLocaleVersDB($this->encodeData($date_fin));
			$sql = "select distinct aliment_id, aliment_libelle_court
					from distrib_quotidien
					natural join aliment_quotidien
					natural join aliment
					where distrib_quotidien_date >= '" . $date_debut . "' 
						and distrib_quotidien_date <= '" . $date_fin . "
						and bassin_id = " . $bassin_id . "
					order by aliment_id";
			return $this->getListeParam($sql);
		}
	}
	function getListeConsommation($bassin_id, $date_debut, $date_fin)
	{
		if ($bassin_id > 0 && is_numeric($bassin_id) && strlen($date_debut) > 2 && strlen($date_fin) > 2) {
			$date_debut = $this->formatDateLocaleVersDB($this->encodeData($date_debut));
			$date_fin = $this->formatDateLocaleVersDB($this->encodeData($date_fin));
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
			$this->alimentListe = $this->getListeParam($sql2);
			/*
			 * Preparation de la clause AS
			 */
			$as = "distrib_quotidien_id int8, 
				bassin_nom text, 
				distrib_quotidien_date timestamp,
				total_distribue float4,
				reste float4
			";
			foreach ($this->alimentListe as $key => $value) {
				$as .= ', "' . $value["aliment_libelle_court"] . '" float4';
			}
			/*
			 * Preparation de la requete
			 */
			$sql = "select * from crosstab ('" . $sql1 . "', '" . $sql3 . "')
				AS ( " . $as . " )";
			// printr($sql);
			return $this->getListeParam($sql);
		}
	}
	/**
	 * Ecrit un enregistrement à partir du bassin et de la date
	 * @param array $data
	 * @return int
	 */
	function ecrireFromBassinDate($data)
	{
		/*
		 * Recuperation de la cle, si existante
		 */
		$data = $this->encodeData($data);
		if ($data["bassin_id"] > 0 && is_numeric($data["bassin_id"]) && strlen($data["distrib_quotidien_date"]) > 0) {
			$date = $this->formatDateLocaleVersDB($data["distrib_quotidien_date"]);
			$sql = "select distrib_quotidien_id from distrib_quotidien
				where bassin_id = " . $data["bassin_id"] . " 
					and distrib_quotidien_date = '" . $date . "'";
			$dataCle = $this->lireParam($sql);
			if ($dataCle["distrib_quotidien_id"] > 0) {
				$data["distrib_quotidien_id"] = $dataCle["distrib_quotidien_id"];
			} else
				$data["distrib_quotidien_id"] = 0;
			return $this->ecrire($data);
		} else
			return -1;
	}
}