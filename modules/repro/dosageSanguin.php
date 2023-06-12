<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 6 mars 2015
 */

require_once 'modules/classes/dosageSanguin.class.php';
require_once 'modules/classes/poissonCampagne.class.php';
$dataClass = new DosageSanguin($bdd, $ObjetBDDParam);
$keyName = "dosage_sanguin_id";
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
		$poissonCampagne = new poissonCampagne($bdd, $ObjetBDDParam);
		$data = dataRead($dataClass, $id, "repro/dosageSanguinChange.tpl", $_REQUEST["poisson_campagne_id"]);
		$vue->set($poissonCampagne->lire($data["poisson_campagne_id"]), "dataPoisson");
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
