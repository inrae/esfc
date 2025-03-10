<?php

namespace App\Controllers;

use App\Libraries\CircuitEau;
use \Ppci\Controllers\PpciController;
use App\Libraries\CircuitEvenement as LibrariesCircuitEvenement;

class CircuitEvenement extends PpciController
{
    protected $lib;
    protected $circuitEau;
    function __construct()
    {
        $this->lib = new LibrariesCircuitEvenement();
        $this->circuitEau = new CircuitEau;
    }
    function change()
    {
        return $this->lib->change();
    }
    function write()
    {
        if ($this->lib->write()) {
            return $this->circuitEau->display();
        } else {
            return $this->lib->change();
        }
    }
    function delete()
    {
        if ($this->lib->delete()) {
            return $this->circuitEau->display();
        } else {
            return $this->lib->change();
        }
    }
}
