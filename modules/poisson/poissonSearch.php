<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 25 févr. 2014
 *  code permettant de preparer l'affichage de la fenetre de recherche des poissons
 *  a utiliser avec la commande : include "modules/poisson/poissonSearch.php"
 */
/*
 * Gestion des variables de recherche
 */
$searchPoisson->setParam ( $_REQUEST );
$dataSearch = $searchPoisson->getParam (); 
if ($searchPoisson->isSearch () == 1) {
	$vue->set( , ""); ("isSearch", 1);	
}
$vue->set( , ""); ("poissonSearch", $dataSearch);
/*
 * Integration des tables necessaires pour la  recherche
 */
include_once "modules/classes/poisson.class.php";
$sexe = new Sexe($bdd, $ObjetBDDParam);
$vue->set( , "");("sexe",$sexe->getListe(1));
$poisson_statut = new Poisson_statut($bdd, $ObjetBDDParam);
$vue->set( , "");("statut", $poisson_statut->getListe(1));
$categorie = new Categorie($bdd, $ObjetBDDParam);
$vue->set( , "");("categorie", $categorie->getListe(1));
include_once 'modules/classes/site.class.php';
$site = new Site($bdd, $ObjetBDDParam);
$vue->set( , "");("site", $site->getListe(2));
?>