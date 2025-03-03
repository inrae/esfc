<?php

namespace App\Libraries;

use App\Models\DosageSanguin as ModelsDosageSanguin;
use App\Models\PoissonCampagne;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class DosageSanguin extends PpciLibrary
{
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    public $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsDosageSanguin;
        $this->keyName = "dosage_sanguin_id";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }
    function change()
    {
        $this->vue = service('Smarty');
        $poissonCampagne = new PoissonCampagne;
        $data = $this->dataRead($this->id, "repro/dosageSanguinChange.tpl", $_REQUEST["poisson_campagne_id"]);
        $this->vue->set($poissonCampagne->lire($data["poisson_campagne_id"]), "dataPoisson");
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
