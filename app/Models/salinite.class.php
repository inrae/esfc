<?php 
namespace App\Models;
use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table salinite
 *
 * @author quinton
 *        
 */
class Salinite extends PpciModel
{
    public AnalyseEau $analyseEau;
    public function __construct()
    {
        $this->table = "salinite";
        $this->fields = array(
            "salinite_id" => array(
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
            "salinite_datetime" => array(
                "type" => 3,
                "requis" => 1
            ),
            "salinite_tx" => array(
                "type" => 1,
                "requis" => 1
            )
        );
        parent::__construct();
    }

    /**
     * Recupere la liste des salinites definies pour un bassin_campagne
     *
     * @param int $bassin_campagne_id        	
     * @return array
     */
    function getListFromBassinCampagne(int $bassin_campagne_id, int $type_id = 0)
    {
        $param["bci"] = $bassin_campagne_id;
        $sql = "SELECT salinite_id, bassin_campagne_id, profil_thermique_type_id,
					salinite_datetime, salinite_tx,
					profil_thermique_type_libelle
					from salinite
					join profil_thermique_type using (profil_thermique_type_id)";
        $where = " where bassin_campagne_id = :bci";
        if ($type_id > 0) {
            $where .= " and profil_thermique_type_id = :type_id" ;
            $param["type_id"] = $type_id;
        }
        $order = " order by salinite_datetime";
        return $this->getListeParamAsPrepared($sql . $where . $order, $param);
    }

    /**
     * Recherche les differentes donnees de salinite (prevues ou relevees)
     * pour affichage dans le graphique
     *
     * @param int $bassin_campagne_id
     * @param int $type_id
     * @return array
     */
    function getValuesFromBassinCampagne(int $bassin_campagne_id, $annee, int $type_id = 1)
    {
        $param["bci"] = $bassin_campagne_id;
       
            if ($type_id == 1) {
                $sql = "SELECT distinct analyse_eau_date as salinite_datetime,
				salinite as salinite_tx
				from analyse_eau
				join circuit_eau using (circuit_eau_id)
				join bassin using (circuit_eau_id)
				join bassin_campagne using (bassin_id)
				where bassin_campagne_id = :bci 
				and extract(year from analyse_eau_date) = :annee
				and salinite is not null
				order by analyse_eau_date
				";
            $param["annee"] = $annee;
            } elseif ($type_id == 2) {
                $sql = "SELECT  salinite_datetime, salinite_tx
				from salinite
				where bassin_campagne_id = :bci
				and profil_thermique_type_id = 2
				order by salinite_datetime
				";
            }
            return $this->getListeParamAsPrepared($sql,$param);
        
    }

    /**
     * Surcharge de la fonction ecrire pour reconstituer le champ salinite_datetime
     * (non-PHPdoc)
     *
     * @see ObjetBDD::ecrire()
     */
    function write($data):int
    {
        $id = parent::write($data);
        if ($data["profil_thermique_type_id"] == 1 && $id > 0 && $data["bassin_id"] > 0 && is_numeric($data["bassin_id"])) {
            /*
			 * Ecriture de l'enregistrement dans les analyses du bassin
			 * Recuperation du numero d'analyse correspondant
			 */
            if (!isset($this->analyseEau)) {
                $this->analyseEau = $this->classInstanciate("AnalyseEau", "analyseEau.class.php");
            }
            /*
			 * Forcage du champ date en datetime
			 */
            $this->analyseEau->colonnes["analyse_eau_date"]["type"] = 3;
            $analyse_eau_id = $this->analyseEau->getIdFromDateBassin($data["salinite_datetime"], $data["bassin_id"]);
            if ($analyse_eau_id > 0) {
                $dataAnalyse = $this->analyseEau->lire($analyse_eau_id);
            } else {
                $dataAnalyse = array(
                    "analyse_eau_id" => 0,
                    "analyse_eau_date" => $data["salinite_datetime"],
                    "circuit_eau_id" => $data["circuit_eau_id"]
                );
            }
            /*
			 * Mise a jour de la salinite
			 */
            $dataAnalyse["salinite"] = $data["salinite_tx"];
            $this->analyseEau->ecrire($dataAnalyse);
        }
        return ($id);
    }
}
