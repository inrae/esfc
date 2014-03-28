<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 24 mars 2014
 */
include_once 'plugins/tcpdf_6_0_062/tcpdf.php';
/**
 * Classe générique, à hériter pour chaque modèle de document
 * @author quinton
 *
 */
class TableauRepartition extends TCPDF {
	public $dataRepartition;
	public $dataDistribution;
	public $dataAliment;
	/**
	 * Parametres par defaut
	 * @var array
	 */
	public $param = array (
			"orientation" => "P",
			"unit" => "mm",
			"format" => "A4",
			"unicode" => true,
			"encoding" => "UTF-8" 
	);
	/**
	 * Jeu de couleur pour les fonds
	 * @var array
	 */
	public $color = array (0 => array (	"nom" => "bleu","R" => 200, "G"=> 235, "B" => 254),
			1 => array ("nom" => "olive","R" => 209, "G"=> 199, "B" => 86),
			2 => array ("nom" => "orange","R" => 252, "G"=> 164, "B" => 75),
			3 => array ("nom" => "jaune","R" => 255, "G"=> 216, "B" => 67),
			4 => array ("nom" => "violet","R" => 224, "G"=> 209, "B" => 204),
			5 => array ("nom" => "vert","R" => 208, "G"=> 232, "B" => 213)
			);
	/**
	 * Constructeur de la classe
	 */
	function __construct($param = null) {
		if (is_array ($param)) {
			foreach ($param as $key => $value) {
				$this->param[$key] = $value;
			} 
		}		
		parent::__construct ( $this->param ["orientation"], $this->param ["unit"], $this->param ["format"], $this->param ["unicode"], $this->param ["encoding"] );
	}
	/**
	 * Recupere les donnees necessaires a la generation de la feuille de repartition
	 * 
	 * @param array $dataRepartition        	
	 * @param array $dataDistribution        	
	 * @param array $dataAliment        	
	 */
	function setData($dataRepartition, $dataDistribution, $dataAliment) {
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
	function Footer() {
		$this->SetY(-15);
		// Set font
		$this->SetFont('helvetica', 'I', 8);
		// Page number
		$this->Cell(0, 10, 'Page '.$this->getAliasNumPage().'/'.$this->getAliasNbPages(), 0, false, 'C', 0, '', 0, false, 'T', 'M');
	}
}
/**
 * Affichage de l'état de répartition pour les adultes
 * @author quinton
 *
 */
class RepartitionAdulte extends TableauRepartition {
	function __construct () {
		$this->param["title"] = "Répartition des aliments dans les bassins - ADULTES";
		parent::__construct();
	} 
	/**
	 * Lancement de la generation du document
	 */
	function exec() {
		/*
		 * Definition de la marge
		 */
		$this->SetMargins(10, 10, 10);
		$this->SetFont("helvetica");
		$this->setPrintHeader(false);
		$this->AddPage();
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
		$jourSemaine = array (0=>"dimanche", 1=>"lundi", 2=>"mardi", 3=>"mercredi", 4=>"jeudi", 5=>"vendredi", 6=>"samedi");
		$jourDebut = date_format($dateDebut,"w");
		$dateFin = date_create_from_format("d/m/Y", $this->dataRepartition["date_fin_periode"]);
		$interval = date_diff($dateDebut, $dateFin);
		$nbJour = $interval->format('%a') + 1;
		$jourFin = date_format($dateFin,"w");
		$titre = $jourSemaine[$jourDebut]." ".$this->dataRepartition["date_debut_periode"]." au ".
				$jourSemaine[$jourFin]. " ". $this->dataRepartition["date_fin_periode"];
		$this->SetFont("", "B");
		$this->SetFontSize(14);
		$this->Write(0, $titre, "", 0, "C");
		$this->ln();
		/*
		 * Preparation de l'entete du tableau
		 */
		$nbAlim = count ($this->dataAliment);
		$alimColumnSize = intval(130 / $nbAlim);
		$this->enteteTableau($nbAlim, $alimColumnSize);
		/*
		 * Impression des données
		 */
		/*
		 * Preparation du tableau general des aliments
		 * En absisse : le numero d'aliment
		 * En ordonnee : le numéro de colonne
		 */
		$aliment = array();
		$i = 0;
		//printr($this->dataAliment);
		foreach ($this->dataAliment as $key=> $value) {
			$aliment[$value["aliment_id"]] = $i;
			$i ++;
		}
		//printr($aliment);
		/*
		 * preparation du tableau de distribution
		 */
		$distrib = array();
		$i = 0 ;
		foreach ($this->dataDistribution as $key => $value) {
			if (strlen($distrib[$i]["bassin_nom"]) > 0 ) {
				if ($value["bassin_nom"] != $distrib[$i]["bassin_nom"]) {
					/*
					 * On incremente le compteur
					 */
					$i ++ ;
					$distrib[$i]["bassin_nom"] = $value["bassin_nom"];
				}
			} else $distrib[0]["bassin_nom"] = $value["bassin_nom"];
			/*
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
			$distrib[$i][$aliment[$value["aliment_id"]]]["quantite"] = $value["quantite"];
			$alimentTotal[$value["aliment_id"]] =  $alimentTotal[$value["aliment_id"]] + $value["quantite"];
		}
		/*
		 * Impression du tableau
		 */
		$nbOccur = 0;
		/*
		 * Traitement du tableau de distribution
		 */
		foreach ($distrib as $key => $value) {
			/*
			 * Traitement du saut de page
			 */
			if ($nbOccur > 9) {
				$this->AddPage();
				$this->enteteTableau($nbAlim, $alimColumnSize);
				$nbOccur = 0;
			}
			/*
			 * Preparation de la ligne supérieure
			*/
			$this->SetFillColor(255,255,255);
			$this->SetFontSize(6);
			$this->SetFont("", "");
			$this->Cell(20, 4, "% de la ration", 1, 0,'C', true);
			/*
			 * Recuperation des taux pour chaque aliment
			 */
			for ($i = 0; $i < $nbAlim; $i ++) {
				$this->SetFillColor($this->color[$i]["R"], $this->color[$i]["G"], $this->color[$i]["B"]);
				$this->SetFont("", "B");
				$this->Cell($alimColumnSize, 4, $value[$i]["repart_alim_taux"], 1, 0, 'C', true);
			}
			/*
			 * Ecriture de la fin de ligne
			 */
			$this->SetFillColor(255,255,255);
			$this->SetFont();
			$this->Cell(40,4,"", 1, 0, 'C', true);
			$this->Ln();
			/*
			 * Preparation de la ligne de donnees
			 */
			$this->SetFont("", "B");
			$this->SetFontSize(16);
			$this->Cell(20, 10, $value["bassin_nom"], 1, 0,'C', true);
			/*
			 * Traitement des aliments
			 */
			$this->SetFontSize(18);
			for ($i = 0; $i < $nbAlim; $i ++) {
				$this->SetFillColor($this->color[$i]["R"], $this->color[$i]["G"], $this->color[$i]["B"]);
				$this->Cell($alimColumnSize, 10, $value[$i]["quantite"], 1, 0, 'C', true);
			}
			/*
			 * Fin de ligne
			 */
			$this->SetFillColor(255,255,255);
			$this->SetFontSize(10);
			$this->Cell(15,10,$value["distribution_masse"], 1, 0, 'C', true);
			$this->Cell(10, 10,$value["taux_nourrissage"], 1, 0, 'C', true);
			$this->Cell(15,10,$value["total_distribue"], 1, 0, 'C', true);
			$this->Ln();
			/*
			 * Troisième ligne
			 */
			$this->Cell(165,8,$value["distribution_consigne"],1, 0, 'L', true);
			$this->Cell(10, 8,$value["evol_taux_nourrissage"], 1, 0, 'C', true);
			$this->Cell(15,8,"", 1, 0, 'C', true);
			$this->Ln();
			$nbOccur ++;
		}
		/*
		 * Preparation de la fin du tableau - totalisations
		 */
		$this->SetFont("", "B");
		$this->Cell(20, 6, "Total/jour", 1, 0,'C', true);
		$this->SetFont();
		/*
		 * Recuperation des totaux pour chaque aliment
		*/
		foreach ($alimentTotal as $key=>$value) {
			$this->Cell($alimColumnSize, 6, $value, 1, 0, 'C', true);
		}
		$this->Cell(40,6,"", 1, 0, 'C', true);
		$this->Ln();
		/*
		 * Total par semaine
		 */
		$this->SetFont("", "B");
		$this->Cell(20, 6, "Total/sem", 1, 0,'C', true);
		$this->SetFont();
		/*
		 * Recuperation des totaux pour chaque aliment
		*/
		foreach ($alimentTotal as $key=>$value) {
			$this->Cell($alimColumnSize, 6, $value * $nbJour, 1, 0, 'C', true);
		}
		$this->Cell(40,6,"", 1, 0, 'C', true);
		/*
		 * envoi au navigateur
		 */
		$nomFichier = "repartitionAdulte_".$dateDebut->format("d-m-Y").".pdf";
		$this->Output($nomFichier, "I");
	}
	/**
	 * Imprime l'entete du tableau 
	 * @param int $nbAlim
	 * @param int $alimColumnSize
	 */
	function enteteTableau($nbAlim, $alimColumnSize) {
		/*
		 * Ecriture du contenu de l'entete
		*/
		$this->SetFillColor(255,255,255);
		$this->SetFont("", "B");
		$this->Cell(20, 10, "Bassin", 1, 0,'C', true);
		/*
		 * Ecriture du nom des aliments
		*/
		$i = 0;
		foreach ($this->dataAliment as $key=>$value) {
			$this->SetFontSize(14);
			$this->SetFillColor($this->color[$i]["R"], $this->color[$i]["G"], $this->color[$i]["B"]);
			$this->Cell($alimColumnSize, 10, $value["aliment_libelle_court"], 1, 0, 'C', true);
			$i++;
		}
		$this->SetFillColor(255,255,255);
		$this->SetFontSize(8);
		$this->Cell(15,10,"Biomasse", 1, 0, 'C', true);
		$this->Cell(10, 10,"Taux", 1, 0, 'C', true);
		$this->Cell(15,10,"Total/jour", 1, 0, 'C', true);
		$this->Ln();
	}
}

?>