<?php
/**
 * Ensemble de fonctions utilisees pour la gestion des fiches
 */

/**
 * Lit un enregistrement dans la base de donnees, affecte le tableau a Smarty,
 * et declenche l'affichage de la page associee
 * @param instance $dataClass
 * @param int $id
 * @param string $smartyPage
 * @param int $idParent
 * @return array
 */
function dataRead($dataClass, $id, $smartyPage, $idParent=null) {
	global $smarty;
	if ($id > 0) {
		$data=$dataClass->lire($id);
		/*
		 * Gestion des valeurs par defaut
		*/
	} else {
		$data=$dataClass->getDefaultValue($idParent);
	}
	/*
	 * Affectation des donnees a smarty
	*/
	$smarty->assign("data",$data);
	$smarty->assign("corps",$smartyPage);
	return $data;
}
/**
 * Ecrit un enregistrement en base de donnees
 * @param instance $dataClass
 * @param array $data
 * @return int
 */
function dataWrite ($dataClass, $data) {
	global $message, $LANG, $module_coderetour, $log;
	$id = $dataClass->write($data) ;
	if (strlen($message)>0) $message.='<br>';
	if ($id > 0) {
		$message .= $LANG["message"][5];
		$module_coderetour = 1;
		$log -> setLog($_SESSION["login"], get_class($dataClass)."-write",$id);
	} else {
		/*
		 * Mise en forme du message d'erreur
		 */
		$message.=formatErrorData($dataClass->getErrorData());
		$message.=$LANG["message"][12];
		$module_coderetour = -1;
	}
	return ($id);
}
/**
 * Supprime un enregistrement en base de donnees
 * @param instance $dataClass
 * @param int $id
 * @return int
 */
function dataDelete($dataClass, $id) {
	global $message, $LANG, $module_coderetour, $log;
	if (is_numeric($id) && $id > 0) {
		if (strlen($message)>0) $message.='<br>';
		$ret=$dataClass->supprimer($id);
		if ($ret>0) {
			$message= $LANG["message"][4];
			$module_coderetour=2;
			$log -> setLog($_SESSION["login"], get_class($dataClass)."-delete",$id);
		}else{
			/*
			 * Mise en forme du message d'erreur
			 */
			$message=formatErrorData($dataClass->getErrorData());
			$message.=$LANG["message"][13];
			$module_coderetour=-1;
		}
	}
	return($ret);
}
/**
 * Modifie la langue utilisee dans l'application
 * @param string $langue
 */
function setlanguage($langue) {

	global $language, $LANG, $APPLI_cookie_ttl ;
	/*
	 * Chargement de la langue par defaut
	*/
	include ('locales/' . $language . ".php");
	/*
	 * On gere le cas ou la langue selectionnee n'est pas la langue par defaut
	*/
	if ($language != $langue) {
		$LANGORI = $LANG;
		/*
		 * Test de l'existence du fichier locales selectionne
		*/
		if (file_exists ( 'locales/' . $langue . '.php' )) {
			include 'locales/'.$langue.'.php';
			$LANGDIFF = $LANG;
			/*
			 * Fusion des deux tableaux
			*/
			$LANG=array();
			$LANG = array_replace_recursive($LANGORI,$LANGDIFF);
		}
	}
	/*
	 * Mise en session de la langue
	*/
	$_SESSION ['LANG'] = $LANG;
	/*
	 * Ecriture du cookie
	*/

	setcookie ( 'langue', $langue, time() +  $APPLI_cookie_ttl);
}
?>