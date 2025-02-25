<?php
namespace App\Models;

class RepartitionJuvenile extends TableauRepartition
{
	function __construct()
	{
		$this->param["title"] = "Répartition des aliments dans les bassins - JUVENILES";
		$this->param["nomFichier"] = "juvenile";
		$this->param["hl"] = 6;
		$this->param["orientation"] = "L";
		parent::__construct();
	}
	/**
	 * Lancement de la generation du document
	 */
	function exec()
	{
		$this->entete();
		/**
		 * Preparation de l'entete du tableau
		 */
		$nbAlim = count($this->dataAliment);
		$alimColumnSize = intval(240 / $nbAlim);
		$alimColumnSizeMatin = intval($alimColumnSize / 2);
		$alimColumnSizeSoir = $alimColumnSize - $alimColumnSizeMatin;
		$largeurTotaleAlim = $nbAlim * $alimColumnSize;
		$this->enteteTableau($alimColumnSize);
		/**
		 * Preparation du tableau general des aliments En absisse : le numero d'aliment En ordonnee : le numéro de colonne
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
			} else
				$distrib[0]["bassin_nom"] = $value["bassin_nom"];
			/**
			 * Integration des donnees generales
			 */
			$distrib[$i]["taux_nourrissage"] = $value["taux_nourrissage"];
			$distrib[$i]["evol_taux_nourrissage"] = $value["evol_taux_nourrissage"];
			$distrib[$i]["total_distribue"] = $value["total_distribue"];
			$distrib[$i]["distribution_consigne"] = $value["distribution_consigne"];
			$distrib[$i]["distribution_masse"] = $value["distribution_masse"];
			$distrib[$i]["distribution_jour"] = $value["distribution_jour"];
			/**
			 * Integration des donnees d'aliment
			 */
			$distrib[$i][$aliment[$value["aliment_id"]]]["repart_alim_taux"] = $value["repart_alim_taux"];
			$distrib[$i][$aliment[$value["aliment_id"]]]["quantiteMatin"] = $value["quantiteMatin"];
			$distrib[$i][$aliment[$value["aliment_id"]]]["quantiteSoir"] = $value["quantiteSoir"];
			$distrib[$i][$aliment[$value["aliment_id"]]]["aliment_type_id"] = $value["aliment_type_id"];
		}
		/**
		 * Impression du tableau
		 */
		/**
		 * Traitement du tableau de distribution
		 */
		foreach ($distrib as $value) {
			/**
			 * Traitement du saut de page
			 */
			if ($this->nbLigne > 35) {
				$this->nbLigne = 0;
				$this->AddPage();
				$this->enteteTableau( $alimColumnSize);
			}
			/**
			 * Preparation de la ligne de donnees
			 */
			$this->SetFont("", "B");
			$this->SetFontSize(12);
			$this->SetFillColor(255, 255, 255);
			$this->Cell(30, $this->param["hl"], $value["bassin_nom"], 1, 0, 'C', true);
			/**
			 * Traitement des aliments
			 */
			$this->SetFontSize(12);
			for ($i = 0; $i < $nbAlim; $i++) {
				if ($this->dataAliment[$i]["aliment_type_id"] == 1) {
					$colorId = 4;
				} else {
					$colorId = 5;
				}
				$this->SetFillColor($this->color[$colorId]["R"], $this->color[$colorId]["G"], $this->color[$colorId]["B"]);
				$this->Cell($alimColumnSizeMatin, $this->param["hl"], $value[$i]["quantiteMatin"], 1, 0, 'C', true);
				$this->Cell($alimColumnSizeSoir, $this->param["hl"], $value[$i]["quantiteSoir"], 1, 0, 'C', true);
				$alimentTotal[$i]["matin"] += $value[$i]["quantiteMatin"];
				$alimentTotal[$i]["soir"] += $value[$i]["quantiteSoir"];
			}
			$this->ln();
			$this->nbLigne++;
			/**
			 * Recherche des jours sans distribution
			 */
			$jourDistrib = explode(",", $value["distribution_jour"]);
			$messageJour = "";
			for ($i = 0; $i < 7; $i++) {
				if ($jourDistrib[$i] != 1) {
					$messageJour .= " " . $this->jourSemaine[($i + 1)];
				}
			}
			if (strlen($messageJour) > 1) {
				$messageJour = 'À jeun le ' . $messageJour;
			}
			if (strlen($value["distribution_consigne"]) > 1) {
				$messageJour .= " " . $value["distribution_consigne"];
			}
			if (strlen($messageJour) > 1) {
				$this->SetTextColor(255, 0, 0);
				$this->SetFillColor(255, 255, 255);
				$this->Cell($largeurTotaleAlim + 30, $this->param["hl"], $messageJour, 1, 0, "L", true);
				$this->SetTextColor(0, 0, 0);
				$this->nbLigne++;
				$this->ln();
			}
		}
		/**
		 * Preparation de la fin du tableau - totalisations
		 */
		$this->SetFillColor(255, 255, 255);
		$this->SetFont("", "B");
		$this->Cell(30, $this->param["hl"], "Total/jour", 1, 0, 'C', true);
		$this->SetFont("");
		/**
		 * Total par jour
		 */
		for ($i = 0; $i < $nbAlim; $i++) {
			$this->Cell($alimColumnSizeMatin, 6, $alimentTotal[$i]["matin"], 1, 0, 'C', true);
			$this->Cell($alimColumnSizeSoir, 6, $alimentTotal[$i]["soir"], 1, 0, 'C', true);
		}
		$this->Ln();
		/**
		 * Total par semaine
		 */
		$this->SetFont("", "B");
		$this->Cell(30, $this->param["hl"], "Total/sem", 1, 0, 'C', true);
		$this->SetFont("");
		/**
		 * Recuperation des totaux pour chaque aliment
		 */
		for ($i = 0; $i < $nbAlim; $i++) {
			$this->Cell($alimColumnSize, $this->param["hl"], ($alimentTotal[$i]["matin"] + $alimentTotal[$i]["soir"]) * 7, 1, 0, 'C', true);
		}
		/**
		 * Envoi au navigateur
		 */
		$this->sent();
	}
	/**
	 * Imprime l'entete du tableau
	 *        	
	 * @param int $alimColumnSize        	
	 */
	function enteteTableau($alimColumnSize)
	{
		/**
		 * Ecriture du contenu de l'entete
		 */
		$this->SetFillColor(255, 255, 255);
		$this->SetFont("", "B");
		$this->Cell(30, $this->param["hl"], "Bassin", 1, 0, 'C', true);
		/**
		 * Ecriture du nom des aliments
		 */
		foreach ($this->dataAliment as $value) {
			$this->SetFontSize(14);
			if ($value["aliment_type_id"] == 1) {
				$i = 4;
			} else {
				$i = 5;
			}
			$this->SetFillColor($this->color[$i]["R"], $this->color[$i]["G"], $this->color[$i]["B"]);
			$this->Cell($alimColumnSize, $this->param["hl"], $value["aliment_libelle_court"], 1, 0, 'C', true);
		}
		$this->Ln();
		$this->nbLigne++;
	}
}
