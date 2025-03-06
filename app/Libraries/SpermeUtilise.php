<?php

namespace App\Libraries;

use App\Models\Croisement;
use App\Models\Sequence;
use App\Models\Sperme;
use App\Models\SpermeUtilise as ModelsSpermeUtilise;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class SpermeUtilise extends PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	public $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsSpermeUtilise;
		$this->keyName = "sperme_utilise_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		}
	}
	function change()
	{
		$this->vue = service('Smarty');
		$this->dataRead($this->id, "repro/spermeUtiliseChange.tpl", $_REQUEST["croisement_id"]);
		/**
		 * Recuperation du croisement
		 */
		$croisement = new Croisement;
		$croisementData = $croisement->getDetail($_REQUEST["croisement_id"]);
		$this->vue->set($croisementData, "croisementData");
		/**
		 * Lecture de la sequence
		 */
		$sequence = new Sequence;
		$this->vue->set($sequence->lire($croisementData["sequence_id"]), "dataSequence");
		/**
		 * Recuperation de la liste des spermes potentiels
		 */
		$sperme = new Sperme;
		$this->vue->set($sperme->getListPotentielFromCroisement($_REQUEST["croisement_id"]), "spermes");
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
