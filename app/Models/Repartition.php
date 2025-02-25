<?php 
namespace App\Models;

use Ppci\Libraries\PpciException;
use Ppci\Models\PpciModel;

class Repartition extends PpciModel
{
	/**
	 * Constructeur de la classe
	 *
	 *         	
	 */
	private Distribution $distribution;
	function __construct()
	{
		$this->table = "repartition";
		$this->fields = array(
			"repartition_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"categorie_id" => array(
				"type" => 1,
				"requis" => 1
			),
			"date_debut_periode" => array(
				"type" => 2,
				"requis" => 1
			),
			"date_fin_periode" => array(
				"type" => 2,
				"requis" => 1
			),
			"repartition_name" => array(
				"type" => 0
			),
			"site_id" => array("type" => 1)
		);
		parent::__construct();
	}
	/**
	 * Lit un enregistrement avec les tables de parametres liees
	 *
	 * @param int $id        	
	 * @return array
	 */
	function readWithCategorie(int $id)
	{
		$sql = "SELECT * from repartition
				left outer join categorie using (categorie_id)
				where repartition_id = :id:";
		return $this->lireParamAsPrepared($sql, array("id" => $id));
	}

	/**
	 * Recherche des repartions d'aliments à partir des paramètres fournis
	 *
	 * @param array $param        	
	 * @return array
	 */
	function getListSearch($param)
	{
		$sql = "SELECT * from repartition
				join categorie using (categorie_id)";
		$where = "";
		$and = "";
		$asql = array(
			"limit" => $param["limit"],
			"offset" => $param["offset"]
		);
		if ($param["categorie_id"] > 0) {
			$where .= $and . "categorie_id = :categorie_id:";
			$and = " and ";
			$asql["categorie_id"] = $param["categorie_id"];
		}
		if (strlen($param["date_reference"]) > 0) {
			$date_reference = $this->formatDateLocaleVersDB($param["date_reference"], 2);
			$where .= $and . "date_fin_periode >= :date_reference:";
			$and = " and ";
			$asql["date_reference"] = $date_reference;
		}
		if ($param["site_id"] > 0) {
			$where .= $and . "site_id = :site_id:";
			$and = " and ";
			$asql["site_id"] = $param["site_id"];
		}
		if ($and = " and ")
			$where = "where " . $where;
		$order = " order by date_debut_periode desc LIMIT :limit: OFFSET :offset:";
		return $this->getListeParamAsPrepared($sql . $where . $order, $asql);
	}
	/**
	 * Recopie les donnees dans une nouvelle repartition
	 *
	 * @param int $id        	
	 * @return int
	 */
	function duplicate(int $id)
	{

		/*
			 * Lecture des infos précédentes
			 */
		$dataPrec = $this->lire($id);
		if ($dataPrec["repartition_id"] > 0) {
			$err = 0;
			$data = $dataPrec;
			$data["repartition_id"] = 0;
			/*
				 * Calcul des dates
				 */
			$datePrec = \DateTime::createFromFormat("d/m/Y", $data["date_fin_periode"]);
			$datePrec->add(new \DateInterval("P1D"));
			$data["date_debut_periode"] = $datePrec->format("d/m/Y");
			$datePrec->add(new \DateInterval("P6D"));
			$data["date_fin_periode"] = $datePrec->format("d/m/Y");
			/*
				 * Ecriture de la nouvelle repartition
				 */
			$newId = parent::write($data);
			if ($newId > 0) {
				/*
					 * Gestion des bassins rattaches
					 */
					if (!isset($this->distribution)) {
						$this->distribution = new Distribution;
					}
				/*
					 * Recuperation de la liste des bassins rattaches a l'ancienne répartition
					 */
				$dataDist = $this->distribution->getFromRepartition($id);
				foreach ($dataDist as $value) {
					/*
						 * On ne traite que les bassins actifs et ceux de la même catégorie
						 * que le modèle de répartition
						 */
					if ($value["actif"] == 1 && $value["repart_template_categorie_id"] == $value["bassin_usage_categorie_id"]) {
						$data = $value;
						$data["distribution_id"] = 0;
						$data["repartition_id"] = $newId;
						$data["evol_taux_nourrissage"] = null;
						$data["ration_commentaire"] = null;
						$data["reste_zone_calcul"] = null;
						$data["distribution_id_prec"] = $value["distribution_id"];
						$data["reste_total"] = 0;
						$data["taux_reste"] = 0;
						/*
							 * Ecriture des nouvelles distributions
							 */
						$idDistribution = $this->distribution->ecrire($data);
						if (!$idDistribution > 0) {
							$this->errorData[] = array(
								"code" => 0,
								"valeur" => $this->distribution->getErrorData(0)
							);
							$err = -1;
						}
					}
				}
			} else {

				$err = -1;
			}
			if ($err == -1)
				return -1;
			else
				return $newId;
		}
	}

	/**
	 * Surcharge de supprimer() pour supprimer les enregistrements fils dans distribution
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::supprimer()
	 */
	function supprimer( $id)
	{
		if ($id > 0) {
			/*
			 * Suppression des enregistrements lies dans distribution
			 */
			if (!isset($this->distribution)) {
				$this->distribution = new Distribution;
			}
			$this->distribution->supprimerChamp($id, "repartition_id");
			return (parent::supprimer($id));
		}
	}

	function writeFromDateCategorie(array $data)
	{
		/*
		 * Recuperation de la cle, si existante
		 */
		if ($data["categorie_id"] > 0 && strlen($data["date_debut_periode"]) > 0) {
			$date = $this->formatDateLocaleVersDB($data["date_debut_periode"]);
			$sql = "SELECT repartition_id from repartition
				where categorie_id = :categorie_id:
					and date_debut_periode = :date:";
			$dataCle = $this->lireParamAsPrepared($sql, array(
				"categorie_id" => $data["categorie_id"],
				"date" => $date
			));
			if ($dataCle["repartition_id"] > 0) {
				$data["repartition_id"] = $dataCle["repartition_id"];
			} else {
				$data["repartition_id"] = 0;
			}
			return $this->ecrire($data);
		} else {
			throw new PpciException("Données incomplètes");
		}
	}
}
