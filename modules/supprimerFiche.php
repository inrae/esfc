<?php
/**
 * code a inclure dans une page pour gerer la suppression d'une fiche
 * $id contient l'identifiant a supprimer
 * $dataClass est l'instance de l'objet herite d'ObjetBDD utilisee pour acceder aux donnees
 */
if (isset($id)) {
	$ret=$dataClass->supprimer($id);
	if ($ret>0) {
		$message= $LANG["message"][4];
		$id=$ret;
		$module_coderetour=2;
	}else{
		$message=formatErrorData($dataClass->getErrorData());
		$message.=$LANG["message"][13];
		$module_coderetour=-1;
	}
}
?>