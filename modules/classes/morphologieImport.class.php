<?php
class FichierException extends Exception
{
}

class HeaderException extends Exception
{
}

class ImportMorphologieException extends Exception
{
}

class MorphologieImport
{

    private $separator = ",";
    private $utf8_encode = false;
    private $handle;
    private $fileColumn = array();
    public $nbTreated = 0;
    private $colonnes = array();
    public $minevent = 9999999;
    public $maxevent = 0;
    public PDO $bdd;
    public array $ObjetBDDParam;
    private $poisson, $evenement, $morphologie;
    public $classpath = "modules/classes";

    function __construct(PDO $bdd, array $ObjetBDDParam = array())
    {
        $this->bdd = $bdd;
        $this->ObjetBDDParam = $ObjetBDDParam;
    }

    function initFile($filename, $separator = ",", array $colonnes, $utf8_encode = false)
    {
        if ($separator == "tab") {
            $separator = "\t";
        }
        $this->separator = $separator;
        $this->utf8_encode = $utf8_encode;
        $this->colonnes = $colonnes;
        /**
         * Ouverture du fichier
         */
        if ($this->handle = fopen($filename, 'r')) {
            /**
             * Lecture de la premiere ligne et affectation des colonnes
             */
            $data = $this->readLine();
            $range = 0;
            for ($range = 0; $range < count($data); $range++) {
                $value = $data[$range];
                if (in_array($value, $this->colonnes)) {
                    $this->fileColumn[$range] = $value;
                } else {
                    throw new HeaderException(sprintf(_('La colonne %1$s n\'est pas reconnue (%2$s)'), $range, $value));
                }
            }
        } else {
            throw new FichierException(sprintf(_("Le fichier %s n'a pas été trouvé ou n'est pas lisible"), $filename));
        }
    }
    function readLine()
    {
        if ($this->handle) {
            $data = fgetcsv($this->handle, 1000, $this->separator);
            if ($data !== false) {
                if ($this->utf8_encode) {
                    foreach ($data as $key => $value) {
                        $data[$key] = utf8_encode($value);
                    }
                }
            }
            return $data;
        } else {
            return null;
        }
    }

    /**
     * Ferme le fichier
     */
    function fileClose()
    {
        if ($this->handle) {
            fclose($this->handle);
        }
    }

    function importAll()
    {
        $date = date("Y-m-d H:i:s");
        $num = 0;
        /**
         * Inhibition du traitement des dates par la classe
         */
        if (!isset($this->poisson)) {
            $this->classInstanciate("Poisson", "poisson.class.php");
        }
        if (!isset($this->evenement)) {
            $this->classInstanciate("Evenement", "evernement.class.php");
        }
        if (!isset($this->morphologie)) {
            $this->classInstanciate("Morphologie", "morphologie.class.php");
        }
        $this->evenement->auto_date = 0;
        $this->morphologie->auto_date = 0;
        /**
         * Traitement du fichier
         */
        while (($line = $this->readLine()) !== false) {

            $num++;
            /**
             * Controle de la ligne
             */
            $resControle = $this->controlLine($line);
            if (!$resControle["code"]) {
                throw new ImportMorphologieException("Line $num : " . $resControle["message"]);
            }

            /**
             * Debut d'ecriture en table
             */
            try {
                $dpoisson = $this->poisson->getPoissonIdFromTag($line["pittag"]);
                $line["date"] = $this->formatDate($line["date"]);
                /**
                 * Search from event
                 */
                $evenement_id = $this->evenement->getEvenementIdByPoissonDate($dpoisson["poisson_id"], $line["date"]);
                if ($evenement_id == 0) {
                    $devenement = array("evenement_id"=>0,
                    "poisson_id"=>$dpoisson["poisson_id"],
                    "evenement_date"=>$line["date"],
                    "evenement_type_id"=> 15);
                    $evenement_id = $this->evenement->ecrire($devenement);
                }
                /**
                 * Search from preexistent morphologie
                 */
                $dmorphologie = $this->morphologie->getDataByEvenement($evenement_id);
                if (!empty($dmorphologie["morphologie_id"])) {
                    $dmorphologie ["morphologie_id"] = 0;
                    $dmorphologie["evenement_id"] = $evenement_id;
                    $dmorphologie["poisson_id"] = $dpoisson["poisson_id"];
                }
                if (!empty($line["weight"])) {
                    $dmorphologie["masse"] = $line["weight"];
                }
                if (!empty($line["length"])) {
                    $dmorphologie["longueur_totale"] = $line["length"];
                }
                if (!empty($line["fork_length"])) {
                    $dmorphologie["longueur_fourche"] = $line["fork_length"];
                }
                $this->morphologie->ecrire($dmorphologie);

                /**
                 * Mise a jour des bornes de l'uid
                 */
                if ($evenement_id < $this->minevent) {
                    $$this->minevent = $evenement_id;
                }
                if ($evenement_id > $this->maxevent) {
                    $this->maxevent = $evenement_id;
                }
            } catch (Exception $pe) {
                throw new ImportMorphologieException("Line $num : error when import sample - " . $pe->getMessage());
            }
            $this->nbTreated++;
        }
    }

