<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Poisson as LibrariesPoisson;

class Poisson extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesPoisson();
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
    function getListeAjaxJson()
    {
        return $this->lib->getListeAjaxJson();
    }
    function getPoissonFromTag()
    {
        return $this->lib->getPoissonFromTag();
    }
}
