<?php
/**
* @author eric.quinton
* 13 ao�t 08
*/
$smarty->assign("version",$APPLI_version);
$smarty->assign("versiondate",$APPLI_versiondate);
$smarty->assign("corps","apropos_".$language.".tpl");
$message = $LANG["menu"][9];
?>