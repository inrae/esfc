<?php

namespace App\Controllers;

use App\Libraries\Bassin;
use \Ppci\Controllers\PpciController;
use App\Libraries\Document as LibrariesDocument;
use App\Libraries\Poisson;
use App\Libraries\PoissonCampagne;

class Document extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesDocument();
    }
    function change()
    {
        return $this->lib->change();
    }
    function write()
    {
        $this->lib->write();
        return $this->goBack();
    }
    function delete()
    {
        $this->lib->delete();
        return $this->goBack();
    }
    function get()
    {
        return $this->lib->get();
    }
    function changeData()
    {
        $this->lib->changeData();
    }
    function writeData()
    {
        $this->lib->writeData();
        return $this->goBack();
    }
    function goBack()
    {
        if ($_REQUEST["moduleParent"] == "poissonDisplay") {
            $lib = new Poisson;
            return $lib->display();
        } else if ($_REQUEST["moduleParent"] == "bassinDisplay") {
            $lib = new Bassin;
            return $lib->display();
        } else if ($_REQUEST["moduleParent"] == "poissonCampagneDisplay") {
            $lib = new PoissonCampagne;
            return $lib->display();
            /*}else if ($_REQUEST["moduleParent"] == "echographieChange"){   
        }else if ($_REQUEST["moduleParent"] == "evenementChange"){ 
        }else if ($_REQUEST["moduleParent"] == "biopsieChange"){   */
        } else {
            defaultPage();
        }
    }
}
