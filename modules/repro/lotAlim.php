<?php
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
$alimJuv->setParam ( $_REQUEST );
$paramAlim = $alimJuv->getParam ();
if (! $paramAlim ["densite"] > 0)
	$paramAlim ["densite"] = 1;
	/*
 * Recherche des lots à traiter
 */
require_once 'modules/classes/lot.class.php';
require_once 'modules/classes/bassin.class.php';
require_once 'modules/classes/aliment.class.php';
require_once 'modules/classes/tableauRepartition.class.php';
$lot = new Lot ( $bdd, $ObjetBDDParam );
$bassinLot = new BassinLot ( $bdd, $ObjetBDDParam );
$lotMesure = new LotMesure ( $bdd, $ObjetBDDParam );
$alimentQuotidien = new AlimentQuotidien ( $bdd, $ObjetBDDParam );
$distribQuotidien = new DistribQuotidien ( $bdd, $ObjetBDDParam );
$lotRepartTempate = new LotRepartTemplate ( $bdd, $ObjetBDDParam );
$repartition = new Repartition ( $bdd, $ObjetBDDParam );
$lots = $lot->getListAfterDate ( $paramAlim ["date_debut_alim"] );
$date = DateTime::createFromFormat ( "d/m/Y", $paramAlim ["date_debut_alim"] );

/**
 * $bassins[$bassin_nom] = array("artemia"=>Qté artémies, "chironome"=>masse chironome,
 * "volumeArtemia"=>volume d'artemies a distribuer,
 * "lots" => liste des lots presents,
 * "bassin_nom"=> nom du bassin);
 */
$bassins = array ();
$artemiaFlag = false;
/*
 * Traitement de chaque lot
 */
foreach ( $lots as $key => $value ) {
	/*
	 * Recuperation du bassin
	 */
	$dataBassin = $bassinLot->getBassin ( $value ["lot_id"], $paramAlim ["date_debut_alim"] );
	if (strlen ( $dataBassin ["bassin_nom"] ) == 0) {
		$dataBassin ["bassin_nom"] = "Inconnu";
	}
	/*
	 * Affectation du nom du lot au bassin
	 */
	if (strlen ( $bassins [$dataBassin ["bassin_nom"]] ["lot_nom"] ) > 0)
		$bassins [$dataBassin ["bassin_nom"]] ["lot_nom"] .= " ,";
	$bassins [$dataBassin ["bassin_nom"]] ["lot_nom"] = $value ["sequence_nom"] . "-" . $value ["lot_nom"];
	$bassins [$dataBassin ["bassin_nom"]] ["bassin_nom"] = $dataBassin ["bassin_nom"];
	$bassins [$dataBassin ["bassin_nom"]] ["bassin_id"] = $dataBassin ["bassin_id"];
	/*
	 * Calcul du nombre de poissons presents et de la masse des poissons du lot
	 */
	$dataLotMesure = $lotMesure->getMesureAtDate ( $value ["lot_id"], $paramAlim ["date_debut_alim"] );
	$nbPoisson = $value ["nb_larve_initial"] - $dataLotMesure ["lot_mortalite"];
	if (! $nbPoisson > 0)
		$nbPoisson = 0;
	$massePoisson = $nbPoisson * $dataLotMesure ["masse_indiv"];
	/*
	 * Calcul du nombre de jours ecoules depuis la naissance
	 */
	$dateNaissance = DateTime::createFromFormat ( "d/m/Y", $value ["eclosion_date"] );
	$intervalle = date_diff ( $dateNaissance, $date );
	$nbJour = $intervalle->format ( '%a' );
	if ($nbJour > 0) {
		/*
		 * Forcage de l'age le plus grand, si deux lots dans le même bassin
		 */
		if ($nbJour > $bassins [$dataBassin ["bassin_nom"]] ["age"] || is_null ( $bassins [$dataBassin ["bassin_nom"]] ["age"] ))
			$bassins [$dataBassin ["bassin_nom"]] ["age"] = $nbJour;
			/*
		 * Recuperation de la quantite a distribuer
		 */
		$repart = $lotRepartTempate->getFromAge ( $nbJour );
		/*
		 * Calcul du nombre d'artemies a distribuer
		 */
		if ($repart ["artemia"] > 0) {
			$bassins [$dataBassin ["bassin_nom"]] ["artemia"] = + $nbPoisson * $repart ["artemia"];
			$artemiaFlag = true;
		}
		/*
		 * Calcul de la masse de chironomes a distribuer
		 */
		if ($repart ["chironome"] > 0) {
			$bassins [$dataBassin ["bassin_nom"]] ["chironome"] = + intval ( $massePoisson * $repart ["chironome"] / 100 );
		}
	}
}

