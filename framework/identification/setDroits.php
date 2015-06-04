<?php
/**
 * Definit les droits si le login est connu
 */
if (isset ( $_SESSION ["login"] )) {
	if ($GACL_new == true) {
		require_once 'framework/droits/droits.class.php';
		$acllogin = new Acllogin ( $bdd_gacl, $ObjetBDDParam );
		$_SESSION ["droits"] = $acllogin->getListDroits ( $_SESSION ["login"], $GACL_aco );
		$smarty->assign ( "droits", $_SESSION ["droits"] );
	} else {
		include_once ("plugins/phpgacl/gacl.class.php");
		$phpgacl = new gacl ();
		$gestionDroit->setgacl ( $phpgacl, $GACL_aco, $GACL_aro, $GACL_listeDroitsGeres );
		$smarty->assign ( "droits", $gestionDroit->getDroits () );
	}
}
?>