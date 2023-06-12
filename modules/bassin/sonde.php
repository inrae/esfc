<?php

/**
 * Gestion de l'importation des données de sonde sur les circuits d'eau
 */
require_once 'modules/classes/sonde.class.php';
$dataClass = new Sonde($bdd, $ObjetBDDParam);
$keyName = "sonde_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
    case "write":
        /*
         * write record in database
         */
        $id = dataWrite($dataClass, $_REQUEST);
        if ($id > 0) {
            $_REQUEST[$keyName] = $id;
        }
        break;
    case "delete":
        /*
         * delete record
         */
        dataDelete($dataClass, $id);
        break;
    case "import":
        $vue->set('bassin/sondeImport.tpl', "corps");
        $vue->set($dataClass->getListe(2), "sondes");
        break;
    case "importExec":
        require_once 'modules/document/documentFunctions.php';
        $files = formatFiles("sondeFileName");
        try {
            $result = $dataClass->importData($_REQUEST["sonde_id"], $files);
            /*if (is_numeric($_REQUEST["sonde_id"])) {
                $vue->set($_REQUEST["sonde_id"], "sonde_id");
            }*/
            $message->set($result . " analyses d'eau créées");
            $module_coderetour = 1;
        } catch (Exception $e) {
            $message->set("Echec d'importation des données ", true);
            $message->set($e->getMessage());
            $module_coderetour = -1;
        }
        break;
}
