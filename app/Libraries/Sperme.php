<?php

namespace App\Libraries;

use App\Models\PoissonCampagne;
use App\Models\PoissonSequence;
use App\Models\Sperme as ModelsSperme;
use App\Models\SpermeAspect;
use App\Models\SpermeCaracteristique;
use App\Models\SpermeCongelation;
use App\Models\SpermeDilueur;
use App\Models\SpermeMesure;
use App\Models\SpermeQualite;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Sperme extends PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	public $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsSperme;
		$this->keyName = "sperme_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		}
	}
	function display()
	{
		$this->vue = service('Smarty');
		/**
		 * Display the detail of the record
		 */
		$this->vue->set($this->dataclass->lire($this->id), "data");
		/**
		 * Recherche des caracteristiques particulieres
		 */
		$caract = new SpermeCaracteristique;
		$this->vue->set($caract->getFromSperme($this->id), "spermeCaract");
		/**
		 * Recherche des mesures effectuees
		 */
		$mesure = new SpermeMesure;
		$this->vue->set($mesure->getListFromSperme($this->id), "dataMesure");
		$this->vue->set("repro/spermeDisplay.tpl", "corps");
		$this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
		return $this->vue->send();
	}
	function change()
	{
		$this->vue = service('Smarty');
		$poissonCampagne = new PoissonCampagne;
		$this->vue->set($poissonCampagne->lire($_REQUEST["poisson_campagne_id"]), "dataPoisson");
		$sequences = $poissonCampagne->getListSequence($_REQUEST["poisson_campagne_id"], $_SESSION["annee"]);
		if (empty($sequences)) {
			return false;
			$this->message->set(_("Le poisson n'est rattaché à aucune séquence, la saisie d'un prélèvement de sperme n'est pas possible"), true);
		} else {
			$this->vue->set($sequences, "sequences");
			$data = $this->dataRead($this->id, "repro/spermeChange.tpl", $_REQUEST["poisson_campagne_id"]);
			$this->initSpermeChange($this->id);
			$this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
			return $this->vue->send();
		}
	}
	function write()
	{
		try {
			$this->id = $this->dataWrite($_REQUEST);
			$_REQUEST[$this->keyName] = $this->id;
			$poissonSequence = new PoissonSequence;
			$poissonSequence->updateStatutFromPoissonCampagne($_REQUEST["poisson_campagne_id"], $_REQUEST["sequence_id"], 4);
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
	function initSpermeChange($sperme_id = 0)
	{
		if (is_null($sperme_id)) {
			$sperme_id = 0;
		}
		/**
		 * Lecture de sperme_qualite
		 */
		$spermeAspect = new SpermeAspect;
		$this->vue->set($spermeAspect->getListe(1), "spermeAspect");
		/**
		 * Recherche des caracteristiques particulieres
		 */
		$caract = new SpermeCaracteristique;
		$this->vue->set($caract->getFromSperme($sperme_id), "spermeCaract");
		/**
		 * Recherche des dilueurs
		 */
		$dilueur = new SpermeDilueur;
		$this->vue->set($dilueur->getListe(2), "spermeDilueur");

		/**
		 * Recherche de la qualite de la semence, pour les analyses realisees en meme temps
		 */
		$qualite = new SpermeQualite;
		$this->vue->set($qualite->getListe(1), "spermeQualite");
		/**
		 * Recherche des congelations associees
		 */
		$congelation = new SpermeCongelation;
		$this->vue->set($congelation->getListFromSperme($sperme_id), "congelation");
		/**
		 * Recherche des analyses realisees
		 */
		$mesure = new SpermeMesure;
		$this->vue->set($mesure->getListFromSperme($sperme_id), "dataMesure");
	}
}
