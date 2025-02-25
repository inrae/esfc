<?php 
namespace App\Models;
use Ppci\Models\PpciModel;

class SpermeCongelation extends PpciModel
{

    private $sql = "SELECT sperme_congelation_id, sperme_id, congelation_date, congelation_volume,
			sperme_dilueur_id, sperme_dilueur_libelle, nb_paillette, 
			nb_visotube, sperme_congelation_commentaire,
            sperme_conservateur_id, sperme_conservateur_libelle,
            volume_sperme, volume_dilueur, volume_conservateur,
            nb_paillettes_utilisees, paillette_volume, operateur
			from sperme_congelation 
			left outer join sperme_dilueur using (sperme_dilueur_id)
            left outer join sperme_conservateur using (sperme_conservateur_id)
             ";

    function __construct()
    {
        $this->table = "sperme_congelation";
        $this->fields = array(
            "sperme_congelation_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "sperme_id" => array(
                "type" => 1,
                "requis" => 1,
                "parentAttrib" => 1
            ),

            "congelation_date" => array(
                "type" => 3,
                "requis" => 1
            ),
            "congelation_volume" => array(
                "type" => 1
            ),
            "sperme_dilueur_id" => array(
                "type" => 1
            ),
            "nb_paillette" => array(
                "type" => 1
            ),
            "nb_visotube" => array(
                "type" => 1
            ),
            "sperme_conservateur_id" => array(
                "type" => 1,
                "defaultValue" => 1
            ),
            "volume_sperme" => array(
                "type" => 1
            ),
            "volume_dilueur" => array(
                "type" => 1
            ),
            "volume_conservateur" => array(
                "type" => 1
            ),
            "nb_paillettes_utilisees" => array(
                "type" => 1
            ),
            "sperme_congelation_commentaire" => array(
                "type" => 0
            ),
            "paillette_volume" => array(
                "type" => 1,
                "defaultValue" => 0.5
            ),
            "operateur" => array(
                "type" => 0
            )
        );
        parent::__construct();
    }

    /**
     * Retourne la liste des congelations associees a un sperme
     *
     * @param int $sperme_id
     */
    function getListFromSperme(int $sperme_id)
    {
        $where = " where sperme_id = :sperme_id";
        $order = " order by congelation_date";
        $arg = array(
            "sperme_id" => $sperme_id
        );
        ;
        return $this->getListeParamAsPrepared($this->sql . $where . $order, $arg);
    }

    function read($id, bool $getDefault = true, int $parentValue = 0): array
    {
        if ($id > 0) {
            $sql = "SELECT sc.*, 
                to_char(congelation_date, 'YYYYMMDD-HH24MI') as congelation_date_label,
                poisson_campagne_id, matricule,
                sequence_id, sperme_date::date
                from sperme_congelation sc
                join sperme using (sperme_id)
                join poisson_campagne using (poisson_campagne_id)
                join poisson using (poisson_id)
                where sperme_congelation_id = :id:";
            return $this->lireParamAsPrepared($sql, array("id" => $id));
        } else {
            return $this->getDefaultValue($parentValue);
        }
    }
    
    function getAllCongelations(int $year = 0) {
        $sql = "SELECT sc.sperme_congelation_id, sc.sperme_id,            
        poisson_campagne_id, sequence_id,
        congelation_date, congelation_volume, nb_paillette, paillette_volume, nb_visotube, 
        nb_paillettes_utilisees, volume_sperme,operateur,
        matricule, prenom, sperme_mesure_date, concentration, sperme_qualite_libelle
        from sperme_congelation sc
        join sperme s using(sperme_id)
        join poisson_campagne using (poisson_campagne_id)
        join poisson using (poisson_id)
        left outer join sperme_mesure sm on (sm.sperme_mesure_id = 
        (SELECT sperme_mesure_id from sperme_mesure sm2 where sm2.sperme_id = s.sperme_id order by sperme_mesure_id desc limit 1)
        )
        left outer join sperme_qualite sq using (sperme_qualite_id)";
                $data = array();
		if ($year > 0) {
			$sql .= " where annee = :year";
			$data["year"] = $year;
		}
        $this->fields["sperme_mesure_date"] = ["type"=>2];
		return $this->getListeParamAsPrepared($sql, $data);
    }
}
