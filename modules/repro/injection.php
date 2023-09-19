<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 23 mars 2015
 */

require_once 'modules/classes/injection.class.php';
$dataClass = new Injection($bdd, $ObjetBDDParam);
$keyName = "injection_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead($dataClass, $id, "repro/injectionChange.tpl", $_REQUEST["poisson_campagne_id"]);
		/*
		 * Lecture des séquences
		 */
		require_once 'modules/classes/poissonCampagne.class.php';
		$poissonCampagne = new PoissonCampagne($bdd, $ObjetBDDParam);
		$vue->set($poissonCampagne->lire($_REQUEST["poisson_campagne_id"]), "dataPoisson");
		$vue->set($poissonCampagne->getListSequence($_REQUEST["poisson_campagne_id"], $_SESSION["annee"]), "sequences");
		/*
		 * Lecture des hormones
		 */
		require_once "modules/classes/hormone.class.php";
		$hormone = new Hormone($bdd, $ObjetBDDParam);
		$vue->set($hormone->getListe(2), "hormones");
		break;
	case "write":
		/*
		 * write record in database
		 */
		$id = dataWrite($dataClass, $_REQUEST);
		if ($id > 0) {
			$_REQUEST[$keyName] = $id;
			/*
			 * Mise a jour du statut de poisson_sequence
			 */
			require_once 'modules/classes/poissonSequence.class.php';
			$poissonSequence = new PoissonSequence($bdd, $ObjetBDDParam);
			$poissonSequence->updateStatutFromPoissonCampagne($_REQUEST["poisson_campagne_id"], $_REQUEST["sequence_id"], 3);
		}
		break;
	case "delete":
		/*
		 * delete record
		 */
		dataDelete($dataClass, $id);
		break;
}
