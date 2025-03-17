<?php
namespace App\Models;

/**
 * Affichage de l'état de répartition pour les adultes
 * 
 * @author quinton
 *        
 */
class RepartitionAdulte extends TableauRepartition
{
	function __construct()
	{
		$this->param["title"] = "Répartition des aliments dans les bassins - ADULTES";
		$this->param["nomFichier"] = "adulte";
		parent::__construct();
	}
	/**
	 * Lancement de la generation du document
	 */
	function exec()
	{
		$this->entete();
		/*
		 * Preparation de l'entete du tableau
		 */
		$nbAlim = count($this->dataAliment);
		if (!$nbAlim > 0) {
			$nbAlim = 1;
		}
		$alimColumnSize = intval(130 / $nbAlim);
		$alimColumnSizeMatin = intval($alimColumnSize / 2);
		$alimColumnSizeSoir = $alimColumnSize - $alimColumnSizeMatin;
		$largeurTotaleAlim = $nbAlim * $alimColumnSize;
		$this->enteteTableau($nbAlim, $alimColumnSize);
		/**
		 * Impression des données
		 */
		/**
		 * Preparation du tableau general des aliments
		 * En absisse : le numero d'aliment
		 * En ordonnee : le numéro de colonne
		 */
		$aliment = array();
		$alimentTotal = array();
		$i = 0;
		foreach ($this->dataAliment as $value) {
			$aliment[$value["aliment_id"]] = $i;
			$i++;
		}
		/**
		 * preparation du tableau de distribution
		 */
		$distrib = array();
		$i = 0;
		foreach ($this->dataDistribution as $value) {
			if (strlen($distrib[$i]["bassin_nom"]) > 0) {
				if ($value["bassin_nom"] != $distrib[$i]["bassin_nom"]) {
					/**
					 * On incremente le compteur
					 */
					$i++;
					$distrib[$i]["bassin_nom"] = $value["bassin_nom"];
				}
			} else {
				$distrib[0]["bassin_nom"] = $value["bassin_nom"];
			}
			/**
			 * Integration des donnees generales
			 */
			$distrib[$i]["taux_nourrissage"] = $value["taux_nourrissage"];
			$distrib[$i]["evol_taux_nourrissage"] = $value["evol_taux_nourrissage"];
			$distrib[$i]["total_distribue"] = $value["total_distribue"];
			$distrib[$i]["distribution_consigne"] = $value["distribution_consigne"];
			$distrib[$i]["distribution_masse"] = $value["distribution_masse"];
			/*
			 * Integration des donnees d'aliment
			 */
			$distrib[$i][$aliment[$value["aliment_id"]]]["repart_alim_taux"] = $value["repart_alim_taux"];
			$distrib[$i][$aliment[$value["aliment_id"]]]["quantiteMatin"] = $value["quantiteMatin"];
			$distrib[$i][$aliment[$value["aliment_id"]]]["quantiteSoir"] = $value["quantiteSoir"];
		}
		/**
		 * Impression du tableau
		 */
		$nbOccur = 0;
		/**
		 * Traitement du tableau de distribution
		 */
		foreach ($distrib as  $value) {
			/**
			 * Traitement du saut de page
			 */
			if ($nbOccur > 9) {
				$this->AddPage();
				$this->enteteTableau($nbAlim, $alimColumnSize);
				$nbOccur = 0;
			}
			/**
			 * Preparation de la ligne supérieure
			 */
			$this->SetFillColor(255, 255, 255);
			$this->SetFontSize(6);
			$this->SetFont("", "");
			$this->Cell(20, 4, "% de la ration", 1, 0, 'C', true);
			/**
			 * Recuperation des taux pour chaque aliment
			 */
			for ($i = 0; $i < $nbAlim; $i++) {
				$this->SetFillColor($this->color[$i]["R"], $this->color[$i]["G"], $this->color[$i]["B"]);
				$this->SetFont("", "B");
				$this->Cell($alimColumnSize, 4, $value[$i]["repart_alim_taux"], 1, 0, 'C', true);
			}
			/**
			 * Ecriture de la fin de ligne
			 */
			$this->SetFillColor(255, 255, 255);
			$this->SetFont("");
			$this->Cell(40, 4, "", 1, 0, 'C', true);
			$this->Ln();
			/**
			 * Preparation de la ligne de donnees
			 */
			$this->SetFont("", "B");
			$this->SetFontSize(16);
			$this->Cell(20, $this->param["hl"], $value["bassin_nom"], 1, 0, 'C', true);
			/**
			 * Traitement des aliments
			 */
			$this->SetFontSize(16);
			for ($i = 0; $i < $nbAlim; $i++) {
				$this->SetFillColor($this->color[$i]["R"], $this->color[$i]["G"], $this->color[$i]["B"]);
				$this->Cell($alimColumnSizeMatin, $this->param["hl"], $value[$i]["quantiteMatin"], 1, 0, 'C', true);
				$this->Cell($alimColumnSizeSoir, $this->param["hl"], $value[$i]["quantiteSoir"], 1, 0, 'C', true);
				$alimentTotal[$i]["matin"] += $value[$i]["quantiteMatin"];
				$alimentTotal[$i]["soir"] += $value[$i]["quantiteSoir"];
			}
			/**
			 * Fin de ligne
			 */
			$this->SetFillColor(255, 255, 255);
			$this->SetFontSize(10);
			$this->Cell(15, $this->param["hl"], $value["distribution_masse"], 1, 0, 'C', true);
			$this->Cell(10, $this->param["hl"], $value["taux_nourrissage"], 1, 0, 'C', true);
			$this->Cell(15, $this->param["hl"], $value["total_distribue"], 1, 0, 'C', true);
			$this->Ln();
			/**
			 * Troisième ligne
			 */
			$this->Cell(20 + $largeurTotaleAlim + 15, 8, $value["distribution_consigne"], 1, 0, 'L', true);
			$this->Cell(10, 8, $value["evol_taux_nourrissage"], 1, 0, 'C', true);
			$this->Cell(15, 8, "", 1, 0, 'C', true);
			$this->Ln();
			$nbOccur++;
		}
		/**
		 * Preparation de la fin du tableau - totalisations
		 */
		$this->SetFont("", "B");
		$this->Cell(20, 6, "Total/jour", 1, 0, 'C', true);
		$this->SetFont("");
		/**
		 * Recuperation des totaux pour chaque aliment
		 */
		for ($i = 0; $i < $nbAlim; $i++) {
			$this->Cell($alimColumnSizeMatin, 6, $alimentTotal[$i]["matin"], 1, 0, 'C', true);
			$this->Cell($alimColumnSizeSoir, 6, $alimentTotal[$i]["soir"], 1, 0, 'C', true);
		}
		$this->Cell(40, 6, "", 1, 0, 'C', true);
		$this->Ln();
		/**
		 * Total par semaine
		 */
		$this->SetFont("", "B");
		$this->Cell(20, 6, "Total/sem", 1, 0, 'C', true);
		$this->SetFont("");
		/**
		 * Recuperation des totaux pour chaque aliment
		 */
		for ($i = 0; $i < $nbAlim; $i++) {
			$this->Cell($alimColumnSize, 6, ($alimentTotal[$i]["matin"] + $alimentTotal[$i]["soir"]) * $this->nbJour, 1, 0, 'C', true);
		}
		$this->Cell(40, 6, "", 1, 0, 'C', true);
		/**
		 * envoi au navigateur
		 */
		$this->sent();
	}
	/**
	 * Imprime l'entete du tableau
	 * 
	 * @param int $nbAlim        	
	 * @param int $alimColumnSize        	
	 */
	function enteteTableau($nbAlim, $alimColumnSize)
	{
		/**
		 * Ecriture du contenu de l'entete
		 */
		$this->SetFillColor(255, 255, 255);
		$this->SetFont("", "B");
		$this->Cell(20, 10, "Bassin", 1, 0, 'C', true);
		/**
		 * Ecriture du nom des aliments
		 */
		$i = 0;
		foreach ($this->dataAliment as $key => $value) {
			$this->SetFontSize(14);
			$this->SetFillColor($this->color[$i]["R"], $this->color[$i]["G"], $this->color[$i]["B"]);
			$this->Cell($alimColumnSize, $this->param["hl"], $value["aliment_libelle_court"], 1, 0, 'C', true);
			$i++;
		}
		$this->SetFillColor(255, 255, 255);
		$this->SetFontSize(8);
		$this->Cell(15, $this->param["hl"], "Biomasse", 1, 0, 'C', true);
		$this->Cell(10, $this->param["hl"], "Taux", 1, 0, 'C', true);
		$this->Cell(15, $this->param["hl"], "Total/jour", 1, 0, 'C', true);
		$this->Ln();
	}
}