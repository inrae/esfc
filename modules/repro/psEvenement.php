<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 10 mars 2015
 */

require_once 'modules/classes/psEvenement.class.php';
$dataClass = new PsEvenement($bdd, $ObjetBDDParam);
$keyName = "ps_evenement_id";
$id = $_REQUEST[$keyName];
if (isset($vue)) {
	if (isset($_SESSION["sequence_id"])) {
		$vue->set($_SESSION["sequence_id"], "sequence_id");
	}
	$vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
}
switch ($t_module["param"]) {
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$dataPsEvenement = $dataClass->lire($id, true, $_REQUEST["poisson_sequence_id"]);
		/*
		 * Affectation des donnees a smarty
		 */
		$vue->set($dataPsEvenement, "dataPsEvenement");
		$vue->set($id, "ps_evenement_id");
		$module_coderetour = 1;
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