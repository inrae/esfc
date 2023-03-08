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
	$vue->set( , "");("spermeAspect", $spermeAspect->getListe(1));
	/*
	 * Recherche des caracteristiques particulieres
	*/
	$caract = new SpermeCaracteristique($bdd, $ObjetBDDParam);
	$vue->set( , "");("spermeCaract", $caract->getFromSperme($sperme_id));
	/*
	 * Recherche des dilueurs
	*/
	$dilueur = new SpermeDilueur($bdd, $ObjetBDDParam);
	$vue->set( , "");("spermeDilueur", $dilueur->getListe(2));
	
	/*
	 * Recherche de la qualite de la semence, pour les analyses realisees en meme temps
	 */
	$qualite = new SpermeQualite($bdd, $ObjetBDDParam);
	$vue->set( , "");("spermeQualite", $qualite->getListe(1));
	/*
	 * Recherche des congelations associees
	 */
	$congelation = new SpermeCongelation($bdd, $ObjetBDDParam);
	$vue->set( , "");("congelation", $congelation->getListFromSperme($sperme_id));
	/*
	 * Recherche des analyses realisees
	 */
	$mesure = new SpermeMesure($bdd, $ObjetBDDParam);
	$vue->set( , "");("dataMesure", $mesure->getListFromSperme($sperme_id));
}
?>