    function controlAll()
    {
        if (!isset($this->poisson)) {
            $this->poisson = $this->classInstanciate("Poisson", "poisson.class.php");
        }
        $num = 1;
        $retour = array();
        while (($line = $this->readLine()) !== false) {
            $num++;
            $controle = $this->controlLine($line);
            if (!$controle["code"]) {
                $retour[] = array(
                    "line" => $num,
                    "message" => $controle["message"]
                );
            }
        }
        return $retour;
    }

    /**
     * Controle une ligne
     *
     * @param array $data
     * @return array ["code"=>boolean,"message"=>string]
     */
    function controlLine($data)
    {
        $retour = array(
            "code" => true,
            "message" => ""
        );
        $ok = true;
        /**
         * Search the fish from pittag
         */
        if (!empty($data["pittag"])) {
            $res = $this->poisson->getPoissonIdFromTag($data["pittag"]);
            if (!$res["poisson_id"] > 0) {
                $retour["code"] = false;
                $retour["message"] = sprintf(_("Le pittag %s ne correspond à aucun poisson"), $data["pittag"]);
                $ok = false;
            }
        } else {
            $retour["code"] = false;
            $retour["message"] = _("Le pittag n'a pas été renseigné");
            $ok = false;
        }
        if ($ok) {
            if (empty($data["date"])) {
                $retour["code"] = false;
                $retour["message"] = _("La date de mesure n'a pas été renseignée");
                $ok = false;
            }
        }
        if ($ok) {
            $empty = true;
            foreach (array("weight", "length", "fork_length") as $col) {
                if (!empty($data[$col])) {
                    if (!is_numeric($data[$col])) {
                        $retour["code"] = false;
                        $retour["message"] = sprintf(_("La colonne %1s contient une valeur non numérique (%2s)"), $col, $data[$col]);
                        $ok = false;
                    }
                    $empty = false;
                }
            }
            if ($empty) {
                $retour["code"] = false;
                $retour["message"] = _("Aucune mesure n'a été renseignée");
                $ok = false;
            }
        }
        return $retour;
    }
    /**
     * Instanciate a DB Class
     *
     * @param string $className
     * @param string $classFile
     * @param boolean $pathAbsolute
     * @return object
     */
    function classInstanciate(string $className, string $classFile, bool $pathAbsolute = false)
    {
        $pathAbsolute ? $path = $classFile : $path = $this->classpath . "/" . $classFile;
        include_once $path;
        if (!isset($this->bdd)) {
            throw new ObjetBDDException(sprintf(_("La connexion à la base de données n'est pas disponible pour instancier la classe %s"), $className));
        }
        return new $className($this->bdd, $this->ObjetBDDParam);
    }

    /**
     * Fonction reformatant la date en testant le format francais, puis standard
     *
     * @param string $date
     * @return string
     */
    function formatDate($date)
    {
        $val = "";
        /**
         * Verification du format de date
         */
        $date1 = explode(" ", $date);
        $timeLength = strlen($date1[1]);
        if ($timeLength > 0) {
            /**
             * Reformate the time
             */
            if ($timeLength == 5) {
                /**
                 * Add seconds
                 */
                $date1[1] .= ":00";
            }
            /**
             * Regenerate the date
             */
            $date = $date1[0] . " " . $date1[1];
            $mask = $_SESSION["MASKDATELONG"];
        } else {
            $mask = $_SESSION["MASKDATE"];
        }
        $result = date_parse_from_format($mask, $date);
        if ($result["warning_count"] > 0) {
            /**
             * La date est attendue avec le format yyyy-mm-dd
             */
            $date2 = explode("-", $date1[0]);
            $result = date_parse($date);
            if ($result["year"] != $date2[0] || str_pad($result["month"], 2, "0", STR_PAD_LEFT) != $date2[1] || str_pad($result["day"], 2, "0", STR_PAD_LEFT) != $date2[2]) {
                $result["warning_count"] = 1;
            }
        }
        if ($result["warning_count"] == 0) {
            $val = $result["year"] . "-" . str_pad($result["month"], 2, "0", STR_PAD_LEFT) . "-" . str_pad($result["day"], 2, "0", STR_PAD_LEFT);
            if (strlen($result["hour"]) > 0 && strlen($result["minute"]) > 0) {
                $val .= " " . str_pad($result["hour"], 2, "0", STR_PAD_LEFT) . ":" . str_pad($result["minute"], 2, "0", STR_PAD_LEFT);
                if (strlen($result["second"]) == 0) {
                    $result["second"] = 0;
                }
                $val .= ":" . str_pad($result["second"], 2, "0", STR_PAD_LEFT);
            }
        }
        return $val;
    }
}