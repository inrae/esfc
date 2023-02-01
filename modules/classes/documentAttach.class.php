<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 7 avr. 2014
 *  
 */

/**
 * Orm de gestion de la table document :
 * Stockage des pièces jointes
 *
 * @author quinton
 *        
 */
class DocumentAttach extends ObjetBDD
{
	public $temp = "tmp"; // Chemin de stockage des images générées à la volée
	/**
	 * Constructeur de la classe
	 *
	 * @param PDO $bdd        	
	 * @param array $param        	
	 */
	function __construct($bdd, $param = array())
	{
		$this->table = "document";
		$this->colonnes = array(
			"document_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"mime_type_id" => array(
				"type" => 1,
				"requis" => 1
			),
			"document_date_import" => array(
				"type" => 2,
				"requis" => 1
			),
			"document_nom" => array(
				"type" => 0,
				"requis" => 1
			),
			"document_description" => array(
				"type" => 0
			),
			"data" => array(
				"type" => 0
			),
			"thumbnail" => array(
				"type" => 0
			),
			"size" => array(
				"type" => 1,
				"defaultValue" => 0
			),
			"document_date_creation" => array(
				"type" => 2,
				"defaultValue" => "getDateJour"
			)
		);
		parent::__construct($bdd, $param);
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
	function ecrire($file, $description = NULL, $document_date_creation = NULL)
	{
		if ($file["error"] == 0 && $file["size"] > 0) {
			/*
			 * Recuperation de l'extension
			 */
			$extension = $this->encodeData(substr($file["name"], strrpos($file["name"], ".") + 1));
			$mimeType = new MimeType($this->connection, $this->paramori);
			$mime_type_id = $mimeType->getTypeMime($extension);
			if ($mime_type_id > 0) {
				$data = array();
				$data["document_nom"] = $file["name"];
				$data["size"] = $file["size"];
				$data["mime_type_id"] = $mime_type_id;
				$data["document_description"] = $description;
				$data["document_date_import"] = date("d/m/Y");
				$data["document_date_creation"] = $document_date_creation;
				$dataDoc = array();

				/*
				 * Recherche pour savoir s'il s'agit d'une image ou d'un pdf pour créer une vignette
				 */
				$extension = strtolower($extension);
				/*
				 * Ecriture du document
				 */
				$dataBinaire = fread(fopen($file["tmp_name"], "r"), $file["size"]);

				$dataDoc["data"] = $this->connection->quote($dataBinaire,  PDO::PARAM_LOB);
				if ($extension == "pdf" || $extension == "png" || $extension == "jpg") {
					$image = new Imagick();
					$image->readImageBlob($dataBinaire);
					$image->setiteratorindex(0);
					$image->resizeimage(200, 200, Imagick::FILTER_LANCZOS, 1, true);
					$image->setformat("png");
					$dataDoc["thumbnail"] = $this->connection->quote($image->getimageblob(),  PDO::PARAM_LOB);
				}
				/*
					 * suppression du stockage temporaire
					 */
				unset($file["tmp_name"]);
				/*
					 * Ecriture dans la base de données
					 */
				$id = parent::ecrire($data);
				if ($id > 0) {
					$sql = "update " . $this->table . " set data = '" . $dataDoc["data"] . "', thumbnail = '" . $dataDoc["thumbnail"] . "' where document_id = " . $id;
					$this->executeSQL($sql);
				}
				return $id;
			}
		}
		return -1;
	}
	/**
	 * Appel de la fonction ecrire native
	 * @param array $data
	 * @return int
	 */
	function writeData($data)
	{
		return parent::ecrire($data);
	}

	/**
	 * Recupere les informations d'un document
	 *
	 * @param int $id        	
	 * @return array
	 */
	function getData(int $id)
	{
		$this->codageHtml = false;
		$sql = "select document_id, document_nom, content_type, mime_type_id, extension, document_date_creation
				from " . $this->table . "
				join mime_type using (mime_type_id)
				where document_id = :id";
		return $this->lireParamAsPrepared($sql, array("id" => $id));
	}

	/**
	 * Envoie un fichier au navigateur, pour affichage
	 *
	 * @param string $nomfile
	 *        	: nom du fichier stocke dans le dossier temporaire
	 *        	
	 * @param int $id
	 *        	: cle du document, necessaire pour recuperer le type mime
	 */

	/**
	 * Envoie un fichier au navigateur, pour affichage
	 *
	 * @param int $id
	 *        	: cle de la photo
	 * @param int $phototype
	 *        	: 0 - photo originale, 1 - resolution fournie, 2 - vignette
	 * @param boolean $attached        	
	 * @param int $resolution
	 *        	: resolution pour les photos redimensionnees
	 */
	function documentSent($id, $phototype, $attached = false, $resolution = 800)
	{
		$id = $this->encodeData($id);
		$filename = $this->generateFileName($id, $phototype, $resolution);
		if (strlen($filename) > 0 && is_numeric($id) && $id > 0) {
			// $filename = $this->temp . "/" . $nomfile;
			if (!file_exists($filename))
				$this->writeFileImage($id, $phototype, $resolution);
			if (file_exists($filename)) {
				$this->_documentSent($filename, $id, $attached);
			}
		}
	}

