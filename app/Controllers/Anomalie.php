<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Anomalie as LibrariesAnomalie;
use App\Libraries\Poisson;

class Anomalie extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesAnomalie();
    }
    function list()
    {
        return $this->lib->list();
    }
    function change()
    {
        return $this->lib->change();
    }
    function write()
    {
        if ($this->lib->write()) {
            if ($_REQUEST["module_origine"] == "poissonDisplay") {
                $poisson = new Poisson;
                return $poisson->display();
            } else {
                return $this->lib->list();
            }
        } else {
            return $this->lib->change();
        }
    }
    function delete()
    {
        if ($this->lib->delete()) {
            if ($_REQUEST["module_origine"] == "poissonDisplay") {
                $poisson = new Poisson;
                return $poisson->display();
            } else {
                return $this->lib->list();
            }
        } else {
            return $this->lib->change();
        }
    }
}
