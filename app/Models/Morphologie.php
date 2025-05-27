<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table morphologie
 *
 * @author quinton
 *        
 */
class Morphologie extends PpciModel
{


    function __construct()
    {
        $this->table = "morphologie";
        $this->fields = array(
            "morphologie_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "poisson_id" => array(
                "type" => 1,
                "requis" => 1,
                "parentAttrib" => 1
            ),
            "longueur_fourche" => array(
                "type" => 1
            ),
            "longueur_totale" => array(
                "type" => 1
            ),
            "masse" => array(
                "type" => 1
            ),
            "morphologie_date" => array(
                "type" => 2
            ),
            "evenement_id" => array(
                "type" => 1
            ),
            "morphologie_commentaire" => array(
                "type" => 0
            ),
            "circonference" => array(
                "type" => 1
            )
        );
        parent::__construct();
    }

    function write($data):int {
        if (strlen($data["morphologie_id"]) == 0) {
            $data["morphologie_id"] = 0;
        }
        return parent::write($data);
    }
    /**
     * Fonction retournant la liste des donnees morphologiques pour un poisson
     *
     * @param int $poisson_id
     * @return array
     */
    function getListeByPoisson(int $poisson_id)
    {
        $sql = "SELECT morphologie_id, m.poisson_id, longueur_fourche, longueur_totale, 
                    masse, circonference, morphologie_date, morphologie_commentaire, 
					m.evenement_id, evenement_type_libelle
					from morphologie m
					left outer join evenement using (evenement_id)
					left outer join evenement_type using (evenement_type_id)
					where m.poisson_id = :id: order by morphologie_date";
        return $this->getListeParamAsPrepared($sql, array("id" => $poisson_id));
    }

    /**
     * Retourne la dernière masse connue pour un poisson
     *
     * @param int $poisson_id
     * @return array
     */
    function getMasseLast(int $poisson_id)
    {
        $sql = "SELECT masse from v_poisson_last_masse
					where  poisson_id = :poisson_id:";
        return $this->lireParamAsPrepared($sql, array("poisson_id" => $poisson_id));
    }

    /**
     * Retourne la masse d'un poisson entre deux dates
     *
     * @param int $poisson_id
     * @param string $date_from
     * @param string $date_to
     * @return array
     */
    function getListMasseFromPoisson(int $poisson_id, string $date_from, string $date_to)
    {

        $sql = "SELECT poisson_id, morphologie_date, masse 
					from morphologie
					where poisson_id = :poisson_id:
					and morphologie_date between :date_from: and :date_to:
					order by morphologie_date";
        return $this->getListeParamAsPrepared(
            $sql,
            array(
                "poisson_id" => $poisson_id,
                "date_from" => $date_from,
                "date_to" => $date_to
            )
        );
    }

    /**
     * Retourne la masse d'un poissson après le 1er juin (post-repro)
     *
     * @param int $poisson_id
     * @param string $date
     * @return array
     */
    function getMasseBeforeDate($poisson_id, $date)
    {
        $sql = "SELECT masse, morphologie_date from morphologie
					where morphologie_date < :date:
					and poisson_id = :poisson_id:
					order by morphologie_date desc
					limit 1";
        return $this->lireParamAsPrepared($sql, array(
            "poisson_id" => $poisson_id,
            "date" => $date
        ));
    }

    /**
     * Retourne la masse d'un poisson avant le 1er juin pré-repro
     *
     * @param int $poisson_id
     * @param int $annee
     * @return array
     */
    function getMasseBeforeRepro($poisson_id, $annee)
    {
        $date_from = $annee . "-01-01";
        $date_to = $annee . "-05-31";
        $sql = "SELECT masse, morphologie_date from morphologie
					where morphologie_date between :date_from: and :date_to:
					and poisson_id = :poisson_id:
					order by morphologie_date asc
					limit 1";
        return $this->lireParamAsPrepared($sql, array(
            "poisson_id" => $poisson_id,
            "date_from" => $date_from,
            "date_to" => $date_to
        ));
    }

    /**
     * Lit un enregistrement à partir de l'événement
     *
     * @param int $evenement_id
     * @return array
     */
    function getDataByEvenement(int $evenement_id)
    {
        $sql = "SELECT * from morphologie where evenement_id = :id:";
        return $this->lireParamAsPrepared($sql, array("id" => $evenement_id));
    }

    function generateGraphAsJson(array $data = array()): array
    {
        $result = array();
        $dc = array();
        $max = array(0 => 0, 1 => 0);
        if ($_SESSION["FORMATDATE"] = "fr") {
            $dateFormat = "%d/%m/%Y";
        } else {
            $dateFormat = "/%Y%/m%/d";
        }
        $k = array(
            _("masse"),
            _("longueur fourche"),
            _("longueur totale")
        );
        $vdate = array();
        $vval = array();
        for ($i =  0; $i < 3; $i++) {
            $dc["xs"][$k[$i]] = "x" . $i + 1;
            $vdate[$i] = array("x" . $i + 1);
            $vval[$i] = array($k[$i]);
            $max[$i] = 0;
        }
        foreach ($data as $row) {
            if (!empty($row["masse"])) {
                $vdate[0][] = $row["morphologie_date"];
                $vval[0][] = $row["masse"];
                if ($row["masse"] > $max[0]) {
                    $max[0] = $row["masse"];
                }
            }
            if (!empty($row["longueur_fourche"])) {
                $vdate[1][] = $row["morphologie_date"];
                $vval[1][] = $row["longueur_fourche"];
                if ($row["longueur_fourche"] > $max[1]) {
                    $max[1] = $row["longueur_fourche"];
                }
            }
            if (!empty($row["longueur_totale"])) {
                $vdate[2][] = $row["morphologie_date"];
                $vval[2][] = $row["longueur_totale"];
                if ($row["longueur_totale"] > $max[1]) {
                    $max[1] = $row["longueur_totale"];
                }
            }
            $lastdate = $row["morphologie_date"];
        }
        for ($i =  0; $i < 3; $i++) {
            $dc["columns"][] = $vdate[$i];
            $dc["columns"][] = $vval[$i];
        }
        $dc["axes"][$k[0]] = 'y';
        $dc["axes"][$k[1]] = 'y2';
        $dc["axes"][$k[2]] = 'y2';
        $dc["xFormat"] = $dateFormat;
        $result["data"] = json_encode($dc);
        $result["maxweight"] = $max[0];
        $result["maxlength"] = $max[1];
        $result["firstdate"] = $data[0]["morphologie_date"];
        $result["lastdate"] = $lastdate;
        $result["dateFormat"] = $dateFormat;

        return $result;
    }
}
