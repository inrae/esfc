<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 3 mars 2014
 *  code permettant de preparer l'affichage de la fenetre de recherche des bassins
 *  a utiliser avec la commande : include "modules/bassin/bassinSearch.php"
 */
/*
 * Gestion des variables de recherche
*/
if(!isset($_SESSION["searchBassin"])) {
	$_SESSION["searchBassin"] = new SearchBassin();
}
$_SESSION["searchBassin"]->setParam ( $_REQUEST );
$dataSearch = $_SESSION["searchBassin"]->getParam ();
if ($_SESSION["searchBassin"]->isSearch () == 1) {
	$vue->set(1 , "isSearch"); 
}
$vue->set( $dataSearch, "bassinSearch"); 
/*
 * Integration des tables necessaires pour la  recherche
*/
include 'modules/bassin/bassinParamAssocie.php';
$_SESSION["bassinParentModule"] = "bassinListniv2";
require_once 'modules/classes/site.class.php';
