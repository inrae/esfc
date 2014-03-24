<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 24 mars 2014
 */
class TableauRepartition extends TCPDF {
	public $dataRepartition;
	public $dataDistribution;
	public $dataAliment;
	public $param;
	/**
	 * Recupere les donnees necessaires a la generation de la feuille de repartition
	 * @param array $dataRepartition
	 * @param array $dataDistribution
	 * @param array $dataAliment
	 */
	function initData($dataRepartition, $dataDistribution, $dataAliment) {
		$this->dataRepartition = $dataRepartition;
		$this->dataDistribution = $dataDistribution;
		$this->dataAliment = $dataAliment;
	}
	/**
	 * Initialise les données générales pour générer le document
	 * Les variables sont stockées dans un tableau
	 * @param array $param
	 */
	function initDocument($param) {
		if (is_array($param)) {
			$this->param = $param;
		}
	}
	
	/**
	 * Reecriture de la fonction Header, pour generer l'entete
	 * (non-PHPdoc)
	 * @see FPDF::Header()
	 */
	function Header() {
		// Definition de la police
		$this­ > SetFont ( "arial", "I", 14 );
		// Calcul de la largeur du titre et positionnement
		$w = $this­->GetStringWidth ( $this­->param["title"] ) + 6;
		$this-­>SetX((210 - $w )/2)		;
		// Ecriture du titre dans une cellule
		$this - ­ > Cell ( $w, 9, $this­ -> param["title"], 0, 0, 'C', false );
		// Insertion d'un saut de ligne
		$this - ­ > Ln ( 10 );
	}
	
	/**
	 * Definition du pied de page
	 * (non­PHPdoc)
	 * @see FPDF::Footer()
	 */
	function Footer() {
		// Positionnement a 15mm du bas
		$this­->SetY(­15);
		// definition de la police
		$this­->SetFont("arial","",8);
		// Recuperation du nombre de pages total
		$this­->AliasNbPages('nbpages');
		// mise en place de la numerotation
		$this­->Cell(0,10,$this­>PageNo().'/nbpages',0,0,'C');
	}
}

?>