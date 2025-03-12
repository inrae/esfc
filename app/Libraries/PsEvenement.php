<?php

namespace App\Libraries;

use App\Models\PoissonCampagne;
use App\Models\PsEvenement as ModelsPsEvenement;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class PsEvenement extends PpciLibrary
{
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    public $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsPsEvenement;
        $this->keyName = "ps_evenement_id";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }
    function change()
    {
        $this->vue = service('Smarty');
        if (isset($_SESSION["sequence_id"])) {
            $this->vue->set($_SESSION["sequence_id"], "sequence_id");
        }
        $this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
        $dataPsEvenement = $this->dataclass->read($this->id, true, $_REQUEST["poisson_sequence_id"]);
        $poissonCampagne = new PoissonCampagne;
		$this->vue->set($poissonCampagne->lire($_REQUEST["poisson_campagne_id"]), "dataPoisson");
        $this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
		if (isset($_REQUEST["sequence_id"])) {
			$this->vue->set($_REQUEST["sequence_id"], "sequence_id");
		}
        $this->vue->set($dataPsEvenement, "dataPsEvenement");
        $this->vue->set($this->id, "ps_evenement_id");
        $this->vue->set("repro/psEvenementChange.tpl", "corps");
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
