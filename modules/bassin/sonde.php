<?php

/**
 * Gestion de l'importation des données de sonde sur les circuits d'eau
 */
include_once 'modules/classes/sonde.class.php';
$dataClass = new Sonde($bdd, $ObjetBDDParam);
$keyName = "sonde_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
    case "list":
		/*
         * Display the list of all records of the table
         */
		 /*
         * $searchExample must be defined into modules/beforesession.inc.php :
         * include_once 'modules/classes/searchParam.class.php';
         * and into modules/common.inc.php :
         * if (!isset($_SESSION["searchExample"])) {
         * $searchExample = new SearchExample();
         *	$_SESSION["searchExample"] = $searchExample; 
         *	} else {
         *	$searchExample = $_SESSION["searchExample"];
         *	}
         * and, also, into modules/classes/searchParam.class.php...
         */
        $searchExample->setParam($_REQUEST);
        $dataSearch = $searchExample->getParam();
        if ($searchExample->isSearch() == 1) {
            $data = $dataClass->getListeSearch($dataExample);
            $vue->set( , "");("data", $data);
            $vue->set( , "");("isSearch", 1);
        }
        $vue->set( , "");("exampleSearch", $dataSearch);
        $vue->set( , "");("data", $dataClass->getListe());
        $vue->set( , "");("corps", "example/exampleList.tpl");
        break;
    case "display":
		/*
         * Display the detail of the record
         */
        $data = $dataClass->lire($id);
        $vue->set( , "");("data", $data);
        $vue->set( , "");("corps", "example/exampleDisplay.tpl");
        break;
    case "change":
		/*
         * open the form to modify the record
         * If is a new record, generate a new record with default value :
         * $_REQUEST["idParent"] contains the identifiant of the parent record 
         */
        dataRead($dataClass, $id, "example/exampleChange.tpl", $_REQUEST["idParent"]);
        break;
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
        $vue->set( , "");('corps', 'bassin/sondeImport.tpl');
        $vue->set( , "");("sondes", $dataClass->getListe(2));
        /**
         * Site
         */
       /* require_once 'modules/classes/site.class.php';
        $site = new Site($bdd, $ObjetBDDParam);
        $vue->set( , "");("site", $site->getListe(2));
        */
        break;
    case "importExec":
        require_once 'modules/document/documentFunctions.php';
        $files = formatFiles("sondeFileName");
        try {
            $result = $dataClass->importData($_REQUEST["sonde_id"], $files);
            if (is_numeric($_REQUEST["sonde_id"])) {
                $vue->set( , "");("sonde_id", $_REQUEST["sonde_id"]);
            }
            $message->set(  $result . " analyses d'eau créées";
            $module_coderetour = 1;
        } catch (Exception $e) {
            $message->set(  "Echec d'importation des données :<br>" . $e->getMessage();
            $module_coderetour = -1;
        }
        break;
}
?>