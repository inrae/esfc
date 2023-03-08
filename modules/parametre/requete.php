<?php
/**
 * Created : 11 déc. 2017
 * Creator : quinton
 * Encoding : UTF-8
 * Copyright 2017 - All rights reserved
 */
require_once 'modules/classes/requete.class.php';
$dataClass = new Requete($bdd,$ObjetBDDParam);
$keyName = "requete_id";
$id = $_REQUEST[$keyName];
switch ($t_module["param"]) {
    case "list":
        /*
         * Display the list of all records of the table
         */
        $vue->set( , "");("data", $dataClass->getListe(2));
        $vue->set( , "");("corps", "parametre/requeteList.tpl");
        break;
    case "change":
        /*
         * open the form to modify the record
         * If is a new record, generate a new record with default value :
         * $_REQUEST["idParent"] contains the identifiant of the parent record
         */
        dataRead($dataClass, $id, "parametre/requeteChange.tpl");
        break;
    case "execListe":
    case "exec":
        $vue->set( , "");("corps", "parametre/requeteChange.tpl");
        $vue->set( , "");("data", $dataClass->lire($id));
        try{
        $vue->set( , "");("result", $dataClass->exec($id));
        $module_coderetour = 1;
        }catch (Exception $e){
            $message->set(  $e->getMessage();
            $module_coderetour = -1;
        }
        break;
    case "write":
        /*
         * write record in database
         */
        $id = dataWrite($dataClass, $_REQUEST);
        if ($id > 0) {
            $_REQUEST[$keyName] = $id;
            $module_coderetour = 1;
        }
        break;
    case "delete":
        /*
         * delete record
         */
        dataDelete($dataClass, $id);
        break;
    case "copy":
        $data = dataRead($dataClass, 0, "parametre/requeteChange.tpl");
        if ($id > 0) {
            $dinit = $dataClass->lire($id);
            if ($dinit["requete_id"] > 0){
                $data ["body"] = $dinit["body"];
                $data["datefields"] = $dinit["datefields"];
                $vue->set( , "");("data", $data);
            }
        }
        break;
    default :
        $message->set(  "Le module demandé n'existe pas";
        $module_coderetour = -1;
}

?>