<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 7 avr. 2014
 */
include_once 'modules/classes/documentSturio.class.php';
require_once 'modules/document/documentFunctions.php';
$dataClass = new DocumentSturio($bdd, $ObjetBDDParam);
$keyName = "document_id";
$id = $_REQUEST[$keyName];
$vars = array("moduleParent", "parentType", "parentIdName", "parent_id", "document_limit", "document_offset");

switch ($t_module["param"]) {

	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead($dataClass, $id, "document/documentChange.tpl");
		foreach ($vars as $var) {
			$vue->set($_REQUEST[$var], $var);
		}
		break;
	case "changeData":
		dataRead($dataClass, $id, "document/documentChangeData.tpl");
		foreach ($vars as $var) {
			$vue->set($_REQUEST[$var], $var);
		}
		$vue->set($_REQUEST["parent_id"], $_REQUEST["parentIdName"]);
		break;
	case "writeData":
		/*
		 * Retour au module initial
		 */
		$dataClass->writeData($_REQUEST);
		$module_coderetour = 1;
		$t_module["retourok"] = $_REQUEST['moduleParent'];
		$_REQUEST[$_REQUEST["parentIdName"]] = $_REQUEST["parent_id"];
		break;
	case "write":
		/*
		 * write record in database
		 */
		if (!empty($_REQUEST["parentType"])) {
			/*
			 * Preparation de files
			 */
			try {
				$files = formatFiles();
				foreach ($files as $file) {
					$id = $dataClass->ecrire($file, $_REQUEST["document_description"], $_REQUEST["document_date_creation"]);
					if ($id > 0) {
						$_REQUEST[$keyName] = $id;
						/**
						 * Ecriture de l'enregistrement en table liee
						 */
						include_once "modules/classes/documentLie.class.php";
						$documentLie = new DocumentLie($bdd, $ObjetBDDParam, $_REQUEST["parentType"]);
						$data = array(
							"document_id" => $id,
							$_REQUEST["parentIdName"] => $_REQUEST["parent_id"]
						);
						$documentLie->ecrire($data);
					}
				}
			} catch (DocumentException $e) {
				$message->set($e->getMessage(), true);
			}
			$log->setLog($_SESSION["login"], get_class($dataClass) . "-write", $id);
		}
		/*
		 * Retour au module initial
		 */
		$module_coderetour = 1;
		$t_module["retourok"] = $_REQUEST['moduleParent'];
		$_REQUEST[$_REQUEST["parentIdName"]] = $_REQUEST["parent_id"];
		break;
	case "delete":
		/*
		 * delete record
		 */
		dataDelete($dataClass, $id);
		/*
		 * Retour au module initial
		*/
		$t_module["retoursuppr"] = $_REQUEST['moduleParent'];
		$t_module["retourok"] = $_REQUEST['moduleParent'];
		$t_module["retourko"] = $_REQUEST['moduleParent'];
		$_REQUEST[$_REQUEST["parentIdName"]] = $_REQUEST["parent_id"];
		break;
	case "get":
		/*
		 * Envoie vers le navigateur le document
		 */
		$_REQUEST["attached"] = 1 ? $attached = true : $attached = false;
		$dataClass->documentSent($id, $_REQUEST["phototype"], $attached);
		break;
}
