<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 20 mars 2014
 */
require_once 'modules/classes/repartTemplate.class.php';
$dataClass = new RepartTemplate($bdd, $ObjetBDDParam);
$keyName = "repart_template_id";
$id = $_REQUEST[$keyName];
switch ($t_module["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		/*
		 * Gestion des variables de recherche
		 */
		if (!isset($_SESSION["searchRepartTemplate"])) {
			$_SESSION["searchRepartTemplate"] = new SearchRepartTemplate();
		}
		$_SESSION["searchRepartTemplate"]->setParam($_REQUEST);
		$dataSearch = $_SESSION["searchRepartTemplate"]->getParam();
		if ($_SESSION["searchRepartTemplate"]->isSearch() == 1) {
			$vue->set(1, "isSearch");
			$data = $dataClass->getListSearch($dataSearch);
		} else {
			$data = array();
		}
		$vue->set($dataSearch, "repartTemplateSearch");
		$vue->set($data, "data");
		$vue->set("aliment/repartTemplateList.tpl", "corps");
		/*
		 * Recherche de la categorie
		 */
		require_once "modules/classes/categorie.class.php";
		$categorie = new Categorie($bdd, $ObjetBDDParam);
		$vue->set($categorie->getListe(2), "categorie");
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = dataRead($dataClass, $id, "aliment/repartTemplateChange.tpl");
		/*
		 * Lecture des categories
		 */
		require_once "modules/classes/categorie.class.php";
		$categorie = new Categorie($bdd, $ObjetBDDParam);
		$vue->set($categorie->getListe(2), "categorie");
		/*
		 * Recuperation des aliments associés
		 */
		if ($data["categorie_id"] > 0 && $id > 0) {
			require_once "modules/classes/repartAliment.class.php";
			$repartAliment = new RepartAliment($bdd, $ObjetBDDParam);
			$vue->set($repartAliment->getFromTemplateWithAliment($id, $data["categorie_id"]), "dataAliment");
		}
		break;
	case "write":
		/*
		 * write record in database
		 */
		$id = dataWrite($dataClass, $_REQUEST);
		if ($id > 0) {
			$_REQUEST[$keyName] = $id;
			/*
			 * Preparation des aliments
			 */
			$data = array();
			foreach ($_REQUEST as $key=>$value) {
				if (preg_match('/[0-9]+$/', $key, $val)) {
					$pos = strrpos($key, "_");
					$nom = substr($key, 0, $pos);
					$data[$val[0]][$nom] = $value;
				}
			}
			/*
			 * Mise en table
			 */
			require_once "modules/classes/repartAliment.class.php";
			$repartAliment = new RepartAliment($bdd, $ObjetBDDParam);
			$error = 0;
			foreach ($data as  $value) {
				if ($value["repart_aliment_id"] > 0 || $value["repart_alim_taux"] > 0) {
					$value["repart_template_id"] = $id;
					$idRepart = $repartAliment->ecrire($value);
					if (!$idRepart > 0) {
						$error = 1;
						$message->set($repartAliment->getErrorData());
					}
				}
			}
			if ($error == 1) {
				$message->set(_("Problème lors de l'enregistrement"), true);
				$module_coderetour = -1;
			}
		}
		break;
	case "delete":
		/*
		 * delete record
		 */
		dataDelete($dataClass, $id);
		break;
}
