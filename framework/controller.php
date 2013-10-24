<?php
/**
 * Controleur de l'application (modele MVC)
 * Fichier modifie le 21 mars 2013 par Eric Quinton
 *
 */
/**
 * Lecture des parametres
 */
include_once ("framework/common.inc.php");
/**
 * Recuperation du module
 */
unset ( $module );
if (isset ( $_REQUEST ["module"] )) {
	$module = $_REQUEST ["module"];
} else {
	/*
	 * Definition du module par defaut
	 */
	$module = "default";
}
/**
 * Gestion des modules
 */
while ( isset ( $module ) ) {
	/*
	 * Recuperation du tableau contenant les attributs du module
	 */
	$t_module = array ();
	$t_module = $navigation->getModule ( $module );
	/*
	 * Verification si le module est bien appele apres son parent
	 */

	/*
	 * Verification si le login est requis
	*/
	if (strlen ( $t_module ["droits"] ) > 1 || $t_module ["loginrequis"] == 1) {
		/*
		 * Verification du login
		 */
		if (! isset ( $_SESSION ["login"] )) {
			/*
			 * Traitement suivant le type d'identification
			 */
			if ($ident_type == "CAS") {
				$identification->getLogin ();
			} else {
				/*
				 * On verifie si on est en retour de validation du login
				 */
				if (isset ( $_REQUEST ["login"] )) {
					if ($ident_type == "BDD") {
						$loginGestion = new LoginGestion ( $bdd_gacl );
						$res = $loginGestion->VerifLogin ( $_REQUEST ['login'], $_REQUEST ['password'] );
						if ($res == TRUE) {
							$_SESSION ["login"] = $_REQUEST ["login"];
							unset ( $_SESSION ["menu"] );
						}
					} else {
						$identification->testLoginLdap ( $_REQUEST ["login"], $_REQUEST ['password'] );
					}
				} else {
					/*
					 * Gestion de la saisie du login
					 */
					$smarty->assign ( "corps", "ident/login.tpl" );
					$smarty->assign ( "module", $_REQUEST ["module"] );
					$message = $LANG ["login"] [2];
				}
			}
			/*
			 * Si le login a ete valide, on definit les droits
			 */
			if (isset ( $_SESSION ["login"] )) {
				/*
				 * Regeneration de l'identifiant de session
				 */
				session_regenerate_id ();
				/*
				 * Recuperation des cookies le cas echeant
				 */
				include 'modules/cookies.inc.php';
				/*
				 * Calcul des droits
				 */
				include "framework/identification/setDroits.php";
			}
		}
	}
	$resident = 1;
	if ($t_module ["loginrequis"] == 1 && ! isset ( $_SESSION ["login"] ))
		$resident = 0;
		/*
	 * Verification des droits
	 */
	if (strlen ( $t_module ["droits"] ) > 1) {
		if (! isset ( $_SESSION ["login"] )) {
			$resident = 0;
			$motifErreur = "nologin";
		} else {
			$resident = $gestionDroit->getgacl ( $t_module ["droits"] );
			if ($resident == 0)
				$motifErreur = "droitko";
		}
	}
	
	/*
	 * Verification que le module soit bien appele apres le module qui doit le preceder La recherche peut contenir plusieurs noms de modules, separes par le caractere |
	 */
	if (strlen ( $t_module ["modulebefore"] ) > 0) {
		$before = explode ( ",", $t_module ["modulebefore"] );
		$beforeok = false;
		foreach ( $before as $key => $value ) {
			if ($_SESSION ["moduleBefore"] == $value)
				$beforeok = true;
		}
		if ($beforeok == false) {
			$resident = 0;
			$motifErreur = "errorbefore";
		}
	}
	/*
	 * fin d'analyse du module
	 */
	if ($t_module ["ajax"] != 1) $_SESSION ["moduleBefore"] = $module;
	unset ( $module );
	unset ( $module_coderetour );
	/*
	 * Execution du module
	 */
	if ($resident == 1) {
		include $t_module ["action"];
		/*
		 * Recuperation du code de retour et affectation du nom du nouveau module
		 */
		if (isset ( $module_coderetour )) {
			switch ($module_coderetour) {
				case - 1 :
					$module = $t_module ["retourko"];
					break;
				case 0 :
					$module = $t_module ["retournull"];
					break;
				case 1 :
					$module = $t_module ["retourok"];
					break;
				case 2 :
					$module = $t_module ["retoursuppr"];
					break;
				case 3 :
					$module = $t_module ["retournext"];
					break;
			}
		}
	} else {
		/*
		 * Traitement des erreurs
		 */
		switch ($motifErreur) {
			case "droitko" :
				if (strlen ( $t_module ["droitko"] ) > 1) {
					$module = $t_module ["droitko"];
				} else {
					$module = $APPLI_moduleDroitKO;
				}
				break;
			case "nologin" :
				$module = $APPLI_moduleErrorLogin;
				break;
			case "errorbefore" :
				$module = $APPLI_moduleErrorBefore;
				break;
		}
	}
}

if ($t_module ["ajax"] != 1) {
	/*
	 * Affichage du message d'accueil
	 */
	if ($message == "")
		$message = $LANG ["message"] [0];
	$smarty->assign ( "message", $message );
	/*
	 * Gestion du menu Rajout du 17/8/09 : mise en cache du menu
	 */
	if (! isset ( $_SESSION ["menu"] )) {
		include ("framework/navigation/menu.inc.php");
	} else {
		$menu = $_SESSION ["menu"];
	}
	$smarty->assign ( "menu", $menu );
	/*
	 * Affichage de la page
	 */
	/*
	 * Alerte Mode developpement
	*/
	if ($APPLI_modeDeveloppement == true) {
		$texteDeveloppement = $LANG ["message"] [32] . " : " . $BDDDEV_server . '/' . $BDDDEV_database;
		$smarty->assign ( "developpementMode", $texteDeveloppement );
	}
	$smarty->display ( $SMARTY_principal );
}
?>
