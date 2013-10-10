<?php
/**
 * Preparation automatique du menu a partir du fichier xml
 */
$menuarray = $navigation->genererMenu();
/* 
 * Tri du tableau selon les cles
 */
ksort($menuarray);
$menu = "<ul>";
foreach ($menuarray as $key => $value){
	$ok = true;
	/* 
	 * Verification des droits
	 */
	if ($value["menuloginrequis"]==1 && !isset($_SESSION["login"])) $ok = false;
	if (strlen($value["menudroits"])>1&& $gestionDroit->getgacl($value["menudroits"])<>1) $ok = false;
	if ($value["onlynoconnect"] == 1 && strlen($_SESSION["login"])>0) $ok = false;
	/* 
	 * Preparation menu niveau 0
	 */
	if ($ok) {
		$menu .= '<li id="'.$value["module"].'"><a href="index.php?module='.$value["module"].'" title="'
		.$LANG["menu"][$value["menutitle"]].'">'.$LANG["menu"][$value["menuvalue"]].'</a>';
		$flag=0;
		/* 
		 * Gestion sous-menu
		 */
		ksort($value);
		foreach($value as $key1 => $value1){
			if (is_array($value1)) {
				$ok1 = true;
				/* 
				 * Verification des droits
				 */
				if ($value1["menuloginrequis"]==1 && !isset($_SESSION["login"])) $ok1 = false;
				if (strlen($value1["menudroits"])>1&& $gestionDroit->getgacl($value1["menudroits"])<>1) $ok1 = false;
				if ($ok1) {
					/* 
					 * Preparation du sous-menu
					 */
					if ($flag==0) {
						$menu .="<ul>";
						$flag = 1;
					}
					$menu .= '<li id="'.$value1["module"].'"><a href="index.php?module='.$value1["module"].'" title="'
					.$LANG["menu"][$value1["menutitle"]].'">'.$LANG["menu"][$value1["menuvalue"]].'</a></li>';
				}				
			}
		}
		if ($flag == 1) $menu .="</ul>";
		$menu .="</li>";
	}
}
$menu .="</ul>";
/* 
 * Mise en cache du menu
 */
$_SESSION["menu"]=$menu;
?>