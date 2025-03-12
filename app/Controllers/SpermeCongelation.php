<?php

namespace App\Controllers;

use App\Libraries\Sperme;
use \Ppci\Controllers\PpciController;
use App\Libraries\SpermeCongelation as LibrariesSpermeCongelation;

class SpermeCongelation extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesSpermeCongelation();
    }
    function change()
    {
        return $this->lib->change();
    }
    function write()
    {
        if ($this->lib->write()) ;
            return $this->lib->change();
    }
    function delete()
    {
        if ($this->lib->delete()) {
            $sperme = new Sperme;
            return $sperme->change();
        } else {
            return $this->lib->change();
        }
    }
    function list()
    {
        return $this->lib->list();
    }
    function generateVisotube()
    {
        $this->lib->generateVisotube();
        return $this->lib->change();
    }
}
