<?php 
namespace App\Libraries;

use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class  extends PpciLibrary { 
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    private $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ;
        $this->keyName = "";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 12 mai 2015
 *  
 *  Génération des fiches d'alimentation pour les lots d'alevin
 */

/*
 * Recuperation des parametres pour l'alimentation
 */

$_SESSION["alimJuv"]->setParam($_REQUEST);
$paramAlim = $_SESSION["alimJuv"]->getParam();
if (!$paramAlim["densite"] > 0) {
	$paramAlim["densite"] = 1;
}
/*
 * Recherche des lots à traiter
 */
require_once 'modules/classes/lot.class.php';
require_once 'modules/classes/bassinLot.class.php';
require_once "modules/classes/lotMesure.class.php";
require_once "modules/classes/alimentQuotidien.class.php";
require_once "modules/classes/distribQuotidien.class.php";
require_once "modules/classes/lotRepartTemplate.class.php";
require_once 'modules/classes/tableauRepartition.class.php';
require_once "modules/classes/repartition.class.php";
require_once "modules/classes/repartitionJuvenileLot.class.php";
$lotClass = new Lot;
$bassinLot = new BassinLot;
$lotMesure = new LotMesure;
$alimentQuotidien = new AlimentQuotidien;
$distribQuotidien = new DistribQuotidien;
$lotRepartTempate = new LotRepartTemplate;
$repartition = new Repartition;
$lots = $lotClass->getDataFromListe($_REQUEST["lots"]);
$date = DateTime::createFromFormat("d/m/Y", $paramAlim["date_debut_alim"]);

/**
 * $bassins[$bassin_nom] = array("artemia"=>Qté artémies, "chironome"=>masse chironome,
 * "volumeArtemia"=>volume d'artemies a distribuer,
 * "lots" => liste des lots presents,
 * "bassin_nom"=> nom du bassin);
 */
$bassins = array();
$artemiaFlag = false;
$error = false;
/*
 * Traitement de chaque lot
 */
try {
foreach ($lots as $lot) {
	/*
	 * Recuperation du bassin
	 */
	$dataBassin = $bassinLot->getBassin($lot["lot_id"], $paramAlim["date_debut_alim"]);
	if (empty($dataBassin)) {
		$this->message->set(sprintf(_("Le lot %s n'est pas affecté à un bassin, la génération de l'alimentation n'est pas possible"), $lot["lot_nom"]), true);
		$error = true;
	} else {
		/*
		 * Affectation du nom du lot au bassin
		 */
		if (strlen($bassins[$dataBassin["bassin_nom"]]["lot_nom"]) > 0) {
			$bassins[$dataBassin["bassin_nom"]]["lot_nom"] .= " ,";
		}
		$bassins[$dataBassin["bassin_nom"]]["lot_nom"] = $lot["sequence_nom"] . "-" . $lot["lot_nom"];
		$bassins[$dataBassin["bassin_nom"]]["bassin_nom"] = $dataBassin["bassin_nom"];
		$bassins[$dataBassin["bassin_nom"]]["bassin_id"] = $dataBassin["bassin_id"];
		/*
		 * Calcul du nombre de poissons presents et de la masse des poissons du lot
		 */
		$dataLotMesure = $lotMesure->getMesureAtDate($lot["lot_id"], $paramAlim["date_debut_alim"]);
		$nbPoisson = $lot["nb_larve_initial"] - $dataLotMesure["lot_mortalite"];
		if (!$nbPoisson > 0) {
			$nbPoisson = 0;
		}
		$massePoisson = $nbPoisson * $dataLotMesure["masse_indiv"];
		/*
		 * Calcul du nombre de jours ecoules depuis la naissance
		 */
		$dateNaissance = DateTime::createFromFormat("d/m/Y", $lot["eclosion_date"]);
		$intervalle = date_diff($dateNaissance, $date);
		$nbJour = $intervalle->format('%a');
		if ($nbJour > 0) {
			/*
			 * Forcage de l'age le plus grand, si deux lots dans le même bassin
			 */
			if ($nbJour > $bassins[$dataBassin["bassin_nom"]]["age"] || is_null($bassins[$dataBassin["bassin_nom"]]["age"]))
				$bassins[$dataBassin["bassin_nom"]]["age"] = $nbJour;
			/*
			 * Recuperation de la quantite a distribuer
			 */
			$repart = $lotRepartTempate->getFromAge($nbJour);
			/*
			 * Calcul du nombre d'artemies a distribuer
			 */
			if ($repart["artemia"] > 0) {
				$bassins[$dataBassin["bassin_nom"]]["artemia"] = +$nbPoisson * $repart["artemia"];
				$artemiaFlag = true;
			}
			/*
			 * Calcul de la masse de chironomes a distribuer
			 */
			if ($repart["chironome"] > 0) {
				$bassins[$dataBassin["bassin_nom"]]["chironome"] = +intval($massePoisson * $repart["chironome"] / 100);
			}
		}
	}
}
if ($error) {
	throw New lotException(_("Certains lots ne sont pas affectés dans des bassins"));
}

/*
 * Calcul de la quantite d'artemia a distribuer (en ml, en fonction de la densite)
 */
if ($artemiaFlag == true) {
	foreach ($bassins as $key => $value) {
		if ($value["artemia"] > 0) {
			$bassins[$key]["volumeArtemia"] = intval($value["artemia"] / $paramAlim["densite"]);
		}
	}
}
/*
 * Ecriture de l'alimentation en base
 */
if ($artemiaFlag == true) {
	$paramAlim["duree"] = 1;
}

$jour = new DateInterval("P1D");
foreach ($bassins as $bassin) {
	if ($bassin["artemia"] > 0 || $bassin["chironome"] > 0) {
		/*
		 * Traitement de chaque jour
		 */
		$dateCalcul = DateTime::createFromFormat("d/m/Y", $paramAlim["date_debut_alim"]);
		for ($i = 0; $i < $paramAlim["duree"]; $i++) {
			if ($i > 0)
				$dateCalcul->add($jour);
			/*
			 * Suppression des donnees du bassin
			 */
			$alimentQuotidien->deleteFromDateBassin($dateCalcul->format("Y-m-d"), $bassin["bassin_id"]);
			/*
			 * Creation des donnees d'alimentation
			 */
			$dataQuotidien = array(
				"bassin_id" => $bassin["bassin_id"],
				"distrib_quotidien_date" => $dateCalcul->format("d/m/Y")
			);
			$this->idDataQuotidien = $distribQuotidien->ecrireFromBassinDate($dataQuotidien);
			if ($this->idDataQuotidien > 0) {
				/*
				 * Traitement des artemia
				 */
				if ($bassin["artemia"] > 0) {
					$dataAlim = array(
						"aliment_quotidien_id" => 0,
						"aliment_id" => 25,
						"distrib_quotidien_id" => $this->idDataQuotidien,
						"quantite" => $bassin["artemia"]
					);
					$alimentQuotidien->ecrire($dataAlim);
				}
				/*
				 * Traitement des chironomes
				 */
				if ($bassin["chironome"] > 0) {
					$dataAlim = array(
						"aliment_quotidien_id" => 0,
						"aliment_id" => 1,
						"distrib_quotidien_id" => $this->idDataQuotidien,
						"quantite" => $bassin["chironome"]
					);
					$alimentQuotidien->ecrire($dataAlim);
				}
			}
		}
	}
}
/*
 * Ecriture de la repartition
 */
$dateFin = DateTime::createFromFormat("d/m/Y", $paramAlim["date_debut_alim"]);
if ($paramAlim["duree"] > 1) {
	$jour = new DateInterval("P" . ($paramAlim["duree"] - 1) . "D");
	$dateFin->add($jour);
}

$dataRepartition = array(
	"repartition_id" => 0,
	"categorie_id" => 3,
	"date_debut_periode" => $paramAlim["date_debut_alim"],
	"date_fin_periode" => $dateFin->format("d/m/Y"),
	"densite_artemia" => $paramAlim["densite"]
);
$repartition->ecrireFromDateCategorie($dataRepartition);

/*
 * Tri du bassin
 */
ksort($bassins);
/*
 * Fin du traitement des donnees
 * Declenchement de la generation du PDF
 */
$pdf = new RepartitionJuvenileLot();
$pdf->setData($dataRepartition, $bassins, $artemiaFlag);
$pdf->exec();
} catch (lotException $le) {
	$module_coderetour = -1;
	$this->message->set($le->getMessage());
	$this->message->set(_("La génération de la fiche d'alimentation a échoué"), true);
}