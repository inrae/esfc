<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 7 avr. 2014
 */
/**
 * ORM de gestion de la table mime_type
 *
 * @author quinton
 *        
 */
class MimeType extends ObjetBDD {
	/**
	 * Constructeur de la classe
	 *
	 * @param Adodb_instance $bdd        	
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->table = "mime_type";
		$this->id_auto = 1;
		$this->colonnes = array (
				"mime_type_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0 
				),
				"extension" => array (
						"type" => 0,
						"requis" => 1 
				),
				"content_type" => array (
						"type" => 0,
						"requis" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Retourne le numero de type mime correspondant a l'extension
	 *
	 * @param string $extension        	
	 * @return int
	 */
	function getTypeMime($extension) {
		if (strlen ( $extension ) > 0) {
			$extension = strtolower ( $extension );
			$sql = "select mime_type_id from " . $this->table . " where extension = '" . $extension."'";
			$res = $this->lireParam ( $sql );
			return $res ["mime_type_id"];
		}
	}
}
/**
 * Orm de gestion de la table document :
 * Stockage des pièces jointes
 *
 * @author quinton
 *        
 */
class DocumentAttach extends ObjetBDD {
	public $temp = "tmp"; // Chemin de stockage des images générées à la volée
	/**
	* Constructeur de la classe
	*
	* @param Adodb_instance $bdd
	* @param array $param
	*/
	function __construct($bdd, $param = null) {
		$this->paramori = $param;
		$this->param = $param;
		$this->table = "document";
		$this->id_auto = 1;
		$this->colonnes = array (
				"document_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0
				),
				"mime_type_id" => array (
						"type" => 1,
						"requis" => 1
				),
				"document_date_import" => array (
						"type" => 2,
						"requis" => 1
				),
				"document_nom" => array (
						"type" => 0,
						"requis" => 1
				),
				"document_description" => array (
						"type" => 0
				),
				"data" => array (
						"type" => 0
				),
				"thumbnail" => array (
						"type" => 0
				),
				"size" => array (
						"type" => 1,
						"defaultValue" => 0
				)
		);
		if (! is_array ( $param ))
			$param == array ();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Envoie le document au navigateur
	 *
	 * @param int $id
	 * @param number $thumnbnail
	 *        	[0|1]
	 * @param string $methode
	 *        	[inline|attachment]
	 */
	function documentSent($id, $thumnbnail = 0, $methode = "inline") {
		if ($id > 0) {
			$sql = "select document_id, document_nom, data, content_type
				from " . $this->table . "
				join mime_type using (mime_type_id)
				where document_id = " . $id;
			$data = $this->lireParam ( $sql );
			if ($data ["document_id"] > 0) {
				if ($thumnbnail == 1) {
					$doc = $data ["thumbnail"];
					$data ["size"] = strlen ( $doc );
				} else {
					$doc = $data ["data"];
				}
				/*
				 * Preparation des entetes
				*/
				header ( "Pragma: public" );
				header ( "Expires: 0" );
				header ( "Cache-Control: must-revalidate, post-check=0, pre-check=0" );
				header ( "Cache-Control: public" );
				header ( "Content-Description: File Transfer" );
				header ( "Content-Type: " . $data ['content_type'] );
				header ( "Content-Disposition: " . $methode . "; filename=" . $data ["document_nom"] );
				header ( "Content-Transfer-Encoding: binary" );
				if (! $data ["size"] > 0)
					$data ["size"] = strlen ( $doc );
				header ( "Content-Length: " . $data ["size"] );
				/*
				 * Envoi au navigateur
				*/
				echo $doc;
			}
		}
	}
	/**
	 * Ecriture d'un document
	 *
	 * @param array $file
	 *        	: tableau contenant les informations sur le fichier importé
	 * @param
	 *        	string description : description du contenu du document
	 * @return int
	 */
	function ecrire($file, $description = NULL) {
		printr($file);
		if ($file ["error"] == 0 && $file ["size"] > 0) {
			/*
			 * Recuperation de l'extension
			*/
			$extension = substr ( $file ["name"], strrpos ( $file ["name"], "." ) + 1 );
			printr($extension);
			$mimeType = new MimeType ( $this->connection, $this->paramori );
			$mime_type_id = $mimeType->getTypeMime ( $extension );
			if ($mime_type_id > 0) {
				$data = array ();
				$data ["document_nom"] = $file ["name"];
				$data ["size"] = $file ["size"];
				$data ["mime_type_id"] = $mime_type_id;
				$data ["document_description"] = $description;
				$data ["document_date_import"] = date ( "d/m/Y" );
				/*
				 * Recherche pour savoir s'il s'agit d'une image ou d'un pdf pour créer une vignette
				*/
				$extension = strtolower ( $extension );
				/*
				 * Ecriture du document
				*/
				printr($data);
				$data ["data"] = pg_escape_bytea ( $file ["tmp_name"] );
				if ($extension == "pdf" || $extension == "jpg" || $extension == "png") {
					$image = new Imagick ();
					$image->readImageBlob ( $file ["tmp_name"] );
					$image->setiteratorindex ( 0 );
					$image->resizeimage ( 200, 200, imagick::FILTER_LANCZOS, 1, true );
					$image->setformat ( "png" );
					$data ["thumbnail"] = pg_escape_bytea ( $image->getimageblob () );
				}
				/*
				 * suppression du stockage temporaire
				*/
				unset ( $file ["tmp_name"] );
				/*
				 * Ecriture dans la base de données
				*/
				return parent::ecrire ( $data );
			}
		}
	}
	/**
	 * Ecrit une photo dans un dossier temporaire, pour lien depuis navigateur
	 * @param int $id
	 * @param binary $document
	 * @return string
	 */
	function writeFileImage($id, $document) {
		if ($id > 0) {
			$image = new Imagick ();
			$image->readImageBlob ( $document );
			$geo = $image->getimagegeometry ();

			$nomPhoto = $this->temp . '/' . $value ["document_id"] . "_" . $geo ["width"] . "x" . $geo ["height"] . ".png";
			if (! file_exists ( $nomPhoto )) {
				$handle = fopen ( $nomPhoto, 'wb' );
				fwrite ( $handle, $document );
				fclose ( $handle );
			}
			return $nomPhoto;
		}
	}
}

?>