	/**
	 * Fonction generant l'envoi au navigateur
	 *
	 * @param string $nomfile        	
	 * @param int $id        	
	 * @param boolean $attached        	
	 */
	private function _documentSent($nomfile, $id, $attached = false)
	{
		/*
		 * Lecture du type mime
		 */
		$data = $this->getData($id);
		if (strlen($data["content_type"]) > 0) {
			header("content-type: " . $data["content_type"]);
			header('Content-Transfer-Encoding: binary');
			if ($attached == true)
				header('Content-Disposition: attachment; filename="' . $data["document_nom"] . '"');

			ob_clean();
			flush();
			readfile($nomfile);
		}
	}

	/**
	 * Calcule le nom de la photo
	 *
	 * @param int $id        	
	 * @param int $phototype
	 *        	: type de la photo - 0 : original, 1 : photo reduite, 2 : vignette
	 * @param int $resolution        	
	 * @return string
	 */
	function generateFileName(int $id, int $phototype, int $resolution = 800)
	{
		/*
		 * Preparation du nom de la photo
		 */
		switch ($phototype) {
			case 0:
				$data = $this->getData($id);
				$filename = $this->temp . '/' . $id . "-" . $data["document_nom"];
				break;
			case 1:
				$filename = $this->temp . '/' . $id . "x" . $resolution . ".png";
				break;
			case 2:
				$filename = $this->temp . '/' . $id . '_vignette.png';
		}
		return $filename;
	}

	/**
	 * Ecrit une photo dans un dossier temporaire, pour lien depuis navigateur
	 *
	 * @param int $id        	
	 * @param $phototype :
	 *        	0 - photo originale, 1 - photo a la resolution fournie, 2 - vignette
	 * @param binary $document        	
	 * @return string
	 */
	function writeFileImage(int $id, int $phototype = 0, int $resolution = 800)
	{
		$data = $this->getData($id);
		$okgenerate = false;
		switch ($phototype) {
			case 0:
				$okgenerate = true;
				break;
			case 2:
				if (in_array($data["mime_type_id"], array(
					1,
					4,
					5,
					6
				)))
					$okgenerate = true;
				break;
			case 1:
				if (in_array($data["mime_type_id"], array(
					4,
					5,
					6
				)))
					$okgenerate = true;
				break;
		}
		if ($okgenerate) {
			// $nomPhoto = array ();
			$i = 0;
			$writeOk = false;
			/*
				 * Selection de la colonne contenant la photo
				 */
			$phototype == 2 ? $colonne = "thumbnail" : $colonne = "data";
			$filename = $this->generateFileName($id, $phototype, $resolution);
			if (strlen($filename) > 0 && !file_exists($filename)) {
				/*
					 * Recuperation des donnees concernant la photo
					 */
				// if ($i != 1)
				$docRef = $this->getBlobReference($id, $colonne);
				if (in_array($data["mime_type_id"], array(
					4,
					5,
					6
				)) && $docRef != NULL) {
					try {
						$image = new Imagick();
						$image->readImageFile($docRef);
						if ($i == 1) {
							/*
								 * Redimensionnement de l'image
								 */
							$resize = 0;
							$geo = $image->getimagegeometry();
							if ($geo["width"] > $resolution || $geo["height"] > $resolution) {
								$resize = 1;
								/*
									 * Calcul de la résolution dans les deux sens
									 */
								if ($geo["width"] > $resolution) {
									$resx = $resolution;
									$resy = $geo["height"] * ($resolution / $geo["width"]);
								} else {
									$resy = $resolution;
									$resx = $geo["width"] * ($resolution / $geo["height"]);
								}
							}
							if ($resize == 1)
								$image->resizeImage($resx, $resy, imagick::FILTER_LANCZOS, 1);
						}
						$document = $image->getimageblob();
						$writeOk = true;
					} catch (Exception $e) {
					};
				} else {
					/*
						 * Autres types de documents : ecriture directe du contenu
						 */
					// rewind ( $docRef );
					if ($data["mime_type_id"] == 1 && $i == 2 || $i == 0) {
						$writeOk = true;
						$document = stream_get_contents($docRef);
						if ($document == false) {
							printr("erreur de lecture " . $docRef);
						}
							
					}
				}
				/*
					 * Ecriture du document dans le dossier temporaire
					 */
				if ($writeOk == true) {
					$handle = fopen($filename, 'wb');
					fwrite($handle, $document);
					fclose($handle);
				}
			}
		}
		return $filename;
	}
}
