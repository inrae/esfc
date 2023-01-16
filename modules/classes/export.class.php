<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 27 mars 2015
 */
class Export {
	/*
	 * Variables utilisees pour l'export CSV
	 */
	public $fichierExport;
	public $nomFichierExport;
	public $separateurExport;
	
	/**
	 * Initialise l'export CSV
	 * 
	 * @param string $nomFichierExport        	
	 * @param string $separateur        	
	 */
	function exportCSVinit($nomFichierExport, $separateur = ",") {
		$this->nomFichierExport = $nomFichierExport . "-" . date ( 'd-m-Y' ) . ".csv";
		if ($separateur == "tab")
			$separateur = "\t";
		$this->separateurExport = $separateur;
	}
	
	/**
	 * Ecrit un tableau entier dans le fichier CSV
	 * 
	 * @param array $data        	
	 */
	function setFullTableau($tableau) {
		foreach ( $tableau as $cle => $data ) {
			$this->setLigneCSV ( $data );
		}
	}
	
	/**
	 * Ecrit une seule ligne dans le fichier CSV
	 * 
	 * @param unknown $data        	
	 */
	function setLigneCSV($data) {
		if (is_array ( $data )) {
			if (strlen ( $this->fichierExport ) > 0)
				$this->fichierExport .= "\n";
			$nbItem = count ( $data );
			$compteur = 1;
			foreach ( $data as $key => $value ) {
				$this->fichierExport .= $value;
				if ($compteur < $nbItem)
					$this->fichierExport .= $this->separateurExport;
				$compteur ++;
			}
		}
	}
	/**
	 * Declenche l'envoi du fichier CSV au navigateur
	 */
	function exportCSV() {
		header ( "content-type: text/csv" );
		header ( 'Content-Disposition: attachment; filename="' . $this->nomFichierExport . '"' );
		header ( 'Pragma: no-cache' );
		header ( 'Cache-Control:must-revalidate, post-check=0, pre-check=0' );
		header ( 'Expires: 0' );
		echo $this->fichierExport;
	}
}

?>