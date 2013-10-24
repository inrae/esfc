<?php
/** Fichier cree le 4 mai 07 par quinton
 * Modifie le 9/8/11 : mise en session de la classe smarty
 *
 *UTF-8
 *
 * inclusions de base, ouverture de session
 *
 */

/**
 * Lecture des parametres de l'application
 */
include_once ("param/param.default.inc.php");
include_once ("param/param.inc.php");

/**
 * Gestion de la session
 */
// ini_set('session.cookie_secure', 1);
ini_set ( 'session.gc_maxlifetime', $APPLI_session_ttl );
// $session_path = ini_get('session.save_path').'/'.$APPLI_path_stockage_session;
// if (!is_dir($session_path)) mkdir($session_path);
// ini_set('session.save_path',$session_path);

session_set_cookie_params ( $APPLI_session_ttl );
/**
 * Integration de la bibliotheque ADODB
 */
// include_once('plugins/adodb5/adodb-errorhandler.inc.php');
// include_once('plugins/adodb5/adodb-exceptions.inc.php');
include_once ('plugins/adodb5.18a/adodb.inc.php');

/**
 * Integration de SMARTY
 */
include_once ('plugins/Smarty-3.1.13/libs/Smarty.class.php');

/**
 * integration de la classe ObjetBDD et des scripts associes
 */
include_once ('plugins/objetBDD-2.3/ObjetBDD.php');
include_once ('plugins/objetBDD-2.3/ObjetBDD_functions.php');
if ($APPLI_utf8 == true)
	$ObjetBDDParam ["UTF8"] = true;

/**
 * Integration de la classe gerant la navigation dans les modules
 */
include_once ("framework/navigation/navigation.class.php");

/**
 * Preparation de l'identification
 */
include_once ("framework/identification/identification.class.php");
if ($ident_type == "CAS")
	include_once ($CAS_plugin);

/**
 * Initialisation des parametres generaux
 */
ini_set ( "register_globals", false );
ini_set ( "magic_quotes_gpc", true );
error_reporting ( $ERROR_level );
ini_set ( "display_errors", $ERROR_display );
include_once "modules/beforesession.inc.php";
/**
 * Demarrage de la session
 */
@session_start ();
$identification = new Identification ();
$identification->setidenttype ( $ident_type );
if ($ident_type == "CAS") {
	$identification->init_CAS ( $CAS_address, $CAS_port, $CAS_uri );
} elseif ($ident_type == "LDAP") {
	$identification->init_LDAP ( $LDAP_address, $LDAP_port, $LDAP_basedn, $LDAP_user_attrib, $LDAP_v3, $LDAP_tls );
}
/**
 * Verification du couple session/adresse IP
 */
if (isset ( $_SESSION ["remoteIP"] )) {
	if ($_SESSION ["remoteIP"] != $_SERVER ['REMOTE_ADDR']) {
		// Tentative d'usurpation de session - on ferme la session
		if ($identification->disconnect ( $APPLI_address ) == 1) {
			$message = $LANG ["message"] [7];
		} else {
			$message = $LANG ["message"] [8];
		}
	}
} else {
	$_SESSION ["remoteIP"] = $_SERVER ['REMOTE_ADDR'];
}
/*
 * Chargement des fonction generiques
*/
include_once 'framework/fonctions.php';
/*
 * Gestion de la langue a afficher
 */
if (isset ( $_SESSION ["LANG"] ) && $APPLI_modeDeveloppement == false) {
	$LANG = $_SESSION ["LANG"];
} else {
	/*
	 * Recuperation le cas echeant du cookie
	 */
	if (isset ( $_COOKIE ["langue"] )) {
		$langue = $_COOKIE ["langue"];
	} else {
		/*
		 * Recuperation de la langue du navigateur
		 */
		$langue = explode ( ';', $_SERVER ['HTTP_ACCEPT_LANGUAGE'] );
		$langue = substr ( $langue [0], 0, 2 );
	}
	/*
	 * Mise a niveau du langage
	 */
	setlanguage($langue);
}
/*
 * Connexion a la base de donnees
 */
if (! isset ( $bdd )) {
	if ($APPLI_modeDeveloppement == true) {
		$bdd = ADONewConnection ( $BDDDEV_type );
		$bdd->debug = $ADODB_debugmode;
		$etaconn = $bdd->Connect ( $BDDDEV_server, $BDDDEV_login, $BDDDEV_passwd, $BDDDEV_database );
	} else {
		$bdd = ADONewConnection ( $BDD_type );
		$bdd->debug = $ADODB_debugmode;
		$etaconn = $bdd->Connect ( $BDD_server, $BDD_login, $BDD_passwd, $BDD_database );
	}
	if ($etaconn == false) {
		echo $LANG ["message"] [22];
	} else {
		/*
		 * Connexion a la base de gestion des droits
		 */
		$bdd_gacl = ADONewConnection ( $GACL_dbtype );
		$bdd_gacl->debug = $ADODB_debugmode;
		$etaconn = $bdd_gacl->Connect ( $GACL_dbserver, $GACL_dblogin, $GACL_dbpasswd, $GACL_database );
		if ($etaconn == false) {
			echo ($LANG ["message"] [29]);
		}
	}
}
/*
 * Activation de SMARTY
 */
$smarty = new Smarty ();
$smarty->template_dir = $SMARTY_template;
$smarty->compile_dir = $SMARTY_template_c;
$smarty->config_dir = $SMARTY_config;
$smarty->cache_dir = $SMARTY_cache_dir;
$smarty->caching = $SMARTY_cache;
if (! isset ( $message ))
	$message = "";
	/*
 * Assignation des variables "standard"
 */
$smarty->assign ( "melappli", $APPLI_mail );
$smarty->assign ( "fds", $path_inc . $APPLI_fds );
$smarty->assign ( "entete", $SMARTY_entete );
$smarty->assign ( "enpied", $SMARTY_enpied );
$smarty->assign ( "corps", $SMARTY_corps );
$smarty->assign ( "LANG", $LANG );

/*
 * Prepositionnement de idFocus, qui permet de positionner le focus automatiquement a l'ouverture d'une page web
 */
$smarty->assign ( "idFocus", "" );
/*
 * Preparation du module de gestion de la navigation
 */
if (isset ( $_SESSION ["navigation"] ) && $APPLI_modeDeveloppement == false) {
	$navigation = $_SESSION ['navigation'];
} else {
	$navigation = new Navigation ( $navigationxml );
	unset ( $_SESSION ["menu"] );
	$_SESSION ['navigation'] = $navigation;
}
/*
 * Preparation de la gestion des droits
 */
if (isset ( $_SESSION ["gestionDroit"] ) && $APPLI_modeDeveloppement == false) {
	$gestionDroit = $_SESSION ["gestionDroit"];
	$smarty->assign ( "droits", $gestionDroit->getDroits () );
} else {
	$gestionDroit = new GestionDroit ();
	if ($APPLI_modeDeveloppement == false) {
		$_SESSION ["gestionDroit"] = $gestionDroit;
	} else {
		/*
		 * Traitement du mode developpement ; calcul a chaque appel
		 */
		include "framework/identification/setDroits.php";
	}
}
/*
 * Chargement des fonctions specifiques
 */
include_once 'modules/fonctions.php';
/*
 * Chargement des traitements communs specifiques a l'application
 */
include_once ("modules/common.inc.php");
?>