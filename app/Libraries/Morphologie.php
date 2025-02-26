<?php 
namespace App\Libraries;

use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class  extends PpciLibrary { 
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    private $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ;
        $this->keyName = "";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }

require_once 'modules/classes/morphologieImport.class.php';
$import = new MorphologieImport;
$header = array("pittag", "date", "weight", "length", "fork_length");
       function import() {
        unset($_SESSION["filename"]);
        $this->vue->set("poisson/morphologieImport.tpl", "corps");
        }
       function matching() {
        $this->vue->set("poisson/morphologieImport.tpl", "corps");
        $this->vue->set("1", "matching");
        $this->vue->set($header, "columns");
        if (file_exists($_FILES['upfile']['tmp_name'])) {
            try {
                $import->initFile($_FILES['upfile']['tmp_name'], $_REQUEST["separator"], $header, $_REQUEST["utf8_encode"], $_REQUEST["headernumber"]);
                $filename = $APPLI_temp . '/' . bin2hex(openssl_random_pseudo_bytes(4));
                if (!copy($_FILES['upfile']['tmp_name'], $filename)) {
                    $this->message->set(_("Impossible de recopier le fichier importé dans le dossier temporaire"), true);
                } else {
                    $this->vue->set($import->headerLine, "headerFile");
                    $_SESSION["filename"] = $filename;
                    $_SESSION["separator"] = $_REQUEST["separator"];
                    $_SESSION["utf8_encode"] = $_REQUEST["utf8_encode"];
                    $_SESSION["headernumber"] = $_REQUEST["headernumber"];
                }
                $import->fileClose();
            } catch (Exception $e) {
                $module_coderetour = -1;
                $this->message->set($e->getMessage());
            }
        }
        }
       function control() {
        /**
         * Lancement des controles
         */
        $this->vue->set("poisson/morphologieImport.tpl", "corps");
        if (file_exists($_SESSION["filename"])) {

            /*
             * Lancement du controle
             */
            try {
                $import->initFile($_SESSION["filename"], $_SESSION["separator"], $header, $_SESSION["utf8_encode"], $_SESSION["headernumber"]);
                /**
                 * Get the match between furnished columns and required columns
                 */
                $translate = array();
                foreach ($header as $column) {
                    if (!empty($_POST[$column])) {
                        $translate[$_POST[$column]] = $column;
                    }
                }
                $_SESSION["importTranslate"] = $translate;
                $import->setRealCols($translate);
                $resultat = $import->controlAll();
                if (count($resultat) > 0) {
                    /*
                     * Erreurs decouvertes
                     */
                    $this->vue->set(1, "erreur");
                    $this->vue->set($resultat, "erreurs");
                    $module_coderetour = -1;
                } else {
                    $this->vue->set(1, "controleOk");
                }
                $import->fileClose();
                $module_coderetour = 1;
                $this->vue->set($_REQUEST["utf8_encode"], "utf8_encode");
            } catch (Exception $e) {
                $this->message->set($e->getMessage());
            }
        } else {
            $module_coderetour = -1;
            $this->message->set(_("Le fichier téléchargé n'est plus accessible sur le serveur, recommencez l'opération"), true);
        }


        }
       function exec() {
        $module_coderetour = -1;
        if (isset($_SESSION["filename"])) {
            if (file_exists($_SESSION["filename"])) {
                try {
                    /*
                     * Demarrage d'une transaction
                     */
                    $bdd->beginTransaction();
                    $import->initFile($_SESSION["filename"], $_SESSION["separator"], $header, $_SESSION["utf8_encode"], $_SESSION["headernumber"]);
                    $import->setRealCols($_SESSION["importTranslate"]);
                    $import->importAll();
                    $this->message->set(sprintf(_("Import effectué. %s lignes traitées"), $import->nbTreated));
                    $this->message->set(sprintf(_("Premier événement généré : %s"), $import->minevent));
                    $this->message->set(sprintf(_("Dernier événement généré : %s"), $import->maxevent));
                    $log->setLog($_SESSION["login"], "massImportDone", "first event:" . $import->minevent . ",last event:" . $import->maxevent . ", Nb treated lines:" . $import->nbTreated);
                    $module_coderetour = 1;
                    $bdd->commit();
                } catch (ImportMorphologieException $ie) {
                    $bdd->rollBack();
                    $this->message->set(_("Une erreur s'est produite pendant l'importation."), true);
                    $this->message->set($ie->getMessage(), true);
                } catch (Exception $e) {
                    $bdd->rollBack();
                    $this->message->set(_("Une erreur s'est produite pendant l'importation."), true);
                    $this->message->set($e->getMessage(), true);
                }
            }
        }
        }
}