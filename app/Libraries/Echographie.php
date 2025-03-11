<?php

namespace App\Libraries;

use App\Models\DocumentLie;
use App\Models\DocumentSturio;
use App\Models\Echographie as ModelsEchographie;
use App\Models\Evenement;
use App\Models\PoissonCampagne;
use App\Models\StadeGonade;
use App\Models\StadeOeuf;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Echographie extends PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	public $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsEchographie;
		$this->keyName = "echographie_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		}
	}
	function change()
	{
		$this->vue = service('Smarty');
		$poissonCampagne = new PoissonCampagne;
		$this->dataRead($this->id, "repro/echographieChange.tpl", $_REQUEST["poisson_id"]);
		$this->vue->set($poissonCampagne->lire($_REQUEST["poisson_campagne_id"]), "dataPoisson");
		/**
		 * Tables des stades
		 */
		$stadeGonade = new StadeGonade;
		$stadeOeuf = new StadeOeuf;
		$this->vue->set($stadeGonade->getListe(1), "gonades");
		$this->vue->set($stadeOeuf->getListe(1), "oeufs");
		/**
		 * Gestion des documents associes
		 */
		$this->vue->set("echographieChange", "moduleParent");
		$this->vue->set("echographie", "parentType");
		$this->vue->set("echographie_id", "parentIdName");
		$this->vue->set($this->id, "parent_id");
		helper("esfc");
		$this->vue->set(getListeDocument("echographie", $this->id, $this->vue, $_REQUEST["document_limit"], $_REQUEST["document_offset"]), "dataDoc");
		if (isset($_SESSION["sequence_id"]))
			$this->vue->set($_SESSION["sequence_id"], "sequence_id");
		$this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
		return $this->vue->send();
	}
	function write()
	{
		try {
			if (empty($_REQUEST["evenement_id"])) {
				// create a new evenement
				$evenement = new Evenement;
				$data = $_REQUEST;
				$data ["evenement_date"] = $data["echographie_date"];
				$data["evenement_type_id"] = $_SESSION["dbparams"]["code_type_evenement_pour_echographie"];
				$data["evenement_id"] = $evenement->write($data);
			}
			$this->id = $this->dataWrite($data);
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
					$document_id = $documentSturio->write($file, $_REQUEST["document_description"]);
					if ($document_id > 0) {
						/**
						 * Ecriture de l'enregistrement en table liee
						 */
						$documentLie = new DocumentLie('evenement');
						$data = array(
							"document_id" => $document_id,
							"evenement_id" => $data["evenement_id"]
						);
						$documentLie->write($data);
					}
				}
			}
			return true;
		} catch (PpciException $e) {
			$this->message->set($e->getMessage(), true);
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
