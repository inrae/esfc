<?php 
namespace App\Models;

use Config\App;
use Ppci\Libraries\PpciException;
use Ppci\Models\PpciModel;

/**
 * Orm de gestion de la table document :
 * Stockage des pièces jointes
 *
 * @author quinton
 *        
 */
class DocumentAttach extends PpciModel
{
	public $temp = "temp"; // Chemin de stockage des images générées à la volée
	public MimeType $mimetype;
	/**
	 * Constructeur de la classe
	 *
	 *         	
	 */
	function __construct()
	{
		$this->table = "document";
		$this->fields = array(
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
		/**
		 * @var App
		 */
		$appConfig = service("AppConfig");
		$this->temp = $appConfig->APP_temp;
		parent::__construct();
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
	function write($file, $description = "", $document_date_creation = ""):int
	{
		if ($file["error"] == 0 && $file["size"] > 0) {
			/*
			 * Recuperation de l'extension
			 */
			$extension = substr($file["name"], strrpos($file["name"], ".") + 1);
			if (!isset($this->mimetype)) {
				$this->mimetype = new MimeType;
			}
			$mime_type_id = $this->mimetype->getTypeMime($extension);
			if ($mime_type_id > 0) {
				$data = array();
				$data["document_nom"] = $file["name"];
				$data["size"] = $file["size"];
				$data["mime_type_id"] = $mime_type_id;
				$data["document_description"] = $description;
				$data["document_date_import"] = date($_SESSION["date"]["maskdate"]);
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
				$dataDoc["data"] = pg_escape_bytea($this->db->connID, $dataBinaire);
                if ($extension == "pdf" || $extension == "png" || $extension == "jpg") {
                    $image = new \Imagick();
                    $image->readImageBlob($dataBinaire);
                    $image->setiteratorindex(0);
                    $image->resizeimage(200, 200, \imagick::FILTER_LANCZOS, 1, true);
                    $image->setformat("png");
                    $dataDoc["thumbnail"] = pg_escape_bytea($this->db->connID, $image->getimageblob());
                }
				/**
					 * suppression du stockage temporaire
					 */
				unset($file["tmp_name"]);
				/**
					 * Ecriture dans la base de données
					 */
				$id = parent::write($data);
				if ($id > 0) {
					$sql = "update " . $this->table . " set data = '" . $dataDoc["data"] . "', thumbnail = '" . $dataDoc["thumbnail"] . "' where document_id = " . $id;
					$this->executeSQL($sql, null, true);
				}
				return $id;
			} else {
				throw new PpciException(_("Le type MIME du fichier n'est pas reconnu"));
			}
		} else {
			throw new PpciException(_("Pas de fichier chargé"));
		}
	}
	/**
	 * Appel de la fonction ecrire native
	 * @param array $data
	 * @return int
	 */
	function writeData($data)
	{
		return parent::write($data);
	}

	/**
	 * Recupere les informations d'un document
	 *
	 * @param int $id        	
	 * @return array
	 */
	function getData(int $id)
	{
		$sql = "SELECT document_id, document_nom, content_type, mime_type_id, extension, document_date_creation
				from document
				join mime_type using (mime_type_id)
				where document_id = :id:";
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
		if (empty($phototype)) {
			$phototype = 0;
		}
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
	 * @param int $resolution     	
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
			if (!file_exists($filename)) {
				try {
					$sql = "select $colonne as picture from document where document_id = :id:";
					$data = $this->readParam($sql, ["id" => $id]);
					if (empty($data)) {
						throw new PpciException(_("Le document demandé n'existe pas"));
					}
					if (($data["mime_type_id"] == 4 || $data["mime_type_id"] == 5 || $data["mime_type_id"] == 6)) {
						$image = new \Imagick();
						try {
							$image->readImageBlob(pg_unescape_bytea($data["picture"]));
							if ($phototype == 1) {
								$resize = false;
								$geo = $image->getimagegeometry();
								if ($geo["width"] > $resolution || $geo["height"] > $resolution) {
									$resize = true;
									if ($resize) {
										/*
									* Mise a l'image de la photo
									*/
										$image->resizeImage($resolution, $resolution, \Imagick::FILTER_LANCZOS, 1, true);
									}
								}
							}
							/**
							 * Ecriture de la photo
							 */
							$image->writeImage($filename);
						} catch (\ImagickException $ie) {
							throw new PpciException(sprintf(_("Impossible de lire la photo %s : "),  $id) . $ie->getMessage());
						}
					} else {
						/**
						 * Others docs
						 */
						$handle = fopen($filename, 'wb');
						fwrite($handle, pg_unescape_bytea($data["picture"]));
						fclose($handle);
					}
				} catch (PpciException $e) {
					throw new PpciException($e->getMessage());
				}
			}
		}
		return $filename;
	}
}
