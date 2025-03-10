<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\SpermeMesure as LibrariesSpermeMesure;

class SpermeMesure extends PpciController
{
    protected $lib;
    protected $sperme;
    function __construct()
    {
        $this->lib = new LibrariesSpermeMesure();
        $this->sperme  = new Sperme;
    }
    function change()
    {
        return $this->lib->change();
    }
    function write()
    {
        if ($this->lib->write()) {
            return $this->sperme->change();
        } else {
            return $this->lib->change();
        }
    }
    function delete()
    {
        if ($this->lib->delete()) {
            return $this->sperme->change();
        } else {
            return $this->lib->change();
        }
    }
}
