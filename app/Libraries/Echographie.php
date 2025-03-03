<?php

namespace App\Libraries;

use App\Models\Echographie as ModelsEchographie;
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
		$data = $this->dataRead($this->id, "repro/echographieChange.tpl", $_REQUEST["poisson_id"]);
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
		require_once "modules/classes/documentSturio.class.php";
		require_once 'modules/document/documentFunctions.php';
		$this->vue->set(getListeDocument("echographie", $this->id, $_REQUEST["document_limit"], $_REQUEST["document_offset"]), "dataDoc");
		if (isset($_SESSION["sequence_id"]))
			$this->vue->set($_SESSION["sequence_id"], "sequence_id");
		$this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
		return $this->vue->send();
	}
	function write()
	{
		try {
			$this->id = $this->dataWrite($_REQUEST);
			$_REQUEST[$this->keyName] = $this->id;
			return true;
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
