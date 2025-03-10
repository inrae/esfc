<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\PoissonCampagne as LibrariesPoissonCampagne;

class PoissonCampagne extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesPoissonCampagne();
    }
    function list()
    {
        return $this->lib->list();
    }
    function display()
    {
        return $this->lib->display();
    }
    function change()
    {
        return $this->lib->change();
    }
    function write()
    {
        if ($this->lib->write()) {
            return $this->lib->display();
        } else {
            return $this->lib->change();
        }
    }
    function delete()
    {
        if ($this->lib->delete()) {
            return $this->lib->list();
        } else {
            return $this->lib->change();
        }
    }
    function changeStatut()
    {
        $this->lib->changeStatut();
        return $this->lib->list();
    }
    function init()
    {
        $this->lib->init();
        return $this->lib->list();
    }
    function recalcul()
    {
        $this->lib->recalcul();
        return $this->lib->display();
    }
}
