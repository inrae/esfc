<?php
/**
* @author eric.quinton
* 13 août 08
*/
$smarty->assign("version",$APPLI_version);
$smarty->assign("versiondate",$APPLI_versiondate);
$smarty->assign("corps","apropos_".$language.".html");
$message = $LANG["menu"][9];
?>