<?php

namespace App\Libraries;

use App\Models\Biopsie as ModelsBiopsie;
use App\Models\BiopsieTechniqueCalcul;
use App\Models\DocumentLie;
use App\Models\DocumentSturio;
use App\Models\PoissonCampagne;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Biopsie extends PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	public $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsBiopsie;
		$this->keyName = "biopsie_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		}
	}
	function change()
	{
		$this->vue = service('Smarty');
		$poissonCampagne = new PoissonCampagne;
		$data = $this->dataRead($this->id, "repro/biopsieChange.tpl", $_REQUEST["poisson_campagne_id"]);
		$this->vue->set($poissonCampagne->lire($data["poisson_campagne_id"]), "dataPoisson");
		/**
		 * Recuperation des methodes de calcul
		 */
		$biopsieTechniqueCalcul = new BiopsieTechniqueCalcul;
		$this->vue->set($biopsieTechniqueCalcul->getListe(1), "techniqueCalcul");
		/**
		 * Gestion des documents associes
		 */
		$this->vue->set("biopsieChange", "moduleParent");
		$this->vue->set("biopsie", "parentType");
		$this->vue->set("biopsie_id", "parentIdName");
		$this->vue->set($this->id, "parent_id");
		$this->vue->set(getListeDocument("biopsie", $this->id, $this->vue, $_REQUEST["document_limit"], $_REQUEST["document_offset"]), "dataDoc");
		if (isset($_SESSION["sequence_id"])) {
			$this->vue->set($_SESSION["sequence_id"], "sequence_id");
		}
		$this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
		return $this->vue->send();
	}
	function write()
	{
		try {
			$this->id = $this->dataWrite($_REQUEST);
			$_REQUEST[$this->keyName] = $this->id;
			/**
			 * Traitement des photos a importer
			 */
			if ($this->id > 0 && !empty($_FILES["documentName"]["name"][0])) {
				/**
				 * Preparation de files
				 */
				$files = formatFiles();
				$documentSturio = new DocumentSturio;
				foreach ($files as $file) {
					$document_id = $documentSturio->ecrire($file, $_REQUEST["document_description"]);
					if ($document_id > 0) {
						/**
						 * Ecriture de l'enregistrement en table liee
						 */
						$documentLie = new DocumentLie('biopsie');
						$data = array(
							"document_id" => $document_id,
							"biopsie_id" => $this->id
						);
						$documentLie->ecrire($data);
						$documentPoisson = new DocumentLie( "poisson");
							$data["poisson_id"] = $this->dataclass->getPoissonId($this->id);
							$documentPoisson->ecrire($data);
					}
				}
				return true;
			}
		} catch (PpciException $e) {
			return false;
		}
	}
	function delete()
	{
		/**
		 * delete record
		 */
		try {
			$this->dataDelete($this->id);
			return true;
		} catch (PpciException $e) {
			return false;
		}
	}
}
