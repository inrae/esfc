<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 7 avr. 2014
 */
include_once 'modules/document/documentSturio.class.php';
$dataClass = new DocumentSturio ( $bdd, $ObjetBDDParam );
$keyName = "document_id";
$id = $_REQUEST [$keyName];

switch ($t_module ["param"]) {
	case "list" :
		break;
	case "display" :
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead ( $dataClass, $id, "document/documentChange.tpl" );
		$smarty->assign ( "moduleParent", $_REQUEST ["moduleParent"] );
		$smarty->assign ( "parentType", $_REQUEST ["parentType"] );
		$smarty->assign ( "parentIdName", $_REQUEST ["parentIdName"] );
		$smarty->assign ( "parent_id", $_REQUEST ["parent_id"] );
		break;
	case "write":
		printr($_REQUEST);
		/*
		 * write record in database
		 */
		if (strlen ( $_REQUEST ["parentType"] ) > 0) {
			foreach ( $_FILES as $key => $file ) {
				$id = $dataClass->ecrire ( $file, $_REQUEST ["document_description"] );
				if ($id > 0) {
					$_REQUEST [$keyName] = $id;
					/*
					 * Ecriture de l'enregistrement en table liee
					 */
					
					$documentLie = new DocumentLie ( $bdd, $ObjetBDDParam, $_REQUEST ["parentType"] );
					$nomAttribParent = $_REQUEST ["parentType"] . "_id";
					$data = array (
							"document_id" => $id,
							$nomAttribParent => $_REQUEST ["parent_id"] 
					);
					$documentLie->ecrire ( $data );
				}
			}
		}
		/*
		 * Retour au module initial
		 */
		$module_coderetour = 1;
		$t_module ["retourok"] = $_REQUEST['moduleParent'];
		$_REQUEST["parentIdName"] = $_REQUEST["parent_id"];
		break;
	case "delete":
		/*
		 * delete record
		 */
		dataDelete ( $dataClass, $id );
		/*
		 * Retour au module initial
		*/
		$module_coderetour = 1;
		$t_module ["retourok"] = $_REQUEST['moduleParent'];
		$_REQUEST["parentIdName"] = $_REQUEST["parent_id"];
		break;
}

?>