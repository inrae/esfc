<?php 
namespace App\Libraries;

use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Xx extends PpciLibrary { 
    /**
     * @var xx
     */
    protected PpciModel $this->dataclass;
    private $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ;
        $keyName = "_id";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }

/**
 * Created : 3 juil. 2017
 * Creator : quinton
 * Encoding : UTF-8
 * Copyright 2017 - All rights reserved
 */
require_once 'modules/classes/spermeFreezingPlace.class.php';
$this->dataclass = new SpermeFreezingPlace;
$keyName = "sperme_freezing_place_id";
$this->id = $_REQUEST[$keyName];
/*
 * Passage en parametre de la liste parente
 */
if (isset ($this->vue)) {
    $this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
}

    function change(){
$this->vue=service('Smarty');
        /*
         * open the form to modify the record
         * If is a new record, generate a new record with default value :
         * $_REQUEST["idParent"] contains the identifiant of the parent record
         */
        $this->dataRead(, $this->id, "repro/spermeFreezingPlaceChange.tpl", $_REQUEST["sperme_congelation_id"]);
        require_once "modules/classes/spermeCongelation.class.php";
        $spermeCongelation = new SpermeCongelation;

        $this->vue->set($spermeCongelation->lire($_REQUEST["sperme_congelation_id"]), "dataCongelation");
        /*
         * Donnees du poisson
         */
        require_once 'modules/classes/poissonCampagne.class.php';
        $poissonCampagne = new PoissonCampagne;
        $this->vue->set($poissonCampagne->lire($_REQUEST["poisson_campagne_id"]), "dataPoisson");

        }
        function write() {
    try {
            $this->id =  try {
            $this->id = $this->dataWrite($_REQUEST);
            $_REQUEST["_id"] = $this->id;
            return true;
        } catch (PpciException $e) {
            return false;
        }
            if ($this->id > 0) {
                $_REQUEST[$this->keyName] = $this->id;
                return true;
            } else {
                return false;
            }
        } catch (PpciException) {
            return false;
        }
    }
        /*
         * write record in database
         */
        $this->id = dataWrite($this->dataclass, $_REQUEST);
        if ($this->id > 0) {
            $_REQUEST[$keyName] = $this->id;
        }
        }
       function delete() {
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
