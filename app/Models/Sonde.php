<?php

namespace App\Models;

use PhpOffice\PhpSpreadsheet\Reader\Xlsx as ReaderXlsx;
use Ppci\Models\PpciModel;
use Ppci\Libraries\PpciException;

/**
 * ORM de gestion de la table sonde
 */
class Sonde extends PpciModel
{
    public CircuitEau $circuitEau;
    public AnalyseEau $analyseEau;
    /**
     * Constructeur
     *
     * @param PDO $bdd
     * @param array $param
     */
    function __construct()
    {
        $this->table = "sonde";
        $this->fields = array(
            "sonde_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "sonde_name" => array("requis" => 1),
            "sonde_param" => array("type" => 0)
        );
        parent::__construct();
    }

    /**
     * Fonction initialisant l'importation des données, 
     * et déclenchant l'import lui-même
     *
     * @param int $sonde_id
     * @param array $files
     * @return int
     */
    function importData(int $sonde_id, array $files)
    {
        $result = 0;
        $dsonde = $this->lire($sonde_id);
        if (!$dsonde["sonde_id"] > 0) {
            throw new PpciException("Le modèle de sonde n'est pas décrit dans la base de données");
        }
        $param = json_decode($dsonde["sonde_param"], true);
        if ($param["filetype"] == "xslx") {
            /**
             * Initialisation Excel
             */
            $reader = new ReaderXlsx;
            $reader->setLoadSheetsOnly($param["sheetname"]);
        }
        /**
         * Extraction des données
         */
        $data = array();
        foreach ($files as $file) {
            if ($file['error'] != UPLOAD_ERR_OK) {
                throw new PpciException(sprintf(_("Le fichier %s n'a pas été téléchargé correctement"), $file["name"]));
            }
            if ($param["filetype"] == "xslx") {
                $spreadSheet = $reader->load($file["tmp_name"]);
                $sheet = $spreadSheet->getActiveSheet();
                $highestRow = $sheet->getHighestRow("A");
                if (!($highestRow > 1)) {
                    throw new PpciException(sprintf(_("L'onglet %1s de %2s est vide ou inexistant"), $param["sheetname"], $file["name"]));
                }
                /**
                 * Recuperation de la ligne d'entete
                 */
                $highestColumn = $sheet->getHighestColumn(1);
                $header = array();
                $i = 1;
                for ($col = 'A'; $col != $highestColumn; $col++) {
                    $header[$i] = $sheet->getCell($col . "1")->getValue();
                    $i++;
                }
                $header[$i] = $sheet->getCell($highestColumn . "1")->getValue();
                /**
                 * Recuperation du tableau contenant les donnees
                 */
                for ($row = 2; $row <= $highestRow; $row++) {
                    $i = 1;
                    $drow = array();
                    for ($col = 'A'; $col != $highestColumn; ++$col) {
                        $drow[$header[$i]] = $sheet->getCell($col . $row)->getFormattedValue();
                        $i++;
                        $drow[$header[$i]] = $sheet->getCell($highestColumn . $row)->getFormattedValue();
                    }
                    $data[] = $drow;
                }
            }
        }
        /**
         * Traitement de l'import
         */
        if ($dsonde["sonde_id"] == 1) {
            $result = $this->importPcwin($param, $data);
        }
        return $result;
    }

    /**
     * Fonction générant l'import pour les fichiers créés par Pcwin
     *
     * @param array $param : paramètres de l'importation
     * @param array $data : jeu de données
     * @return int
     */
    function importPcwin(array $param, array $data)
    {
        if (!isset($this->circuitEau)) {
            $this->circuitEau = new CircuitEau;
        }
        if (!isset($this->analyseEau)) {
            $this->analyseEau = new AnalyseEau;
        }
        $circuits = array();
        $listeAnalyse = array(); /* tableau contenant la liste des dates d'analyse pour un bassin, et les analyses par date */
        foreach ($data as $row) {
            /**
             * Verification que les données fournies ne sont pas anormales
             */
            if ((!empty($row["value"]) and ! in_array($row["value"], $param["abnormalvalues"]))) {
                /**
                 * Extraction du nom du circuit d'eau
                 */
                $drank = explode($param["fieldSeparator"], $row["rank"]);
                $circuitName = substr($drank[0], 3);
                if (isset($param["circuits"][$circuitName])) {
                    $realCircuitName = $param["circuits"][$circuitName];
                } else {
                    $realCircuitName = $circuitName;
                }
                /**
                 * Recuperation du circuit_eau_id
                 */
                if (isset($circuits[$realCircuitName])) {
                    $circuit_id = $circuits[$realCircuitName];
                } else {
                    $dcircuit = $this->circuitEau->getIdFromName($realCircuitName);
                    if ($dcircuit["circuit_eau_id"] > 0) {
                        $circuit_id = $dcircuit["circuit_eau_id"];
                        $circuits[$realCircuitName] = $dcircuit["circuit_eau_id"];
                    } else {
                        throw new PpciException(sprintf(_("Le circuit d'eau %s n'est pas connu dans la base de données"), $realCircuitName));
                    }
                }
                /**
                 * Recherche s'il existe déjà une analyse
                 */
                $analyseId = $this->analyseEau->getIdFromDateCircuit($row["date"], $circuit_id);
                if (! $analyseId["analyse_eau_id"] > 0) {
                    /**
                     * Recherche de l'attribut correspondant au critère analysé
                     */
                    $attribut = $param["attributs"][substr($drank[1], 0, 1)];
                    if (!empty($attribut)) {
                        $listeAnalyse[$circuit_id][$row["date"]][$attribut] = $row["value"];
                    } else {
                        throw new PpciException(sprintf(_("La valeur analysée %s n'est pas décrite dans le fichier de paramétrage"), $drank[1]));
                    }
                }
            }
        }
        /**
         * Traitement de l'écriture en table
         */
        $nb = 0;
        foreach ($listeAnalyse as $circuitId => $circuit) {
            foreach ($circuit as $analyseDate => $analyse) {
                $danalyse = array("circuit_eau_id" => $circuitId, "analyse_eau_date" => $analyseDate);
                foreach ($analyse as $row => $value) {
                    $danalyse[$row] = $value;
                }
                try {
                    $this->analyseEau->ecrire($danalyse);
                    $nb++;
                } catch (\Exception) {
                    throw new PpciException(sprintf(_("Erreur lors de l'écriture dans la table analyse_eau : %s"), implode(",", $danalyse)));
                }
            }
        }
        return ($nb);
    }
}
