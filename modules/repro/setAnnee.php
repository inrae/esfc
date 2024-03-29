<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 1 avr. 2015
 *  
 *  Initialise l'annee ou recupere l'annee saisie pour utilisation dans les modules de repro
 */
if ($_REQUEST["annee"] > 0) {
	$_SESSION["annee"] = $_REQUEST["annee"];
}

if (!isset($_SESSION["annees"])) {
	require_once 'modules/classes/poissonCampagne.class.php';
	$poissonCampagne = new PoissonCampagne($bdd, $ObjetBDDParam);
	$annees = $poissonCampagne->getAnnees();
	$thisannee = date('Y');
	if ($annees[0] < $thisannee) {
		$annees[] = $thisannee;
		arsort($annees);
	}
	$_SESSION["annees"] = $annees;
	if (!isset($_SESSION["annee"])) {
		$_SESSION["annee"] = $thisannee;
	}
}
if (isset($vue)) {
	$vue->set($_SESSION["annees"], "annees");
	$vue->set($_SESSION["annee"], "annee");
}
