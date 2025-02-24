<?php 
namespace App\Models;
use Ppci\Models\PpciModel;
/**
 * Generation du fichier de distribution pour les lots de juveniles
 * @author quinton
 *
 */
class RepartitionJuvenileLot extends TableauRepartition
{
	public $dataBassin;
	public $isArtemia = false;
	public $horaire = array("8h", "14h", "18h", "22h");

	function __construct()
	{
		$this->param["title"] = "Répartition des aliments dans les bassins - JUVENILES LOTS";
		$this->param["nomFichier"] = "juvenileLot";
		$this->param["hl"] = 6;
		$this->param["orientation"] = "P";
		parent::__construct();
	}

	/**
	 * Affectation des donnees
	 * @param $dataRepartition : tableau correspondant a la table repartition
	 * @param $dataBassin : donnees de distribution par bassin
	 * @isArtemia : booleen pour indiquer s'il y a ou non distribution d'artemies
	 * (non-PHPdoc)
	 * @see TableauRepartition::setData()
	 */
	function setData($dataRepartition, $dataBassin, $isArtemia)
	{
		$this->dataBassin = $dataBassin;
		$this->dataRepartition = $dataRepartition;
	}

	/**
	 * Creation du PDF
	 */
	function exec()
	{
		$this->entete();
		/*
		 * Affichage de la densité d'artemia
		 */
		$this->SetFillColor(255, 255, 255);
		$this->SetFont("");
		$this->Cell(50, $this->param["hl"], "Nb artémies/ml : ", 0, 0, 'R', true);
		$this->SetFont("", "B");
		$this->Cell(50, $this->param["hl"], $this->dataRepartition["densite_artemia"], 0, 0, 'L', true);
		$this->Ln();
		$this->nbLigne++;
		$total = array();
		/*
		 * Appel de l'entete
		 */
		$this->enteteTableau();
		/*
	 * Traitement de chaque bassin
	 */
		foreach ($this->dataBassin as $key => $bassin) {
			/*
			 * Traitement du saut de page
			 */
			if ($this->nbLigne > 35) {
				$this->nbLigne = 0;
				$this->AddPage();
				$this->enteteTableau();
			}

			$this->Cell(30, $this->param["hl"], $bassin["bassin_nom"], 1, 0, 'C', true);
			/*
			 * Traitement des artemies
			 */
			if ($bassin["artemia"] > 0) {
				$taux = array(0.2, 0.2, 0.2, 0.4);
				$this->Cell(25, $this->param["hl"], $bassin["artemia"], 1, 0, 'C', true);
				$total[0] += $bassin["artemia"];
				for ($i = 0; $i < 4; $i++) {
					$val = intval($bassin["volumeArtemia"] * $taux[$i]);
					$this->Cell(15, $this->param["hl"], $val, 1, 0, 'C', true);
					$total[$i + 1] += $val;
				}
			} else {
				/*
				 * mise a vide
				 */
				$this->Cell(25, $this->param["hl"], "-", 1, 0, 'C', true);
				for ($i = 0; $i < 4; $i++) {
					$this->Cell(15, $this->param["hl"], "", 1, 0, 'L', true);
				}
			}
			/*
			 * Traitement des chironomes
			 */
			if ($bassin["chironome"] > 0) {
				if ($bassin["artemia"] > 0) {
					/*
					 * 4 distributions par jour
					 */
					$taux = array(0.2, 0.2, 0.2, 0.4);
				} else {
					$taux = array(0.25, 0.25, 0.50, 0);
				}
				for ($i = 0; $i < 4; $i++) {
					$val = intval($bassin["chironome"] * $taux[$i]);
					if ($val == 0) $val = "";
					$this->Cell(15, $this->param["hl"], $val, 1, 0, 'C', true);
					$total[$i + 5] += $val;
				}
			} else {
				/*
				 * Mise a vide
				 */
				for ($i = 0; $i < 4; $i++) {
					$this->Cell(15, $this->param["hl"], "", 1, 0, 'L', true);
				}
			}
			$this->Ln();
			$this->nbLigne++;
		}
		/*
		 * Creation de la ligne de total
		 */
		$this->Cell(30, $this->param["hl"], "Totaux", 1, 0, 'C', true);
		$this->Cell(25, $this->param["hl"], $total[0], 1, 0, 'C', true);
		for ($i = 1; $i < 9; $i++) {
			$this->Cell(15, $this->param["hl"], $total[$i], 1, 0, 'C', true);
		}
		$this->Ln();
		/*
		 * Envoi au navigateur
		 */
		$this->sent();
	}

	/**
	 * Generation de l'entete du tableau
	 */
	function enteteTableau()
	{
		/*
		 * Ecriture du contenu de l'entete
		 */
		$this->SetFillColor(255, 255, 255);
		$this->SetFont("", "B");
		$this->Cell(30, $this->param["hl"], "Bassin", 'LTR', 0, 'C', true);
		$this->Cell(85, $this->param["hl"], "Artémies (ml)", 1, 0, 'C', true);
		$this->Cell(60, $this->param["hl"], "Chironomes (gramme)", 1, 0, 'C', true);
		$this->Ln();
		$this->nbLigne++;
		/*
		 * Seconde ligne
		 */
		$this->Cell(30, $this->param["hl"], "", 'LBR', 0, 'C', true);
		$this->Cell(25, $this->param["hl"], "Total", 1, 0, 'C', true);
		/*
		 * Generation des cellules horaires
		 */
		for ($i = 1; $i <= 2; $i++) {
			for ($j = 0; $j < 4; $j++) {
				$this->Cell(15, $this->param["hl"], $this->horaire[$j], 1, 0, 'C', true);
			}
		}
		$this->Ln();
		$this->nbLigne++;
	}
}
