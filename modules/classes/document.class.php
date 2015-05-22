<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 7 avr. 2014
 *  
 *  Les classes fonctionnent avec les tables suivantes :
 *  
CREATE TABLE mime_type
(
   mime_type_id  serial     NOT NULL,
   content_type  varchar    NOT NULL,
   extension     varchar    NOT NULL
);

-- Column mime_type_id is associated with sequence public.mime_type_mime_type_id_seq


ALTER TABLE mime_type
   ADD CONSTRAINT mime_type_pk
   PRIMARY KEY (mime_type_id);

COMMENT ON TABLE mime_type IS 'Table des types mime, pour les documents associés';
COMMENT ON COLUMN mime_type.content_type IS 'type mime officiel';
COMMENT ON COLUMN mime_type.extension IS 'Extension du fichier correspondant';
INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  1,  'application/pdf',  'pdf');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  2,  'application/zip',  'zip');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  3,  'audio/mpeg',  'mp3');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  4,  'image/jpeg',  'jpg');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES(  5,  'image/jpeg',  'jpeg');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  6,  'image/png',  'png');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  7,  'image/tiff',  'tiff');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  9,  'application/vnd.oasis.opendocument.text',  'odt');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  10,  'application/vnd.oasis.opendocument.spreadsheet',  'ods');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  11,  'application/vnd.ms-excel',  'xls');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  12,  'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',  'xlsx');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  13,  'application/msword',  'doc');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  14,  'application/vnd.openxmlformats-officedocument.wordprocessingml.document',  'docx');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  8,  'text/csv',  'csv');


CREATE TABLE document
(
   document_id           serial     NOT NULL,
   mime_type_id          integer    NOT NULL,
   document_date_import  date       NOT NULL,
   document_nom          varchar    NOT NULL,
   document_description  varchar,
   data                  bytea,
   size                  integer,
   thumbnail             bytea
);

-- Column document_id is associated with sequence public.document_document_id_seq


ALTER TABLE document
   ADD CONSTRAINT document_pk
   PRIMARY KEY (document_id);

ALTER TABLE document
  ADD CONSTRAINT mime_type_document_fk FOREIGN KEY (mime_type_id)
  REFERENCES mime_type (mime_type_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

COMMENT ON TABLE document IS 'Documents numériques rattachés à un poisson ou à un événement';
COMMENT ON COLUMN document.document_nom IS 'Nom d''origine du document';
COMMENT ON COLUMN document.document_description IS 'Description libre du document';
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
			$extension = strtolower ( $this->encodeData($extension ) );
			$sql = "select mime_type_id from " . $this->table . " where extension = '" . $extension . "'";
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
	 * Recupere les informations d'un document
	 * 
	 * @param int $id        	
	 * @return array
	 */
	function getData($id) {
		if ($id > 0) {
			$this->UTF8 = false;
			$this->codageHtml = false;
			$sql = "select document_id, document_nom, data, content_type, thumbnail, mime_type_id
				from " . $this->table . "
				join mime_type using (mime_type_id)
				where document_id = " . $id;
			return $this->lireParam ( $sql );
		}
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
			$data = $this->getData ( $id );
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
		if ($file ["error"] == 0 && $file ["size"] > 0) {
			/*
			 * Recuperation de l'extension
			 */
			$extension = $this->encodeData(substr ( $file ["name"], strrpos ( $file ["name"], "." ) + 1 ));
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
				$dataBinaire = fread ( fopen ( $file ["tmp_name"], "r" ), $file ["size"] );
				$data ["data"] = pg_escape_bytea ( $dataBinaire );
				if ($extension == "pdf" || $extension == "jpg" || $extension == "png") {
					$image = new Imagick ();
					$image->readImageBlob ( $dataBinaire );
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
	 * 
	 * @param int $id        	
	 * @param binary $document        	
	 * @return string
	 */
	function writeFileImage($id, $thumbnail = 0, $resolution = 800) {
		if ($id > 0) {
			/*
			 * Preparation du nom de la photo
			 */
			if ($thumbnail == 0) {
				$nomPhoto = $this->temp . '/' . $id . "x" . $resolution . ".png";
			} else {
				$nomPhoto = $this->temp . '/' . $id . '_vignette.png';
			}
			if (! file_exists ( $nomPhoto )) {
				/*
				 * Recuperation des donnees concernant la photo
				 */
				
				$data = $this->getData ( $id );
				if ($thumbnail == 1)
					$document = $data ["thumbnail"];
				else
					$document = $data ["data"];
				$image = new Imagick ();
				$image->readImageBlob ( $document );
				/*
				 * Mise a l'echelle de la photo
				 */
				$resize = 0;
				if (thumbnail == 0 && ($data ["mime_type_id"] == 4 || $data ["mime_type_id"] == 5 || $data ["mime_type_id"] == 6)) {
					$geo = $image->getimagegeometry ();
					if ($geo ["width"] > $resolution || $geo ["height"] > $resolution) {
						$resize = 1;
						/*
						 * Calcul de la résolution dans les deux sens
						 */
						if ($geo ["width"] > $resolution) {
							$resx = $resolution;
							$resy = $geo ["height"] * ($resolution / $geo ["width"]);
						} else {
							$resy = $resolution;
							$resx = $geo ["width"] * ($resolution / $geo ["height"]);
						}
					}
				}
				if ($resize == 1) {
					$image->resizeImage ( $resx, $resy, imagick::FILTER_LANCZOS, 1 );
					$document = $image->getimageblob ();
				}
				/*
				 * Ecriture de la photo dans le dossier temporaire
				 */
				$handle = fopen ( $nomPhoto, 'wb' );
				fwrite ( $handle, $document );
				fclose ( $handle );
			}
			return $nomPhoto;
		}
	}
}

?>