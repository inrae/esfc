<?php

namespace App\Controllers;

use App\Libraries\SpermeCongelation;
use \Ppci\Controllers\PpciController;
use App\Libraries\SpermeFreezingPlace as LibrariesSpermeFreezingPlace;

class SpermeFreezingPlace extends PpciController
{
    protected $lib;
    protected $sc;
    function __construct()
    {
        $this->lib = new LibrariesSpermeFreezingPlace();
        $this->sc = new SpermeCongelation;
    }
    function change()
    {
        return $this->lib->change();
    }
    function write()
    {
        if ($this->lib->write()) {
            return $this->sc->change();
        } else {
            return $this->lib->change();
        }
    }
    function delete()
    {
        if ($this->lib->delete()) {
            return $this->sc->change();
        } else {
            return $this->lib->change();
        }
    }
}
