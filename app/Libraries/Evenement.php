<?php

namespace App\Libraries;

use App\Models\Anesthesie;
use App\Models\AnesthesieProduit;
use App\Models\AnomalieDb;
use App\Models\Bassin;
use App\Models\Cohorte;
use App\Models\CohorteType;
use App\Models\DeterminationParente;
use App\Models\DocumentLie;
use App\Models\DocumentSturio;
use App\Models\DosageSanguin;
use App\Models\Echographie;
use App\Models\Evenement as ModelsEvenement;
use App\Models\EvenementType;
use App\Models\Export;
use App\Models\GenderMethode;
use App\Models\GenderSelection;
use App\Models\Genetique;
use App\Models\Morphologie;
use App\Models\Mortalite;
use App\Models\MortaliteType;
use App\Models\Nageoire;
use App\Models\Parente;
use App\Models\Pathologie;
use App\Models\PathologieType;
use App\Models\Poisson;
use App\Models\Sexe;
use App\Models\Sortie;
use App\Models\SortieLieu;
use App\Models\StadeGonade;
use App\Models\StadeOeuf;
use App\Models\Transfert;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Evenement extends PpciLibrary
{
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    public $keyName;
    private $classes = array(
        "poisson",
        "bassin",
        "dosageSanguin",
        "evenementType",
        "pathologieType",
        "genderMethod",
        "sexe",
        "mortaliteType",
        "cohorteType",
        "sortieLieu",
        "anesthesieProduit",
        "nageoire",
        "determinationParente",
        "stadeGonade",
        "stadeOeuf",
        "categorie",
        "poissonStatut",
        "morphologie",
        "genderSelection",
        "pathologie",
        "pittag",
        "transfert",
        "mortalite",
        "cohorte",
        "sortie",
        "echographie",
        "anesthesie",
        "ventilation",
        "genetique",
        "parente",
        "lot",
        "vieModele",
        "transfert",
    );

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsEvenement;
        $this->keyName = "evenement_id";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }
    function change()
    {
        $this->vue = service('Smarty');
        if ($_REQUEST["poisson_id"] > 0) {
            /**
             * Passage en parametre de la liste parente
             */
            $this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
            $evenement_type = new EvenementType;
            $this->vue->set($evenement_type->getListe(2), "evntType");
            $pathologie_type = new PathologieType;
            $this->vue->set($pathologie_type->getListe(2), "pathoType");
            $gender_methode = new GenderMethode;
            $this->vue->set($gender_methode->getListe(1), "genderMethode");
            $sexe = new Sexe;
            $this->vue->set($sexe->getListe(1), "sexe");
            $bassin = new Bassin;
            $this->vue->set($bassin->getListe("bassin_nom"), "bassinList");
            $this->vue->set($bassin->getListe("bassin_nom"), "bassinListActif");
            $mortalite_type = new MortaliteType;
            $this->vue->set($mortalite_type->getListe(2), "mortaliteType");
            $cohorte_type = new CohorteType;
            $this->vue->set($cohorte_type->getListe(2), "cohorteType");
            $sortie_lieu = new SortieLieu;
            $this->vue->set($sortie_lieu->getListeActif(1), "sortieLieu");
            $anesthesie_produit = new AnesthesieProduit;
            $dataProduit = $anesthesie_produit->getListeActif(1);
            $this->dataRead($this->id, "poisson/evenementChange.tpl", $_REQUEST["poisson_id"]);
            $nageoire = new Nageoire;
            $this->vue->set($nageoire->getListe(1), "nageoire");
            $determinationParente = new DeterminationParente;
            $this->vue->set($determinationParente->getListe(1), "determinationParente");
            if (isset($_REQUEST["poisson_campagne_id"])) {
                $this->vue->set($_REQUEST["poisson_campagne_id"], "poisson_campagne_id");
            }

            /**
             * Tables des stades de maturation des oeufs ou gonades
             */
            $stadeGonade = new StadeGonade;
            $stadeOeuf = new StadeOeuf;
            $this->vue->set($stadeGonade->getListe(1), "gonades");
            $this->vue->set($stadeOeuf->getListe(1), "oeufs");
            /**
             * Lecture du poisson
             */
            $poisson = new Poisson;
            $dataPoisson = $poisson->getDetail($_REQUEST["poisson_id"]);
            $this->vue->set($dataPoisson, "dataPoisson");
            $dataTransfert = array();
            /**
             * Lecture des tables associees
             */
            if ($this->id > 0) {
                $morphologie = new Morphologie;
                $this->vue->set($morphologie->getDataByEvenement($this->id), "dataMorpho");
                $pathologie = new Pathologie;
                $this->vue->set($pathologie->getDataByEvenement($this->id), "dataPatho");
                $genderSelection = new GenderSelection;
                $this->vue->set($genderSelection->getDataByEvenement($this->id), "dataGender");
                $mortalite = new Mortalite;
                $this->vue->set($mortalite->getDataByEvenement($this->id), "dataMortalite");
                $cohorte = new Cohorte;
                $this->vue->set($cohorte->getDataByEvenement($this->id), "dataCohorte");
                $sortie = new Sortie;
                $this->vue->set($sortie->getDataByEvenement($this->id), "dataSortie");
                $echographie = new Echographie;
                $this->vue->set($echographie->getDataByEvenement($this->id), "dataEcho");
                $anesthesie = new Anesthesie;
                $dataAnesthesie = $anesthesie->getDataByEvenement($this->id);
                $dosageSanguin = new DosageSanguin;
                $this->vue->set($dosageSanguin->getDataByEvenement($this->id), "dataDosageSanguin");
                $genetique = new Genetique;
                $this->vue->set($genetique->getDataByEvenement($this->id), "dataGenetique");
                $this->vue->set($dataAnesthesie, "dataAnesthesie");
                $parente = new Parente;
                $this->vue->set($parente->getDataByEvenement($this->id), "dataParente");

                /**
                 * Recherche si le produit est toujours utilise
                 */
                if (isset($dataAnesthesie["anesthesie_produit_id"])) {
                    $is_found = false;
                    foreach ($dataProduit as $key => $value) {
                        if ($value["anesthesie_produit_id"] == $dataAnesthesie["anesthesie_produit_id"])
                            $is_found = true;
                    }
                    if ($is_found == false) {
                        $dataProduit[] = array(
                            $dataAnesthesie["anesthesie_produit_id"],
                            $dataAnesthesie["anesthesie_produit_libelle"]
                        );
                    }
                }
                $this->vue->set($dataProduit, "produit");

                /**
                 * Traitement particulier du transfert
                 */
                $transfert = new Transfert;
                $dataTransfert = $transfert->getDataByEvenement($this->id);
            }

            if ($dataPoisson["bassin_id"] > 0) {
                $dataTransfert["dernier_bassin_connu"] = $dataPoisson["bassin_id"];
                $dataTransfert["dernier_bassin_connu_libelle"] = $dataPoisson["bassin_nom"];
            }
            $this->vue->set($dataTransfert, "dataTransfert");
            /**
             * Gestion des documents associes
             */
            $this->vue->set("evenementChange", "moduleParent");
            $this->vue->set("evenement", "parentType");
            $this->vue->set("evenement_id", "parentIdName");
            $this->vue->set($this->id, "parent_id");
            require_once 'modules/document/documentFunctions.php';
            $this->vue->set(getListeDocument("evenement", $this->id, $_REQUEST["document_limit"], $_REQUEST["document_offset"]), "dataDoc");
        }
        return $this->vue->send();
    }
    function write()
    {
        $db = $this->dataclass->db;
        $db->transBegin();
        try {
            /**
		 * write record in database
		 */
            $this->id = $this->dataWrite($_REQUEST);

            /**
             * Ecriture des informations complementaires
             */
            /**
             * Morphologie
             */
            if ($_REQUEST["longueur_fourche"] > 0 || $_REQUEST["longueur_totale"] > 0 || $_REQUEST["masse"] > 0 || $_REQUEST["circonference"] > 0 || strlen($_REQUEST["morphologie_commentaire"]) > 0) {
                $morphologie = new Morphologie;
                $_REQUEST["morphologie_date"] = $_REQUEST["evenement_date"];
                $morphologie->ecrire($_REQUEST);
            }
            /**
             * Pathologie
             */
            if ($_REQUEST["pathologie_type_id"] > 0) {
                $pathologie = new Pathologie;
                $_REQUEST["pathologie_date"] = $_REQUEST["evenement_date"];
                $pathologie->ecrire($_REQUEST);
            }
            /**
             * Sexage
             */
            if ($_REQUEST["sexe_id"] > 0) {
                $genderSelection = new GenderSelection;
                $_REQUEST["gender_selection_date"] = $_REQUEST["evenement_date"];
                $genderSelection->ecrire($_REQUEST);
            }
            /**
             * Transfert
             */
            if ($_REQUEST["bassin_destination"] > 0) {
                $transfert = new Transfert;
                $_REQUEST["transfert_date"] = $_REQUEST["evenement_date"];
                $transfert->ecrire($_REQUEST);
            }
            /**
             * Mortalite
             */
            if ($_REQUEST["mortalite_type_id"] > 0) {
                $mortalite = new Mortalite;
                $_REQUEST["mortalite_date"] = $_REQUEST["evenement_date"];
                $mortalite->ecrire($_REQUEST);
            }
            /**
             * Cohorte
             */
            if ($_REQUEST["cohorte_type_id"] > 0) {
                $cohorte = new Cohorte;
                $_REQUEST["cohorte_date"] = $_REQUEST["evenement_date"];
                $cohorte->ecrire($_REQUEST);
            }
            /**
             * Sortie
             */
            if ($_REQUEST["sortie_lieu_id"] > 0) {
                $sortie = new Sortie;
                $_REQUEST["sortie_date"] = $_REQUEST["evenement_date"];
                $sortie->ecrire($_REQUEST);
            }
            /**
             * Echographie
             */
            if (strlen($_REQUEST["echographie_commentaire"]) > 0 || $_REQUEST["stade_gonade_id"] > 0 || $_REQUEST["stade_oeuf_id"] > 0 || $_FILES["documentName"]['error'] == 0 || $_FILES["documentName"]['error'][0] == 0) {
                $echographie = new Echographie;
                $_REQUEST["echographie_date"] = $_REQUEST["evenement_date"];
                $echographie_id = $echographie->ecrire($_REQUEST);

                /**
                 * Traitement des photos a importer
                 */
                if ($echographie_id > 0 && isset($_FILES["documentName"])) {
                    /**
                     * Preparation de files
                     */
                    $files = formatFiles();
                    $documentSturio = new DocumentSturio;
                    foreach ($files as $file) {
                        $document_id = $documentSturio->ecrire($file, $_REQUEST["document_description"]);
                        if ($document_id > 0) {
                            /**
                             * Ecriture de l'enregistrement en table liee
                             */
                            $documentLie = new DocumentLie('evenement');
                            $data = array(
                                "document_id" => $document_id,
                                "evenement_id" => $this->id
                            );
                            $documentLie->ecrire($data);
                        }
                    }
                }
            }
            /**
             * Anesthesie
             */
            if ($_REQUEST["anesthesie_produit_id"] > 0) {
                $anesthesie = new Anesthesie;
                $_REQUEST["anesthesie_date"] = $_REQUEST["evenement_date"];
                $anesthesie->ecrire($_REQUEST);
            }
            /**
             * Dosage sanguin
             */
            $fields = array(
                "tx_e2",
                "tx_e2_texte",
                "tx_calcium",
                "tx_hematocrite",
                "dosage_sanguin_commentaire"
            );
            $flag = false;
            foreach ($fields as $field) {
                if (strlen($_REQUEST[$field]) > 0)
                    $flag = true;
            }
            if ($flag == true) {
                $_REQUEST["dosage_sanguin_date"] = $_REQUEST["evenement_date"];
                $dosageSanguin = new DosageSanguin;
                $dosageSanguin->ecrire($_REQUEST);
            }
            /**
             * Prelevement genetique
             */
            if (strlen($_REQUEST["genetique_reference"]) > 0) {
                $_REQUEST["genetique_date"] = $_REQUEST["evenement_date"];
                $genetique = new Genetique;
                $genetique->ecrire($_REQUEST);
            }

            /**
             * Determination de parente
             */
            if ($_REQUEST["determination_parente_id"] > 0) {
                $_REQUEST["parente_date"] = $_REQUEST["evenement_date"];
                $parente = new Parente;
                $parente->ecrire($_REQUEST);
            }

            /**
             * Creation d'une nouvelle anomalie a traiter en cas de souci
             */
            if ($_REQUEST["anomalie_flag"] > 0) {
                require_once "modules/classes/anomalie.class.php";
                $anomalie = new AnomalieDb;
                $_REQUEST["anomalie_id"] = 0;
                $_REQUEST["anomalie_db_date"] = $_REQUEST["evenement_date"];
                $_REQUEST["anomalie_db_statut"] = 0;
                $_REQUEST["anomalie_db_type_id"] = $_REQUEST["anomalie_flag"];
                $anomalie->ecrire($_REQUEST);
            }
            /**
             * Gestion de la redirection vers un nouvel evenement pour un autre poisson
             */
            if (!empty($_POST["newtag"])) {
                if (!isset($poisson)) {
                    $poisson = new Poisson;
                }
                $poissonId = $poisson->getPoissonIdFromTag($_POST["newtag"]);
                if ($poissonId > 0) {
                    $_REQUEST["poisson_id"] = $poissonId;
                    return "evenementChange";
                    $_REQUEST["evenement_id"] = 0;
                } else {
                    $this->message->set(sprintf(_("Aucun poisson ne correspond au pittag %s"), $_POST["newtag"]), true);
                }
            }
            $_REQUEST[$this->keyName] = $this->id;
            $db->transCommit();
            return true;
        } catch (PpciException $e) {
            $db->transRollback();
            return false;
        }
    }
    function delete()
    {
        /**
		 * delete record
		 */
        try {
            $this->dataDelete($this->id);
            return true;
        } catch (PpciException $e) {
            return false;
        }
    }
    function getAllCSV()
    {
        /**
		 * Retourne la liste de tous les événements pour les poissons sélectionnés, 
		 * au format CSV
		 */
        $export = new Export();
        $data = $this->dataclass->getAllEvenements($_SESSION["searchPoisson"]->getParam());
        if (is_array($data)) {
            $export->exportCSVinit("sturio-evenements", "tab");
            /**
             * Preparation de la ligne d'entete
             */
            $entete = array();
            foreach ($data[0] as $key => $value) {
                $entete[] = $key;
            }
            $export->setLigneCSV($entete);
            /**
             * Envoi de toutes les lignes
             */
            foreach ($data as $key => $value) {
                $export->setLigneCSV($value);
            }
            /**
             * Envoi au navigateur
             */
            $export->exportCSV();
        }
    }
}
