<?php
/** Fichier cree le 4 mai 07 par quinton
 *
 *UTF-8
 *
 * Classe maîtrisant les aspects identification.
 */

/**
 * @class Identification
 * Gestion de l'identification - récupération du login en fonction du type d'accès
 * @author Eric Quinton - eric.quinton@free.fr
 *
 */

class Identification {
	var $ident_type = NULL;
	var $CAS_address ;
	var $CAS_port;
	var $CAS_uri;
	var $LDAP_address;
	var $LDAP_port;
	var $LDAP_rdn;
	var $LDAP_basedn;
	var $LDAP_user_attrib;
	var $LDAP_v3;
	var $LDAP_tls;
	var $password;
	var $login;
	var $gacl;
	var $aco;
	var $aro;
	var $pagelogin;

	function setpageloginBDD($page) {
		$this->pagelogin = $page;
	}
	/**
	 * @param $ident_type string
	 */
	function setidenttype($ident_type){
		$this->ident_type = $ident_type;
	}
	/**
	 * initialisation si utilisation d'un CAS
	 * @param $cas_address adresse du CAS
	 * @param $CAS_port port du CAS
	 * @return  none
	 */
	function init_CAS($cas_address,$CAS_port, $CAS_uri) {
		$this->CAS_address = $cas_address;
		$this->CAS_port = $CAS_port;
		$this->CAS_uri = $CAS_uri;
		$this->ident_type = "CAS";

	}
	/**
	 * initialisation si utilisation d'un LDAP
	 * @param $LDAP_address adresse du CAS
	 * @param $LDAP_port port du serveur LDAP
	 * @param $LDAP_rdn chemin complet de recherche, incluant le login
	 * @param $login login qui sera retourné à l'application
	 * @param $password mot de passe à tester
	 * @return  none
	 */

	function init_LDAP($LDAP_address, $LDAP_port,$LDAP_basedn, $LDAP_user_attrib,$LDAP_v3,$LDAP_tls) {
		$this->LDAP_address = $LDAP_address;
		$this->LDAP_port = $LDAP_port;
		$this->LDAP_basedn = $LDAP_basedn;
		$this->LDAP_user_attrib = $LDAP_user_attrib;
		$this->LDAP_v3 = $LDAP_v3;
		$this->LDAP_tls = $LDAP_tls;
		$this->ident_type = "LDAP";
	}

	/**
	 * Retourne le login en mode CAS ou BDD
	 *
	 * @return login ou -1 - Le login est stocké en variable de session si ok
	 */
	function getLogin() {
		$ident_type = $this->ident_type;
		if (!isset($ident_type)){
			echo "Cette fonction doit être appelée après soit init_LDAP, init_CAS, ou init_BDD";
			die;
		}
		if (!isset($_SESSION["login"])) {
			/*
			 * Récupération du login selon le type
			 */
			if ($ident_type == "BDD") {

			}elseif ($ident_type == "CAS") {

				phpCAS::client(CAS_VERSION_2_0,$this->CAS_address,$this->CAS_port,$this->CAS_uri);
				//				if (phpCAS::isAuthenticated()==FALSE) {
				phpCAS::forceAuthentication();
				//				}
				$_SESSION["login"] = phpCAS::getUser();
			}
		}

		if (isset( $_SESSION["login"])) {
			$this->login = $_SESSION["login"];
			unset($_SESSION["menu"]);
			return $_SESSION["login"];
		}else{
			return -1;
		}
	}
	/**
	 * Teste le login et le mot de passe sur un annuaire ldap
	 *
	 * @param string $login
	 * @param string $password
	 * @return string $password |int -1
	 */
	function testLoginLdap ($login,$password) {
		if (!isset($this->ident_type)){
			echo "Cette fonction doit être appelee apres init_LDAP";
			die;
		}
		$ldap = @ldap_connect($this->LDAP_address,$this->LDAP_port)
		or die("Impossible de se connecter au serveur LDAP.");
	if ($this->LDAP_v3)
		{
			ldap_set_option($ldap, LDAP_OPT_PROTOCOL_VERSION, 3);
		}
		if ($this->LDAP_tls)
		{
			ldap_start_tls($ldap);
		}
		$dn = $this->LDAP_user_attrib."=".$login.",".$this->LDAP_basedn;
		$rep=ldap_bind($ldap,$dn, $password);
		if ($rep == 1)
		{
			$_SESSION["login"] = $login;
			unset($_SESSION["menu"]);
			return $login;
		}else{
			return -1;
		}
	}


