<?php

namespace App\Models;

use Ppci\Libraries\PpciException;

class CreateFishFromBatch
{

    public array $content;
    private $separator = ",";
    private $utf8_encode = false;
    private $handle;
    public array $headers;
    private $columns = ["pittag", "pittag_type_id", "tag", "tag_type_id", "longueur_totale", "longueur_fourche", "masse", "commentaire"];
    public $poissonIdMin = 9999999;
    public $poissonIdMax = 0;
    function initFile($filename, $separator = ",",  $utf8_encode = false)
    {
        if ($separator == "tab") {
            $separator = "\t";
        }
        $this->separator = $separator;
        $this->utf8_encode = $utf8_encode;
        /**
         * Ouverture du fichier
         */
        if ($this->handle = fopen($filename, 'r')) {
            /**
             * Lecture de la premiere ligne et affectation des colonnes
             */
            $header = $this->readLine();
            foreach ($header as $pos => $name) {
                if (in_array($name, $this->columns)) {
                    $this->headers[$name] = $pos;
                }
            }
            /**
             * Read content of the file, and assign it before treatment
             */
            while (($line = $this->readLine()) !== false) {
                if (!empty($line)) {
                    $current = [];
                    foreach ($this->headers as $name => $col) {
                        $current[$name] = $line[$col];
                    }
                    $this->content[] = $current;
                }
            }
            $this->fileClose();
        } else {
            throw new PpciException(sprintf(_("Le fichier %s n'a pas été trouvé ou n'est pas lisible"), $filename));
        }
    }
    function createFish(array $ddevenir, $bassin_destination = 0)
    {
        $poisson = new Poisson;
        $event = new Evenement;
        $morphologie = new Morphologie;
        $parentPoisson = new ParentPoisson;
        $pittag = new Pittag;
        $lot = new Lot;
        $nb = 0;
        $line = 1;
        $devenirType = new DevenirType;
        if ($bassin_destination > 0) {
            $transfert = new Transfert;
        }
        if (in_array($ddevenir["devenir_type_id"], [1, 3, 4])) {
            $sortie = new Sortie;
        }
        $dlot = $lot->getDetail($ddevenir["lot_id"]);
        $ddevenirType = $devenirType->read($ddevenir["devenir_type_id"]);
        $evenement_type_id = $ddevenirType["evenement_type_id"];
        if ($ddevenir["devenir_type_id"] == 1) {
            $status = 4;
        } else if (in_array($ddevenir["devenir_type_id"], [3, 4])) {
            $status = 3;
        } else {
            $status = 1;
        }
        $croisement = new Croisement;
        $parents = $croisement->getPoissonIdFromCroisement($dlot["croisement_id"]);
        /**
         * Treatment of each row of the file
         */
        foreach ($this->content as $row) {
            if (empty($row["pittag"])) {
                throw new PpciException(sprintf(_("Ligne %s : le pittag n'a pas été renseigné"), $line));
            }
            $dpoisson = [
                "poisson_id" => 0,
                "poisson_statut_id" => $status,
                "matricule" => $row["pittag"],
                "cohorte" => $dlot["annee"],
                "commentaire" => $row["commentaire"],
                "date_naissance" => $dlot["eclosion_date"],
                "categorie_id" => 2,
                "sexe_id" => 3,
                "lot_id" => $ddevenir["lot_id"]
            ];
            $poisson_id = $poisson->write($dpoisson);
            /**
             * Add parents
             */
            foreach ($parents as $parent) {
                $dparent = [
                    "parent_poisson_id" => 0,
                    "poisson_id" => $poisson_id,
                    "parent_id" => $parent["poisson_id"]
                ];
                $parentPoisson->write($dparent);
            }
            /**
             * Add pittags
             */
            $dpittag = [
                "pittag_id" => 0,
                "poisson_id" => $poisson_id,
                "pittag_valeur" => $row["pittag"],
                "pittag_type_id" => $row["pittag_type_id"],
                "pittag_date_pose" =>$ddevenir["devenir_date"]
            ];
            $pittag->write($dpittag);
            if (!empty($row["tag"])) {
                $dpittag["pittag_valeur"] = $row["tag"];
                $dpittag["pittag_type_id"] = $row["tag_type_id"];
                $pittag->write($dpittag);
            }
            /**
             * Add event
             */
            $devent = [
                "evenement_id" => 0,
                "poisson_id" => $poisson_id,
                "evenement_type_id" => $evenement_type_id,
                "evenement_date" => $ddevenir["devenir_date"]
            ];
            $evenement_id = $event->write($devent);
            /**
             * Add morphology
             */
            if (!empty($row["longueur_totale"]) || !empty($row["longueur_fourche"]) || !empty($row["masse"])) {
                $dmorphologie = [
                    "morphologie_id" => 0,
                    "poisson_id" => $poisson_id,
                    "evenement_id" => $evenement_id,
                    "longueur_totale" => $row["longueur_totale"],
                    "longueur_fourche" => $row["longueur_fourche"],
                    "masse" => $row["masse"]
                ];
                $morphologie->write($dmorphologie);
            }
            /**
             * Add transfert
             */
            if (!empty($bassin_destination)) {
                $dtransfert = [
                    "transfert_id" => 0,
                    "poisson_id" => $poisson_id,
                    "evenement_id" => $evenement_id,
                    "bassin_destination" => $bassin_destination,
                    "transfert_date" => $ddevenir["devenir_date"]
                ];
                $transfert->write($dtransfert);
            }
            /**
             * add exit
             */
            if (!empty($ddevenir["sortie_lieu_id"])) {
                $dsortie = [
                    "sortie_id" => 0,
                    "poisson_id" => $poisson_id,
                    "evenement_id" => $evenement_id,
                    "sortie_lieu_id" => $ddevenir["sortie_lieu_id"],
                    "sortie_date" => $ddevenir["devenir_date"]
                ];
                $sortie->write($dsortie);
            }
            /**
             * update the min and max of poisson_id
             */
            if ($poisson_id < $this->poissonIdMin) {
                $this->poissonIdMin = $poisson_id;
            }
            $this->poissonIdMax = $poisson_id;
            $nb++;
            $line++;
        }
        return $nb;
    }
    /**
     * read the next line in the file
     *
     * @return array|false
     */
    function readLine()
    {
        if ($this->handle) {
            $data = fgetcsv($this->handle, 1000, $this->separator);
            if ($data !== false) {
                if ($this->utf8_encode) {
                    $data = mb_convert_encoding($data, 'UTF-8', 'ISO-8859-15, ISO-8859-1, Windows-1252');
                }
            }
            return $data;
        } else {
            return false;
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
}
