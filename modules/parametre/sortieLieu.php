<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 16 avr. 2014
 *  gestion de la table sortie_lieu
 */
include_once 'modules/classes/poisson.class.php';
$dataClass = new SortieLieu($bdd,$ObjetBDDParam);
$keyName = "sortie_lieu_id";
$id = $_REQUEST[$keyName];
switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		$vue->set( , "");("data", $dataClass->getListeActif());
		$vue->set( , "");("corps", "parametre/sortieLieuList.tpl");
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		/*
		 * Lecture des statuts de poissons
		 */
		$poissonStatut = new Poisson_statut($bdd, $ObjetBDDParam);
		$vue->set( , "");("poissonStatut", $poissonStatut->getListe(1));
		dataRead($dataClass, $id, "parametre/sortieLieuChange.tpl");
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

?>