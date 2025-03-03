<?php

namespace App\Libraries;

use App\Models\CircuitEau;
use App\Models\CircuitEvenement as ModelsCircuitEvenement;
use App\Models\CircuitEvenementType;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class CircuitEvenement extends PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	public $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsCircuitEvenement;
		$this->keyName = "circuit_evenement_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		}
	}
	function change()
	{
		$this->vue = service('Smarty');
		$this->dataRead($this->id, "bassin/circuitEvenementChange.tpl", $_REQUEST["circuit_eau_id"]);
		/**
		 * Lecture des types d'événements
		 */
		$circuitEvenementType = new CircuitEvenementType;
		$this->vue->set($circuitEvenementType->getListe(1), "dataEvntType");
		/**
		 * Lecture du circuit d'eau
		 */
		$circuit = new CircuitEau;
		$this->vue->set($circuit->lire($_REQUEST["circuit_eau_id"]), "dataCircuit");
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
