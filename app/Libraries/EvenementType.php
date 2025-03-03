<?php

namespace App\Libraries;

use App\Models\EvenementType as ModelsEvenementType;
use App\Models\PoissonStatut;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class EvenementType extends PpciLibrary
{
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    public $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsEvenementType;
        $this->keyName = "evenement_type_id";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }
    function list()
    {
        $this->vue = service('Smarty');
        /**
		 * Display the list of all records of the table
		 */
        $this->vue->set($this->dataclass->getListe(2), "data");
        $this->vue->set("parametre/evenementTypeList.tpl", "corps");
        return $this->vue->send();
    }

    function change()
    {
        $this->vue = service('Smarty');
        $this->dataRead($this->id, "parametre/evenementTypeChange.tpl");
        /**
         * Get the list of status of fish
         */
        $poissonStatut = new PoissonStatut;
        $this->vue->set($poissonStatut->getListe(2), "poissonStatuts");
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
