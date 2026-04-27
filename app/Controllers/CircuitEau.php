<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\CircuitEau as LibrariesCircuitEau;

class CircuitEau extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesCircuitEau();
    }
    function list()
    {
        return $this->lib->list();
    }
    function display()
    {
        if (isset($_REQUEST["circuit_eau_id"])) {
            return $this->lib->display();
        } else {
            return $this->list();
        }
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
}
