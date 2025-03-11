<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Ventilation as LibrariesVentilation;
use App\Libraries\Poisson;
use App\Libraries\PoissonCampagne;

class Ventilation extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesVentilation();
    }
    function change()
    {
        return $this->lib->change();
    }
    function write()
    {
        if ($this->lib->write()) {
            return $this->goBack();
        } else {
            return $this->lib->change();
        }
    }
    function delete()
    {
        if ($this->lib->delete()) {
            return $this->goBack();
        } else {
            return $this->lib->change();
        }
    }
    function goBack()
    {
        if ($_REQUEST["poisson_campagne_id"] > 0) {
            $lib = new PoissonCampagne;
        } else {
            $lib = new Poisson;
        }
        return $lib->display();
    }
}
