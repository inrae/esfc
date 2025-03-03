<?php

namespace App\Libraries;

use App\Models\GenderMethode as ModelsGenderMethode;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class GenderMethode extends PpciLibrary
{
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    public $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsGenderMethode;
        $this->keyName = "gender_methode_id";
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
        $this->vue->set("parametre/genderMethodeList.tpl", "corps");
        return $this->vue->send();
    }

    function change()
    {
        $this->vue = service('Smarty');
        $this->dataRead($this->id, "parametre/genderMethodeChange.tpl");
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
