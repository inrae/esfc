<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 6 mars 2015
 */
include_once 'modules/classes/biopsie.class.php';
$dataClass = new Biopsie($bdd, $ObjetBDDParam);
$keyName = "biopsie_id";
$id = $_REQUEST[$keyName];
if (isset($_SESSION["sequence_id"]))
	$vue->set($_SESSION["sequence_id"], "sequence_id");
$vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
switch ($t_module["param"]) {
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		require_once 'modules/classes/poissonCampagne.class.php';
		$poissonCampagne = new poissonCampagne($bdd, $ObjetBDDParam);
		$data = dataRead($dataClass, $id, "repro/biopsieChange.tpl", $_REQUEST["poisson_campagne_id"]);
		$vue->set($poissonCampagne->lire($data["poisson_campagne_id"]), "dataPoisson");
		/*
		 * Recuperation des methodes de calcul
		 */
		require_once "modules/classes/biopsieTechniqueCalcul.class.php";
		$biopsieTechniqueCalcul = new BiopsieTechniqueCalcul($bdd, $ObjetBDDParam);
		$vue->set($biopsieTechniqueCalcul->getListe(1), "techniqueCalcul");
		/*
		 * Gestion des documents associes
		 */
		$vue->set("biopsieChange", "moduleParent");
		$vue->set("biopsie", "parentType");
		$vue->set("biopsie_id", "parentIdName");
		$vue->set($id, "parent_id");
		require_once 'modules/document/documentFunctions.php';
		$vue->set(getListeDocument("biopsie", $id, $_REQUEST["document_limit"], $_REQUEST["document_offset"]), "dataDoc");
		break;
	case "write":
		/*
		 * write record in database
		 */
		$id = dataWrite($dataClass, $_REQUEST);
		if ($id > 0) {
			$_REQUEST[$keyName] = $id;
		}
		/*
		 * Traitement des photos a importer
		 */
		if ($id > 0 && isset($_FILES["documentName"])) {
			/*
			 * Preparation de files
			 */
			$files = array();
			$fdata = $_FILES['documentName'];
			if (is_array($fdata['name'])) {
				for ($i = 0; $i < count($fdata['name']); ++$i) {
					$files[] = array(
						'name' => $fdata['name'][$i],
						'type' => $fdata['type'][$i],
						'tmp_name' => $fdata['tmp_name'][$i],
						'error' => $fdata['error'][$i],
						'size' => $fdata['size'][$i]
					);
				}
			} else
				$files[] = $fdata;
			$documentSturio = new DocumentSturio($bdd, $ObjetBDDParam);
			foreach ($files as $file) {
				$document_id = $documentSturio->ecrire($file, "Calcul du diamètre moyen de l'ovocyte - " . $_REQUEST["biopsie_date"]);
				if ($document_id > 0) {
					/*
					 * Ecriture de l'enregistrement en table liee
					 */
					$documentLie = new DocumentLie($bdd, $ObjetBDDParam, 'biopsie');
					$data = array(
						"document_id" => $document_id,
						"biopsie_id" => $id
					);
					$documentLie->ecrire($data);
					/*
					 * Ajout de l'information pour le poisson
					 */
					$documentPoisson = new DocumentLie($bdd, $ObjetBDDParam, "poisson");
					$data["poisson_id"] = $dataClass->getPoissonId($id);
					$documentPoisson->ecrire($data);
				}
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
