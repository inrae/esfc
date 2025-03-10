<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\AlimentType as LibrariesAlimentType;

class AlimentType extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesAlimentType();
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
            return $this->lib->list();
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
}
