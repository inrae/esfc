<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 1 avr. 2015
 *  
 *  Initialise l'annee ou recupere l'annee saisie pour utilisation dans les modules de repro
 */
 
if ($_REQUEST ["annee"] > 0)
	$_SESSION ["annee"] = $_REQUEST ["annee"];
if (! isset ( $_SESSION ["annee"] )) {
	require_once 'modules/classes/poissonRepro.class.php';
	$poissonCampagne = new PoissonCampagne ( $bdd, $ObjetBDDParam );
	$annees = $poissonCampagne->getAnnees ();
	$_SESSION ["annee"] = $annees [0] ["annee"];
	if (! isset ( $_SESSION ["annee"] ))
		$_SESSION ["annee"] = date ( 'Y' );
}

$smarty->assign ( "annee", $_SESSION ["annee"] );

?>