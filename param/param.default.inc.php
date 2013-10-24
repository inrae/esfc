<?php
/** Fichier cree le 4 mai 07 par quinton
*
*UTF-8
* 
* Parametres par defaut de l'application
*/
$APPLI_version = "0.8";
$APPLI_versiondate = "24/09/2013";
$language = "fr";
$DEFAULT_formatdate = "fr";
/*
 * Navigation a partir du fichier xml
 */
$navigationxml = "param/actions.xml";
/*
 * Duree de la session par defaut
 * @var unknown_type
 */
$APPLI_session_ttl = 1800;
$APPLI_cookie_ttl = 2592000;
/*
 * 
 * Nom du chemin de stockage des sessions
 * @var unknown_type
 */
$APPLI_path_stockage_session = "prototypephp";
/*
 * Type d'identification
 * 
 * BDD : mot de passe en base de donnees
 * CAS : utilisation d'un serveur CAS
 * LDAP : utilisation d'un serveur LDAP
 */
$ident_type = "BDD";
//$CAS_plugin="plugins/phpcas-simple/phpcas.php";
$CAS_plugin = 'plugins/esup-phpcas/source/CAS/CAS.php';
$CAS_address = "http://localhost/CAS";
$CAS_port = 443;
$LDAP_address = "localhost";
$LDAP_port = 389;
$LDAP_rdn = "cn=manager,dc=example,dc=com";
$LDAP_basedn = "ou=people,ou=example,o=societe,c=fr";
$LDAP_user_attrib = "uid";
$LDAPGROUP_port = 389;
$LDAP_v3 = true;
$LDAP_tls = false;
/*
 * Parametres concernant la base de donnees
 */
$BDD_type = "mysql";
$BDD_server = "localhost";
$BDD_login = "proto";
$BDD_passwd = "proto";
$BDD_database = "proto";
/*
 * Base de donnees de developpement
*/
$BDDDEV_type = "mysql";
$BDDDEV_server = "localhost";
$BDDDEV_login = "proto";
$BDDDEV_passwd = "proto";
$BDDDEV_database = "proto";
/*
 * Parametres concernant SMARTY
 */
$SMARTY_template ='display/templates';
$SMARTY_template_c = 'display/templates_c';
$SMARTY_config = 'param/configs_smarty';
$SMARTY_cache_dir = 'display/smarty_cache';
$SMARTY_cache = FALSE;
$SMARTY_entete = "entete.tpl";
$SMARTY_enpied = "enpied.tpl";
$SMARTY_principal = "main.htm";
$SMARTY_corps = "main.tpl";
/*
 * Variables de base de l'application
 */ 
$APPLI_mail = "proto@proto.com";
$APPLI_nom = "Prototype d'application";
$APPLI_code = 'proto';
$APPLI_fds = "display/CSS/blue.css";
$APPLI_address = "http://localhost/proto";
$APPLI_modeDeveloppement = false;
$APPLI_utf8 = true;

/*
 * Variables liees a GACL et l'identification via base de donnees
 */
$GACL_dbtype = "mysql";
$GACL_dbserver = "localhost";
$GACL_dblogin = "proto";
$GACL_dbpasswd = "proto";
$GACL_database = "proto";
$GACL_dbprefixe = "gacl";
$GACL_aro = "login";
$GACL_aco = "appli";
$GACL_path = "param/gacl.ini.php";
$GACL_listeDroitsGeres = "admin,gestion";
/*
 * Gestion des erreurs
 */
$ERROR_level=E_ERROR;
/*
 * Pour le developpement :
 * $ERROR_level = E_ALL & ~E_NOTICE & E_STRICT 
 * En production :
 * $ERROR_level = E_ERROR ;
 */ 
$ERROR_display=0;
$ADODB_debugmode = 0;
$OBJETBDD_debugmode = 1;
/*
 * Modules de traitement des erreurs
 */
$APPLI_moduleDroitKO = "droitko";
$APPLI_moduleErrorBefore = "errorbefore";
$APPLI_moduleNoLogin = "errorlogin";
?>
