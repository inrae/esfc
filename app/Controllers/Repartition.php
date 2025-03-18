<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Repartition as LibrariesRepartition;

class Repartition extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesRepartition();
    }
    function list()
    {
        return $this->lib->list();
    }
    function change()
    {
        return $this->lib->change();
    }
    function create()
    {
        if ($this->lib->create()) {
            return $this->lib->change();
        }
    }
    function duplicate()
    {
        if ($this->lib->duplicate()) {
            return $this->lib->change();
        } else {
            return $this->lib->list();
        }
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
    function print()
    {
        return $this->lib->print();
    }
    function resteChange()
    {
        return $this->lib->resteChange();
    }
    function resteWrite()
    {
        if ( $this->lib->resteWrite()) {
            return $this->lib->list();
        } else {
            return $this->lib->resteChange();
        }
    }
}
