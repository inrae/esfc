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
 * Created : 1 août 2017
 * Creator : quinton
 * Encoding : UTF-8
 * Copyright 2017 - All rights reserved
 */
require_once 'modules/classes/spermeMesure.class.php';
$this->dataclass = new SpermeMesure;
$keyName = "sperme_mesure_id";
$this->id = $_REQUEST[$keyName];

    function change(){
$this->vue=service('Smarty');
        /**
         * open the form to modify the record
         * If is a new record, generate a new record with default value :
         * $_REQUEST["idParent"] contains the identifiant of the parent record
         */
        $data = $this->dataRead( $this->id, "repro/spermeMesureChange.tpl", $_REQUEST["sperme_id"]);
        if (isset($_REQUEST["sperme_congelation_id"])) {
            $data["sperme_congelation_id"] = $_REQUEST["sperme_congelation_id"];
            $this->vue->set($data, "data");
        }
        /**
         * Recuperation des donnees du sperme
         */
        require_once "modules/classes/sperme.class.php";
        $sperme = new Sperme;
        $dataSperme =  $sperme->lire($_REQUEST["sperme_id"]);
        $this->vue->set($dataSperme, "dataSperme");

        require_once 'modules/classes/poissonCampagne.class.php';
        $poissonCampagne = new PoissonCampagne;
        $this->vue->set($poissonCampagne->lire($dataSperme["poisson_campagne_id"]), "dataPoisson");
        $this->vue->set($poissonCampagne->getListSequence($dataSperme["poisson_campagne_id"], $_SESSION["annee"]), "sequences");

        require_once "modules/classes/spermeQualite.class.php";
        $qualite = new SpermeQualite;
        $this->vue->set($qualite->getListe(1), "spermeQualite");
        require_once "modules/classes/spermeCaracteristique.class.php";
        $caract = new SpermeCaracteristique;
        $this->vue->set($caract->getFromSperme($_REQUEST["sperme_id"]), "spermeCaract");
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
        if ($this->id > 0) {
            $_REQUEST[$keyName] = $this->id;
        }
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
