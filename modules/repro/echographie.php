<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 11 mars 2015
 */

require_once 'modules/classes/echographie.class.php';
$dataClass = new Echographie($bdd, $ObjetBDDParam);
$keyName = "echographie_id";
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
		$poissonCampagne = new PoissonCampagne($bdd, $ObjetBDDParam);
		$data = dataRead($dataClass, $id, "repro/echographieChange.tpl", $_REQUEST["poisson_campagne_id"]);
		$vue->set($poissonCampagne->lire($data["poisson_campagne_id"]), "dataPoisson");
		/*
		 * Tables des stades
		 */
		require_once 'modules/classes/stadeGonade.class.php';
		require_once 'modules/classes/stadeOeuf.class.php';
		$stadeGonade = new StadeGonade($bdd, $ObjetBDDParam);
		$stadeOeuf = new StadeOeuf($bdd, $ObjetBDDParam);
		$vue->set($stadeGonade->getListe(1), "gonades");
		$vue->set($stadeOeuf->getListe(1), "oeufs");
		/*
		 * Gestion des documents associes
		 */
		$vue->set("echographieChange", "moduleParent");
		$vue->set("echographie", "parentType");
		$vue->set("echographie_id", "parentIdName");
		$vue->set($id, "parent_id");
		require_once "modules/classes/documentSturio.class.php";
		require_once 'modules/document/documentFunctions.php';
		$vue->set(getListeDocument("echographie", $id, $_REQUEST["document_limit"], $_REQUEST["document_offset"]), "dataDoc");

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
