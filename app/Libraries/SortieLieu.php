<?php

namespace App\Libraries;

use App\Models\PoissonStatut;
use App\Models\SortieLieu as ModelsSortieLieu;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class SortieLieu extends PpciLibrary
{
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    public $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsSortieLieu;
        $this->keyName = "sortie_lieu_id";
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
        $this->vue->set($this->dataclass->getListeActif(), "data");
        $this->vue->set("parametre/sortieLieuList.tpl", "corps");
        return $this->vue->send();
    }
    function change()
    {
        $this->vue = service('Smarty');
        /**
         * Lecture des statuts de poissons
         */
        $poissonStatut = new PoissonStatut;
        $this->vue->set($poissonStatut->getListe(1), "poissonStatut");
        $this->dataRead($this->id, "parametre/sortieLieuChange.tpl");
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
