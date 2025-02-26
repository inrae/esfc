<?php

namespace App\Libraries;

use App\Models\Bassin;
use App\Models\BassinEvenement as ModelsBassinEvenement;
use App\Models\BassinEvenementType;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class BassinEvenement extends PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	private $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsBassinEvenement;
		$this->keyName = "bassin_evenement_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		}
	}
	function change()
	{
		$this->vue = service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$this->dataRead($this->id, "bassin/bassinEvenementChange.tpl", $_REQUEST["bassin_id"]);
		/*
		 * Lecture des types d'événements
		 */
		$bassinEvenementType = new BassinEvenementType;
		$this->vue->set($bassinEvenementType->getListe(1), "dataEvntType");
		/*
		 * Lecture du bassin
		 */
		$bassin = new Bassin;
		$this->vue->set($bassin->getDetail($_REQUEST["bassin_id"]), "dataBassin");
		$this->vue->set($_SESSION["bassinParentModule"], "bassinParentModule");
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
		/*
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
