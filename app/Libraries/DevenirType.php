<?php

namespace App\Libraries;

use App\Models\DevenirType as ModelsDevenirType;
use App\Models\EvenementType;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class DevenirType extends PpciLibrary {
    /**
     * @var ModelsDevenirType
     */
    protected PpciModel $dataclass;
    public $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsDevenirType;
        $this->keyName = "devenir_type_id";
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
        $this->vue->set($this->dataclass->getList(), "data");
        $this->vue->set("parametre/devenirTypeList.tpl", "corps");
        return $this->vue->send();
    }
    function change()
    {
        $this->vue = service('Smarty');
        $this->dataRead($this->id, "parametre/devenirTypeChange.tpl");
        $evenementType = new EvenementType;
        $this->vue->set($evenementType->getListActive(),"evenementTypes");
        return $this->vue->send();
    }
    function write()
    {
        try {
            $this->id = $this->dataWrite($_REQUEST);
            $_REQUEST[$this->keyName] = $this->id;
            return true;
        } catch (PpciException) {
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
        } catch (PpciException) {
            return false;
        }
    }
}
