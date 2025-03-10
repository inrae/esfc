<?php

namespace App\Controllers;

use App\Libraries\SpermeCongelation;
use \Ppci\Controllers\PpciController;
use App\Libraries\SpermeFreezingMeasure as LibrariesSpermeFreezingMeasure;

class SpermeFreezingMeasure extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesSpermeFreezingMeasure();
    }
    function change()
    {
        return $this->lib->change();
    }
    function write()
    {
        $this->lib->write();
            return $this->lib->change();
    }
    function delete()
    {
        if ($this->lib->delete()) {
            $sp = new SpermeCongelation;
            return $sp->change();
        } else {
            return $this->lib->change();
        }
    }
}
