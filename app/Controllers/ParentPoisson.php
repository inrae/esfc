<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\ParentPoisson as LibrariesParentPoisson;
use App\Libraries\Poisson;

class ParentPoisson extends PpciController
{
    protected $lib;
    protected $poisson;
    function __construct()
    {
        $this->lib = new LibrariesParentPoisson();
        $this->poisson = new Poisson;
    }
    function change()
    {
        return $this->lib->change();
    }
    function write()
    {
        if ($this->lib->write()) {
            return $this->poisson->display();
        } else {
            return $this->lib->change();
        }
    }
    function delete()
    {
        if ($this->lib->delete()) {
            return $this->poisson->display();
        } else {
            return $this->lib->change();
        }
    }
}
