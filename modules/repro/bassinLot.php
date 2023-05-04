<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 7 mai 2015
 */

include_once 'modules/classes/bassin.class.php';
$dataClass = new BassinLot($bdd, $ObjetBDDParam);
$keyName = "bassin_lot_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {

	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = dataRead($dataClass, $id, "repro/bassinLotChange.tpl", $_REQUEST["lot_id"]);
		$bassin = new Bassin($bdd, $ObjetBDDParam);
		$vue->set($bassin->getListe(1, 6), "bassins");
		require_once 'modules/classes/lot.class.php';
		$lot = new Lot($bdd, $ObjetBDDParam);
		$vue->set($lot->getDetail($data["lot_id"]), "dataLot");
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
