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
$searchBassin->setParam ( $_REQUEST );
$dataSearch = $searchBassin->getParam ();
if ($searchBassin->isSearch () == 1) {
	$smarty->assign ("isSearch", 1);
}
$smarty->assign ("bassinSearch", $dataSearch);
/*
 * Integration des tables necessaires pour la  recherche
*/
include_once 'modules/classes/bassin.class.php';
$bassin_type = new Bassin_type($bdd, $ObjetBDDParam);
$smarty->assign("bassin_type", $bassin_type->getListe());
$bassin_usage = new Bassin_usage($bdd, $ObjetBDDParam);
$smarty->assign("bassin_usage", $bassin_usage->getListe());
$bassin_zone = new Bassin_zone($bdd, $ObjetBDDParam);
$smarty->assign("bassin_zone", $bassin_zone->getListe());
$circuit_eau = new Circuit_eau($bdd, $ObjetBDDParam);
$smarty->assign("circuit_eau", $circuit_eau->getListe());
?>