<?php

require_once 'modules/classes/morphologieImport.class.php';
$import = new MorphologieImport($bdd, $ObjetBDDParam);
$header = array("pittag", "date", "weight", "length", "fork_length");
switch ($t_module["param"]) {
    case "import":
        unset($_SESSION["filename"]);
        $vue->set("poisson/morphologieImport.tpl", "corps");
        break;
    case "matching":
        $vue->set("poisson/morphologieImport.tpl", "corps");
        $vue->set("1", "matching");
        $vue->set($header, "columns");
        if (file_exists($_FILES['upfile']['tmp_name'])) {
            try {
                $import->initFile($_FILES['upfile']['tmp_name'], $_REQUEST["separator"], $header, $_REQUEST["utf8_encode"], $_REQUEST["headernumber"]);
                $filename = $APPLI_temp . '/' . bin2hex(openssl_random_pseudo_bytes(4));
                if (!copy($_FILES['upfile']['tmp_name'], $filename)) {
                    $message->set(_("Impossible de recopier le fichier importé dans le dossier temporaire"), true);
                } else {
                    $vue->set($import->headerLine, "headerFile");
                    $_SESSION["filename"] = $filename;
                    $_SESSION["separator"] = $_REQUEST["separator"];
                    $_SESSION["utf8_encode"] = $_REQUEST["utf8_encode"];
                    $_SESSION["headernumber"] = $_REQUEST["headernumber"];
                }
                $import->fileClose();
            } catch (Exception $e) {
                $module_coderetour = -1;
                $message->set($e->getMessage());
            }
        }
        break;
    case "control":
        /**
         * Lancement des controles
         */
        $vue->set("poisson/morphologieImport.tpl", "corps");
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
                    $vue->set(1, "erreur");
                    $vue->set($resultat, "erreurs");
                    $module_coderetour = -1;
                } else {
                    $vue->set(1, "controleOk");
                }
                $import->fileClose();
                $module_coderetour = 1;
                $vue->set($_REQUEST["utf8_encode"], "utf8_encode");
            } catch (Exception $e) {
                $message->set($e->getMessage());
            }
        } else {
            $module_coderetour = -1;
            $message->set(_("Le fichier téléchargé n'est plus accessible sur le serveur, recommencez l'opération"), true);
        }


        break;
    case "exec":
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
                    $message->set(sprintf(_("Import effectué. %s lignes traitées"), $import->nbTreated));
                    $message->set(sprintf(_("Premier événement généré : %s"), $import->minevent));
                    $message->set(sprintf(_("Dernier événement généré : %s"), $import->maxevent));
                    $log->setLog($_SESSION["login"], "massImportDone", "first event:" . $import->minevent . ",last event:" . $import->maxevent . ", Nb treated lines:" . $import->nbTreated);
                    $module_coderetour = 1;
                    $bdd->commit();
                } catch (ImportMorphologieException $ie) {
                    $bdd->rollBack();
                    $message->set(_("Une erreur s'est produite pendant l'importation."), true);
                    $message->set($ie->getMessage(), true);
                } catch (Exception $e) {
                    $bdd->rollBack();
                    $message->set(_("Une erreur s'est produite pendant l'importation."), true);
                    $message->set($e->getMessage(), true);
                }
            }
        }
        break;
}