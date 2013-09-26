<?php
/** Fichier cree le 14 mai 07 par quinton
*
*UTF-8
*/
@session_start();
include_once("../../../param/param.default.inc.php");
include_once("../../../param/param.inc.php");

if (!$gacl->acl_check($GACL_aco,"admin",$GACL_aro,$_SESSION["login"])){
			header('location:'.$APPLI_address);
		die;
	
}

?>