	/**
	 * Déconnexion de l'application
	 * @return 0:1
	 */
	function disconnect($adresse_retour) {
		if (!isset($this->ident_type)) {
			return 0;
		}
		if ($this->ident_type == "CAS") {
			phpCAS::client(CAS_VERSION_2_0,$this->CAS_address,$this->CAS_port,$this->CAS_uri);
			phpCAS::logout($adresse_retour);
		}
		// Détruit toutes les variables de session
		$_SESSION = array();

		// Si vous voulez détruire complètement la session, effacez également
		// le cookie de session.
		// Note : cela détruira la session et pas seulement les données de session !
		if (isset($_COOKIE[session_name()])) {
			setcookie(session_name(), '', time()-42000, '/');
		}

		// Finalement, on détruit la session.
		session_destroy();
		return 1;

	}
	/**
	 * Initialisation de la classe gacl
	 * @param $gacl instance gacl
	 * @param $aco nom de la catégorie de base contenant les objets à tester
	 * @param $aro nom de la catégorie contenant les logins à tester
	 */
	function setgacl(&$gacl,$aco,$aro) {
		$this->gacl=$gacl;
		$this->aco=$aco;
		$this->aro=$aro;

	}
	/**
	 * Teste les droits
	 * @param $aco Catégorie à tester
	 * @return 0|1
	 */
	function getgacl($aco){
		$login = $this->getLogin();
		if ($login ==-1) return -1;
		return $this->gacl->acl_check($this->aco,$aco,$this->aro,$login);

	}
}

/**
 * Classe permettant de manipuler les logins stockés en base de données locale
 *
 */
class LoginGestion extends ObjetBDD
{
	//

	function LoginGestion($link,$param=NULL)
	{
		if (is_array($param)==false) $param=array();
		$param["table"]="LoginGestion";
		$param["id_auto"]=1;
		$param["cle"]="id";
//		$this->table="LoginGestion";
//		$this->id_auto=1;
//		$this->cle="id";
		$this->colonnes = array (
		"id"=> array("type"=>1),
		"datemodif"=>array("type"=>2),
		"mail"=>array("pattern"=>"#^.+@.+\.[a-zA-Z]{2,6}$#"),
		"login"=>array('requis'=>1)
		);
		parent::__construct($link,$param);
	}
	function VerifLogin($login,$password){
//		$password = md5($password);
		$password = hash("sha256",$password);
		$sql="select login from LoginGestion where login ='".$login
		."' and password = '".$password."'";
		$res=ObjetBDD::lireParam($sql);
		if ($res["login"]==$login) {
			return TRUE;
		}else{
			return FALSE;
		}
	}
	function getListeTriee(){
		$sql = 'select id,login,nom,prenom,mail from LoginGestion order by nom,prenom';
		return ObjetBDD::getListeParam($sql);
	}
	function ecrire($liste){
		$list=array();
		$list["id"]=$liste["id"];
		$list["login"]=$liste["login"];
		if(isset($liste["pass1"])&&isset($liste["pass2"])&&$liste["pass1"]==$liste["pass2"]&&strlen($liste["pass1"])>3) {
			$list["password"]=hash("sha256",($liste["pass1"]));
		}
		$list["nom"]=$liste["nom"];
		$list["prenom"]=$liste["prenom"];
		$list["mail"]=$liste["mail"];
		$list["datemodif"]=date('d-m-y');
		return ObjetBDD::ecrire($list);
	}
}
/**
 *
 * Classe de gestion des droits
 * @author eric.quinton
 *
 */
class GestionDroit {
	private $droits = array();
	private $gacl;
	private $aco;
	private $aro;
	private $listeDroitsGeres;

	/**
	 *
	 * Recherche des droits attribues au login, a partir de phpgacl et autres...
	 * Impose que les droits geres dans l'application soient declares dans la
	 * variable globale $GACL_listeDroitsGeres (fichier param.default.inc.php)
	 * @param $gacl
	 * @param $aco
	 * @param $aro
	 * @param $ressource
	 * @param $listeDroitsGeres
	 */
	function setgacl(&$gacl,$aco,$aro,$listeDroitsGeres) {
		$this->gacl=$gacl;
		$this->aco=$aco;
		$this->aro=$aro;

		$login = $this->getLogin();
		if (!is_null($listeDroitsGeres)&&!is_null($login)) {
			$droits=explode(",",$listeDroitsGeres);
			$this->droits = array();
			foreach($droits as $value) {
				if ($this->gacl->acl_check($this->aco,$value,$this->aro,$login)==1) {
					$this->droits[$value]=1;
				}
			}
		}
	}
	/**
	 *
	 * Retourne le login stocke en variable de session
	 */
	function getLogin() {
		return $_SESSION["login"];
	}

	/**
	 * Teste des droits
	 * @param $aco Categorie_a_tester
	 * @return -1|1
	 */
	function getgacl($aco){
		$login = $this->getLogin();
		if (is_null($login)) return -1;
		if ($this->droits[$aco] == 1) {
			return 1;
		} else {
			return -1;
		}
	}
	/**
	 * Retourne les droits affectes au login courant
	 * @return array
	 */
	function getDroits() {
		return $this->droits;
	}
}

?>