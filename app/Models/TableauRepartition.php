<?php 
namespace App\Models;
use Ppci\Models\PpciModel;
use TCPDF;

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 24 mars 2014
 */

/**
 * Classe générique, à hériter pour chaque modèle de document
 * 
 * @author quinton
 *        
 */
class TableauRepartition extends TCPDF
{
	public $dataRepartition;
	public $dataDistribution;
	public $dataAliment;
	/**
	 * Parametres par defaut
	 * 
	 * @var array
	 */
	public $param = array(
		"orientation" => "P",
		"unit" => "mm",
		"format" => "A4",
		"unicode" => true,
		"encoding" => "UTF-8",
		"nomFichier" => "sturio",
		"hl" => 10  // Hauteur de ligne
	);
	public $nbLigne = 0;
	/**
	 * Jeu de couleur pour les fonds
	 * 
	 * @var array
	 */
	public $color = array(
		0 => array(
			"nom" => "bleu",
			"R" => 200,
			"G" => 235,
			"B" => 254
		),
		1 => array(
			"nom" => "olive",
			"R" => 209,
			"G" => 199,
			"B" => 86
		),
		2 => array(
			"nom" => "orange",
			"R" => 252,
			"G" => 164,
			"B" => 75
		),
		3 => array(
			"nom" => "jaune",
			"R" => 255,
			"G" => 216,
			"B" => 67
		),
		4 => array(
			"nom" => "violet",
			"R" => 224,
			"G" => 209,
			"B" => 204
		),
		5 => array(
			"nom" => "vert",
			"R" => 208,
			"G" => 232,
			"B" => 213
		),
		6 => array(
			"nom" => "bleu",
			"R" => 200,
			"G" => 235,
			"B" => 254
		),
		7 => array(
			"nom" => "olive",
			"R" => 209,
			"G" => 199,
			"B" => 86
		),
		8 => array(
			"nom" => "orange",
			"R" => 252,
			"G" => 164,
			"B" => 75
		),
		9 => array(
			"nom" => "jaune",
			"R" => 255,
			"G" => 216,
			"B" => 67
		),
		10 => array(
			"nom" => "violet",
			"R" => 224,
			"G" => 209,
			"B" => 204
		),
		11 => array(
			"nom" => "vert",
			"R" => 208,
			"G" => 232,
			"B" => 213
		)
	);
	public $jourSemaine = array(
		0 => "dimanche",
		1 => "lundi",
		2 => "mardi",
		3 => "mercredi",
		4 => "jeudi",
		5 => "vendredi",
		6 => "samedi",
		7 => "dimanche"
	);
	public $nbJour = 7;
	private $dateDebut;
	/**
	 * Constructeur de la classe
	 */
	function __construct()
	{
		parent::__construct();
	}
	/**
	 * Recupere les donnees necessaires a la generation de la feuille de repartition
	 *
	 * @param array $dataRepartition        	
	 * @param array $dataDistribution        	
	 * @param array $dataAliment        	
	 */
	function setData($dataRepartition, $dataDistribution, $dataAliment)
	{
		$this->dataRepartition = $dataRepartition;
		$this->dataDistribution = $dataDistribution;
		$this->dataAliment = $dataAliment;
	}
	/**
	 * Definition du pied de page
	 * (non­PHPdoc)
	 *
	 * @see FPDF::Footer()
	 */
	function Footer()
	{
		$this->SetY(-15);
		// Set font
		$this->SetFont('helvetica', 'I', 8);
		// Page number
		$this->Cell(0, 10, 'Page ' . $this->getAliasNumPage() . '/' . $this->getAliasNbPages(), 0, false, 'C', 0, '', 0, false, 'T', 'M');
	}
	/**
	 * Definition de l'entete de page
	 */
	function entete()
	{
		/*
		 * Definition de la marge
		 */
		$this->SetMargins(10, 10, 10);
		$this->SetFont("helvetica");
		$this->setPrintHeader(false);
		$this->AddPage($this->param["orientation"]);
		/*
		 * Impression du titre
		 */
		$this->SetFont("", "B");
		$this->SetFontSize(10);
		$this->Write(0, $this->param["title"], "", 0, "C");
		$this->Ln();
		/*
		 * Titre du document
		 */
		$dateDebut = date_create_from_format("d/m/Y", $this->dataRepartition["date_debut_periode"]);
		$this->dateDebut = $dateDebut;
		$jourDebut = date_format($dateDebut, "w");
		$dateFin = date_create_from_format("d/m/Y", $this->dataRepartition["date_fin_periode"]);
		$interval = date_diff($dateDebut, $dateFin);
		$this->nbJour = $interval->format('%a') + 1;
		$jourFin = date_format($dateFin, "w");
		$titre = $this->dataRepartition["repartition_name"] . " " . $this->jourSemaine[$jourDebut] . " " .  $this->dataRepartition["date_debut_periode"] . " au " . $this->jourSemaine[$jourFin] . " " . $this->dataRepartition["date_fin_periode"];
		$this->SetFont("", "B");
		$this->SetFontSize(14);
		$this->Write(0, $titre, "", 0, "C");
		$this->ln();
	}
	/**
	 * Envoie le document au navigateur
	 */
	function sent($dateDebut = "")
	{
		if ($dateDebut == "") {
			$dateDebut = date('d-m-Y');
		}
		$nomFichier = $this->param["nomFichier"] . "_" . $this->dateDebut->format("d-m-Y") . ".pdf";
		$this->Output($nomFichier, "I");
	}
}


