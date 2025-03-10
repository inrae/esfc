<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\AnalyseEau as LibrariesAnalyseEau;
use App\Libraries\CircuitEau;

class AnalyseEau extends PpciController
{
    protected $lib;
    protected $circuitEau;
    function __construct()
    {
        $this->lib = new LibrariesAnalyseEau();
        $this->circuitEau = new CircuitEau;
    }
    function display()
    {
        return $this->circuitEau->display();
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
    function graph()
    {
        return $this->lib->graph();
    }
}
