<?php 
namespace App\Libraries;

use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Xx extends PpciLibrary { 
    /**
     * @var xx
     */
    protected PpciModel $this->dataclass;
    private $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ;
        $keyName = "_id";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }

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

function initSpermeChange($sperme_id = 0)
{
	global $bdd, $ObjetBDDParam, $this->vue;
	if (is_null($sperme_id)) {
		$sperme_id = 0;
	}
	/*
	 * Lecture de sperme_qualite
	 */
	$spermeAspect = new SpermeAspect;
	$this->vue->set($spermeAspect->getListe(1), "spermeAspect");
	/*
	 * Recherche des caracteristiques particulieres
	*/
	$caract = new SpermeCaracteristique;
	$this->vue->set($caract->getFromSperme($sperme_id), "spermeCaract");
	/*
	 * Recherche des dilueurs
	*/
	$dilueur = new SpermeDilueur;
	$this->vue->set($dilueur->getListe(2), "spermeDilueur");

	/*
	 * Recherche de la qualite de la semence, pour les analyses realisees en meme temps
	 */
	$qualite = new SpermeQualite;
	$this->vue->set($qualite->getListe(1), "spermeQualite");
	/*
	 * Recherche des congelations associees
	 */
	$congelation = new SpermeCongelation;
	$this->vue->set($congelation->getListFromSperme($sperme_id), "congelation");
	/*
	 * Recherche des analyses realisees
	 */
	$mesure = new SpermeMesure;
	$this->vue->set($mesure->getListFromSperme($sperme_id), "dataMesure");
}
