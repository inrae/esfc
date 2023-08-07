<?php
require_once 'modules/classes/morphologieImport.class.php';
$import = new MorphologieImport($bdd, $ObjetBDDParam);
$header = array("pittag", "date", "weight", "length", "fork_length");
switch ($t_module["param"]) {
    case "import":
        unset($_SESSION["filename"]);
        $vue->set("poisson/morphologieImport.tpl", "corps");
        break;
    case "control":
        /**
         * Lancement des controles
         */
        $vue->set("poisson/morphologieImport.tpl", "corps");
        if (file_exists($_FILES['upfile']['tmp_name'])) {
            /*
             * Lancement du controle
             */
            try {
                $import->initFile($_FILES['upfile']['tmp_name'], $_REQUEST["separator"], $header, $_REQUEST["utf8_encode"]);
                $resultat = $import->controlAll();
                if (count($resultat) > 0) {
                    /*
                     * Erreurs decouvertes
                     */
                    $vue->set(1, "erreur");
                    $vue->set($resultat, "erreurs");
                    $module_coderetour = -1;
                } else {
                    /*
                     * Deplacement du fichier dans le dossier temporaire
                     */
                    $filename = $APPLI_temp . '/' . bin2hex(openssl_random_pseudo_bytes(4));
                    if (!copy($_FILES['upfile']['tmp_name'], $filename)) {
                        $message->set(_("Impossible de recopier le fichier importé dans le dossier temporaire"), true);
                    } else {
                        $_SESSION["filename"] = $filename;
                        $_SESSION["separator"] = $_REQUEST["separator"];
                        $_SESSION["utf8_encode"] = $_REQUEST["utf8_encode"];
                        $vue->set(1, "controleOk");
                        $vue->set($_FILES['upfile']['name'], "filename");
                    }
                }
            } catch (Exception $e) {
                $message->set($e->getMessage());
            }
        }
        $import->fileClose();
        $module_coderetour = 1;
        $vue->set($_REQUEST["separator"], "separator");
        $vue->set($_REQUEST["utf8_encode"], "utf8_encode");
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
                    $import->initFile($_SESSION["filename"], $_SESSION["separator"], $header, $_SESSION["utf8_encode"]);
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