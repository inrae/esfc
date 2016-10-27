<?php
/**
 * @author : quinton
 * @date : 16 mars 2016
 * @encoding : UTF-8
 * (c) 2016 - All rights reserved
 */
require_once 'modules/classes/sperme.class.php';
function initSpermeChange($sperme_id) {
	global $smarty, $bdd, $ObjetBDDParam;
	/*
	 * Lecture de sperme_qualite
	 */
	$spermeAspect = new SpermeAspect($bdd, $ObjetBDDParam);
	$smarty->assign("spermeAspect", $spermeAspect->getListe(1));
	/*
	 * Recherche des caracteristiques particulieres
	*/
	$caract = new SpermeCaracteristique($bdd, $ObjetBDDParam);
	$smarty->assign("spermeCaract", $caract->getFromSperme($sperme_id));
	/*
	 * Recherche des dilueurs
	*/
	$dilueur = new SpermeDilueur($bdd, $ObjetBDDParam);
	$smarty->assign("spermeDilueur", $dilueur->getListe(2));
	
	/*
	 * Recherche de la qualite de la semence, pour les analyses realisees en meme temps
	 */
	$qualite = new SpermeQualite($bdd, $ObjetBDDParam);
	$smarty->assign("spermeQualite", $qualite->getListe(1));
	/*
	 * Recherche des congelations associees
	 */
	$congelation = new SpermeCongelation($bdd, $ObjetBDDParam);
	$smarty->assign("congelation", $congelation->getListFromSperme($sperme_id));
}
?>