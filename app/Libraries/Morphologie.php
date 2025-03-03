<?php

namespace App\Libraries;

use App\Models\Morphologie as ModelsMorphologie;
use App\Models\MorphologieImport;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Morphologie extends PpciLibrary
{
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    public $keyName;
    private MorphologieImport $import;
    private $header = array("pittag", "date", "weight", "length", "fork_length");
    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsMorphologie;
        $this->keyName = "morphologie_id";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
        $this->import = new MorphologieImport;
    }
    function import()
    {
        $this->vue = service('Smarty');
        unset($_SESSION["filename"]);
        $this->vue->set("poisson/morphologieImport.tpl", "corps");
        return $this->vue->send();
    }
    function matching()
    {
        $this->vue = service('Smarty');
        $this->vue->set("poisson/morphologieImport.tpl", "corps");
        $this->vue->set("1", "matching");
        $this->vue->set($this->header, "columns");
        if (file_exists($_FILES['upfile']['tmp_name'])) {
            try {
                $this->import->initFile($_FILES['upfile']['tmp_name'], $_REQUEST["separator"], $this->header, $_REQUEST["utf8_encode"], $_REQUEST["headernumber"]);

                $filename = $this->appConfig->APP_temp . '/' . bin2hex(openssl_random_pseudo_bytes(4));
                if (!copy($_FILES['upfile']['tmp_name'], $filename)) {
                    throw new PpciException(_("Impossible de recopier le fichier importé dans le dossier temporaire"));
                }
                $this->vue->set($this->import->headerLine, "headerFile");
                $_SESSION["filename"] = $filename;
                $_SESSION["separator"] = $_REQUEST["separator"];
                $_SESSION["utf8_encode"] = $_REQUEST["utf8_encode"];
                $_SESSION["headernumber"] = $_REQUEST["headernumber"];
                $this->import->fileClose();
            } catch (PpciException $e) {
                $this->message->set($e->getMessage(), true);
                return false;
            }
        }
        return $this->vue->send();
    }

    function control()
    {
        /**
         * Lancement des controles
         */
        $this->vue = service('Smarty');
        $this->vue->set("poisson/morphologieImport.tpl", "corps");
        if (file_exists($_SESSION["filename"])) {
            /**
             * Lancement du controle
             */
            try {
                $this->import->initFile($_SESSION["filename"], $_SESSION["separator"], $this->header, $_SESSION["utf8_encode"], $_SESSION["headernumber"]);
                /**
                 * Get the match between furnished columns and required columns
                 */
                $translate = array();
                foreach ($this->header as $column) {
                    if (!empty($_POST[$column])) {
                        $translate[$_POST[$column]] = $column;
                    }
                }
                $_SESSION["importTranslate"] = $translate;
                $this->import->setRealCols($translate);
                $resultat = $this->import->controlAll();
                if (count($resultat) > 0) {
                    /**
                     * Erreurs decouvertes
                     */
                    $this->vue->set(1, "erreur");
                    $this->vue->set($resultat, "erreurs");
                } else {
                    $this->vue->set(1, "controleOk");
                }
                $this->import->fileClose();
                $this->vue->set($_REQUEST["utf8_encode"], "utf8_encode");
            } catch (PpciException $e) {
                $this->message->set($e->getMessage(), true);
            }
        } else {
            $this->message->set(_("Le fichier téléchargé n'est plus accessible sur le serveur, recommencez l'opération"), true);
        }
        return $this->vue->send();
    }
    function exec()
    {
        if (isset($_SESSION["filename"])) {
            if (file_exists($_SESSION["filename"])) {
                $db = $this->dataclass->db;
                try {
                    /**
                     * Demarrage d'une transaction
                     */
                    $db->transBegin();
                    $this->import->initFile($_SESSION["filename"], $_SESSION["separator"], $this->header, $_SESSION["utf8_encode"], $_SESSION["headernumber"]);
                    $this->import->setRealCols($_SESSION["importTranslate"]);
                    $this->import->importAll();
                    $this->message->set(sprintf(_("Import effectué. %s lignes traitées"), $this->import->nbTreated));
                    $this->message->set(sprintf(_("Premier événement généré : %s"), $this->import->minevent));
                    $this->message->set(sprintf(_("Dernier événement généré : %s"), $this->import->maxevent));
                    $this->log->setLog($_SESSION["login"], "massImportDone", "first event:" . $this->import->minevent . ",last event:" . $this->import->maxevent . ", Nb treated lines:" . $this->import->nbTreated);
                    $db->transCommit();
                    return true;
                } catch (PpciException $ie) {
                    $db->transRollback();
                    $this->message->set(_("Une erreur s'est produite pendant l'importation."), true);
                    $this->message->set($ie->getMessage(), true);
                    return false;
                }
            }
        }
    }
}
