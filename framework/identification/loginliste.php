<?php
/** Fichier cree le 10 mai 07 par quinton
*
*UTF-8
*/

$loginGestion = new LoginGestion($bdd_gacl,$ObjetBDDParam);
//$loginGestion = _new("LoginGestion");
$liste = array();
$liste = $loginGestion->getListeTriee();
$smarty->assign("liste",$liste);
$smarty->assign("corps","ident/loginliste.tpl");

?>