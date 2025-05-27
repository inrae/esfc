<?php

namespace App\Controllers;

use App\Libraries\DevenirType as LibrariesDevenirType;
use \Ppci\Controllers\PpciController;

class DevenirType extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesDevenirType;
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