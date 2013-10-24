<?php
/**
 * Code generique appele systematiquement pour toute ecriture de fiche
 * Necessite une instanciation de la classe heritee d'objetBDD,
 * dans la variable $dataClass
 * L'identifiant de la fiche doit etre stocke dans la variable $id
 * $corps doit contenir le tpl utilise pour afficher l'ecran
 * de modification de la fiche
 */

if (isset($_REQUEST["action"])){
	/*
	 * Modification
	*/
	if (isset($id)) {
		$ret=$dataClass->ecrire($_REQUEST);
		if ($ret>0) {
			$message= $LANG["message"][5];
			$id=$ret;
			$module_coderetour=1;
		}else{
			$message=formatErrorData($dataClass->getErrorData());
			$message.=$LANG["message"][12];
			$module_coderetour=-1;
		}
	}
}
if (!isset($module_coderetour)&&isset($id)){
	$data=$dataClass->lire($id);
	/*
	 * Gestion des valeurs par defaut
	*/
	if (is_array($dataDefaut)) {
		foreach($dataDefaut as $key => $value) {
			$data[$key]=$value;
		}
	}
	$smarty->assign("data",$data);
	$smarty->assign("corps",$corps);
}
?>