/*
 * Calcul de la quantite d'artemia a distribuer (en ml, en fonction de la densite)
 */
if ($artemiaFlag == true) {
	foreach ( $bassins as $key => $value ) {
		if ($value ["artemia"] > 0) {
			$bassins [$key] ["volumeArtemia"] = intval ( $value ["artemia"] / $paramAlim ["densite"] );
		}
	}
}
/*
 * Ecriture de l'alimentation en base
 */
if ($artemiaFlag == true)
	$paramAlim ["duree"] = 1;

$jour = new DateInterval ( "P1D" );
foreach ( $bassins as $key => $bassin ) {
	if ($bassin ["artemia"] > 0 || $bassin ["chironome"] > 0) {
		/*
		 * Traitement de chaque jour
		 */
		$dateCalcul = DateTime::createFromFormat ( "d/m/Y", $paramAlim ["date_debut_alim"] );
		for($i = 0; $i < $paramAlim ["duree"]; $i ++) {
			if ($i > 0)
				$dateCalcul->add ( $jour );
				/*
			 * Suppression des donnees du bassin
			 */
			$alimentQuotidien->deleteFromDateBassin ( $dateCalcul->format ( "Y-m-d" ), $bassin ["bassin_id"] );
			/*
			 * Creation des donnees d'alimentation
			 */
			$dataQuotidien = array (
					"bassin_id" => $bassin ["bassin_id"],
					"distrib_quotidien_date" => $dateCalcul->format ( "d/m/Y" ) 
			);
			$idDataQuotidien = $distribQuotidien->ecrireFromBassinDate ( $dataQuotidien );
			if ($idDataQuotidien > 0) {
				/*
				 * Traitement des artemia
				 */
				if ($bassin ["artemia"] > 0) {
					$dataAlim = array (
							"aliment_quotidien_id" => 0,
							"aliment_id" => 25,
							"distrib_quotidien_id" => $idDataQuotidien,
							"quantite" => $bassin ["artemia"] 
					);
					$alimentQuotidien->ecrire ( $dataAlim );
				}
				/*
				 * Traitement des chironomes
				 */
				if ($bassin ["chironome"] > 0) {
					$dataAlim = array (
							"aliment_quotidien_id" => 0,
							"aliment_id" => 1,
							"distrib_quotidien_id" => $idDataQuotidien,
							"quantite" => $bassin ["chironome"] 
					);
					$alimentQuotidien->ecrire ( $dataAlim );
				}
			}
		}
	}
}
/*
 * Ecriture de la repartition
 */
$dateFin = DateTime::createFromFormat ( "d/m/Y", $paramAlim ["date_debut_alim"] );
if ($paramAlim ["duree"] > 1) {
	$jour = new DateInterval ( "P" . ($paramAlim ["duree"] - 1) . "D" );
	$dateFin->add ( $jour );
}

$dataRepartition = array (
		"repartition_id" => 0,
		"categorie_id" => 3,
		"date_debut_periode" => $paramAlim ["date_debut_alim"],
		"date_fin_periode" => $dateFin->format ( "d/m/Y" ),
		"densite_artemia" => $paramAlim ["densite"] 
);
$repartition->ecrireFromDateCategorie ( $dataRepartition );

/*
 * Tri du bassin
 */
ksort ( $bassins );
/*
 * Fin du traitement des donnees
 * Declenchement de la generation du PDF
 */
$pdf = new RepartitionJuvenileLot ();
$pdf->setData ( $dataRepartition, $bassins, $artemiaFlag );
$pdf->exec ();
?>