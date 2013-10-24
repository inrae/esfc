<?php
/**
 * Definit les droits si le login est connu
 */
if(isset($_SESSION["login"])) {
	include_once ("plugins/phpgacl/gacl.class.php");
	$phpgacl = new gacl();
	$gestionDroit->setgacl($phpgacl, $GACL_aco, $GACL_aro, $GACL_listeDroitsGeres);
	$smarty->assign("droits",$gestionDroit->getDroits());
}
?>