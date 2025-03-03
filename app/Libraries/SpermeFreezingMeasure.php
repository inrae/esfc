<?php 
namespace App\Libraries;

use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class  extends PpciLibrary { 
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    public $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ;
        $this->keyName = "";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }

/**
 * Created : 3 juil. 2017
 * Creator : quinton
 * Encoding : UTF-8
 * Copyright 2017 - All rights reserved
 */ require_once 'modules/classes/spermeFreezingMeasure.class.php';
$this->dataclass = new SpermeFreezingMeasure;
$keyName = "sperme_freezing_measure_id";
$this->id = $_REQUEST[$keyName];
/**
 * Passage en parametre de la liste parente
 */
if (isset($this->vue)) {
    $this->vue->set($_SESSION["poissonDetailParent"], "poissonDetailParent");
}

    function change(){
$this->vue=service('Smarty');
        /**
         * open the form to modify the record
         * If is a new record, generate a new record with default value :
         * $_REQUEST["idParent"] contains the identifiant of the parent record
         */
        $this->dataRead( $this->id, "repro/spermeFreezingMeasureChange.tpl", $_REQUEST["sperme_congelation_id"]);
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
                        $this->id = $this->dataWrite($_REQUEST);
            $_REQUEST[$this->keyName] = $this->id;
            return true;
        } catch (PpciException $e) {
            return false;
        }
            
        /**
         * write record in database
         */
        $this->id = $this->dataWrite( $_REQUEST);
        /*if ($this->id > 0) {
            $_REQUEST[$keyName] = $this->id;
        }*/
        }
       function delete() {
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
