<?php
/** Fichier cree le 10 mai 07 par quinton
 *
 *UTF-8
 */

$loginGestion = new LoginGestion($bdd_gacl,$ObjetBDDParam);
//$loginGestion = _new("LoginGestion");
/**
 * R�cup�ration du type d'action
 */
if (isset($_REQUEST["action"])){
	if ($_REQUEST["action"]=="M") {
		//Modification
		if (isset($_REQUEST["id"])) {
			$list=array();
			$list=$_REQUEST;
			$ret=$loginGestion->ecrire($list);
//$ret = _ecrire("loginGestion",$list);
			if ($ret>0) {
				$message= $LANG["message"][5];
				$_REQUEST["id"]=$ret;
			}else{
				$message=formatErrorData($loginGestion->getErrorData());
				$message.=$LANG["message"][12];
			}
		}

	}elseif ($_REQUEST["action"]=="S"&&$_REQUEST["id"]>0) {
		//Suppression
		if($loginGestion->supprimer($_REQUEST["id"])==1) {
			$message=$LANG["message"][4];
			unset($_REQUEST["id"]);
			$module_coderetour = 1;
		}else{
			$message=$LANG["message"][13];
		}

	}elseif ($_REQUEST["action"]=="X"){
		$module_coderetour = 0;
	}
}
if (isset($_REQUEST["id"])) {
	$id = $_REQUEST['id'];
}

if (isset($id)){
	$list=$loginGestion->lire($id);
	$smarty->assign("list",$list);
	$smarty->assign("corps","ident/loginsaisie.tpl");
//}else{
//	$message=$LANG["message"][14];
}

?>