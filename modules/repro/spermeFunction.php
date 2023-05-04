<?php

/**
 * @author : quinton
 * @date : 16 mars 2016
 * @encoding : UTF-8
 * (c) 2016 - All rights reserved
 */
require_once 'modules/classes/spermeAspect.class.php';
require_once 'modules/classes/spermeCaracteristique.class.php';
require_once 'modules/classes/spermeDilueur.class.php';
require_once 'modules/classes/spermeQualite.class.php';
require_once 'modules/classes/spermeCongelation.class.php';
require_once 'modules/classes/spermeMesure.class.php';

function initSpermeChange($sperme_id)
{
	global $bdd, $ObjetBDDParam, $vue;
	/*
	 * Lecture de sperme_qualite
	 */
	$spermeAspect = new SpermeAspect($bdd, $ObjetBDDParam);
	$vue->set($spermeAspect->getListe(1), "spermeAspect");
	/*
	 * Recherche des caracteristiques particulieres
	*/
	$caract = new SpermeCaracteristique($bdd, $ObjetBDDParam);
	$vue->set($caract->getFromSperme($sperme_id), "spermeCaract");
	/*
	 * Recherche des dilueurs
	*/
	$dilueur = new SpermeDilueur($bdd, $ObjetBDDParam);
	$vue->set($dilueur->getListe(2), "spermeDilueur");

	/*
	 * Recherche de la qualite de la semence, pour les analyses realisees en meme temps
	 */
	$qualite = new SpermeQualite($bdd, $ObjetBDDParam);
	$vue->set($qualite->getListe(1), "spermeQualite");
	/*
	 * Recherche des congelations associees
	 */
	$congelation = new SpermeCongelation($bdd, $ObjetBDDParam);
	$vue->set($congelation->getListFromSperme($sperme_id), "congelation");
	/*
	 * Recherche des analyses realisees
	 */
	$mesure = new SpermeMesure($bdd, $ObjetBDDParam);
	$vue->set($mesure->getListFromSperme($sperme_id), "dataMesure");
}
