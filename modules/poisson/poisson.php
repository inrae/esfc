<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 25 févr. 2014
 */
include_once 'modules/classes/poisson.class.php';
$dataClass = new Poisson($bdd,$ObjetBDDParam);
$keyName = "poisson_id";
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
		include "modules/poisson/poissonSearch.php";
		if ($searchPoisson->isSearch () == 1) {
			$data = $dataClass->getListeSearch ( $dataSearch );
			$smarty->assign ( "data", $data );
		}
		$smarty->assign("corps", "poisson/poissonList.tpl");
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$data = $dataClass->getDetail($id);
		$smarty->assign("dataPoisson", $data);
		/*
		 * Recuperation des morphologies
		 */
		$morphologie = new Morphologie($bdd, $ObjetBDDParam);
		$smarty->assign("dataMorpho", $morphologie->getListeByPoisson($id));
		/*
		 * Recuperation des événements
		 */
		include_once 'modules/classes/evenement.class.php';
		$evenement = new Evenement($bdd, $ObjetBDDParam);
		$smarty->assign("dataEvenement",$evenement->getEvenementByPoisson($id));
		/*
		 * Recuperation du sexage
		 */
		$gender_selection = new Gender_selection($bdd, $ObjetBDDParam);
		$smarty->assign("dataGender",$gender_selection->getListByPoisson($id));
		/*
		 * Recuperation des pathologies
		 */
		$pathologie = new Pathologie($bdd, $ObjetBDDParam);
		$smarty->assign("dataPatho", $pathologie->getListByPoisson($id));
		/*
		 * Recuperation des pittag
		 */
		$pittag = new Pittag($bdd, $ObjetBDDParam);
		$smarty->assign("dataPittag", $pittag->getListByPoisson($id));
		/*
		 * Recuperation des transferts
		 */
		$transfert = new Transfert($bdd, $ObjetBDDParam);
		$smarty->assign("dataTransfert", $transfert->getListByPoisson($id));
		/*
		 * Affichage
		 */
		$smarty->assign("corps", "poisson/poissonDisplay.tpl");
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data=dataRead($dataClass, $id, "poisson/poissonChange.tpl");
		$sexe = new Sexe($bdd, $ObjetBDDParam);
		$smarty->assign("sexe", $sexe->getListe());
		$poissonStatut = new Poisson_statut($bdd, $ObjetBDDParam);
		$smarty->assign("poissonStatut", $poissonStatut->getListe());
		/*
		 * Recuperation de la liste des types de pittag
		*/
		$pittagType = new Pittag_type($bdd, $ObjetBDDParam);
		$smarty->assign("pittagType", $pittagType->getListe());
		/*
		 * Recuperation du dernier pittag connu
		 */
		$pittag = new Pittag($bdd,$ObjetBDDParam);
		$smarty->assign("dataPittag", $pittag->getListByPoisson($id,1));
		break;
	case "write":
		/*
		 * write record in database
		 */
		$id = dataWrite($dataClass, $_REQUEST);
		if ($id > 0) {
			$_REQUEST[$keyName] = $id;
			/*
			 * Ecriture du pittag
			 */
			if (strlen($_REQUEST["pittag_valeur"]) > 0) {
				$pittag = new Pittag($bdd,$ObjetBDDParam);
				$idPittag = $pittag->ecrire($_REQUEST);
				if (! $idPittag > 0) {
					$module_coderetour = -1;
					$message.=formatErrorData($pittag->getErrorData());
					$message.=$LANG["message"][12];
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

?>