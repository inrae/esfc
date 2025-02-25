<?php 
namespace App\Models;
use Ppci\Models\PpciModel;
/**
 * ORM de gestion de la table profil_thermique
 *
 * @author quinton
 *        
 */
class ProfilThermique extends PpciModel
{
    public AnalyseEau $analyseEau;
	public function __construct()
	{

		$this->table = "profil_thermique";
		$this->fields = array(
			"profil_thermique_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"bassin_campagne_id" => array(
				"type" => 1,
				"requis" => 1,
				"parentAttrib" => 1
			),
			"profil_thermique_type_id" => array(
				"type" => 1,
				"requis" => 1,
				"defaultValue" => 2
			),
			"pf_datetime" => array(
				"type" => 3,
				"requis" => 1
			),
			"pf_temperature" => array(
				"type" => 1,
				"requis" => 1
			)
		);
		parent::__construct();
	}

	/**
	 * Recupere la liste des temperatures definies pour un bassin_campagne
	 *
	 * @param int $bassin_campagne_id        	
	 * @return array
	 */
	function getListFromBassinCampagne(int $bassin_campagne_id)
	{
			$sql = "SELECT profil_thermique_id, bassin_campagne_id, profil_thermique_type_id,
					pf_datetime, pf_temperature, 
					profil_thermique_type_libelle
					from profil_thermique
					join profil_thermique_type using (profil_thermique_type_id)";
			$where = " where bassin_campagne_id = :id: ";
			$order = " order by pf_datetime";
			return $this->getListeParamAsPrepared($sql . $where . $order, array("id"=>$bassin_campagne_id));
	}
	/**
	 * Recherche les differentes donnees de temperature (prevues ou relevees)
	 * pour affichage dans le graphique
	 * 
	 * @param int $bassin_campagne_id     
     * @param int $annee  	
	 * @param int $type_id        	
	 * @return array
	 */
	function getValuesFromBassinCampagne(int $bassin_campagne_id, int $annee, int $type_id = 1)
	{
        $data["bci"] = $bassin_campagne_id;
			if ($type_id == 1) {
				$sql = "SELECT distinct analyse_eau_date as pf_datetime,
						temperature as pf_temperature
						from analyse_eau
						join circuit_eau using (circuit_eau_id)
						join bassin using (circuit_eau_id)
						join bassin_campagne using (bassin_id)
						where bassin_campagne_id = :bci:
						and extract(year from analyse_eau_date) = :annee:
						and temperature is not null
						order by analyse_eau_date
						";
            $data["annee"] = $annee;
			} elseif ($type_id == 2) {
				$sql = "SELECT  pf_datetime, pf_temperature
						from profil_thermique
						where bassin_campagne_id = :bci:
						and profil_thermique_type_id = 2
						order by pf_datetime
						";
			}
			return $this->getListeParamAsPrepared($sql, $data);
		
	}

	/**
	 * Surcharge de la fonction ecrire pour reconstituer le champ pf_datetime
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::ecrire()
	 */
	function write($data):int
	{
		$id = parent::write($data);
		if ($data["profil_thermique_type_id"] == 1 && $id > 0 && $data["bassin_id"] > 0) {
			/*
			 * Ecriture de l'enregistrement dans les analyses du bassin
			 * Recuperation du numero d'analyse correspondant
			 */
            if (!isset($this->analyseEau)) {
                $this->analyseEau = new AnalyseEau;
            }
			/*
			 * Forcage du champ date en datetime
			 */
			$this->analyseEau->datetimeFields[] = "analyse_eau_date";
			$analyse_eau_id = $this->analyseEau->getIdFromDateBassin($data["pf_datetime"], $data["bassin_id"]);
			if ($analyse_eau_id > 0) {
				$dataAnalyse = $this->analyseEau->lire($analyse_eau_id);
			} else {
				$dataAnalyse = array(
					"analyse_eau_id" => 0,
					"analyse_eau_date" => $data["pf_datetime"],
					"circuit_eau_id" => $data["circuit_eau_id"]
				);
			}
			/*
			 * Mise a jour de la temperature
			 */
			$dataAnalyse["temperature"] = $data["pf_temperature"];
			$this->analyseEau->ecrire($dataAnalyse);
		}
		return ($id);
	}
}
