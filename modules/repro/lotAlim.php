<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 12 mai 2015
 */
 
/*
 * Recuperation des parametres pour l'alimentation
 */
$alimJuv->setParam($_REQUEST);
$dataAlim = $alimJuv->getParam();
if (! $dataAlim["densite"] > 0)
	$dataAlim["densite"] = 1;
/*
 * Recherche des lots à traiter
 */
require_once 'modules/classes/lot.class.php';
require_once 'modules/classes/bassin.class.php';
$lot = new Lot($bdd, $ObjetBDDParam);
$bassinLot = new BassinLot($bdd, $ObjetBDDParam);
$lotMesure = new LotMesure($bdd, $ObjetBDDParam);
$lotRepartTempate = new LotRepartTemplate($bdd, $ObjetBDDParam);
$lots = $lot->getListAfterDate($dataAlim["date_debut_alim"]);
$date = DateTime::createFromFormat("d/m/Y", $dataAlim["date_debut_alim"]);


/**
 * $bassins[$bassin_id] = array("artemia"=>Qté artémies, "chironome"=>masse chironome, 
 * "volumeArtemia"=>volume d'artemies a distribuer,
 * "lots" => liste des lots presents,
 * "bassin_nom"=> nom du bassin);
 */
$bassins = array();
$artemiaFlag = false;
/*
 * Traitement de chaque lot
 */
foreach ($lots as $key => $value) {
	/*
	 * Recuperation du bassin
	 */
	$dataBassin = $bassinLot->getBassin($value["lot_id"], $dataAlim["date_debut_alim"]);
	if (!$dataBassin["bassin_id"] > 0) {
		$dataBassin["bassin_id"] = 0;
	}
	/*
	 * Affectation du nom du lot au bassin
	 */
	if (strlen($bassins[$dataBassin["bassin_id"]]["lot_nom"]) > 0)
		$bassins[$dataBassin["bassin_id"]]["lot_nom"] .= " ,";
	$bassins[$dataBassin["bassin_id"]]["lot_nom"] = $value["sequence_nom"]."-".$value["lot_nom"];
	$bassins[$dataBassin["bassin_id"]]["bassin_nom"] = $dataBassin["bassin_nom"];
	/*
	 * Calcul du nombre de poissons presents et de la masse des poissons du lot
	 */
	$dataLotMesure = $lotMesure->getMesureAtDate($value["lot_id"], $dataAlim["date_debut_alim"]);
	$nbPoisson = $value["nb_larve_initial"] - $dataLotMesure["lot_mortalite"];
	if (!$nbPoisson > 0)
		$nbPoisson = 0;
	$massePoisson = $nbPoisson * $dataLotMesure["masse_indiv"];
	if (!massePoisson >= 0) 
		$massePoisson = 0;
	/*
	 * Calcul du nombre de jours ecoules depuis la naissance
	 */
	$dateNaissance = DateTime::createFromFormat("d/m/Y", $value["eclosion_date"]);
	$intervalle = date_diff($dateNaissance, $date);
	$nbJour = $intervalle->format('a');
	if ($nbJour > 0) {
		/*
		 * Forcage de l'age le plus grand, si deux lots dans le même bassin
		 */
		if ($nbJour > $bassins[$dataBassin["bassin_id"]]["age"] || is_null($bassins[$dataBassin["bassin_id"]]["age"]))
			$bassins[$dataBassin["bassin_id"]]["age"] = $nbJour;
		/*
		 * Recuperation de la quantite a distribuer
		 */
		$repart = $lotRepartTempate->getFromAge($nbJour);
		/*
		 * Calcul du nombre d'artemies a distribuer
		 */
		if ($repart["artemia"] > 0) {
			$bassins[$dataBassin["bassin_id"]]["artemia"] += $nbPoisson * $repart["artemia"];
			$artemiaFlag = true;
		}
		/*
		 * Calcul de la masse de chironomes a distribuer
		 */
		if ($repart["chironome"] > 0) {
			$bassins[$dataBassin["bassin_id"]]["chironome"] += $massePoisson * $repart["artemia"] / 100;
		}
	}

}

/*
 * Calcul de la quantite d'artemia a distribuer (en ml, en fonction de la densite)
 */
if ($artemiaFlag == true) {
	foreach($bassins as $key => $value) {
		if ($value["artemia"] > 0) {
			$bassins[$key]["volumeArtemia"] = intval($value["artemia"] / $dataAlim["densite"]);
		}
	}
}
/*
 * Fin du traitement des donnees
 * Declenchement de la generation du PDF
 * 
 */
?>