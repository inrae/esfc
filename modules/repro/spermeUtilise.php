<?php

/**
 * @author : quinton
 * @date : 17 mars 2016
 * @encoding : UTF-8
 * (c) 2016 - All rights reserved
 */
include_once 'modules/classes/sperme.class.php';
$dataClass = new SpermeUtilise($bdd, $ObjetBDDParam);
$keyName = "sperme_utilise_id";
$id = $_REQUEST[$keyName];
$vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");

switch ($t_module["param"]) {
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead($dataClass, $id, "repro/spermeUtiliseChange.tpl", $_REQUEST["croisement_id"]);
		/*
		 * Recuperation du croisement
		 */
		require_once 'modules/classes/croisement.class.php';
		$croisement = new Croisement($bdd, $ObjetBDDParam);
		$croisementData = $croisement->getDetail($_REQUEST["croisement_id"]);
		$vue->set($croisementData, "croisementData");
		/*
		 * Lecture de la sequence
		 */
		require_once "modules/classes/sequence.class.php";
		$sequence = new Sequence($bdd, $ObjetBDDParam);
		$vue->set($sequence->lire($croisementData["sequence_id"]), "dataSequence");
		/*
		 * Recuperation de la liste des spermes potentiels
		 */
		require_once "modules/classes/sperme.class.php";
		$sperme = new Sperme($bdd, $ObjetBDDParam);
		$vue->set($sperme->getListPotentielFromCroisement($_REQUEST["croisement_id"]), "spermes");
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
}
