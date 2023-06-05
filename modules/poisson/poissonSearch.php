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
if (!isset($_SESSION["searchPoisson"])) {
	$_SESSION["searchPoisson"] = new SearchPoisson();
}
$_SESSION["searchPoisson"]->setParam($_REQUEST);
$dataSearch = $_SESSION["searchPoisson"]->getParam();
if ($_SESSION["searchPoisson"]->isSearch() == 1) {
	$vue->set(1, "isSearch");
}
$vue->set($dataSearch, "poissonSearch");
/*
 * Integration des tables necessaires pour la  recherche
 */
include_once "modules/classes/sexe.class.php";
$sexe = new Sexe($bdd, $ObjetBDDParam);
$vue->set($sexe->getListe(1), "sexe");
include_once "modules/classes/poissonStatut.class.php";
$poisson_statut = new Poisson_statut($bdd, $ObjetBDDParam);
$vue->set($poisson_statut->getListe(1), "statut");
include_once "modules/classes/categorie.class.php";
$categorie = new Categorie($bdd, $ObjetBDDParam);
$vue->set($categorie->getListe(1), "categorie");
include_once 'modules/classes/site.class.php';
$site = new Site($bdd, $ObjetBDDParam);
$vue->set($site->getListe(2), "site");
