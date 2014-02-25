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
	$smarty->assign ("isSearch", 1);	
}
$smarty->assign ("poissonSearch", $dataSearch);
/*
 * Integration des tables necessaires pour la  recherche
 */
include_once "modules/classes/poisson.class.php";
$sexe = new Sexe($bdd, $ObjetBDDParam);
$smarty->assign("sexe",$sexe->getListe());
$poisson_statut = new Poisson_statut($bdd, $ObjetBDDParam);
$smarty->assign("statut", $poisson_statut->getListe());

?>