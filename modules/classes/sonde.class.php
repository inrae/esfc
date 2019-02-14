<?php

class SondeException extends Exception
{
};
/**
 * ORM de gestion de la table sonde
 */
class Sonde extends ObjetBDD
{
    /**
     * Constructeur
     *
     * @param PDO $bdd
     * @param array $param
     */
    function __construct($bdd, $param = array())
    {
        $this->table = "sonde";
        $this->colonnes = array(
            "sonde_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "sonde_name" => array("requis" => 1),
            "sonde_param" => array("type" => 0)
        );
        parent::__construct($bdd, $param);
    }

    /**
     * Fonction initialisant l'importation des données, 
     * et déclenchant l'import lui-même
     *
     * @param int $sonde_id
     * @param array $files
     * @return int
     */
    function importData($sonde_id, array $files)
    {
        $result = 0;
        $dsonde = $this->lire($sonde_id);
        if (!$dsonde["sonde_id"] > 0) {
            throw new SondeException("Le modèle de sonde n'est pas décrit dans la base de données");
        }
        $param = json_decode(($dsonde["sonde_param"]));
        if (param["filetype"] == "xslx") {
            /**
             * Initialisation Excel
             */
            $reader = new \PhpOffice\PhpSpreadsheet\Reader\Xlsx();
            $reader->setLoadSheetsOnly($param["sheetname"]);

        }
        /**
         * Extraction des données
         */
        $data = array();
        foreach ($files as $file) {
            if ($file['error'] != UPLOAD_ERR_OK) {
                throw new SondeException("Le fichier " . $file["name"] . " n'a pas été téléchargé correctement");
            }
            if ($param["filetype"] == "xslx") {
                $spreadSheet = $reader->load($file["tmp_name"]);
                $sheet = $spreadSheet->getActiveSheet();
                $highestRow = $sheet->getHighestRow("A");
                if (!hightestRow > 1) {
                    throw new SondeException("L'onglet " . $param["sheetname"] . " de " . $file["name"] . " est vide ou inexistant");
                }
                /**
                 * Recuperation de la ligne d'entete
                 */
                $highestColumn = $sheet->getHighestColumn(1);
                $header = array();
                $i = 1;
                for ($col = 'A'; $col != $highestColumn; ++$col) {
                    $header[$i] = $sheet->getCell($col . "1");
                    $i++;
                }
                /**
                 * Recuperation du tableau contenant les donnees
                 */
                for ($row = 2; $row <= $highestRow; $row++) {
                    $i = 1;
                    $drow = array();
                    for ($col = 'A'; $col != $highestColumn; ++$col) {
                        $drow[$header[$i]] = $sheet->getCell($col . $row);
                        $i++;
                    }
                    $data[] = $drow;
                }
            }
        }
        /**
         * Traitement de l'import
         */
        if ($dsonde["sonde_name"] == "pcwin") {
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
    function importPcwin($param, $data)
    {
        require_once 'modules/classes/bassin.class.php';
        $circuitEau = new Circuit_eau($this->connection, $this->paramori);
        $analyseEau = new AnalyseEau($this->connection, $this->paramori);
        $result = array();
        $circuits = array();
        $listeAnalyse = array(); /* tableau contenant la liste des dates d'analyse pour un bassin, et les analyses par date */
        foreach ($data as $row) {
            /**
             * Verification que les données fournies ne sont pas anormales
             */
            if ( (strlen($row["value"] > 0) and ! in_array($row["value"], $param["abnormalvalues"]))) {
                /**
                 * Extraction du nom du circuit d'eau
                 */
                $drank = explode (" - ", $row["rank"]);
                $circuitName = substr($drank[0], 3);
                $realCircuitName = $param["circuits"][$circuitName];
                /**
                 * Recuperation du circuit_eau_id
                 */
                if (isset ($circuits[$realCircuitName])) {
                    $circuit_id = $circuits[$realCircuitName];
                } else {
                    $dcircuit = $circuitEau->getIdFromName($realCircuitName);
                    if ($dcircuit["circuit_eau_id"] > 0) {
                        $circuit_id = $dcircuit["circuit_eau_id"];
                        $circuits[$realCircuitName] = $dcircuit["circuit_eau_id"];
                    } else {
                        throw new SondeException("Le circuit d'eau ".$realCircuitName." n'est pas connu dans la base de données");
                    }
                }
                /**
                 * Recherche s'il existe déjà une analyse
                 */
                $analyseId = $analyseEau->getIdFromDateCircuit($row["date"],$circuit_id);
                if (! $analyseId["analyse_eau_id"] > 0) {
                    /**
                     * Recherche de l'attribut correspondant au critère analysé
                     */
                    $attribut = $param["attributs"][substring($drank[1],0, 1)];
                    if (strlen($attribut)>0) {
                    $listeAnalyse[$circuit_id] [$row["date"]] [$attribut] = $row["value"];
                    } else {
                        throw new SondeException("La valeur analysée ".$drank[1]. " n'est pas décrite dans le fichier de paramétrage");
                    }
                    //$analyse = array("circuit_eau_id"=>$circuit_id); 
                }
            }
        }
        /**
         * Traitement de l'écriture en table
         */
        $nb = 0;
        foreach ($listeAnalyse as $circuitId => $circuit) {
            foreach ($circuit as $analyseDate=>$analyse) {
                $danalyse = array("circuit_eau_id"=>$circuitId, "analyse_eau_date"=>$analyseDate);
                foreach ($analyse as $row => $value) {
                    $danalyse[$row] = $value;
                    try {
                        $analyseEau->ecrire($danalyse);
                        $nb ++;
                    } catch (Exception $e) {
                        throw new SondeException("Erreur lors de l'écriture dans la table analyse_eau : ".implode(",",$danalyse));
                    }
                }
            }
        }
        return ($nb);
    }
}
?>