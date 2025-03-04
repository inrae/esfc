<?php

namespace App\Libraries;

use app\Models\BassinType;
use app\Models\BassinUsage;
use App\Models\BassinZone;
use App\Models\CircuitEau;
use App\Models\DocumentSturio;
use App\Models\PoissonCampagne;
use App\Models\SpermeAspect;
use App\Models\SpermeCaracteristique;
use App\Models\SpermeCongelation;
use App\Models\SpermeDilueur;
use App\Models\SpermeMesure;
use App\Models\SpermeQualite;

function bassinParamAssocie($vue)
{
    $bassin_type = new BassinType;
    $vue->set($bassin_type->getListe(2), "bassin_type");
    $bassin_usage = new BassinUsage;
    $vue->set($bassin_usage->getListe(2), "bassin_usage");
    $bassin_zone = new BassinZone;
    $vue->set($bassin_zone->getListe(2), "bassin_zone");
    $circuit_eau = new CircuitEau;
    $vue->set($circuit_eau->getListe(2), "circuit_eau");
}

function getListeDocument($type, array|int $id, $vue, $limit = "", $offset = 0)
{
    $document = new DocumentSturio;
    if (!$limit == "all" && !$limit > 0) {
        $limit = 10;
    }
    if (!$offset || !is_numeric($offset) || $offset < 1) {
        $offset = 0;
    }

    /*
	 * Envoi au navigateur des valeurs de limit et offset
	 */
    $vue->set($limit, "document_limit");
    $vue->set($offset, "document_offset");
    return $document->getListeDocument($type, $id, $limit, $offset);
}
function formatFiles($attributName = "documentName")
{
    $files = array();
    $fdata = $_FILES[$attributName];
    if (is_array($fdata['name'])) {
        for ($i = 0; $i < count($fdata['name']); ++$i) {
            $files[] = array(
                'name' => $fdata['name'][$i],
                'type' => $fdata['type'][$i],
                'tmp_name' => $fdata['tmp_name'][$i],
                'error' => $fdata['error'][$i],
                'size' => $fdata['size'][$i]
            );
        }
    } else
        $files[] = $fdata;
    return $files;
}
function setAnneesRepro($vue = null)
{
    if ($_REQUEST["annee"] > 0) {
        $_SESSION["annee"] = $_REQUEST["annee"];
    }
    if (!isset($_SESSION["annees"])) {
        $poissonCampagne = new PoissonCampagne;
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
}
function initSpermeChange($vue, $sperme_id = 0)
{
	if (is_null($sperme_id)) {
		$sperme_id = 0;
	}
	/**
	 * Lecture de sperme_qualite
	 */
	$spermeAspect = new SpermeAspect;
	$vue->set($spermeAspect->getListe(1), "spermeAspect");
	/**
	 * Recherche des caracteristiques particulieres
	*/
	$caract = new SpermeCaracteristique;
	$vue->set($caract->getFromSperme($sperme_id), "spermeCaract");
	/**
	 * Recherche des dilueurs
	*/
	$dilueur = new SpermeDilueur;
	$vue->set($dilueur->getListe(2), "spermeDilueur");

	/**
	 * Recherche de la qualite de la semence, pour les analyses realisees en meme temps
	 */
	$qualite = new SpermeQualite;
	$vue->set($qualite->getListe(1), "spermeQualite");
	/**
	 * Recherche des congelations associees
	 */
	$congelation = new SpermeCongelation;
	$vue->set($congelation->getListFromSperme($sperme_id), "congelation");
	/**
	 * Recherche des analyses realisees
	 */
	$mesure = new SpermeMesure;
	$vue->set($mesure->getListFromSperme($sperme_id), "dataMesure");
}